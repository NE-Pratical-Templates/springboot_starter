package com.starter.starter.repositories;

import com.starter.starter.enums.ERole;
import com.starter.starter.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface IRoleRepository extends JpaRepository<Role, UUID> {
    Optional<Role> findByName(ERole role);

    boolean existsByName(ERole role);
}
