package com.spring.javaweb2S;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}

}
