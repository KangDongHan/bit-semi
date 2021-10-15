<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.ServiceDto"%>
<%@page import="data.dao.ServiceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<title>CUSTOMERSERVICE</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<style>
/* COMMON */
body{
    font-size: 14px;
    line-height: 24px;
    color: #37434c;
    font-family: 'Nanum Myeongjo', serif;
    font-weight: 700;
    background-color: rgba(5,20,31,0.03);
}

.baseBtn {
	width: 185px;
	height: 40px;
	background-color: #333;
	border: 1px solid #333;
	cursor: pointer;
	color: white;
}
.baseBtn:hover {
	background-color: rgb(118, 118, 118);
	color: white;
	border: 1px solid rgb(118, 118, 118);
}
.inner{
    width:1100px;
    margin: 0 auto;
    height: 850px;
    position: relative;
   
}
/* TITLE */
.inner .container h1{
    width: 200px;
    height: 40px;
    text-align: center;
    margin-left: 380px;
    margin-top:20px;
    color: #37434c;
    font-family: 'Nanum Myeongjo', serif;
    font-weight: bold;
}

/* TABLE */
.inner .container{
    width: 1048px;
    height: 680px;
    position: absolute;
    top: 100px;
    left: 29px;
    background-color: white;
 
}
.inner .container .detail{
    width: 982;
    box-sizing: border-box;
    border-collapse: collapse;
    margin-left: 16px;
    margin-top: 40px;
}
.inner .container .detail tr{
    height: 60px;
}
.inner .container .detail td.col1{
    width: 200px;
    background-color: #333;
	color: white;
    text-align: center;
}
.inner .container .detail td.col2{
    width: 292px;
}
.inner .container .detail td{
    border: 1px solid rgb(118, 118, 118);
    text-align: center;
    
}
.inner .container .detail td.contents{
    width:980px;
    height: 150px;
    border: none;   
    box-sizing: border-box;
    border: 1px solid rgb(118, 118, 118);
}
.inner .container .detail .img{
   	background-color: #333;
	color: white;
}
.inner .container .detail td.contents #content{
    width:982px;
    height: 130px;
    border: none;
    
}
.inner .container .btnContainer {
    position: absolute;
    width: 600px;
    height: 50px;
    margin-top: 20px;
    left: 450px;
}
#getFile:hover {
	cursor: pointer;
}
.reply{
	margin-top: 10px;
	margin-left: 817px;
}






</style>

<%	
	String login = (String)session.getAttribute("loginok");
	String id = (String)session.getAttribute("myid");
	String num=request.getParameter("num");
	String currentPage=request.getParameter("currentPage");
	int perPage = 10;
	if(request.getParameter("perPage")!=null){
		perPage = Integer.parseInt(request.getParameter("perPage"));
	}
	if(currentPage==null)
		currentPage="1";
	//key는 목록에서만 값이 넘어오고 그 이외는 null값
	String key=request.getParameter("key");
	
	ServiceDao dao=new ServiceDao();
	//목록에서 올경우에만 조회수 1 증가한다
	if(key!=null)
	dao.updateViewsCount(num);
	
	//num 에 해당하는 dto 얻기
	ServiceDto dto=dao.getData(num);
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<body>
    <div class="inner">
        <div class="container">
            <h1>Q&A</h1>
            <button class="baseBtn reply" onclick = "location.href = './index.jsp?main=service/replyForm.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>&perPage=<%=perPage%>'">답글</button>
            <table class="detail">
                <tr>
                    <td class="col1 ">제목</td>
                    <td colspan="3" id="subject"><%=dto.getSubject()%></td>
                </tr>    
                <tr>
                    <td class="col1">작성자</td>
                    <td colspan="3" id="writer"><%=dto.getWriter()%></td>
                </tr>    
                <tr>
                    <td class="col1" id="writeday">작성일</td>
                    <td class="col2"><%=sdf.format(dto.getWriteday())%></td>
                    <td class="col1" id="views">조회수</td>
                    <td class="col2"><%=dto.getViews()%></td>
                </tr>    
                <tr>
                    <td class="col1">이메일</td>
                    <td class="col2" id="email"><%=dto.getEmail()%></td>
                    <td class="col1">전화번호</td>
                    <td class="col2" id="mobile"><%=dto.getMobile()%></td>
                </tr>    
                <tr>
                    <td colspan="4" class="contents">
                        <textarea id="content" readonly><%=dto.getContents()%></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="img">첨부파일</td>
                    <td colspan="3" class="">
                        <a id ="getFile" ><%=dto.getFile()%></a>
                    </td>
                </tr>    
                    
            </table>
            <div class="btnContainer">
                <button class="baseBtn update">수정</button>
                <button class="baseBtn delete">삭제</button>
                <button class="baseBtn back" onclick="location.href = 'index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage%>&perPage=<%=perPage%>'">목록</button>
            </div>
        </div>
    </div>
	<script>
		$(".update").hide();
		$(".delete").hide();
		$(".reply").hide();
		
		//if loginId = writeId show update, delete button
		if('<%=id%>' === '<%=dto.getId()%>' || '<%=id%>' === "master"){
			$(".update").show();
			$(".delete").show();
			
		}
		//로그인시만 답글버튼보이기
		if('<%=login%>' === 'yes' || '<%=id%>' === "master"){
			$(".reply").show();
		}
		
		$(".update").click(function () {
			location.href = "index.jsp?main=service/updateqna.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>&perPage=<%=perPage%>";
		})
		$(".delete").click(function () {
			let num = <%=dto.getNum()%>;
			let currentPage = <%=currentPage%>;
			let perPage = <%=perPage%>
			$.ajax({
				type : "post",
				url : "service/deleteAction.jsp",
				data: {
					"num": num,
					"currentPage":currentPage,
					"perPage" : perPage
					
				},
				success : function() {
					//move page
					alert("삭제완료")
					location.href = "index.jsp?main=service/qnalist.jsp?currentPage=<%=currentPage%>&perPage=<%=perPage%>";
					
				},
				error:function(request,status,error){
				      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }

			});
			
		})
		 $("#getFile").click(function() {
			 if($("#getFile").text() =="미입력"){
				alert("등록된 파일이 없습니다.")
				return;
			 }else{
				location.href="service/filedown.jsp?name=<%=dto.getFile()%>";
			 }
			
		})  
	</script>
</body>
</html>