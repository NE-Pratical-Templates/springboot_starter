package com.erp.employee.services;

import com.erp.employee.interfaces.IDeductionService;
import com.erp.employee.models.Deduction;
import com.erp.employee.repositories.IDeductionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

@Service
@RequiredArgsConstructor
public class DeductionServiceImpl implements IDeductionService {
    private final IDeductionRepository deductionRepo;


    @Override
    public String initializeDeduction() {
        List<Deduction> defaultDeductions = Arrays.asList(
                new Deduction("DTX001", "EmployeeTax", new BigDecimal("30")),
                new Deduction("DPN001", "Pension", new BigDecimal("6")),
                new Deduction("DMI001", "MedicalInsurance", new BigDecimal("5")),
                new Deduction("DOT001", "Others", new BigDecimal("5")),
                new Deduction("DHO001", "Housing", new BigDecimal("14")),
                new Deduction("DTR001", "Transport", new BigDecimal("14"))
        );

        for (Deduction deduction : defaultDeductions) {
            if (!deductionRepo.existsByCode(deduction.getCode())) {
                deductionRepo.save(deduction);
            }
        }
        return "Deduction initialized successfully";
    }
}

