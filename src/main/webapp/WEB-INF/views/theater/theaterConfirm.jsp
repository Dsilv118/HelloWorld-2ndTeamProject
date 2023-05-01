<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<c:if test="${thConfirmResult == 3 }">
		<b style="color: red;">한 스케쥴당 4개 이하만 등록할 수 있습니다.</b>
	</c:if>
	<c:if test="${thConfirmResult < 3 }">
		<b style="color: #9729ff;">등록 가능</b>
	</c:if>
</body>
</html>