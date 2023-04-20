<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${conPath }/css/style.css" rel="stylesheet">
<link href="${conPath }/css/header.css" rel="stylesheet">
</head>
<body>
	<div class="util">
		<div class="utill_inner">
			<div class="utill_inner_left">
				KOR▾
			</div>
			<div class="login">
				<a href="">로그인</a>
				<a href="">회원가입</a>
			</div>
		</div>
	</div>
	<header>
		<div class="header_inner">
			<div class="logo">
				<h1>Hello World</h1>
			</div>
			<nav>
				<ul>
					<li><a href="">즐길거리</a></li>
					<li><a href="">요금/우대혜택</a></li>
					<li><a href="">이용가이드</a></li>
					<li><a href="">더 알아보기</a></li>
				</ul>
			</nav>
			<div class="header_inner_right">
				<img alt="할인프로모션" src="${conPath }/img/header_nPay.png">
			</div>
		</div>
	</header>
</body>