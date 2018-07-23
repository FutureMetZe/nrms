<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>

<html>
<%@include file="/common/common-ui.jsp" %>
<script type="text/javascript">
	$().ready(function(){
		$('#appraiseStatus').val('${searchParam.appraiseStatus}');
	});
	
 	function showAddAppraiseModal(obj){
 		var obj = $(obj);
		var applyId = $(obj.siblings().first()).val();
		var devIdList = $(obj.siblings()[1]).val();
		var url = '${basePath}/appraise/addAppraisePage?applyId='+applyId+'&developerIdList='+devIdList;
		showIframeModal('添加评价',url,'submitAppraise()');
	}
	
	function submitAppraise(){
		var myFrame = $(window.frames['iframeModal-frame'].document);
		
		var appraiseIdArray = [];
		var applyIdArray = [];
		var scoreArray = [];
		var contentArray = [];
		//评价id存入数组
		myFrame.find('.aa-appraiseId').each(function(){
			appraiseIdArray.push($(this).val());
		});
		//申请id存入数组
		myFrame.find('.aa-applyId').each(function(){
			applyIdArray.push($(this).val());
		});
		//分数存入数组
		myFrame.find('.aa-score').each(function(){
			var score = $($(this).children().first()).val();
			//前端验证score
			if(score === ''){
				hideIframeModal();
				msgPromptModalShow('评分为必填项', 'javascript:msgPromptModalHide();showIframeModal();');
				return;
			}
			if(Number(score) < 0 || Number(score) > 10){
				hideIframeModal();
				msgPromptModalShow('评分应该在0.0-10.0之间', 'javascript:msgPromptModalHide();showIframeModal();');
				return;
			}
			scoreArray.push(score);
		});
		//评价内容存入数组
		myFrame.find('.aa-content').each(function(){
			contentArray.push($($(this).children().first()).val());
		})
		
		if(!(appraiseIdArray.length==applyIdArray.length
			&&appraiseIdArray.length==scoreArray.length
			&&appraiseIdArray.length==contentArray.length)){
			
			return;
		}
		
		var appraiseArray = [];
		for(var i=0;i<appraiseIdArray.length;i++){
			var obj = {};
			obj.id = appraiseIdArray[i];
			obj.applyId = applyIdArray[i];
			obj.score = scoreArray[i];
			obj.appraiseContent = contentArray[i];
			appraiseArray.push(obj);
		}
		
		$.ajax({
			url:'${basePath}/appraise/addAppraise',
			type:'post',
			data:JSON.stringify(appraiseArray),
			contentType:"application/json",
			dataType:'json',
			success:function(data){
				if(data.success===true){
					hideIframeModal()
					msgPromptModalShow(data.msg, 'javascipt:window.location.reload();');
				}
				if(data.success===false){
					hideIframeModal()
					msgPromptModalShow(data.msg, 'javascript:msgPromptModalHide();showIframeModal();');
				}
			},
			error:function(){
				hideIframeModal()
				msgPromptModalShow('server error');
			}
		});
	}

	function viewAppraise(obj){
		var obj = $(obj);
		var applyId = $(obj.siblings().first()).val();
		var devIdList = $(obj.siblings()[1]).val();
		var url = '${basePath}/appraise/getAppraiseList?applyId='+applyId+"&developerIdList="+devIdList;
		showIframeModal('查看评价',url);
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
                <li class="breadcrumb-item active">我的评价</li>
            </ol>


            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <form id="searchForm" method="post" action="${pageContext.request.contextPath }/appraise/applyList">
                            	<input type="hidden" id="pageNum" name="pageNum" value="1">
                            	<div class="from-search">
	                                <ul class="form-inline">
	                                    <li class="form-group">
	                                        <label for="appraiseStatus">评价状态</label>
	                                        <select type="text" id="appraiseStatus" name="appraiseStatus" class="form-control" onchange ="javascript:$('#searchForm').submit();">
	                                            <option value="0">未评价</option>
	                                            <option value="1">已评价</option>
	                                        </select>
	                                    </li>
	                                    <!-- <li class="form-group-btn">
	                                        <button type="submit" class="btn btn-primary">搜索</button>
	                                    </li> -->
	                                </ul>
	                            </div>
                            </form>
                            <div class="card">

                                <div class="card-header">
                                    <i class="fa fa-code"></i> 评价列表
                                </div>
                                <div class="card-block">
                                    <table class="table user-table table-striped">
                                        <thead>
                                        <tr>
                                            <th>任务名</th>
                                            <th>负责人</th>
                                            <th>开发人员</th>
                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${beans}" var="apply">
                                            <tr>
                                                <td>${apply.taskName}</td>
                                                <td>${apply.applyerName}</td>
                                                <td>${apply.developerNameList}</td>
                                                <td>
                                                    <input type="hidden" value="${apply.applyId }">
                                                    <input type="hidden" value="${apply.developerIdList }">
                                                    <c:if test="${apply.appraiseStatus==0 }">
                                                   	<button class="badge badge-edit" onclick="showAddAppraiseModal(this)">评价</button>
                                                    </c:if>
                                                    <c:if test="${apply.appraiseStatus==1 }">
                                                    <button class="badge badge-edit" onclick="viewAppraise(this)">查看评价</button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <%@include file="/common/page.jsp"%>
                                </div>
                            </div>
                        </div>
                        <!--/.col-->


                        <!--/.col-->
                    </div>
                    <!--/.row-->


                    <!--/.row-->


                    <!--/.row-->
                </div>

            </div>
        </main>
        
        <!-- iframe Modal -->
		<%@include file="/common/common-iframeModal.jsp" %>

		
		<!-- alert 和 prompt的modal实现 -->
		<%@include file="/common/common-msgAlert.jsp" %>

    </div>
</body>
<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>
</html>
