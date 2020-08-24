package com.bd.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean result = true;
		
		try {
			HttpSession session = request.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("user");
			String cp = request.getContextPath();
			String uri = request.getRequestURI();
			String queryString = request.getQueryString();//GET방식 쿼리스트링
			
			if(info!=null) {
				return result;
			}
			
			result = false;
			if(isAjaxRequest(request)) {
				response.sendError(403);
			} else {
				if(uri.indexOf(cp)==0) {
					uri=uri.substring(cp.length());
				}
				if(queryString!=null) {
					uri+="?"+queryString;
				}
				session.setAttribute("preLoginURI", uri);
				response.sendRedirect(cp+"/user/login");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
	private boolean isAjaxRequest(HttpServletRequest req) {
		String h = req.getHeader("AJAX");
		return h != null && h.equals("true");
	}

}
