package com.erp.employee.interfaces;

import com.erp.employee.models.Employment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IEmploymentRepository extends JpaRepository<Employment, Long> {
}
