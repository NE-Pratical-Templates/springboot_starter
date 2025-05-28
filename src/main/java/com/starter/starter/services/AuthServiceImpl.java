package com.starter.starter.services;

import com.starter.starter.dtos.request.CreateUserDTO;
import com.starter.starter.dtos.request.LoginDTO;
import com.starter.starter.dtos.response.JwtAuthenticationResponse;
import com.starter.starter.enums.EAccountStatus;
import com.starter.starter.enums.ERole;
import com.starter.starter.exceptions.BadRequestException;
import com.starter.starter.exceptions.ResourceNotFoundException;
import com.starter.starter.interfaces.IAuthService;
import com.starter.starter.models.Role;
import com.starter.starter.models.User;
import com.starter.starter.repositories.IRoleRepository;
import com.starter.starter.repositories.IUserRepository;
import com.starter.starter.security.JwtTokenProvider;
import com.starter.starter.standalone.MailService;
import com.starter.starter.utils.Utility;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public  class AuthServiceImpl implements IAuthService {
    private final IUserRepository userRepo;
    private final IRoleRepository roleRepo;
    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;
    private final MailService mailService;
    private static final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public User registerUser(CreateUserDTO dto) {
        User user = new User();
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setEmail(dto.getEmail());
        user.setMobile(dto.getMobile());
        user.setNationalId(dto.getNationalId());
        user.setDob(dto.getDob());

        try {
            Role role = roleRepo.findByName(ERole.STANDARD).orElseThrow(
                    () -> new BadRequestException("STANDARD Role not set"));
            String encodedPassword = passwordEncoder.encode(dto.getPassword());

            user.setPassword(encodedPassword);
            user.setRoles(Collections.singleton(role));
            return userRepo.save(user);
        } catch (DataIntegrityViolationException ex) {
            String errorMessage = Utility.getConstraintViolationMessage(ex, user);
            throw new BadRequestException(errorMessage, ex);
        }
    }

    //    login
    @Override
    public JwtAuthenticationResponse login(LoginDTO dto) {
        String jwt = null;

        // Authenticate the user
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(dto.getEmail(), dto.getPassword())
        );

        try {
            SecurityContextHolder.getContext().setAuthentication(authentication);


            jwt = jwtTokenProvider.generateToken(authentication);

        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }

        User user = userRepo.findByEmail(dto.getEmail()).orElseThrow(() -> new UsernameNotFoundException("user not found "));
        if (user.getStatus() == EAccountStatus.PENDING)
            throw new BadRequestException("please verify account before login ");
        if (user.getStatus() == EAccountStatus.DEACTIVATED)
            throw new BadRequestException("your account is deactivated , please activate it before using it ");
        return new JwtAuthenticationResponse(jwt, user);
    }

    //    initiate reset of password
    @Override
    public void initiateResetPassword(String email) {
        User user = userRepo.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("no user found with that email"));
        user.setActivationCode(Utility.randomUUID(6, 0, 'N'));
        user.setStatus(EAccountStatus.RESET);
        userRepo.save(user);
        mailService.sendResetPasswordMail(user.getEmail(), user.getFirstName() + " " + user.getLastName(), user.getActivationCode());
    }


    //    reset password
    @Override
    public void resetPassword(String email, String passwordResetCode, String newPassword) {
        User user = userRepo.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("no user found with  that email "));
        if (Utility.isCodeValid(user.getActivationCode(), passwordResetCode) &&
                (user.getStatus().equals(EAccountStatus.RESET)) || user.getStatus().equals(EAccountStatus.PENDING)) {
            user.setPassword(passwordEncoder.encode(newPassword));
            user.setActivationCode(Utility.randomUUID(6, 0, 'N'));
            user.setActivationCodeExpiresAt(null);
            user.setStatus(EAccountStatus.ACTIVE);
            userRepo.save(user);
            this.mailService.sendPasswordResetSuccessfully(user.getEmail(), user.getFullName());
        } else {
            throw new BadRequestException("Invalid code or account status");
        }
    }

//initiate to get verification codes

    @Override
    public void initiateAccountVerification(String email) {
        User user = userRepo.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("no user found with email"));
        if (user.getStatus() == EAccountStatus.ACTIVE) {
            throw new BadRequestException("User is already verified");
        }
        String verificationCode;
        do {
            verificationCode = Utility.generateCode();
        } while (userRepo.findByActivationCode(verificationCode).isPresent());
        LocalDateTime verificationCodeExpiresAt = LocalDateTime.now().plusHours(6);
        user.setActivationCode(verificationCode);
        user.setActivationCodeExpiresAt(verificationCodeExpiresAt);
        this.mailService.sendActivateAccountEmail(user.getEmail(), user.getFullName(), verificationCode);
        userRepo.save(user);
    }

//      verify account

    @Override
    public void verifyAccount(String verificationCode) {
        Optional<User> _user = userRepo.findByActivationCode(verificationCode);
        if (_user.isEmpty()) {
            throw new ResourceNotFoundException("User", verificationCode, verificationCode);
        }
        User user = _user.get();
        if (user.getActivationCodeExpiresAt().isBefore(LocalDateTime.now())) {
            throw new BadRequestException("Verification code is invalid or expired");
        }
        user.setStatus(EAccountStatus.ACTIVE);
        user.setActivationCodeExpiresAt(null);
        user.setActivationCode(null);
        this.mailService.sendAccountVerifiedSuccessfullyEmail(user.getEmail(), user.getFullName());
        userRepo.save(user);
    }
}
