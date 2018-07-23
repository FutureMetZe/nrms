<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>

<html>
<%@include file="/common/common-ui.jsp" %>
<script type="text/javascript">
	$("#searchButton").click(function(){
		$.ajax({
			url : '${basePath}/apply/toAppliedListPage',
			dataType : 'text',
			type : 'post',
			data :	$("#searchForm").serialize(),
			success : function(data){
			},
			error : function(){
				alert("服务器处理异常");
			},
		});
	})
}
</script>
<head>
</head>

<body>
 <div id="wrap" class="">
        <!--    头部 和  菜单 start -->
        	<%@include file="/common/headAndLeft.jsp" %>
        <!--    头部 和  菜单 end -->
        
        <!-- 内容start -->
        <main class="main">

            <!-- Breadcrumb -->
            <ol class="breadcrumb">
                <li class="breadcrumb-item">当前位置</li>
                <li class="breadcrumb-item active">我申请的</li>
            </ol>


            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="from-search">
	                            <form id="searchForm" action="${basePath}/apply/toAppliedListPage" method="post">
	                                <ul class="form-inline">
	                                    <li class="form-group">
	                                        <label for="exampleInputName">任务名</label>
	                                        <input type="text" class="form-control" name="taskName" id="taskName" value="${apply.taskName}">
	                                    </li>
	                                    <li class="form-group">
	                                        <label for="exampleInputUser">申请状态</label>
	                                        <select type="text" name="applyStatus" id="applyStatus" class="form-control">
	                                            <option value="1">已接受</option>
	                                            <c:choose>
	                                            	<c:when test="${apply.applyStatus == 0}">
	                                            		<option value="0" selected="selected">未接受</option>
	                                            	</c:when>
	                                            	<c:otherwise>
	                                            		<option value="0">未接受</option>
	                                            	</c:otherwise>
	                                            </c:choose>
	                                        </select>
	                                    </li>
	                                    <li class="form-group-btn">
	                                        <button type="submit" class="btn btn-primary" id="searchButton">搜索</button>
	                                    </li>
	                                    
	                                </ul>
	                               </form>
                            </div>

                            <div class="card">

                                <div class="card-header">
                                    <i class="fa fa-code"></i> 申请列表
                                </div>
                                <div class="card-block">
                                    <table class="table user-table table-striped">
                                        <thead>
                                        <tr>
                                            <th>任务名</th>
                                            <th>借用开始时间</th>
                                            <th>借用截止时间</th>
                                            <th>申请状态</th>
                                            <th>任务状态</th>
                                            <th>申请时间</th>
                                            <th>指派人员</th>
                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${beans}" var="pojo">
                                            <tr>
                                                <td>${pojo.taskName}</td>
                                                <td>${pojo.lendStartTime}</td>
                                                <td>${pojo.lendOverTime}</td>
                                                <td>${pojo.applyStatus == 1 ? "已接受" : "未接受"}</td>
                                                <td>
                                                	<c:choose>
	                                                	<c:when test="${pojo.taskStatus == 1}">开启</c:when>
	                                                	<c:when test="${pojo.taskStatus == 2}">关闭</c:when>
	                                                	<c:when test="${pojo.taskStatus == 3}">作废</c:when>
                                                	</c:choose>
                                                </td>
                                                <%-- <td><fmt:formatDate value="${pojo.applyDate}" pattern="yyyy-MM-dd"/></td> --%>
                                                <td>${pojo.applyDate}</td>
                                                <td>${pojo.developerNameList}</td>

                                                <td>
	                                                <button type="button" class="badge badge-edit" data-toggle="modal"
					                                	data-target="#taskDetailModal" onclick="taskDetail('${pojo.taskId}')">详情
					                                </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <%@include file="/common/page.jsp"%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>
     <%@include file="/common/common-taskDetailDiv.jsp" %> 
 	 <%@include file="/common/common-msgAlert.jsp" %>	
  </body>
 
<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>
</html>
