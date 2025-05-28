package com.starter.starter.dtos.request;

import com.starter.starter.validators.ValidPassword;
import lombok.Getter;

import jakarta.validation.constraints.NotBlank;

@Getter
public class ResetPasswordDTO {

    @NotBlank
    private String email;

    @NotBlank
    private String passwordResetCode;

    @ValidPassword
    private String newPassword;
}
