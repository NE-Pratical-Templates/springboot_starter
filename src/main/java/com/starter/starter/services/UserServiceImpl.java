package com.starter.starter.services;

import com.starter.starter.exceptions.BadRequestException;
import com.starter.starter.exceptions.ResourceNotFoundException;
import com.starter.starter.interfaces.IUserService;
import com.starter.starter.models.User;
import com.starter.starter.repositories.IUserRepository;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class UserServiceImpl implements IUserService {
    private final IUserRepository userRepo;

    @Override
    public User getLoggedInuser() {
        // Get the current authentication context
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // Check if user is authenticated
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BadRequestException("No authenticated user found");
        }

        Object principal = authentication.getPrincipal();

        // Ensure principal is of type UserDetails
        if (!(principal instanceof UserDetails)) {
            throw new BadRequestException("Invalid authentication principal");
        }

        String username = ((UserDetails) principal).getUsername();
        return userRepo.findByEmail(username)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with email: ", username, "email"));
    }

}
