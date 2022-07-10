package com..Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com..Config.MyUserDetails;
import com..DAO.LoginDAO;
import com..DTO.LoginDTO;

@Service
public class MyUserDetailsService implements UserDetailsService {

    @Autowired LoginDAO loginDAO;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	LoginDTO user = new LoginDTO();
    	user.setU_email(username);
    	user.setU_provider("");
        user = loginDAO.findByUserid(user);
        if (user == null) throw new UsernameNotFoundException(username);
        return new MyUserDetails(user);
    }

}
