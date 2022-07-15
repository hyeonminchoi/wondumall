package com..Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com..Service.BusinessService;

@Controller
public class BusinessController {
	
	@Autowired
	private BusinessService businessService;
	
	@GetMapping(value = "/business/index.do")
	public String businessindex() {
		
		return "businessindex";
	}
}
