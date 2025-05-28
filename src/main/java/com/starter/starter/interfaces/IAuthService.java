package com.starter.starter.interfaces;

import com.starter.starter.dtos.request.CreateUserDTO;
import com.starter.starter.dtos.request.LoginDTO;
import com.starter.starter.dtos.response.JwtAuthenticationResponse;
import com.starter.starter.models.User;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public interface IAuthService {
    User registerUser(@Valid CreateUserDTO dto);


    JwtAuthenticationResponse login(@Valid LoginDTO dto);

    void verifyAccount(String verificationCode);

    void initiateAccountVerification(@Email String email);


    void initiateResetPassword(@NotBlank @Email String email);

    void resetPassword(@NotBlank String email, @NotBlank String passwordResetCode, String newPassword);
}
