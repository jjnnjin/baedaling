package com.bd.review;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bd.user.SessionInfo;

@Controller("review.reviewController")
@RequestMapping("/review/*")
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value="write",method=RequestMethod.GET)
	public String writeReview(
			@RequestParam int foodOrderNum,
			@RequestParam int restaurantsNum,
			Model model
			) {
		model.addAttribute("state","write");
		model.addAttribute("foodOrderNum",foodOrderNum);
		model.addAttribute("restaurantsNum",restaurantsNum);
		return ".mypage.review";
	}
	
	@RequestMapping(value="write",method=RequestMethod.POST)
	public String writeSubmit(
			Review dto,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("user");
		try {
			dto.setUserIdx(info.getUserIdx());
			reviewService.insertReview(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/main";
	}
	

}
