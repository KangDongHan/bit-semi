<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8 ">
<title>CUSTOMERSERVICE</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<style>
.inner{
	padding-top:50px;
	width: 1100px;
	height:600px;
	margin:0 auto;
	position: relative;
}
.inner .container{
	position: absolute;
	top: 20;
	left: 0;
}
.inner .container h1{
	width: 500px;
	text-align: center;
	postion:absolute;
	left: 50%;
	margin-left: 250px;
	font-size: 30px;
    color: #05141f;
    line-height: 30px;
}
.inner .container .items{
	margin-top: 50px;
	border-collapse:collapse;
	border: 1px solid #333;
	width: 500px;
	left: 50%;
	margin-left: 250px;
	
	
}
.inner .container .items a.link:hover{
	cursor: pointer;
}
.inner .container .items tr{
	height: 180px;
	
}
.inner .container .items td{
	border: 1px solid #333;
	width: 250px;
	text-align: center;
	padding-bottom: 20px;
}

</style>
</head>
<body>
	<div class = "inner">
		<div class = "container">
			<h1>COSTOMER SERVICE</h1>
			<table class = "items">
				<tr>
					<td>
					<a class = "link">
						<img alt="Q&A" src="images/qna.PNG" class = "images qna"><br>	
						<span class = "service qna">Q&A	</span> <br>
					
					</a>
					</td>
					<td>
					<a  class = "link">
						<img alt="Q&A" src="images/chat.PNG" class = "images chat" ><br>
						<span class = "service chat" >채팅상담</span> <br>
					</a>
					</td>
				</tr>
				<tr>
					<td>
					<a>
						<img alt="Q&A" src="images/call.PNG" class = "images"><br>
						<span class = "service">콜센터</span> <br>
						<span class = "service">02-2890-0500</span>
						
					</a>
					</td>
					<td>
					<a>
						<img alt="Q&A" src="images/call.PNG" class = "images"><br>	
						<span class = "service">시승예약문의</span> <br>
						<span class = "service">010-7895-0880</span>
					</a>
					</td>
				</tr>
				
			</table>
			
		</div>
	</div>
	<script>
	$(".chat").click(function() {
		chat();
		alert("채팅이 활성화 되었습니다 화면 오른쪽 아래부분을 확인해주세요")	
	});
	$(".qna").click(function() {
		location.href = "index.jsp?main=service/qnalist.jsp";		
	});
	function chat() {
		var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
		(function(){
		var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
		s1.async=true;
		s1.src='https://embed.tawk.to/609cdaefb1d5182476b87984/1f5ibedp2';
		s1.charset='UTF-8';
		s1.setAttribute('crossorigin','*');
		s0.parentNode.insertBefore(s1,s0);
		})();
	}	
	</script>
	
</body>
</html>