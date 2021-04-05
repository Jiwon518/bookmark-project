<%@page import="com.exam.user.UserTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 현재 세션 상태를 체크한다
	UserTO userInfo = null;
	if(session.getAttribute("userInfo") != null) {
		userInfo = (UserTO)session.getAttribute("userInfo");
		//System.out.println(session.getAttribute("userInfo"));
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책갈피</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>

<!-- sidebar -->
<link rel="stylesheet" type="text/css" href="./css/sidebar.css">
<script type="text/javascript" src="./js/sidebar.js"></script>


<!-- 검색어 입력 조건 -->
<script type="text/javascript">
	window.onload = function(){
		document.getElementById('search').onclick = function(){
			//alert('alertalert');
			
			if(document.search_frm.searchword.value.trim() == ''){
				alert('검색어를 입력하세요.');
				return false;
			}

		};
	};
</script>

<style type="text/css">
	
	#content {position: absolute; left: 50%; transform: translateX(-50%);}
	.button1{
	float: right;
	margin-right:0px;
	width: 30px;
	font-size: 20px;

}
.button2{
	float: right;
	margin-right: 50px;
	width: 30px;
	font-size: 20px;
}
.button3{
	float: right;
	width: 30px;
	font-size: 20px;
}
.intro_search{
	padding-left: 20px;
}
.tit_brunch{
	font-size: 50px;
}
.part{
	font-size: 25px;
}
</style>

</head>
<body>

<div id="mySidebar" class="sidebar">
	<div class="sidebar-header">
		<a><h3>당신의 책갈피</h3></a>
	</div>

	<%if (userInfo != null) {%>
		<div class="sidebar-userprofile">
			<div class="sidebar-user_img" align="center" style="padding-top: 10px; padding-bottom: 10px;">
				<img src="./profile/<%=userInfo.getProfile_filename() %>" border="0" width=80px height=80px style="border-radius: 50%;"/>
			</div>
			<div  align="center" style="color:gray; font-size:18px;"><%=userInfo.getNickname()%>님이</div>
			<div  align="center" style="color:gray; font-size:18px;">로그인 중 입니다.</div>
			<br/>
		</div>
	<%} else {%>
		<p>로그인해주세요.</p>
	<%}%>
	<a href="./home.do">Home</a>
		<%if(userInfo != null){
		if(userInfo.getId().equals("testadmin1")) {%>
			<a href="./admin.do">Admin Page</a>
		<%} else{ %>
			<a href="./mypage.do">My Page</a>
		<%}
	}%>
	<a href="./list.do">모든 게시글 보기</a>
	<a href="./book_list.do">책 구경하기</a>
</div>

<div id="main">
	<div id="header">
		<div>
			<table>
				<tr>
					<td width=5%><span>
						<button class="sidebar-btn" onclick="sidebarCollapse()">
							<span><i class="fa fa-bars" aria-hidden="true"></i></span>
			             </button>
					</span>
					</td>
					<td width=5%><span><a class="navbar-brand" href="./home.do"> <img src="./images/logo.png" alt="logo" style="width: 200px; height:50px; "></a></span></td>
					<% if(userInfo == null){ %>
						<td width=75% ><span><a class="button1" href="./login.do" id="start-button" style="color: black;">START</a></span></td>
	        		<% }else{ %>
	        			<td width=75% ><span><a class="button2" href="./logout_ok.do" id="logout-button" style="color: black;">LOGOUT</a></span></td>
	        		<% } %>
					<td width=5%><span><a class="button3" href="./search.do" style="color: black;"><i class="fa fa-search" aria-hidden="true"></i></a></span></td>
				</tr>
			</table>		
    	</div>
	</div>
    
    <div id="content">
        <!-- <h1>검색 페이지</h1> -->

		<table>
			<tr height="150px"><td></td></tr>
			<tr>
				<td><img src="./images/login-image.png" height="480px" /></td>
				<td>
					<table width="900px">
					
					<tr><td>
						<div class="intro_search">
							<div class="tit_brunch">'책갈피' 프로젝트</div>
							<div class="desc_search">
								<span class="part">독서 후, 당신의 감성과 생각을 나누기 위한 플랫폼<br></span>
							</div>
						</div>
					</td></tr>
					
					<tr height="300px"><td align="right">
						<div>
							<span>오늘은 어떤 영감을 받고 싶나요?</span>
						
							<form action="./search_list.do" method="get" name="search_frm">
							<!-- hidden으로 현재 보여지는 탭명을 보내서 검색결과페이지에서 두번째 탭에서 페이지를 변경하여도 계속 두번째 탭 내용이 나오게 함 -->
							<input type="hidden" name="active" value="tab1"/>
								<input type="text" name = "searchword"  style="border-radius: 4px"/>
								<button type="submit" id="search" value="검색" width="50px" class="btn btn-dark">검색</button>
							</form>
						</div>					
					</td></tr>
					
					<tr height="120px"><td></td></tr>
					
					</table>
				</td>
			</tr>
		</table>

        <!-- span span 같은 줄, p p 한 줄 건너 띄고 다른 줄, div div 바로 아래 줄 -->
 		
    </div>
</div>

</body>
</html>