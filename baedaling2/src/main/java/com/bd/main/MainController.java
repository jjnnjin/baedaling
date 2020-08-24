package com.bd.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("main.mainController")
public class MainController {
	@RequestMapping("/main")
	public String main(Model model) {
		model.addAttribute("searchBar", "true");
		return ".main.main";
	}
}