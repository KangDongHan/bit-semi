<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="data.dao.EventDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.EventDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<style type="text/css">
table.tb {
	margin: auto;
	width: 700px;
	height: 300px;
	max-height:200px;
	max-width:800px;
	border-top: solid 1px gray;
	font-family: 'Noto Sans KR', sans-serif;
}
.tb td{
	max-width:560px;
	max-height: 200px;
	overflow: hidden;
	padding-bottom: 15px;
}


button.bt {
	margin-bottom: 100px;
	margin-right: 100px;
	width: 100px;
	font-family: 'Noto Sans KR', sans-serif;
	background-color: white;
	color: gray;
	padding: 10px 20px;
	text-align: center;
	font-size: 12px;
	opacity: 0.6;
	transition: 0.3s;
	cursor: pointer;
	border: solid 1px gray;
}

.pagination{
	display: block;
	text-align: center;
}

.pagination > li > a{
	float: none;
	margin-left: -5px;
}

</style>
</head>
<%
	EventDao dao=new EventDao();
	//페이징 처리에 필요한 변수선언
	int perPage=5;//한페이지에 보여질 글의 갯수
	int totalCount; //총 글의 수
	int currentPage;//현재 페이지번호
	int totalPage;//총 페이지수
	int start;//각페이지에서 불러올 db 의 시작번호
	int perBlock=5;//몇개의 페이지번호씩 표현할것인가
	int startPage; //각 블럭에 표시할 시작페이지
	int endPage; //각 블럭에 표시할 마지막페이지
	//총 갯수
	totalCount=dao.getTotalCount();
	//현재 페이지번호 읽기(단 null 일경우는 1페이지로 설정)
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	//총 페이지 갯수 구하기
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
	//각 블럭의 시작페이지
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
	if(endPage>totalPage)
		endPage=totalPage;
	//각 페이지에서 불러올 시작번호
	start=(currentPage-1)*perPage;
	//각페이지에서 필요한 게시글 가져오기
	List<EventDto> list=dao.getList(start, perPage);
	if(list.size()==0 && totalCount>0)
	{%>
	<script type="text/javascript">
	 location.href="index.jsp?main=event/eventlist.jsp?currentPage=<%=currentPage-1%>";		
	</script>
	<%}
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월dd일 HH:mm z");
	//각페이지에 출력할 시작번호
	int no=totalCount-(currentPage-1)*perPage;
	
	String myid="";
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto;
	String name ="";
	String loginok="";
	//로그인 상태 확인후 입력폼 나타내기
	if(session.getAttribute("loginok")!=null){
		loginok = (String)session.getAttribute("loginok");
		//아이디,닉네임 얻기
		myid = (String)session.getAttribute("myid");
		Ldto = Ldao.getUserInfo(2, myid);
		name = Ldto.getName();
	}
	
		
	
%>


<body>
<img src="./images/ev1.PNG" style="width:100%;">
<div class="container">
	<span style="font-family: 'Noto Sans KR', sans-serif; font-weight:400;
	 font-size:40pt;">이벤트</span>
	 <span style="color:gray; font-size:20pt;">EVENT</span>
</div>
   
   



<section style="margin-top:20px; margin-bottom:20px;">
<div style="text-align:right;">
<%
	//로그인한 아이디와 글을 쓴 아이디가 같을 경우에만 글쓰기 버튼 보이게한다.
	if(loginok!=null && myid.equals("admin")){%>
	<button type="button" class="btn btn-default pull-right bt"
	onclick="location.href='index.jsp?main=event/eventform.jsp'">
	<span class='fas fa-pencil-alt'></span>&nbsp;글쓰기</button>
<%} %>

</div>

<p style="clear:both;"></p>
	
	<%
	if(totalCount==0)
	{%>
		<p align="center">
			<b style="font-family: 'Noto Sans KR', sans-serif; margin-bottom: 30px;">아직 작성된 글이 없습니다.<br> 이벤트를 등록해주세요!
			</b>
		</p>
	<%}else{
	for(EventDto dto:list)
		{%>
	<table class="tb" style="cursor:pointer;" onclick="location.href='index.jsp?main=event/eventdetail.jsp?num=<%=dto.getNum()%>&currentPage=<%= currentPage%>&key=list'">
		<tr>
			<td rowspan="4" width="200" height="200">
				<img src="/Team/save/<%=dto.getPhotoname()%>"  onerror="this.style.display='none'" style="margin-right:30px; margin-top:-25px; border-radius:7%" width="230" height="130">
			</td>
			<td style="color:A52A2A; font-weight: 400;">
				<%=sdf.format(dto.getWriteday())%>
				<%
				//로그인한 아이디와 글을 쓴 아이디가 같을 경우에만 수정,삭제 보이게한다.
				if(loginok!=null && myid.equals("admin")){
				%>
				<td>
					|&nbsp;<a href="index.jsp?main=event/eventupdateform.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>" 
						style="color: black;"><span class='far fa-edit'></span>&nbsp;수정</a>
					|&nbsp;<a href="event/eventdelete.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>" style="color: black;"><span class='far fa-file-excel'></span>&nbsp;삭제</a>
				</td>
				<%} %>
			</td>
		</tr>
		<tr>
			<td style="font-weight: 700;">
			<%=dto.getSubject()%>
			</td>
		</tr>
		
		<tr>
		<%if(dto.getContent().length() >= 50){%>
			<td style="font-weight: 400;"> 
				<%=dto.getContent().substring(0, 50)%>
			</td>
			<% }else{%>
			<td style="font-weight: 400;">
				<%=dto.getContent()%>
			</td>
			<%} %>
		</tr>
		
		<tr>
			<td style="font-weight: 400;">
			조회수 : <%=dto.getReadcount()%>
			</td>
		</tr>
	</table>
		<%}
	}
	%>
	
	

</section>

<!-- 페이징 -->
<div>
	<ul class="pagination">
	<%
	
	//이전
	if(startPage>1)
	{%>
		<li>
		<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=startPage-1%>"><</a>
		</li>
	<%}
	
	for(int pp = startPage; pp <= endPage;pp++)
	{
		if(pp==currentPage) //현재페이지일때 active
		{%>
			<li class="active">
			<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
		<%}else{%>
			<li>
			<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=pp%>"><%=pp %></a></li>
		<%}
	}
	
	//다음
	if(endPage<totalPage)
	{%>
		<li>
		<a href="index.jsp?main=event/eventlist.jsp?currentPage=<%=endPage+1%>">></a>
		</li>
	<%}
	%>
	</ul>
</div>


</body>
</html>