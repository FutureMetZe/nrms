<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/common-ui.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>增加评价</title>
</head>
<body style="background-color:white;">
<div class="container-fluid">
	<form>
		<table class="table user-table table-striped" style="width: 100%;">
			<thead>
				<tr>
					<th>开发人员</th>
					<th>评分<span style="color: red;">*</span></th>
					<th>评价内容</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="appraise" items="${appraiseList }">
				<tr>
					<td>
						${appraise.developerName }
						<input class="aa-appraiseId" type="hidden" value="${appraise.id }">
						<input class="aa-applyId" type="hidden" value="${appraise.applyId }">
					</td>
					<td class="aa-score"><input type="text" class="check-input form-control" placeholder="请输入0.0-10.0分"></td>
					<td class="aa-content"><textarea rows="1" class="form-control" placeholder="请输入评价内容"></textarea></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</div>
</body>
<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>
</html>