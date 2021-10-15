<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="data.dto.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<% 
	//숫자 읽어오기
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");

	ReviewDao dao = new ReviewDao();

	//번호에 해당하는 dto 정보 얻기
	ReviewDto dto = dao.getReviewData(num);
	
	// 아이디,닉네임 얻기
	String email = (String)session.getAttribute("myid");
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto = Ldao.getUserInfo(2, email);
%>

<body>

<!-- 댓글 폼 -->
<div class="commentform">
	<form action="review/commentInsert.jsp" method="post">
	<input type="hidden" name="num" value="<%=dto.getNum()%>">
	<input type="hidden" name="myid" value="<%=Ldto.getEmail()%>">
	<input type="hidden" name="name" value="<%=Ldto.getName()%>">
	<input type="hidden" name="currentPage" value="<%=currentPage%>">
	<table>
		<tr>
			<td>
				<textarea name="content" required="required" class="form-control text"></textarea>
			</td>
			<td>
				<button type="submit" class="btn btn-info cbtn">등록</button>
			</td>
		</tr>
	</table>
	</form>
</div>

</body>
</html>