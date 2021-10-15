<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String postcode = request.getParameter("postcode");
	String addr1 = request.getParameter("addr1");
	addr1=new String(addr1.getBytes("8859_1"),"UTF-8");
	String addr2 = request.getParameter("addr2");
	addr2=new String(addr2.getBytes("8859_1"),"UTF-8");
	String mobile1 = request.getParameter("mobile1");
	String mobile2 = request.getParameter("mobile2");
	String mobile3 = request.getParameter("mobile3");
	String email = request.getParameter("id");
	String name = request.getParameter("name");
	name=new String(name.getBytes("8859_1"),"UTF-8");
	
	System.out.println(postcode);
	System.out.println(addr1);
	System.out.println(addr2);
	System.out.println(mobile1);
	System.out.println(mobile2);
	System.out.println(mobile3);
	System.out.println(email);
	System.out.println(name);
	
	LoginDao dao = new LoginDao();
	dao.updateMember(postcode, addr1, addr2, mobile1, mobile2, mobile3, name, email);
	
	session.removeAttribute("loginok");
	session.removeAttribute("myid");
	
	response.sendRedirect("../index.jsp?main=login/noticeUpdate.jsp");
	
%>