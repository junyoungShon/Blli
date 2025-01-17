package kr.co.blli.model.product;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import kr.co.blli.model.vo.BlliBabyVO;
import kr.co.blli.model.vo.BlliBigCategoryVO;
import kr.co.blli.model.vo.BlliBuyLinkClickVO;
import kr.co.blli.model.vo.BlliMemberDibsVO;
import kr.co.blli.model.vo.BlliMemberScrapeVO;
import kr.co.blli.model.vo.BlliMidCategoryVO;
import kr.co.blli.model.vo.BlliNotRecommMidCategoryVO;
import kr.co.blli.model.vo.BlliPostingDisLikeVO;
import kr.co.blli.model.vo.BlliPostingLikeVO;
import kr.co.blli.model.vo.BlliPostingVO;
import kr.co.blli.model.vo.BlliSmallProductBuyLinkVO;
import kr.co.blli.model.vo.BlliSmallProductVO;
import kr.co.blli.model.vo.BlliWordCloudVO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAOImpl implements ProductDAO{
	@Resource
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<BlliSmallProductVO> getSmallProduct() {
		return sqlSessionTemplate.selectList("product.getSmallProduct");
	}

	@Override
	public void insertBigCategory(BlliBigCategoryVO blliBigCategoryVO) {
		sqlSessionTemplate.insert("product.insertBigCategory", blliBigCategoryVO);
	}

	@Override
	public List<BlliBigCategoryVO> getBigCategory() {
		return sqlSessionTemplate.selectList("product.getBigCategory");
	}

	@Override
	public void insertMidCategory(BlliMidCategoryVO blliMidCategoryVO) {
		sqlSessionTemplate.insert("product.insertMidCategory", blliMidCategoryVO);
	}

	@Override
	public int updateBigCategory(BlliBigCategoryVO blliBigCategoryVO) {
		return sqlSessionTemplate.update("product.updateBigCategory", blliBigCategoryVO);
	}

	@Override
	public int updateMidCategory(BlliMidCategoryVO blliMidCategoryVO) {
		return sqlSessionTemplate.update("product.updateMidCategory", blliMidCategoryVO);
	}

	@Override
	public List<BlliMidCategoryVO> getMidCategory() {
		return sqlSessionTemplate.selectList("product.getMidCategory");
	}
	@Override
	public List<BlliMidCategoryVO> selectRecommendingMidCategory(
			BlliBabyVO blliBabyVO) {
		return sqlSessionTemplate.selectList("product.selectRecommendingMidCategory",blliBabyVO);
	}
	@Override
	public List<BlliNotRecommMidCategoryVO> selectNotRecommMidCategoryList(
			BlliBabyVO blliBabyVO) {
		return sqlSessionTemplate.selectList("product.selectNotRecommMidCategoryList",blliBabyVO);
	}
	@Override
	public void deleteRecommendMidCategory(BlliNotRecommMidCategoryVO blliNotRecommMidCategoryVO) {
		sqlSessionTemplate.insert("product.deleteRecommendMidCategory", blliNotRecommMidCategoryVO);
	}
	@Override
	public void selectSameAgeMomBestPickedSmallProductList(Integer put) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BlliSmallProductVO> selectSameAgeMomBestPickedSmallProductList(
			HashMap<String, String> paraMap) {
		return sqlSessionTemplate.selectList("product.selectSameAgeMomBestPickedSmallProductList", paraMap);
	}

	@Override
	public BlliSmallProductVO selectSameAgeMomBestPickedSmallProduct(
			HashMap<String, String> paraMap) {
		return sqlSessionTemplate.selectOne("product.selectSameAgeMomBestPickedSmallProduct", paraMap);
	}

	@Override
	public void insertSmallProduct(BlliSmallProductVO blliSmallProductVO) {
		sqlSessionTemplate.insert("product.insertSmallProduct", blliSmallProductVO);
	}

	@Override
	public int updateSmallProduct(BlliSmallProductVO blliSmallProductVO) {
		return sqlSessionTemplate.update("product.updateSmallProduct", blliSmallProductVO);
	}

	@Override
	public void insertSmallProductBuyLink(BlliSmallProductBuyLinkVO blliSmallProductBuyLinkVO) {
		sqlSessionTemplate.insert("product.insertSmallProductBuyLink", blliSmallProductBuyLinkVO);
	}

	@Override
	public int updateSmallProductBuyLink(BlliSmallProductBuyLinkVO blliSmallProductBuyLinkVO) {
		return sqlSessionTemplate.update("product.updateSmallProductBuyLink", blliSmallProductBuyLinkVO);
	}
	@Override
	public List<BlliPostingVO> selectPostingBySmallProductList(HashMap<String, String> paraMap) {
		return sqlSessionTemplate.selectList("posting.selectPostingBySmallProductList", paraMap);
	}
	@Override
	public int deleteDipsInfo(BlliMemberDibsVO blliMemberDibsVO) {
		return sqlSessionTemplate.delete("product.deleteDipsInfo", blliMemberDibsVO);
	}
	@Override
	public int insertDipsInfo(BlliMemberDibsVO blliMemberDibsVO) {
		return sqlSessionTemplate.delete("product.insertDipsInfo", blliMemberDibsVO);
	}
	@Override
	public void updatePlusSmallProductDibsCount(BlliMemberDibsVO blliMemberDibsVO) {
		sqlSessionTemplate.update("product.updatePlusSmallProductDibsCount", blliMemberDibsVO);
	}
	@Override
	public void updateMinusSmallProductDibsCount(BlliMemberDibsVO blliMemberDibsVO) {
		sqlSessionTemplate.update("product.updateMinusSmallProductDibsCount", blliMemberDibsVO);
	}
	
	
	// 포스팅 스크랩, 좋아요 , 싫어요 관련 메서드 시작
	@Override
	public int deletePostingScrapeInfo(BlliMemberScrapeVO blliMemberScrapeVO) {
		return sqlSessionTemplate.delete("posting.deletePostingScrapeInfo", blliMemberScrapeVO);
	}
	/**
	  * @Method Name : insertPostingScrap
	  * @Method 설명 : 회원이 해당 포스팅을 스크랩한 정보가 없다면 넣어줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliMemberScrapVO
	  * @return
	 */
	@Override
	public int insertPostingScrape(BlliMemberScrapeVO blliMemberScrapeVO) {
		return sqlSessionTemplate.delete("posting.insertPostingScrape", blliMemberScrapeVO);
	}
	/**
	  * @Method Name : updatePlusPostingScrapCount
	  * @Method 설명 : 회원이 스크랩한 경우 스크랩 수를 늘려줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliMemberScrapVO
	 */
	@Override
	public void updatePlusPostingScrapeCount(BlliMemberScrapeVO blliMemberScrapeVO) {
		sqlSessionTemplate.update("posting.updatePlusPostingScrapeCount", blliMemberScrapeVO);
	}
	/**
	  * @Method Name : updateMinusPostingScrapCount
	  * @Method 설명 : 회원의 스크랩을 취소할 경우 그 수를 줄여줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliMemberScrapVO
	 */
	@Override
	public void updateMinusPostingScrapeCount(BlliMemberScrapeVO blliMemberScrapeVO) {
		sqlSessionTemplate.update("posting.updateMinusPostingScrapeCount", blliMemberScrapeVO);
	}
	/**
	  * @Method Name : deletePostingLikeInfo
	  * @Method 설명 : 회원이 포스팅을 좋아한 정보가 있을 경우 지워줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingLikeVO
	  * @return
	 */
	@Override
	public int deletePostingLikeInfo(BlliPostingLikeVO blliPostingLikeVO) {
		return sqlSessionTemplate.delete("posting.deletePostingLikeInfo", blliPostingLikeVO);
	}
	/**
	  * @Method Name : insertPostingLikeInfo
	  * @Method 설명 : 회원이 포스팅을 좋아한 정보가 없을 경우 지워줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingLikeVO
	  * @return
	 */
	@Override
	public int insertPostingLikeInfo(BlliPostingLikeVO blliPostingLikeVO) {
		return sqlSessionTemplate.delete("posting.insertPostingLikeInfo", blliPostingLikeVO);
	}
	/**
	  * @Method Name : updatePlusPostingLikeCount
	  * @Method 설명 : 포스팅의 좋아요수를 올려줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingLikeVO
	 */
	@Override
	public void updatePlusPostingLikeCount(BlliPostingLikeVO blliPostingLikeVO) {
		sqlSessionTemplate.update("posting.updatePlusPostingLikeCount", blliPostingLikeVO);
	}
	/**
	  * @Method Name : updateMinusPostingLikeCount
	  * @Method 설명 : 포스팅의 좋아요 수를 줄여줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingLikeVO
	 */
	@Override
	public void updateMinusPostingLikeCount(BlliPostingLikeVO blliPostingLikeVO) {
		sqlSessionTemplate.update("posting.updateMinusPostingLikeCount", blliPostingLikeVO);
	}
	/**
	  * @Method Name : deletePostingDisLikeInfo
	  * @Method 설명 : 포스팅의 싫어요 정보를 지워줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingDisLikeVO
	  * @return
	 */
	@Override
	public int deletePostingDisLikeInfo(BlliPostingDisLikeVO blliPostingDisLikeVO) {
		return sqlSessionTemplate.delete("posting.deletePostingDisLikeInfo", blliPostingDisLikeVO);
	}
	/**
	  * @Method Name : insertPostingDisLikeInfo
	  * @Method 설명 : 포스팅의 싫어요 정보를 넣어줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingDisLikeVO
	  * @return
	 */
	@Override
	public int insertPostingDisLikeInfo(BlliPostingDisLikeVO blliPostingDisLikeVO) {
		return sqlSessionTemplate.delete("posting.insertPostingDisLikeInfo", blliPostingDisLikeVO);
	}
	/**
	  * @Method Name : updatePlusPostingDisLikeCount
	  * @Method 설명 : 포스팅의 싫어요 수를 올려줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingDisLikeVO
	 */
	@Override
	public void updatePlusPostingDisLikeCount(BlliPostingDisLikeVO blliPostingDisLikeVO) {
		sqlSessionTemplate.update("posting.updatePlusPostingDisLikeCount", blliPostingDisLikeVO);
	}
	/**
	  * @Method Name : updateMinusPostingDisLikeCount
	  * @Method 설명 : 포스팅의 싫어요 수를 줄여줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingDisLikeVO
	 */
	@Override
	public void updateMinusPostingDisLikeCount(BlliPostingDisLikeVO blliPostingDisLikeVO) {
		sqlSessionTemplate.update("posting.updateMinusPostingDisLikeCount", blliPostingDisLikeVO);
	}
	/**
	  * @Method Name : selectThisPostingScrap
	  * @Method 설명 : 포스팅의 스크랩을 이미했는지 파악해줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliMemberScrapVO
	  * @return
	 */
	@Override
	public int selectThisPostingScrape(BlliMemberScrapeVO blliMemberScrapeVO) {
		return sqlSessionTemplate.selectOne("posting.selectThisPostingScrape", blliMemberScrapeVO);
	}
	/**
	  * @Method Name : selectThisPostingLike
	  * @Method 설명 : 유저가 포스팅을 좋아했는지 여부를 파악해줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingLikeVO
	  * @return
	 */
	@Override
	public int selectThisPostingLike(BlliPostingLikeVO blliPostingLikeVO) {
		return sqlSessionTemplate.selectOne("posting.selectThisPostingLike", blliPostingLikeVO);
	}
	/**
	  * @Method Name : selectThisPostingDisLike
	  * @Method 설명 : 유저가 포스팅을 싫어했는지 여부를 파악해줍니다.
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliPostingDisLikeVO
	  * @return
	 */
	@Override
	public int selectThisPostingDisLike(BlliPostingDisLikeVO blliPostingDisLikeVO) {
		return sqlSessionTemplate.selectOne("posting.selectThisPostingDisLike", blliPostingDisLikeVO);
	}

	
	// 포스팅 스크랩, 좋아요 , 싫어요 관련 메서드 끝

	/**
	  * @Method Name : selectMemberDibsSmallProduct
	  * @Method 설명 : 회원이 소제품을 찜했는지 여부를 리턴해준다. 0 찜안함 / 1 찜함
	  * @작성일 : 2016. 1. 22.
	  * @작성자 : junyoung
	  * @param blliMemberDibsVO
	  * @return
	 */
	@Override
	public int selectMemberDibsSmallProduct(BlliMemberDibsVO blliMemberDibsVO) {
		return sqlSessionTemplate.selectOne("product.selectMemberDibsSmallProduct", blliMemberDibsVO);
	}

	@Override
	public void updateSearchTime(String smallProductId) {
		sqlSessionTemplate.update("product.updateSearchTime", smallProductId);
	}
	
	@Override
	public List<BlliSmallProductVO> selectSmallProductRank(String midCategoryId) {
		return sqlSessionTemplate.selectList("product.selectSmallProductRank", midCategoryId);
	}

	@Override
	public List<BlliSmallProductVO> searchMidCategory(HashMap<String, String> map) {
		return sqlSessionTemplate.selectList("product.searchMidCategory", map);
	}

	@Override
	public BlliSmallProductVO searchSmallProduct(String searchWord) {
		return sqlSessionTemplate.selectOne("product.searchSmallProduct", searchWord);
	}

	@Override
	public List<BlliSmallProductBuyLinkVO> getSmallProductBuyLink(String smallProductId) {
		return sqlSessionTemplate.selectList("product.getSmallProductBuyLink", smallProductId);
	}

	@Override
	public List<BlliSmallProductVO> getOtherSmallProductList(BlliSmallProductVO smallProductVO) {
		return sqlSessionTemplate.selectList("product.getOtherSmallProductList", smallProductVO);
	}

	@Override
	public List<BlliSmallProductVO> searchSmallProductList(HashMap<String, String> map) {
		return sqlSessionTemplate.selectList("product.searchSmallProductList", map);
	}

	@Override
	public int totalOtherSmallProduct(String midCategory) {
		return sqlSessionTemplate.selectOne("product.totalOtherSmallProduct", midCategory);
	}

	@Override
	public int totalPageOfSmallProductOfMidCategory(String searchWord) {
		return sqlSessionTemplate.selectOne("product.totalPageOfSmallProductOfMidCategory", searchWord);
	}

	@Override
	public int totalPageOfSmallProductRelatedSearchWord(String searchWord) {
		return sqlSessionTemplate.selectOne("product.totalPageOfSmallProductRelatedSearchWord", searchWord);
	}

	@Override
	public List<BlliSmallProductVO> selectAllSmallProduct() {
		return  sqlSessionTemplate.selectList("product.selectAllSmallProduct");
	}

	@Override
	public int selectPostingNumBySmallProductId(String smallProductId) {
		return sqlSessionTemplate.selectOne("product.selectPostingNumBySmallProductId", smallProductId);
	}

	@Override
	public int selectBuyLinkClickCountBySmallProductId(String smallProductId) {
		return sqlSessionTemplate.selectOne("product.selectBuyLinkClickCountBySmallProductId", smallProductId);
	}

	@Override
	public void updateProductScore(BlliSmallProductVO blliSmallProductVO) {
		sqlSessionTemplate.update("product.updateProductScore", blliSmallProductVO);
	}

	@Override
	public int selectSmallProductNumByMidCategoryId(String midCategoryId) {
		return sqlSessionTemplate.selectOne("product.selectSmallProductNumByMidCategoryId", midCategoryId);
	}

	@Override
	public String getSmallProductStatus(String smallProductId) {
		return sqlSessionTemplate.selectOne("product.getSmallProductStatus", smallProductId);
	}

	@Override
	public int isSmallProductSeller(BlliSmallProductBuyLinkVO blliSmallProductBuyLinkVO) {
		return sqlSessionTemplate.selectOne("product.isSmallProductSeller", blliSmallProductBuyLinkVO);
	}

	@Override
	public void insertDeadSmallProduct(BlliSmallProductVO blliSmallProductVO) {
		sqlSessionTemplate.insert("product.insertDeadSmallProduct", blliSmallProductVO);
	}

	@Override
	public List<String> selectMidCategoryVOList() {
		return sqlSessionTemplate.selectList("product.selectMidCategoryVOList");
	}

	@Override
	public List<BlliSmallProductVO> selectAllSmallProductByMidCategoryId(String midCategoryId) {
		return sqlSessionTemplate.selectList("product.selectAllSmallProductByMidCategoryId",midCategoryId);
	}

	@Override
	public void updateSmallProductRanking(BlliSmallProductVO blliSmallProductVO) {
		sqlSessionTemplate.update("product.updateSmallProductRanking",blliSmallProductVO);
	}

	@Override
	public void updateSmallProductDetailViewCount(String smallProductId) {
		sqlSessionTemplate.update("product.updateSmallProductDetailPageView",smallProductId);
	}

	@Override
	public void insertBlliBuyLinkClick(BlliBuyLinkClickVO blliBuyLinkClickVO) {
		sqlSessionTemplate.insert("product.insertBlliBuyLinkClick", blliBuyLinkClickVO);
	}

	@Override
	public void updateBlliBuyLinkClickCount(String smallProductId) {
		sqlSessionTemplate.update("product.updateBlliBuyLinkClickCount",smallProductId);
	}

	@Override
	public List<BlliWordCloudVO> selectWordCloudList(String smallProductId) {
		return sqlSessionTemplate.selectList("product.selectWordCloudList", smallProductId);
	}

	@Override
	public String selectProductMinPrice(String smallProductId) {
		return sqlSessionTemplate.selectOne("product.selectProductMinPrice", smallProductId);
	}

	@Override
	public String selectTotalProductNum() {
		return sqlSessionTemplate.selectOne("product.selectTotalProductNum");
	}

	@Override
	public void subtractDbInsertPostingCount(String smallProductId) {
		sqlSessionTemplate.update("product.subtractDbInsertPostingCount", smallProductId);
	}

	@Override
	public void subtractDbInsertPostingCountByTemptdead(HashMap<String, Object> map) {
		sqlSessionTemplate.update("product.subtractDbInsertPostingCountByTemptdead", map);
	}

	@Override
	public int updateSmallProductStatusToConfirmedByAdmin(String smallProductId) {
		return sqlSessionTemplate.update("product.updateSmallProductStatusToConfirmedByAdmin", smallProductId);
	}

	@Override
	public void updateSmallProductStatusToDead(String smallProductId) {
		sqlSessionTemplate.update("product.updateSmallProductStatusToDead", smallProductId);
	}

	@Override
	public BlliSmallProductVO getSmallProductWhenToUse(String midCategoryId) {
		return sqlSessionTemplate.selectOne("product.getSmallProductWhenToUse", midCategoryId);
	}

	@Override
	public void updateMidCategoryWhenToUse(BlliSmallProductVO smallProductVO) {
		sqlSessionTemplate.update("product.updateMidCategoryWhenToUse", smallProductVO);
	}

	@Override
	public int updateSmallProductStatusToDeadBySoldOut(String midCategoryId) {
		return sqlSessionTemplate.update("product.updateSmallProductStatusToDeadBySoldOut", midCategoryId);
	}

	@Override
	public void resetSmallProductUpdateColumn(String midCategoryId) {
		sqlSessionTemplate.update("product.resetSmallProductUpdateColumn", midCategoryId);
	}

	@Override
	public List<String> getSmallProductIdBySoldOut(String midCategoryId) {
		return sqlSessionTemplate.selectList("product.getSmallProductIdBySoldOut", midCategoryId);
	}

	@Override
	public void deleteSmallProductBuyLink(String smallProductId) {
		sqlSessionTemplate.delete("product.deleteSmallProductBuyLink", smallProductId);
	}

	@Override
	public String getSmallProductName(String smallProductId) {
		return sqlSessionTemplate.selectOne("product.getSmallProductName", smallProductId);
	}

	@Override
	public void updateSmallProductStatusToUnconfirmed(String smallProductId) {
		sqlSessionTemplate.update("product.updateSmallProductStatusToUnconfirmed", smallProductId);
	}

	@Override
	public void updateSmallProductInfo(BlliSmallProductVO blliSmallProductVO) {
		sqlSessionTemplate.update("product.updateSmallProductInfo", blliSmallProductVO);
	}

	@Override
	public void addDbInsertPostingCount(String smallProductId) {
		sqlSessionTemplate.update("product.addDbInsertPostingCount", smallProductId);
	}

	@Override
	public List<String> getDibSmallProductId(String memberId) {
		return sqlSessionTemplate.selectList("product.getDibSmallProductId", memberId);
	}

	@Override
	public BlliSmallProductVO getDibSmallProduct(String smallProductId) {
		return sqlSessionTemplate.selectOne("product.getDibSmallProduct", smallProductId);
	}

	@Override
	public List<BlliSmallProductBuyLinkVO> getDibSmallProductBuyLink(String smallProductId) {
		return sqlSessionTemplate.selectList("product.getDibSmallProductBuyLink", smallProductId);
	}

}
