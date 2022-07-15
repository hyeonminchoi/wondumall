package com..Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.BusinessDAO;

@Service
public class BusinessService {

	@Autowired
	private BusinessDAO businessDAO;
}
