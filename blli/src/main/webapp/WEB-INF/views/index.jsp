<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>블리 - 충동구매보다 빠른 합리적 쇼핑!</title>
<link href="${initParam.root}img/favicon/favicon.ico" rel="shortcut icon" type="image/x-icon" />
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<!-- 스타일 시트 -->
<link rel="stylesheet" type="text/css" href="./css/reset.css" />
<link rel="stylesheet" type="text/css" href="./css/css.css" />
<!-- jquery -->
<script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!-- 카카오로그인 스크립트 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- 네이버 로그인 용 스크립트 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if("${requestScope.deny}" != ""){
		alert("${requestScope.deny}");
		location.href="${initParam.root}index.do";
	}
	$.ajax({
		type:"get",
		url:"footerStatics.do",
		success:function(data){
			$('.footerProductStatics').text(data.productStatics);
			$('.footerPostingStatics').text(data.postingStatics);
		}
	});
});
</script>
</head>
<body class="login_bg">
 	<sec:authorize access="hasAnyRole('ROLE_USER')">
		<script type="text/javascript">
			location.href='${initParam.root}member_proceedingToMain.do'
		</script>
</sec:authorize>

<!-- 아이정보를 입력하지 않은 자동로그인 사용자 && 이미 로그인한 유저의 경우 authorityCheck.jsp로 가서 아이정보 입력 -->
<sec:authorize access="hasAnyRole('ROLE_RESTRICTED')">
	<script type="text/javascript">
		location.href='${initParam.root}authorityCheck.do'
	</script>
</sec:authorize>


	<!-- 자동로그인 된 관리자의 경우 관리자 페이지로 이동합니다. -->
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<script type="text/javascript">
			location.href='${initParam.root}authorityCheck.do'
		</script>
	</sec:authorize>
	
		<div class="login_bg2">
			<img src="./img/login_logo.png" class="login_logo"><br>
			<img src="./img/login_ti.png" style="margin-top:20px; margin-bottom:20px;"><br>
			<p style="margin-bottom: 40px">
				블리를 통해 충동구매보다 빠르게 합리적인 쇼핑을 즐기세요.<br/>
				이미 블리 회원이신가요? <a href="${initParam.root}loginPage.do" style="color: gold; font-weight: bolder;">로그인</a>
			</p>
			<div class="login_bt">
				<p><a href="#" onclick="checkLoginState()"><img src="./img/login_bt1.png" alt="페이스북으로 가입하기"></a>	</p>	
				<p><a href="#" onclick="kakaoLogin()"><img src="./img/login_bt2.png" alt="카카오톡으로 가입하기"></a></p>
				<p><a href="#" id="naver_id_login"><img src="./img/login_bt2.png" alt="네이버로 가입하기"></a></p>
				<p><a href="${initParam.root}goJoinMemberPage.do"><img src="./img/login_bt3.png" alt="이메일로 가입하기"></a></p>
			</div>
		</div>
		<div class="login_bottom">
			<div class="fl login_bottom_ft">
				블리는 <span class="footerProductStatics"></span>개의 상품을 소개하고, 관련된 <span class="footerPostingStatics"></span>개의 블로그를 분석하고 소개합니다.
			</div>
			<div class="fr">
				<div class="login_bottom_right">
				<a href="${initParam.root}admin_adminIndex.do"><img src="./img/bottom_app1.png" alt="안드로이드 다운로드받기"></a>
				<a href="#"><img src="./img/bottom_app2.png" alt="애플 다운로드받기"></a>
				</div>
			</div>
		</div>
	
		<!-- 네이버 로그인 버튼 -->
	<script type="text/javascript">
		
		//sns 공통 로그인 function
		function snsLogin(memberId,memberName,whichChannel){
			$.ajax({
            	type:"get",
            	url:"findMemberBySNSId.do?memberId="+whichChannel+"_"+memberId,
            	success:function(result){
            		if(result==true){
            			location.href="${initParam.root}loginBySNSId.do?memberId="
            					+whichChannel+"_"+memberId
            		}else{
            			location.href=
            				"${initParam.root}joinMemberBySNS.do?memberId="
            						+whichChannel+"_"+memberId+"&memberName="+memberName
            		}
            	}
            });
		}
		
		//네이버 아이디로 로그인 시작
		var naver_id_login = new naver_id_login("vy4NpIx3E_02LT8vXvkh", 
				"http://bllidev.dev/projectBlli2/");
		naver_id_login.setButton("green", 3,47);
		naver_id_login.setState("abcdefghijkmnopqrst");
		naver_id_login.init_naver_id_login();
		//get_naver_userprofile 동작후 callback 될 function
		function naverUserInfoCallBack(){
			var naverMail = naver_id_login.getProfileData('email')
			var naverName = naver_id_login.getProfileData('name');
			snsLogin(naverMail,naverName,'naver');
		}
		naver_id_login.get_naver_userprofile("naverUserInfoCallBack()");
		//네이버 아이디로 로그인 끝
      
		//카카오 아이디로 로그인 시작
     	Kakao.init('7e613c0241d9f07553638f04b7df66ef');
     	function kakaoLogin(){
        // 로그인 성공시, API를 호출합니다.
        Kakao.Auth.login({
	        success: function(authObj) {
	        	Kakao.API.request({
	                url: '/v1/user/me',
	                success: function(authObj) {
	                	 var kakaoId = authObj.id;
	                 	var kakaoNickName = authObj.properties.nickname;
	                 	snsLogin(kakaoId, kakaoNickName, 'kakao')
	                },
	                fail: function(error) {
                  alert(JSON.stringify(error))
               }
             });
        },
        fail: function(error) {
        	alert(JSON.stringify(error))
        }
        });       
      }
      //카카오 아이디로 로그인 끝
    
	//페이스북 로그인 시작    
	function checkLoginState() {
		FB.login(function(response) {
			if (response.authResponse) {
				FB.api('/me', function(response) {
					snsLogin(response.id, response.name, 'fb');
				});
			} else {
				alert('페이스북으로 로그인하기를 취소하셨습니다!');
			}
		}, {scope: 'email,user_likes'});
	}
			  window.fbAsyncInit = function() {
			  FB.init({
			    appId      : '{476938162497817}',
			    cookie     : true,  // 쿠키가 세션을 참조할 수 있도록 허용
			    xfbml      : true,  // 소셜 플러그인이 있으면 처리
			    version    : 'v2.5' // 버전 2.1 사용
			  });
			  
			    FB.getLoginStatus(function(response) {
			      statusChangeCallback(response);
			    });
			    
				};
	// SDK를 비동기적으로 호출
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		    if (d.getElementById(id)) return;
		    js = d.createElement(s); js.id = id;
		    js.src = 
		    	"//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=476938162497817";
		    fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
    </script>
    
<!--
  아래는 소셜 플러그인으로 로그인 버튼을 넣는다.
  이 버튼은 자바스크립트 SDK에 그래픽 기반의 로그인 버튼을 넣어서 클릭시 FB.login() 함수를 실행하게 된다.
-->


</body>
<!-- Google 애널리틱스 추적코드 -->
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-72734813-1', {'cookieDomain': 'none'});
ga('send', 'pageview');

</script>
</html>
