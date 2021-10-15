<%@page import="java.io.File"%>
<%@page import="data.dao.ServiceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//request
	String num = request.getParameter("num");
	String currentPage = request.getParameter("currentPage");
	
	//get photo name
	ServiceDao dao = new ServiceDao();
	String filename = dao.getData(num).getFile();
	if(!filename.equals("no")){
		//real path
		String realPath = getServletContext().getRealPath("/files");
		File file = new File(realPath+"\\"+filename);
		//delete file
		System.out.println(realPath+"\\"+filename);
		file.delete();
		System.out.println("삭제");
	}
	System.out.println(filename);
	//delete content
	dao.deleteContent(num);
	
%>