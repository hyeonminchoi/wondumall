package com.wondumall.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.wondumall.Config.MyUserDetails;
import com.wondumall.DAO.LoginDAO;
import com.wondumall.DTO.LoginDTO;

@Service
public class MyUserDetailsService implements UserDetailsService {

    @Autowired LoginDAO loginDAO;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	LoginDTO user = new LoginDTO();
    	user.setU_email(username);
    	user.setU_provider("wondumall");
        user = loginDAO.findByUserid(user);
        if (user == null) throw new UsernameNotFoundException(username);
        return new MyUserDetails(user);
    }

}
