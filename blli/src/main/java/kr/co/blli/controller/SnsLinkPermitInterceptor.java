package kr.co.blli.controller;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.blli.model.vo.BlliMemberVO;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SnsLinkPermitInterceptor extends HandlerInterceptorAdapter{
	
	
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
		Boolean flag = true;
		//요청에 대해 이전 주소 출력
		String requestUrl = request.getRequestURL().toString();
		if(!requestUrl.startsWith("http://bllidev.dev/blli/")||request!=null){
			//타 사이트의 링크를 통해 본 페이지에 접근하고자 할 때 접근을 허용해줌
		}
		return flag;
	}
}
