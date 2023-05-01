<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello World</title>
<link href="${conPath }/css/style.css" rel="stylesheet">
<link href="${conPath }/css/theater/theater.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
	$(document).ready(function() {

	});
</script>
</head>
<body>
	<jsp:include page="../main/header.jsp" />
	<div id="wrap">
		<h1 class="center">${thcon.thname }</h1>
		
		<!-- 게시판 -->
		<table class="content_table">
			<tr>
				<th>상담구분</th>
				<th class="title">상담제목</th>
				<th>작성자</th>
			</tr>
			<tr>
				<td>${qna.qacat }</td>
				<td class="title">${qna.qatitle }</td>
				<td>${qna.mid }</td>
			</tr>
			<tr>
				<td colspan="3" class="content"><span class="qes">Q.</span>${qna.qacontent }</td>
			</tr>
			<!-- 첨부 이미지가 있는 경우 출력 -->
			<c:if test="${not empty review.rphoto}">
				<tr>
					<td class="center" colspan="4"><img alt="첨부이미지" width="200px"
						src="${conPath }/reviewBoardUp/${review.rphoto}"></td>
				</tr>
			</c:if>
			<tr>
				<td>작성일</td>
				<td colspan="2"><fmt:formatDate value="${qna.qardate }" type="date"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<td>IP</td>
				<td colspan="2">${qna.qaip }</td>
			</tr>
			
			<!-- 회원: 자신이 작성한 글만 수정 및 삭제 가능 -->
			<c:if test="${member.mid eq qna.mid}">
				<tr>
					<td colspan="3" class="btnBox">
						<input type="button" onclick="location.href='${conPath}/qnaBoard/qBoardModify.do?qanum=${qna.qanum }&pageNum=${param.pageNum }'" value="수정" class="btn_submit">
						<input type="button" onclick="location.href='${conPath}/qnaBoard/qBoardList.do?pageNum=${param.pageNum }&schItem=${param.schItem}&schWord=${param.schWord}'" value="목록" class="btn_submit">
					</td>
				</tr>
			</c:if>
			<!-- 관리자 계정: 답글 및 삭제 가능 -->
		</table>
		
		<div class="notice_box">
			<h3>1:1 문의내역</h3>
			<br>
			<p>
				<b>상담시간</b>
				<br>
				평일(월 ~ 금) 10:00 ~ 17:00
				<br>
				(Off-time 12:30 ~ 13:30, 토/일/공휴일 휴무)
			</p>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp" />
</body>
</html>