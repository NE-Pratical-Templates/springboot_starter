package com.starter.starter.dtos.request;

import jakarta.validation.constraints.Email;
import lombok.Data;

@Data
public class InitiateAccountVerificationDTO {

    @Email
    private String email;

}
