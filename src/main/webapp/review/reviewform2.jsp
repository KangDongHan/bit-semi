<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<style type="text/css">
	th {
		width: 150px;
	}
</style>

<%
	//프로젝트의 경로
	String root=request.getContextPath();
%>

<!-- se2 폴더에서 js 파일 가져오기 -->
<script type="text/javascript" src="<%=root%>/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=root%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>	
	
</head>


<body>
<form action="review/reviewaction.jsp" method="post">
	<div>
		<h3>▶ 내용입력</h3>
		<table class="table table-bordered">
			<tr>
				<th>시승 모델</th>
				<td>
					<select style="width: 200px;" name="car" class="form-control" required="required">
						<option value="" selected="selected">선택</option>
						<option value="차종1">차종1</option>
						<option value="차종2">차종2</option>
						<option value="차종3">차종3</option>
						<option value="차종4">차종4</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td> <input type="text" name="name" class="form-control" style="width: 200px;" readonly="readonly" value="회원리스트에서 얻어오기"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" class="form-control" style="width: 500px;" required="required" >
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="2">
					<textarea name="content" id="content"
					style="width: 100%;height: 300px; display: none;" required="required"></textarea>		
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<button type="button" id="add" class="btn btn-info" onclick="submitContents(this)">등록</button>
					<button type="button" id="cancel" class="btn btn-danger">취소</button>
				</td>
			</tr>
		</table>
	</div>

</form>



<!-- 스마트게시판에 대한 스크립트 코드 넣기 -->
<script type="text/javascript">
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({

    oAppRef: oEditors,

    elPlaceHolder: "content",

    sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",

    fCreator: "createSEditor2"

}); 

//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.

function submitContents(elClickedObj) {

    // 에디터의 내용이 textarea에 적용된다.

    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", [ ]);

 

    // 에디터의 내용에 대한 값 검증은 이곳에서

    // document.getElementById("textAreaContent").value를 이용해서 처리한다.
    try {
        elClickedObj.form.submit();
    } catch(e) { 

    }

}

// textArea에 이미지 첨부

function pasteHTML(filepath){
    var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]); 

}

</script>


</body>
</html>