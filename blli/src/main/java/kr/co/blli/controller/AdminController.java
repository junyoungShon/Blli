package kr.co.blli.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.blli.model.admin.AdminService;
import kr.co.blli.model.vo.BlliLogVO;
import kr.co.blli.model.vo.BlliMemberVO;
import kr.co.blli.model.vo.BlliPostingVO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {
	@Resource
	private AdminService adminService;
	
	@RequestMapping("sendMail.do")
	public String sendMail(String memberId, String mailForm) {
		
		String viewName = "admin/sendMail_success";
		try {
			adminService.sendMail(memberId, mailForm);
		} catch (Exception e) {
			e.printStackTrace();
			viewName = "admin/sendMail_fail";
		}
		
		return viewName;
	}
	/**
	 * 
	 * @Method Name : unconfirmedPosting
	 * @Method 설명 : 확정안된 포스팅의 리스트를 반환해주는 메서드 
	 * @작성일 : 2016. 1. 27.
	 * @작성자 : hyunseok
	 * @param pageNo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("unconfirmedPosting.do")
	public ModelAndView unconfirmedPosting(String pageNo, String category, String searchWord) throws IOException{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/unconfirmedPosting");
		mav.addObject("resultList", adminService.unconfirmedPosting(pageNo, category, searchWord));
		mav.addObject("category", category);
		mav.addObject("searchWord", searchWord);
		return mav;
	}	
	/**
	 * 
	 * @Method Name : postingListWithSmallProducts
	 * @Method 설명 : 두개 이상의 소제품과 관련된 포스팅의 리스트를 반환해주는 메서드
	 * @작성일 : 2016. 1. 27.
	 * @작성자 : hyunseok
	 * @param pageNo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("postingListWithSmallProducts.do")
	public ModelAndView postingListWithSmallProducts(String pageNo) throws IOException{
		return new ModelAndView("admin/postingListWithSmallProducts","resultList",adminService.postingListWithSmallProducts(pageNo));
	}
	/**
	 * 
	 * @Method Name : unconfirmedSmallProduct
	 * @Method 설명 : 확정안된 소제품의 리스트를 반환해주는 메서드 
	 * @작성일 : 2016. 1. 27.
	 * @작성자 : hyunseok
	 * @param pageNo
	 * @return
	 */
	@RequestMapping("unconfirmedSmallProduct.do")
	public ModelAndView unconfirmedSmallProduct(String pageNo){
		return new ModelAndView("admin/unconfirmedSmallProduct","resultList",adminService.unconfirmedSmallProduct(pageNo));
	}	
	/**
	 * 
	 * @Method Name : selectProduct
	 * @Method 설명 : 두개 이상의 소제품과 관련된 포스팅의 소제품을 확정하는 메서드
	 * @작성일 : 2016. 1. 27.
	 * @작성자 : hyunseok
	 * @param urlAndProduct
	 */
	@ResponseBody
	@RequestMapping("selectProduct.do")
	public void selectProduct(@RequestBody List<Map<String, Object>> urlAndImage){
		adminService.selectProduct(urlAndImage);
	}
	/**
	 * 
	 * @Method Name : registerPosting
	 * @Method 설명 : 확정안된 포스팅을 확정하는 메서드 
	 * @작성일 : 2016. 1. 27.
	 * @작성자 : hyunseok
	 * @param urlAndProduct
	 */
	@ResponseBody
	@RequestMapping("registerPosting.do")
	public void registerPosting(@RequestBody List<Map<String, Object>> urlAndImage){
		adminService.registerPosting(urlAndImage);
	}
	/**
	 * 
	 * @Method Name : registerSmallProduct
	 * @Method 설명 : 확정안된 소제품을 확정하는 메서드 
	 * @작성일 : 2016. 1. 27.
	 * @작성자 : hyunseok
	 * @param smallProductInfo
	 */
	@ResponseBody
	@RequestMapping("registerSmallProduct.do")
	public void registerSmallProduct(@RequestBody List<Map<String, Object>> smallProductInfo){
		adminService.registerSmallProduct(smallProductInfo);
	}
	/**
	  * @Method Name : makingWordCloud
	  * @Method 설명 : 워드클라우드 만드는 임시 메서드
	  * @작성일 : 2016. 2. 11.
	  * @작성자 : junyoung
	  * @param blliPostingVO
	 */
	@RequestMapping("makingWordCloud.do")
	public void makingWordCloud(BlliPostingVO blliPostingVO){
		adminService.makingWordCloud(blliPostingVO);
	}
	/**
	 * 
	 * @Method Name : checkLog
	 * @Method 설명 : 로그 조회를 위한 메서드
	 * @작성일 : 2016. 2. 10.
	 * @작성자 : hyunseok
	 * @return
	 */
	@RequestMapping("checkLog.do")
	public ModelAndView checkLog(){
		ArrayList<BlliLogVO> list = (ArrayList<BlliLogVO>)adminService.checkLog();
		return new ModelAndView("admin/log", "logList", list);
	}	
	/**
	 * 
	 * @Method Name : snsShareCountUp
	 * @Method 설명 : 확정안된 소제품을 확정하는 메서드 
	 * @작성일 : 2016. 1. 27.
	 * @작성자 : hyunseok
	 * @param smallProductInfo
	 */
	@ResponseBody
	@RequestMapping("snsShareCountUp.do")
	public void snsShareCountUp(String smallProductId){
		adminService.snsShareCountUp(smallProductId);
	}
	@RequestMapping("allProductDownLoader.do")
	public void allProductDownLoader(){
		adminService.allProductDownLoader();
	}
	
	@RequestMapping("checkPosting.do")
	public ModelAndView checkPosting(){
		ArrayList<BlliPostingVO> list = (ArrayList<BlliPostingVO>)adminService.checkPosting();
		return new ModelAndView("admin/checkPosting", "postingList", list);
	}	
	@ResponseBody
	@RequestMapping("deletePosting.do")
	public void deletePosting(BlliPostingVO postingVO){
		adminService.deletePosting(postingVO);
	}
	@ResponseBody
	@RequestMapping("notAdvertisingPosting.do")
	public void notAdvertisingPosting(BlliPostingVO postingVO){
		adminService.notAdvertisingPosting(postingVO);
	}
	@RequestMapping("checkMember.do")
	public ModelAndView checkMember(){
		ArrayList<BlliMemberVO> list = (ArrayList<BlliMemberVO>)adminService.checkMember();
		return new ModelAndView("admin/checkMember", "memberList", list);
	}
}
