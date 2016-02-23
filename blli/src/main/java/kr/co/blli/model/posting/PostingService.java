package kr.co.blli.model.posting;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.blli.model.vo.BlliMemberScrapeVO;
import kr.co.blli.model.vo.BlliPostingVO;
import kr.co.blli.model.vo.BlliSmallProductVO;

public interface PostingService {

	abstract ArrayList<BlliPostingVO> searchPosting(String pageNo, String searchWord);

	abstract void recordResidenceTime(BlliPostingVO blliPostingVO);

	abstract int totalPageOfPosting(String searchWord);

	abstract ArrayList<BlliPostingVO> searchPostingListInProductDetail(String searchWord, String memberId, String string);

	abstract ArrayList<BlliPostingVO> searchPostingListInProductDetail(String smallProductId, HttpServletRequest request, String pageNo);

	abstract String selectTotalPostingtNum();


	abstract ArrayList<BlliPostingVO> getPostingSlideListInfo(String smallProductId);

	BlliPostingVO searchPostingByUserScrape(BlliPostingVO blliPostingVO,
			String memberId);

	List<BlliPostingVO> searchPostingBySmallProductList(
			List<BlliSmallProductVO> blliSmallProductVOList, String memberId,
			String pageNum);

}
