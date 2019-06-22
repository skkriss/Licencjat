package pl.foodtalk.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import pl.foodtalk.core.model.User;

import javax.transaction.Transactional;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
    User findById(Long id);
    @Transactional
    Long deleteById(Long id);
}
