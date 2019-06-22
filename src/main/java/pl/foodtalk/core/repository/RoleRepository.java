package pl.foodtalk.core.repository;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import pl.foodtalk.core.model.Role;

public interface RoleRepository extends JpaRepository<Role, Long>{
	Set<Role> findById(Long id);
}
