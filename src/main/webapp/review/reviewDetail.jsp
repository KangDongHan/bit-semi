<%@page import="data.dto.RcommentDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.RcommentDao"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<style type="text/css">
div.bg {
	margin: 150px auto;
	width: 940px;
	display: block;
}

 * {
	font-family: Nanum Gothic, sans-serif, Roboto, Helvetica, Arial;
} 

h3>p {
	font-size: 30px;
	color: #05141f;
	line-height: 30px;
}

.chuImg {
	cursor: pointer;
	color: red;
	font-size: 0px;
}

.updown {
	display: table-cell;
    width: 150px;
	background-color: #cdd0d2;
	padding: 20px;
    text-transform: uppercase;
    vertical-align: middle;
    font-size: 15px;
}
.cbtn {
    border-color: #eaeaea;
    border-right-color: transparent;
    border-bottom-color: transparent;
    color: #444;
	height: 50px;
	width: 100px;
	margin-left: 8px;
	margin-bottom: 50px;
}
.text {
	width: 470px;
	height: 200px;
	margin-left: 10px;
	margin-bottom: 50px;
}

div.btns {
	width: 940px;
	margin-bottom: 20px;
	color: #05141f;
}
button.list {
	margin-left: 50px;
	margin-right: 700px;
}

</style>

</head>
<% 
	// 숫자 읽어오기
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	//System.out.println(num);
	
	if(currentPage==null)
		currentPage = "1";
	
	ReviewDao dao = new ReviewDao();
	
	String key = request.getParameter("key");
	if(key!=null)
		dao.updateReadcount(num);
	
	//번호에 해당하는 dto 정보 얻기
	ReviewDto dto = dao.getReviewData(num);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// 아이디,닉네임 얻기
	String email = (String)session.getAttribute("myid");
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto = Ldao.getUserInfo(2, email);
	
	String login = (String)session.getAttribute("loginok");
	
%>

<script type="text/javascript">
$(function () {
	//삭제 확인창
	$("button.del").click(function () {
		let cancel = confirm("후기글을 삭제하시겠습니까?");
		if(cancel)
			// 삭제할 파일 호출
			location.href="review/reviewDel.jsp?num="+<%= dto.getNum() %>;
	});
	
	//추천수 이벤트
	$("span.chu").click(function () {
		let num = $(this).attr("num");
		let tag = $(this);
		
		$.ajax({
			type: "get",
			dataType: "json",
			url: "review/ajaxChu.jsp",
			data: {"num":num},
			success: function (data) {
				//alert(data.chu); // 확인용
				tag.next().text(data.chu);
			}
		});
	});
});

</script>


<body>
	<div class="bg">
		<div class="title" style="margin-bottom: 30px;">
			<h3>
				<p>시승 후기 게시판</p>
			</h3>
		</div>
		<div style="margin-bottom: 100px;">
			<p>고객님의 소중한 리뷰가 큰 힘이 됩니다.</p>
		</div>
		
		<!-- 내용 본문 -->
		<table class="table table-bordered" style="width: 800px;">
			<tr>
				<th colspan="2" style="padding: 25px 30px;">
					<span style="font-size: 20pt;"><%= dto.getSubject()%></span><br>
					<span style="line-height: 50px;">시승모델 | <%= dto.getCar() %></span><br>
					<span style="margin-left: 13px; line-height: 20px;">작성일 | <%= sdf.format(dto.getWriteday()) %></span>
					<span style="margin-left: 25px;">작성자 | <%= dto.getName() %></span><br>
					<span style="margin-left: 750px;" class="chu" num="<%= dto.getNum() %>">좋아요</span>
					<span class="glyphicon glyphicon-thumbs-up" style="color: red;"><%= dto.getChu() %></span>
					<span style="margin-left: 15px;">조회수 | <%= dto.getReadcount() %></span>
				</th>
			</tr>
			<tr>
				<td colspan="2">
					<%= dto.getContent() %>
				</td>
			</tr>
		</table>
		
		
		<!-- 목록,수정,삭제 버튼 -->
		<div class="btns">
			<button type="button" class="btn btn-default list" onclick="location.href='index.jsp?main=review/reviewList.jsp?currentPage=<%= currentPage%>'">목록</button>
			
			<% 
				if(login!=null && dto.getEmail().equals(email)){
			%>
			<button type="button" class="btn btn-default update" onclick="location.href='index.jsp?main=review/reviewUpdateForm.jsp?num=<%=dto.getNum()%>'">수정</button>
			<button type="button" class="btn btn-default del" onclick="">삭제</button>
			<% } %>
		</div>
		
		<!-- 댓글-->
		<div class="comment">
		<%
			
			RcommentDao rdao = new RcommentDao();
			List<RcommentDto> rlist = rdao.getAllcomment(dto.getNum());
		
			 // 입력폼은 로그인한 경우에만 보이게 하기
			if(login!=null){
		%>
				<jsp:include page="commentForm.jsp"/>
				<% } %>
				<jsp:include page="commentList.jsp"/>
		</div>
		
		<!-- 이전, 다음 글 -->
		<table class="table table-bordered" style="width: 800px;">
			<tr>
				<td style="padding: 0px;">
					<span class="glyphicon glyphicon-chevron-up updown">&nbsp;다음글</span>
				</td>
				<td style="width: 850px;">
				<% 
				if(dao.reviewNextNum(num)!=0){
				%>
					<a class="subject" href="index.jsp?main=review/reviewDetail.jsp?num=<%= dao.reviewNextNum(num) %>&currentPage=<%=currentPage%>&key=list"><%= dao.reviewNextNum(num)%></a>
					<% }else{ %>
					<a>다음 글이 없습니다</a>
					<% } %>
				</td>
			</tr>
			<tr>
				<td style="padding: 0px;">
					<span class="glyphicon glyphicon-chevron-down updown">&nbsp;이전글</span>
				</td>
				<td style="width: 850px;">
				<% 
				if(dao.reviewPreNum(num)!=0){
				%>
				<input type="hidden" value="<%= dao.reviewPreNum(num)%>">
				<a class="subject" href="index.jsp?main=review/reviewDetail.jsp?num=<%= dao.reviewPreNum(num) %>&currentPage=<%=currentPage%>&key=list"><%= dao.reviewPreNum(num)%></a>
				<% }else{ %>
				<a>이전 글이 없습니다</a>
				<% } %>
				</td>
			</tr>
		</table>
	</div>

</body>
</html>