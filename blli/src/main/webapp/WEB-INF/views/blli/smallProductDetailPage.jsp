<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$.ajaxSetup({ cache: false });

	//무한 스크롤의 현재 페이지 넘버를 저장
	var pageNum = 1;
	
	// ===== Scroll to Top ==== 
	$(window).scroll(function() {
		currentScrollTop = $(window).scrollTop();
	    if ($(this).scrollTop() >= 200) {        // If page is scrolled more than 50px
	        $('#return-to-top').fadeIn(200);    // Fade in the arrow
	    } else {
	        $('#return-to-top').fadeOut(200);   // Else fade out the arrow
	    }
	  //사이드의 소분류 제품 리스트를 고정시켜줌
	    if($(this).scrollTop()>900){
	    	 $('.main_right_list').css("margin-top",$(this).scrollTop()-900);
	    }else{
	    	 $('.main_right_list').css("margin-top",0);
	    }
	});
	$('#return-to-top').click(function() {      // When arrow is clicked
		$('body,html').stop().animate({
	        scrollTop : 0                       // Scroll to top of body
	    }, 2000);
	});

	//블로그로 이동시키며 체류시간을 측정하는 함수
	function goBlogPosting(targetURL,smallProductId){
		//도착시간 체크를 위해 
		var connectDate = new Date();
		var connectTime = connectDate.getTime();
		window.open(targetURL, "_blank");
		//중복 실행 방지 메서드
		var count = 0;
		//다시 사용자가 본 서비스 브라우져에서 움직였을 때 메서드 체류시간 기록
		setTimeout(function(){
			$('body').mouseover(function(){
				if(count==0){
					count=1;
					var exitDate = new Date();
					var exitTime = exitDate.getTime();
					var residenceTime = Math.round((exitTime - connectTime)/1000);
					$.ajax({
						type:"get",
						url:"recordResidenceTime.do?postingUrl="
							+targetURL+"&smallProductId="
							+smallProductId+"&postingTotalResidenceTime="
							+residenceTime,
							success:function(date){
							alert('체류시간 기록 완료 : '+residenceTime+'초');
							}
					});
				}else{
					return false;
				}
		 	}); 
		},2000);
	}
	
	$(document).ready(function(){
		var width = $(document).width();
		var count = 0;
		var totalImageWidth = 0;
		var currImageWidth = 0;
		
		window.onload = function(){
			$(".slideImg").each(function() {
	        	count++;
	        	width = width - $(this).width();
	        	totalImageWidth = totalImageWidth + $(this).width();
		        if($(".slideImg").length == count){
		        	var index = 0;
		        	$(".slideImg").each(function(i) {
		        		currImageWidth = currImageWidth + $(this).width();
		        		if(currImageWidth > (totalImageWidth/2)){
		        			index = i;
		        			return false;
		        		}
		        	});
		        	if(width > 0){
		        		$("#slide_img_list").flickity({
	        				cellAlign: 'center',
	        				imagesLoaded: 'true',
	        				initialIndex: index
	        			});
		        		return false;
		        	}else{
		        		$("#slide_img_list").flickity({
		        			wrapAround: 'true',
	        				imagesLoaded: 'true'
	        			});
		        		return false;
		        	}
		        }
		    });
		};
		
		$( '.jbMenu' ).addClass( 'jbFixed' );
		//소제품 찜하기 스크립트
		$('.in_fr').on("click", ".smallProductDibBtn",function(){
			var smallProductId = $(this).children('.smallProductId').val();
			$.ajax({
				type:"get",
				url:"smallProductDib.do?memberId=${sessionScope.blliMemberVO.memberId}&smallProductId="+smallProductId,
				success:function(result){
					$('.smallProductDibBtn').each(function(index){
						if($($('.smallProductDibBtn').get(index)).children('.smallProductId').val()==smallProductId){
							if(result==1){
								$($('.smallProductDibBtn').get(index)).children('.fa').removeClass("fa-heart-o").addClass("fa-heart");
								var dibsCount = $($('.smallProductDibBtn').get(index)).children('.dibsCount').text();
								dibsCount *= 1
								$($('.smallProductDibBtn').get(index)).children('.dibsCount').text(dibsCount+1);
							}else{
								$($('.smallProductDibBtn').get(index)).children('.fa').removeClass("fa-heart").addClass("fa-heart-o");
								var dibsCount = $($('.smallProductDibBtn').get(index)).children('.dibsCount').text();
								dibsCount *= 1
								$($('.smallProductDibBtn').get(index)).children('.dibsCount').text(dibsCount-1);
							}
						}
					}) 
				}
			});
		}); 
		//포스팅 스크랩 스크립트
		$('.in_fr').on("click", ".postingScrapeBtn",function(){
			var comp = $(this);
			$.ajax({
				type:"get",
				url:"postingScrape.do?memberId=${sessionScope.blliMemberVO.memberId}&smallProductId="+$(comp).parent('.sns').children('.smallProductIdInfo').val()
						+'&postingUrl='+$(comp).parent('.sns').children('.postingUrlInfo').val(),
				success:function(result){
					if(result==1){
						$(comp).css('color','orange');
						var count = $(comp).siblings('.scrapeCount').text();
						count *= 1;
						$(comp).siblings('.scrapeCount').text(count+1);
					}else if(result==0){
						$(comp).css('color','gray');
						var count = $(comp).siblings('.scrapeCount').text();
						count *= 1;
						$(comp).siblings('.scrapeCount').text(count-1);
					}
				}
			}); 
		});
		//포스팅 좋아요 스크립트
		$('.in_fr').on("click", ".postingLikeBtn",function(){
			var comp = $(this);
			$.ajax({
				type:"get",
				url:"postingLike.do?memberId=${sessionScope.blliMemberVO.memberId}&smallProductId="+$(comp).parent('.sns').children('.smallProductIdInfo').val()
						+'&postingUrl='+$(comp).parent('.sns').children('.postingUrlInfo').val(),
				success:function(result){
					if(result==1){
						$(comp).css('color','hotpink');
						var count = $(comp).siblings('.likeCount').text();
						count *= 1;
						$(comp).siblings('.likeCount').text(count+1);
					}else if(result==0){
						$(comp).css('color','gray');
						var count = $(comp).siblings('.likeCount').text();
						count *= 1;
						$(comp).siblings('.likeCount').text(count-1);
					}
				}
			}); 
		});
		
		//포스팅 싫어요 스크립트
		$('.in_fr').on("click", ".postingDisLikeBtn",function(){
			var comp = $(this);
			$.ajax({
				type:"get",
				url:"postingDisLike.do?memberId=${sessionScope.blliMemberVO.memberId}&smallProductId="+$(comp).parent('.sns').children('.smallProductIdInfo').val()
						+'&postingUrl='+$(comp).parent('.sns').children('.postingUrlInfo').val(),
				success:function(result){
					if(result==1){
						$(comp).css('color','hotpink');
						var count = $(comp).siblings('.disLikeCount').text();
						count *= 1;
						$(comp).siblings('.disLikeCount').text(count+1);
					}else if(result==0){
						$(comp).css('color','gray');
						var count = $(comp).siblings('.disLikeCount').text();
						count *= 1;
						$(comp).siblings('.disLikeCount').text(count-1);
					}
				}
			}); 
		});
		
		
		//무한 스크롤
		$(window).scroll(function(){ 
		    if($(window).scrollTop() >= $(document).height() - $(window).height()){  
		    	setTimeout(function(){$("#loading").show();}, 100)
		    	setTimeout(function(){loadingPostingList();}, 800)
		    	setTimeout(function(){$("#loading").hide();}, 600)
		    }
		});
		
		function loadingPostingList(){
			pageNum++;
    		var smallProductId='${requestScope.smallProductInfo.smallProduct.smallProductId}';
	    	
	    	$.ajax({
	    		type : "get",
	    		url : "selectPostingBySmallProductInSmallProductDetailView.do?pageNum="+pageNum+"&smallProductId="+smallProductId,
	    		success : function(data){
	    			var leftProductAjaxHTML = "";
	    			var rightPostingAjaxHTML = "";
	    			
	    			if(data.length==0){
	    				alert('현재 추천되는 소제품 관련 포스팅은 여기까지 입니다 ^^');
	    			}
	    			for(var i=0;i<data.length;i++){
	    				var postingScrapeAjaxHTML = '<i class="fa fa-bookmark-o postingScrapeBtn" style="color: gray" data-tooltip-text="스크랩해두시면 스크랩페이지에서 다시볼 수 있어요!"></i> ';
		    			var postingLikeAjaxHTML = '<i class="fa fa-thumbs-up postingLikeBtn" style="color: gray" data-tooltip-text="유익한 블로그였다면 바로 좋아요!"></i> ';
		    			var postingDisLikeAjaxHTML = '<i class="fa fa-thumbs-down postingDisLikeBtn" style="color: gray" data-tooltip-text="광고,상관없는 포스팅등은 가차없이 싫어요!"></i> ';
		    			
	    				if(data[i].isScrapped==1){
	    					postingScrapeAjaxHTML = '<i class="fa fa-bookmark postingScrapeBtn" style="color: orange" data-tooltip-text="스크랩해두시면 스크랩페이지에서 다시볼 수 있어요!"></i>';
	    				}
	    				if(data[i].isLike==1){
	    					postingLikeAjaxHTML = '<i class="fa fa-thumbs-up postingLikeBtn" style="color: hotpink" data-tooltip-text="유익한 블로그였다면 바로 좋아요!"></i>';
	    				}
	    				if(data[i].isDisLike==1){
	    					postingDisLikeAjaxHTML = '<i class="fa fa-thumbs-down postingDisLikeBtn" style="color: hotpink" data-tooltip-text="광고,상관없는 포스팅등은 가차없이 싫어요!"></i>';
	    				}
	    				$('.postingForSmallProduct').each(function(index){
	    						if(data[i].smallProductId==$($('.postingForSmallProduct').get(index)).children('.product_price').children('.fr').children().children('.smallProductId').val()){
		    						leftProductAjaxHTML += '<div style="height:357px;margin-left: 30px;width: 120px;" class="postingForSmallProduct">';
		    						leftProductAjaxHTML += $($('.postingForSmallProduct').get(index)).html();
		    						leftProductAjaxHTML += '</div>';
		    						return false;
			    				}
	    				})
						
					
						rightPostingAjaxHTML +=
						'<div style="height:325px; border: 1px solid #ccc;border-radius: 10px; margin-bottom:30px;"><div class="result_ti">'+
						'<div style="width:450px; overflow:hidden;white-space:nowrap; text-overflow:ellipsis;">'+
						data[i].postingTitle+
						'</div></div><div style="height:245px;"><div class="result_foto fl">'
						+'<a href="#" onclick=goBlogPosting("'+data[i].postingUrl+'","'+data[i].smallProductId+'")>'
						+'<img src="'+
						data[i].postingPhotoLink+
						'" style="width: 335px; height: 235px; MARGIN-LEFT:5px;"></a></div><div class="fl"><div class="product_text2">'+
						data[i].postingSummary+
						'</div><div class="product_id"><div style="width:180px; overflow:hidden;white-space:nowrap; text-overflow:ellipsis;">'+
						data[i].postingAuthor+
						'</div></div></div></div><div class="product_sns"><div class="fl score">'+
						data[i].postingScore+
						'점</div><div class="fr sns">'+
						'<input type="hidden" class="smallProductIdInfo" value="'+data[i].smallProductId+'">'+
						'<input type="hidden" class="postingUrlInfo" value="'+data[i].postingUrl+'">'+
						postingScrapeAjaxHTML+
						'<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="scrapeCount">'+data[i].postingScrapeCount+'</span>'+
						postingLikeAjaxHTML+
						'<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="likeCount">'+data[i].postingLikeCount+'</span>'+
						postingDisLikeAjaxHTML+
						'<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="disLikeCount">'+data[i].postingDislikeCount+'</span>'+
						'</div></div></div>'
	    			}
	    			
	    			$('.main_left_product').append(leftProductAjaxHTML);
	    			$('.main_left_con').append(rightPostingAjaxHTML);
	    			leftProductAjaxHTML = "";
	    		}
	   		});
		}
		
	});
</script>
<div class="jbContent">
	<div class="result_bg1">
			<div class="in_fr" style="height:330px;">
				<div class="result_num">
					1
				</div>
				<div class="result_con">
					<div class="result_ti">
						${requestScope.smallProductInfo.smallProduct.smallProduct} 
					</div>
					<div>
						<div class="result_foto fl">
							<img src="${requestScope.smallProductInfo.smallProduct.smallProductMainPhotoLink}" alt="${requestScope.smallProductInfo.smallProduct.smallProduct}" style="width: 100%; height: 100%; vertical-align: middle;">
							<div class="product_month">
								${requestScope.smallProductInfo.smallProduct.smallProductWhenToUseMin}~${requestScope.smallProductInfo.smallProduct.smallProductWhenToUseMax}<br/>
								개월
							</div>
						</div>
						<div class="fl">
							<div class="product_text">
								하은맘 프라임 샴푸 의자 이젠 32개월 모야 안고 머리감기는 일 너무 힘들어요~ 무게도 덩치도
								발육이 남다른 모야 ~ 구상도를보면 참 많은 생각을 하시고 제작하신것 같아요
							</div>
							<div class="product_price">
								<div class="fl">
									<p class="result_gray">최저가</p>
									<p class="result_price">${requestScope.smallProductInfo.smallProduct.minPrice}원</p>
								</div>
								<div class="fr">
									<div style="margin-top: 15px" class="smallProductDibBtn" data-tooltip-text="찜해두시면 스크랩페이지에서 다시 보실 수 있어요!">
										<c:if test="${requestScope.smallProductInfo.smallProduct.isDib==0}">
											<i class="fa fa-heart-o fa-2x" style="color: red"></i>
										</c:if>
										<c:if test="${requestScope.smallProductInfo.smallProduct.isDib==1}">
											<i class="fa fa-heart fa-2x" style="color: red"></i>
										</c:if>
											<span style="font-size: 15px ;color: gray;" class="dibsCount">${requestScope.smallProductInfo.smallProduct.smallProductDibsCount}</span>
											<input type="hidden" value="${requestScope.smallProductInfo.smallProduct.smallProductId}" class="smallProductId">
									</div>
									
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="result_last fr">
					<ul>
						<li>
							<p class="result_sns">${requestScope.smallProductInfo.smallProduct.dbInsertPostingCount}</p>
							<p class="result_sns_text">blog</p>
						</li>
						<li>
							<p class="result_sns">${requestScope.smallProductInfo.smallProduct.smallProductScore}</p>
							<p class="result_sns_text">Point</p>
						</li>
					</ul>
					<div style="text-align:center;">
					<!-- 페이스북 공유 -->
					<div id="fb-root"></div>
				    <script src='http://connect.facebook.net/en_US/all.js'></script>
				     <script src="https://developers.kakao.com/sdk/js/kakao.story.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="/js/kakaolink.js"></script>
				    <!-- 공유끝 -->
					<a onclick='postToFeed(); return false;'><img src="${initParam.root}img/fbShareBtn.png" alt="페이스북 공유하기"></a>
					<a style="cursor:pointer;" id='kakao-login-btn' 
					onclick="kakaolink_send('블리!', 'http://bllidev.dev/projectBlli2/goSmallProductDetailView.do?smallProduct=${requestScope.smallProductInfo.smallProduct.smallProduct}');" >
					<img src="${initParam.root}img/kakaoShareBtn.png" alt="카스 공유하기"></a>
					
					</div>
					<script> 
					      FB.init({appId: "476938162497817", status: true, cookie: true});
					  	
					      function postToFeed() {
					        var obj = {
					          method: 'feed',
					          redirect_uri:"http://bllidev.dev/projectBlli2/goSmallProductDetailView.do?smallProduct=${requestScope.smallProductInfo.smallProduct.smallProduct}",
					          link: "http://bllidev.dev/projectBlli2/goSmallProductDetailView.do?smallProduct=${requestScope.smallProductInfo.smallProduct.smallProduct}",
					          picture: 'http://bllidev.dev/projectBlli2/scrawlImage/smallProduct/${requestScope.smallProductInfo.smallProduct.smallProductMainPhotoLink}',
					          name: '충동구매보다 빠른 합리적 소비!',
					          caption: '블리가 추천하는 유아용품! 포스팅과 함께 확인하세요',
					          description: '블리가 추천하는 유아용품! 광고없는 !! 포스팅과 함께 확인하세요'
					        };
					 
					        function callback(response) {
								snsShareCountUp();
					        }
					        FB.ui(obj, callback);
					      }
					  	 // 사용할 앱의 JavaScript 키를 설정해 주세요.
					      Kakao.init('7e613c0241d9f07553638f04b7df66ef');
					
							
					      function kakaolink_send(text, targetURL){
					    	var n = "http://bllidev.dev/projectBlli2/goSmallProductDetailView.do?smallProduct=".length;
					    	var koreanWord = targetURL.substring(n,targetURL.length);
					    	var url = targetURL.substring(0,n)+encodeURIComponent(koreanWord);
					    	alert("koreanWord:"+koreanWord);
					    	alert("url:"+url);
					      	Kakao.Auth.login({
					      		success: function(authObj) {
					      			 Kakao.API.request( {
					      				 url : '/v1/api/story/linkinfo',
					      				 data : {
					      				   url : url
					      				 }
					      			   }).then(function(res) {
					      				 // 이전 API 호출이 성공한 경우 다음 API를 호출합니다.
					      				 return Kakao.API.request( {
					      				   url : '/v1/api/story/post/link',
					      				   data : {
					      					 link_info : res
					      				   }
					      				 });
					      			   }).then(function(res) {
					      				 return Kakao.API.request( {
					      				   url : '/v1/api/story/mystory',
					      				   data : { id : res.id }
					      				 });
					      			   }).then(function(res) {
					      				 snsShareCountUp();
					      			   }, function (err) {
					      				 alert(JSON.stringify(err));
					      			   });
					      		}
					      	});
					      }
					     function snsShareCountUp(){
					    	 alert('${requestScope.smallProductInfo.smallProduct}');
					    	 $.ajax({
									type:"get",
									url:"snsShareCountUp.do?smallProductId=${requestScope.smallProductInfo.smallProduct.smallProductId}",
									success:function(){
										
								}
							}); 
					     }
					
				</script>
				</div>
			</div>
		</div>
		<div class="result_bg2">
			<div class="in_fr" style="clear:both;">
				<div class="detail_list fl">
					<div class="result_ti">
						쇼핑몰 리스트 
					</div>
					<div style="overflow-y:auto; height: 247px;">
						<table>
							<colgroup>
								<col width="15%">
								<col width="15%">
								<col width="20%">
								<col width="30%">
								<col width="20%">
							</colgroup>
							<tr>
								<th>
									쇼핑몰
								</th>
								<th>
									판매가
								</th>
								<th>
									배송비
								</th>
								<th>
									부가정보
								</th>
								<th>
									사러가기
								</th>
							</tr>
							<c:forEach items="${requestScope.smallProductInfo.buyLink}" var="sellerInfo">
								<tr>
									<td>
										${sellerInfo.seller}
									</td>
									<td>
										${sellerInfo.buyLinkPrice}원
									</td>
									<td>
										${sellerInfo.buyLinkDeliveryCost}
									</td>
									<td>
										<c:if test="${sellerInfo.buyLinkOption == null}">
											없음
										</c:if>
										<c:if test="${sellerInfo.buyLinkOption != null}">
											${sellerInfo.buyLinkOption}
										</c:if>
									</td>
									<td>
										<form action="goBuyMidPage.do" method="post" id="smallProductLinkInfo">
											<img src="${initParam.root}img/bt_buy.png" alt="사러가기" onclick="submit();" style="cursor: pointer;">
											<input type="hidden" name="buyLink" value="${sellerInfo.buyLink}"> 
											<input type="hidden" name="smallProductId" value="${sellerInfo.smallProductId}"> 
											<input type="hidden" name="memberId" value="${sessionScope.blliMemberVO.memberId}"> 
											<input type="hidden" name="seller" value="${sellerInfo.seller}"> 
										</form>
										
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="detail_list fr">
					<div class="result_ti">
						동일 제품점수별로 보기
					</div>
					<div style="overflow-y:auto; height: 247px;">
						<table id="otherProductInfo">
							<colgroup>
								<col width="10%">
								<col width="50%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<tr>
								<th>
									순위
								</th>
								<th>
									제품명
								</th>
								<th>
									점수
								</th>
								<th>
									보러가기
								</th>
							</tr>
							<c:forEach items="${requestScope.smallProductInfo.otherSmallProductList}" var="productList" varStatus="rank">
								<tr>
									<td>
										${rank.count}
									</td>
									<td>
										${productList.smallProduct}
									</td>
									<td>
										${productList.smallProductScore}
									</td>
									<td>
										<a href="${initParam.root}goSmallProductDetailView.do?smallProduct=${productList.smallProduct}"><img src="${initParam.root}img/bt_see.png" alt="보러가기"></a>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	<div class="jbMenu2">
		<div id="slide_img_list">
			<c:forEach items="${requestScope.postingSlideList}" var="postingList">
				<div style="height: 175px; display: inline-block;">
					<a href="javascript:goBlogPosting('${postingList.postingUrl}','${postingList.smallProductId}');">
						<img src="${postingList.postingPhotoLink}" alt="${requestScope.smallProductInfo.smallProduct.smallProduct}" class="slideImg">
					</a>
				</div>
			</c:forEach>
		</div>
	</div>
	<!-- 키워드 -->
		<div class="in_fr">
			<div class="result_ti">
				Keyword
			</div>
			<div class="keyword">
				<ul>
					<c:forEach items="${requestScope.wordCloudList}" var="wordList">
						<li>
							<span class="key${wordList.wordLevel}">${wordList.word}</span>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!-- 블로그 내용 -->
		
		<div class="in_fr" style="margin-top:20px; clear:both;">
		<div class="main_ti">
			추천 상품을 포스팅한 블로그들
		</div>
		<div class="main_left_product">
			<c:forEach items="${requestScope.blliPostingVOList}" var="postingList">
				
			<div style="height:357px;margin-left: 30px;width: 120px;" class="postingForSmallProduct">
				<div class="foto170">
					<a href = "goSmallProductDetailView.do?smallProduct=${requestScope.smallProductInfo.smallProduct.smallProduct}">
					<img src="${requestScope.smallProductInfo.smallProduct.smallProductMainPhotoLink} " style="height: 120px; width: 120px;">
					</a>
					<div class="product_month">
							${requestScope.smallProductInfo.smallProduct.smallProductWhenToUseMin}~${requestScope.smallProductInfo.smallProduct.smallProductWhenToUseMax}<br/>
						개월
					</div>
				</div>
				<div class="main_product_ti">
						<div style='width:120px; overflow:hidden;white-space:nowrap; text-overflow:ellipsis;'>
							${requestScope.smallProductInfo.smallProduct.smallProduct} / ${requestScope.smallProductInfo.smallProduct.smallProductMaker}
						</div>
				</div>
				
				<div class="product_price" style="margin:0px;">
					<div class="fl">
						<p class="result_gray">최저가</p>
						<p class="result_price">${requestScope.smallProductInfo.smallProduct.minPrice}원</p>
					</div>
				
					<div class="fr">
						
						<div style="margin-top: 15px" class="smallProductDibBtn" data-tooltip-text="찜해두시면 스크랩페이지에서 다시 보실 수 있어요!">
						<c:if test="${requestScope.smallProductInfo.smallProduct.isDib==0}">
							<i class="fa fa-heart-o fa-2x" style="color: red"></i>
						</c:if>
						<c:if test="${requestScope.smallProductInfo.smallProduct.isDib==1}">
							<i class="fa fa-heart fa-2x" style="color: red"></i>
						</c:if>
							<span style="font-size: 15px ;color: gray;" class="dibsCount">${requestScope.smallProductInfo.smallProduct.smallProductDibsCount}</span>
							<input type="hidden" value="${requestScope.smallProductInfo.smallProduct.smallProductId}" class="smallProductId">
						</div>
					</div>
				</div>
			</div>
			
			</c:forEach>
		</div>
		
		<div class="main_left_con">
			<c:forEach items="${requestScope.blliPostingVOList}" var="postingList">
			<div style="height:325px; border: 1px solid #ccc;border-radius: 10px; margin-bottom:30px;">
				<div class="result_ti">
					<div style='width:450px; overflow:hidden;white-space:nowrap; text-overflow:ellipsis;'>
							${postingList.postingTitle}
					</div>
					
				</div>
				<div style="height:245px;">
					<div class="result_foto fl">
					
						<a href="#" onclick="goBlogPosting('${postingList.postingUrl}','${postingList.smallProductId}')">
							<img src="${postingList.postingPhotoLink}" style="width: 335px; height: 235px; MARGIN-LEFT:5px;">
						</a>
					</div>
					<div class="fl">
						<div class="product_text2">
							${postingList.postingSummary}
						</div>
						<div class="product_id">
							<div style='width:180px; overflow:hidden;white-space:nowrap; text-overflow:ellipsis;'>
								${postingList.postingAuthor}
							</div>
						</div>
					</div>
				</div>
				<div class="product_sns">
					<div class="fl score">
						${postingList.postingScore}점
					</div>
					<div class="fr sns">
						<input type="hidden" class="smallProductIdInfo" value="${postingList.smallProductId}">
						<input type="hidden" class="postingUrlInfo" value="${postingList.postingUrl}">
						<c:if test="${postingList.isScrapped==0}">
							<i class="fa fa-bookmark-o postingScrapeBtn" style="color: gray" data-tooltip-text="스크랩해두시면 스크랩페이지에서 다시 보실 수 있어요!"></i>
							<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="scrapeCount">${postingList.postingScrapeCount}</span>
						</c:if>
						<c:if test="${postingList.isScrapped==1}">
							<i class="fa fa-bookmark postingScrapeBtn" style="color: orange" data-tooltip-text="스크랩해두시면 스크랩페이지에서 다시 보실 수 있어요!"></i>
							<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="scrapeCount">${postingList.postingScrapeCount}</span>
						</c:if>		
						<c:if test="${postingList.isLike==0}">
							<i class="fa fa-thumbs-up postingLikeBtn" style="color: gray" data-tooltip-text="유익한 내용의 블로그였다면 좋아요!"></i>
							<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="likeCount">${postingList.postingLikeCount}</span>
						</c:if>
						<c:if test="${postingList.isLike==1}">
							<i class="fa fa-thumbs-up postingLikeBtn" style="color: hotpink" data-tooltip-text="유익한 내용의 블로그였다면 좋아요!"></i>
							<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="likeCount">${postingList.postingLikeCount}</span>
						</c:if>
						<c:if test="${postingList.isDisLike==0}">
							<i class="fa fa-thumbs-down postingDisLikeBtn" style="color: gray" data-tooltip-text="광고,상관없는 포스팅등은 가차없이 싫어요!"></i>
							<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="disLikeCount">${postingList.postingDislikeCount}</span>
							
						</c:if>
						<c:if test="${postingList.isDisLike==1}">
							<i class="fa fa-thumbs-down postingDisLikeBtn" style="color: hotpink" data-tooltip-text="광고,상관없는 포스팅등은 가차없이 싫어요!"></i>
							<span style="font-size: 11px; line-height: 16px ;margin-right:15px" class="disLikeCount">${postingList.postingDislikeCount}</span>
							
						</c:if>
					</div>
				</div>
			</div>
			<%-- <p align="center"><img id="loading" src="${initParam.root}image/loading.gif" style="width: 50px"></p> --%>
			</c:forEach>
		</div>
		<div class="main_right_list">
			<div class="main_right_ti">
				월령별 추천상품
			</div>
			<div class="accordion accordion1">
				<c:forEach items="${requestScope.smallProductInfo.otherSmallProductList}" var="productList" varStatus="rank">
				<div class="accordion-section">
					<input type="hidden" value="${recommProductList.midCategoryId}" class="midCategoryIdValue">
					<a href="${initParam.root}goSmallProductDetailView.do?smallProduct=${productList.smallProduct}" class="smallProductSideSection">
						<div class="foto50">
							<img alt="" src="${initParam.root}${productList.smallProductMainPhotoLink }" style="width: 50px;height: 50px;">
						</div>
						<div class="main_right_name">
							<div style='width:150px; overflow:hidden;white-space:nowrap; text-overflow:ellipsis;'>
							${productList.smallProduct}
							</div>
						</div>
					</a> 
				</div>
				</c:forEach>
			</div>

		</div>
		<a href="#" id="return-to-top"><i class="fa fa-chevron-up"></i></a>
	</div>
</div>