<%@page import="data.dao.RcommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

	String idx = request.getParameter("idx");
	RcommentDao rdao = new RcommentDao();
	rdao.deleteComment(idx);

%>