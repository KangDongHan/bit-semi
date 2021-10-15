<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dao.RcommentDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="data.dto.RcommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div.commentlist {
	width: 600px;
	margin-bottom: 20px;
}
</style>
<script type="text/javascript">
$(function () {
	$("div.commentlist").hide();
	$("div.icon").click(function () {
		$("div.commentlist").toggle();
	});
	
	// 댓글 삭제
	$("span.cdel").click(function () {
		let idx = $(this).attr("idx");
		let tag = $(this);
		alert(idx);
		
		
	});
	
});
</script>
</head>

<% 
	String num = request.getParameter("num");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	//아이디,닉네임 얻기
	String email = (String)session.getAttribute("myid");
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto = Ldao.getUserInfo(2, email);
	//String rname = Ldto.getName();
	
	ReviewDao dao = new ReviewDao();
	RcommentDao rdao = new RcommentDao();
	
	//글번호에 대한 데이터
	ReviewDto dto = dao.getReviewData(num);
	
	List<RcommentDto> rlist = rdao.getAllcomment(dto.getNum());
	
	// 세션
	String login = (String)session.getAttribute("loginok");
	
	// 댓글 수
	int totalComment;
	totalComment = rdao.getCount(num);
	//System.out.println(totalComment);
	
%>

<body>

<!-- 댓글 리스트 -->
<div class="icon">
댓글
</div>
<div class="commentlist">
	<table table class="table table-bordered" style="width: 900px;">
	<% 
		for(RcommentDto rdto:rlist){
	%>
		<tr>
			<td align="left">
			<% 
			if(totalComment!=0){
			%>
				<span class="glyphicon glyphicon-user" style="font-size: 20px; font-size: 15px; margin-right: 8px;"></span>
				<% 
					String rname = rdto.getName();
				%>
				<span><%= rname %></span>
				<% // 후기글email=댓글email 경우 작성자 나오게
					if(dto.getEmail().equals(rdto.getEmail())){
				%>
					<span style="color: red; font-size: 8pt;">작성자</span>
					<% } %>
				<span>
					<%= sdf.format(rdto.getWriteday()) %>
				</span>
					<% // 로그인이면서 로그인한email 과 같을 경우
						if(login!=null && rdto.getEmail().equals(email)){
					%>
						<span class="glyphicon glyphicon-trash cdel" style="font-size: 12pt; cursor: pointer; margin-left: 600px; line-height: 50px;" idx="<%= rdto.getIdx() %>"></span>
					<% } %>
					<br>
				<span>
					<%= rdto.getContent().replace("\n", "<br>") %>
				</span>
			<% }else{ %>
			<span>댓글이 없습니다</span>
		<% } %>
			</td>
		</tr>
		<% } %>
	</table>
</div>

</body>
</html>