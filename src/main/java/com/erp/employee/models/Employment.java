package com.erp.employee.models;

import com.erp.employee.audits.InitiatorAudit;
import com.erp.employee.enums.EmploymentStatus;
import jakarta.persistence.*;
import jakarta.validation.constraints.PastOrPresent;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

@EqualsAndHashCode(callSuper = true)
@Data
@Entity
@Table(name = "employees")
public class Employment extends InitiatorAudit {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private UUID id;

    @Column(name = "code")
    private String code;

    @Column(name = "department")
    private String department;

    @Column(name = "position")
    private String position;

    @Column(name = "base_salary")
    private BigDecimal baseSalary;

    @PastOrPresent(message = "Joining date must be in the past or present")
    @Column(name = "joining_date")
    private LocalDate joiningDate;


    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private EmploymentStatus status =EmploymentStatus.ACTIVE;

    @OneToOne
    @JoinColumn(name = "employee_id")
    private Employee employee;


}
