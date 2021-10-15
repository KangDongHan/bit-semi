<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String myid = (String)session.getAttribute("myid");
	String pw = request.getParameter("pw");
	System.out.println(pw);
	LoginDao dao = new LoginDao();
	dao.updatePw(myid, pw);
%>