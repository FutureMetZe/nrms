<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/common-ui.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看评价</title>
</head>
<body style="background-color:white;">
<div class="container-fluid">
	<form>
		<div class="row">
			<table class="table user-table table-striped">
				<thead>
					<tr>
						<th style="text-align: center;">开发人员</th>
						<th style="text-align: center;">评分</th>
						<th style="text-align: center;">评价内容</th>
						<th style="text-align: center;">评价日期</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="appraise" items="${appraiseList }">
					<tr>
						<td style="text-align: center;">${appraise.developerName }</td>
						<td style="text-align: center;">${appraise.score }</td>
						<td style="text-align: center;">${appraise.appraiseContent }</td>
						<td style="text-align: center;">${appraise.appraiseDate }</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</form>
</div>
</body>
<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>
</html>