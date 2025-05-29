package com.erp.employee.controllers;

import com.erp.employee.interfaces.IEmployeeService;
import com.erp.employee.models.Employee;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/Employees")
@RequiredArgsConstructor

public class EmployeeController {
    private final IEmployeeService EmployeeService;

    @Operation(summary = "get loggedIn Employee ", description = "get loggedIn Employee", security = @SecurityRequirement(name = "bearerAuth"))
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = " get loggedIn Employee fetched successfully"),
            @ApiResponse(responseCode = "401", description = "Unauthorized - Invalid or missing token")
    })
    @GetMapping("/profile")
    public ResponseEntity<Employee> getCurrentEmployee() {
        return ResponseEntity.ok(EmployeeService.getLoggedInEmployee());
    }
}
