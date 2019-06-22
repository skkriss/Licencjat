package pl.foodtalk.core.service;

import pl.foodtalk.core.model.User;
import pl.foodtalk.core.repository.RoleRepository;
import pl.foodtalk.core.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashSet;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void save(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(new HashSet<>(roleRepository.findById((long) 1)));
        userRepository.save(user);
    }
    public void saveWPC(User user){
        user.setRoles(new HashSet<>(roleRepository.findById((long) 1)));
        userRepository.save(user);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public User findById(Long id) { 
    	return userRepository.findById(id); }

    @Override
    public List<User> findAll() { 
    	return userRepository.findAll(); }
    
    @Override
    @Transactional
    public Long deleteById(Long id) {
    	return userRepository.deleteById(id);
    }
}
