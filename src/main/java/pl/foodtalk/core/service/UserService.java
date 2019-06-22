package pl.foodtalk.core.service;

import pl.foodtalk.core.model.User;

import javax.transaction.Transactional;
import java.util.List;

public interface UserService {
    void save(User user);
    void saveWPC(User user);
    User findByUsername(String username);
    User findById(Long id);
    List<User> findAll();
    @Transactional
    Long deleteById(Long id);
}
