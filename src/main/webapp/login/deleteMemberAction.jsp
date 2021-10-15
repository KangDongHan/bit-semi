<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String myid = (String)session.getAttribute("myid");
	
	LoginDao dao = new LoginDao();
	dao.deleteMember(myid);
	
	session.removeAttribute("loginok");
	session.removeAttribute("myid");
	//
	response.sendRedirect("../index.jsp?main=login/goodBye.jsp");
%>