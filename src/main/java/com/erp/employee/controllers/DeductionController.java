package com.erp.employee.controllers;

import com.erp.employee.dtos.response.ApiResponseDTO;
import com.erp.employee.interfaces.IDeductionService;
import com.erp.employee.interfaces.IEmployeeService;
import com.erp.employee.models.Employee;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/deductions")
@RequiredArgsConstructor
public class DeductionController {
    private final IDeductionService service;
    private final IEmployeeService EmployeeService;

    @Operation(summary = "initialize deduction", description = "initialize deduction", security = @SecurityRequirement(name = "bearerAuth"))
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = " initialize deduction fetched successfully"),
            @ApiResponse(responseCode = "401", description = "Unauthorized - Invalid or missing token")
    })
    @PostMapping("/initialize")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponseDTO> getCurrentEmployee() {
        return ResponseEntity.ok(ApiResponseDTO.success(service.initializeDeduction(), "Deduction initialized successfully"));
    }
}
