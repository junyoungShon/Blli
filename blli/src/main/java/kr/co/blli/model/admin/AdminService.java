package kr.co.blli.model.admin;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import kr.co.blli.model.vo.BlliPostingVO;
import kr.co.blli.model.vo.BlliLogVO;
import kr.co.blli.model.vo.BlliMemberVO;
import kr.co.blli.model.vo.ListVO;

public interface AdminService {
	
	public void sendMail(String memberId, String mailForm) throws FileNotFoundException, URISyntaxException, UnsupportedEncodingException, MessagingException;
	
	abstract ListVO unconfirmedPosting(String pageNo, String category, String searchWord) throws IOException;
	
	abstract ListVO postingListWithSmallProducts(String pageNo) throws IOException;
	
	public ListVO unconfirmedSmallProduct(String pageNo);
	
	abstract void selectProduct(List<Map<String, Object>> urlAndImage);
	
	abstract void registerPosting(List<Map<String, Object>> urlAndImage);
	
	public void registerSmallProduct(List<Map<String, Object>> smallProductInfo);

	void insertAndUpdateWordCloud(ArrayList<BlliPostingVO> blliPostingVOList);

	public void makingWordCloud(BlliPostingVO blliPostingVO);
	
	public ArrayList<BlliLogVO> checkLog();

	public void snsShareCountUp(String smallProductId);

	public void allProductDownLoader();
	public ArrayList<BlliPostingVO> checkPosting();

	public void deletePosting(BlliPostingVO postingVO);

	public void notAdvertisingPosting(BlliPostingVO postingVO);

	public ArrayList<BlliMemberVO> checkMember();
}
