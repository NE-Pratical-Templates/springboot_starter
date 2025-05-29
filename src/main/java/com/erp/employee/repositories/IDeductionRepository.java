package com.erp.employee.repositories;

import com.erp.employee.models.Deduction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IDeductionRepository extends JpaRepository<Deduction, Long> {
    boolean existsByCode(String code);

}
