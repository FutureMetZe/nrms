<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>

<html>
<%@include file="/common/common-ui.jsp" %>
<script type="text/javascript">	
</script>

<head>
</head>

<body>
	<!-- 当前用户id -->
	<input type="hidden" id="currentUserId" value="${sessionScope.LOGIN_USER.id}">
	
    <div id="wrap" class="">
        <!--    头部 和  菜单 start -->
        	<%@include file="/common/headAndLeft.jsp" %>
        <!--    头部 和  菜单 end -->
        
        <!-- 内容start -->
        <main class="main">

            <!-- Breadcrumb -->
            <ol class="breadcrumb">
                <li class="breadcrumb-item">当前位置</li>
                <li class="breadcrumb-item active">任务发布</li>
            </ol>


            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="from-search">
                                <form id="searchForm" action="${basePath}/TaskPublishController/taskList">
                                    <input type="hidden" id="pageNum" name="pageNum" value="1">
                                    <ul class="form-inline">
                                        <li class="form-group">
                                            <label for="exampleInputName">任务名</label>
                                            <input type="text" class="form-control" id="taskName" name="taskName" value='${searchParam.taskName}'>
                                        </li>
                                        <li class="form-group">
                                            <label for="exampleInputName">发布人</label>
                                            <input type="text" class="form-control" id="publishName"  name="publishName" value='${searchParam.publishName}'>
                                        </li>
                                        <li class="form-group-btn">
                                            <button type="submit" class="btn btn-primary" onclick="searchTask()">搜索</button>
                                        </li>
                                    </ul>
                                </form>
                            </div>
                            <div class="card">

                                <div class="card-header">
                                    <i class="fa fa-code"></i> 任务管理
                                    <button type="button" class="btn btn-success float-right" data-toggle="modal"
                                            onclick="showAddTaskDiv()">发布任务
                                    </button>
                                </div>
                                <div class="card-block">
                                    <table class="table user-table table-striped">
                                        <thead>
                                        <tr>
                                            <th>任务名</th>
                                            <th>人数需求</th>
                                            <th>借用开始时间</th>
                                            <th>借用结束时间</th>
                                            <th>发布人</th>
                                            <th>发布时间</th>                                   
                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                      		<c:forEach items="${taskList}" var="task">
                                      			<tr>
                                      				<td>${task.taskName}</td>
                                      				<td>${task.peopleNum}</td>
                                      				<td>${task.startTime}</td>
                                      				<td>${task.overTime}</td>
                                      				<td>${task.publishName}</td>
                                      				<td>${task.createdTime}</td>
                                      				<td>
			                                            <button class="badge badge-star " onclick="taskDetail('${task.taskId}')">详情</button>
			                                            <button class="badge badge-star "  onclick="applyTask('${task.taskId}','${task.taskName}','${task.publisherId}','${task.startTime}','${task.overTime}')" >领取任务</button>
                                      				</td>
                                      			</tr>
                                      		</c:forEach>
                                      		
                                        </tbody>
                                    </table>
                                    <%@include file="/common/page.jsp"%>
                                   <%--aaaaaaaaaaaa--%>
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

    </div>
    
  <!-- 添加任务 ===================================start -->
<div class="modal animate-fade" id="taskAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" >
            <div class="modal-header">
                <h6 class="modal-title" id="myModalLabel">任务发布</h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="card-block">
                    <form action="#" method="post"  class="form-horizontal " id="addTaskForm">
                        <div class="form-group row">
                            <label class="col-md-3 form-control-label">任务名<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <input type="text" id="addtaskName" name="taskName" class="check-input form-control">
                             
                            </div>
                        </div>
                       <div class="form-group row">
                            <label class="col-md-3 form-control-label">人数需求<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <input type="number" id="addpeopleNum" name="peopleNum" class="check-input form-control">
                            </div>
                        </div>
						
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">借用开始时间<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <input type="date" id="addstartTime" name="startTime" class="check-input form-control">
                            </div>
                        </div>
						
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">借用结束时间<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <input type="date" id="addoverTime" name="overTime"  class="check-input form-control" >
                            </div>
                        </div>
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">技术需求<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <textarea name="abilityRequired" id="addabilityRequired" rows="" cols="" style="width: 350px">掌握公司常用开发技术</textarea>
                            </div>
                        </div>
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">任务描述<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                               <textarea  name = "taskDesc" id="addtaskDesc" rows="" cols="" style="width: 350px"></textarea>
                            </div>
                        </div> 
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addTask()">确认</button>
            </div>
        </div>
	</div>
</div>
	<ul id="allDeveloperData" style="visibility: hidden;display: none;"></ul> <!-- 保存所有的开发者信息 -->
  <!-- 添加任务 ===================================end -->
  
  <!-- 领取任务 =================================start -->
  <div class="modal animate-fade" id="recieveTaskModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="myModalLabel">领取任务</h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="card-block">
                    <form action="" method="post" enctype="multipart/form-data" class="form-horizontal " id="applyForm">
                        <div class="form-group row">
                            <label class="col-md-3 form-control-label">借用人员人数<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <input type="number" id="applyDeveloperNum" name="applyDeveloperNum" class="check-input form-control">
                            </div>
                        </div>
                         <div class="form-group row">
                            <label class="col-md-3 form-control-label">借用人员名单<span style="color: red;">*</span></label>
                            <div class="col-md-9" >
                                <input type="text" id="developerNameList" name="developerNameList" class="check-input form-control"style="width: 255px;float: left;" readonly="readonly">
                            	<button id="addDevelopers" type="button" class="btn btn-primary" onclick="choosePerson()" style="float: left;width: 80px;margin-left: 5px ;text-align: center;">添加人员</button>
                            </div>
                        </div>
                         <div class="form-group row" style="display: none;visibility: hidden;">
                            <label class="col-md-2 form-control-label">借用人员id<span style="color: red;">*</span></label>
                            <div class="col-md-10">
                                <input type="text" id="developerIdList" name="developerIdList" class="check-input form-control">
                            </div>
                        </div>
                        <div class="form-group row" style="display: none;visibility: hidden;">
                            <label class="col-md-2 form-control-label">任务id<span style="color: red;">*</span></label>
                            <div class="col-md-10">
                                <input type="text" id="appTaskId" name="taskId" class="check-input form-control">
                            </div>
                        </div>
						<div class="form-group row" style="display: none;visibility: hidden;">
                            <label class="col-md-2 form-control-label">任务名<span style="color: red;">*</span></label>
                            <div class="col-md-10">
                                <input type="text" id="appTaskName" name="taskName" class="check-input form-control">
                            </div>
                        </div>
                        <!--方便前台验证  -->
                        <div class="form-group row" style="display: none;visibility: hidden;" >
                            <label class="col-md-2 form-control-label">任务借用开始时间</label>
                            <div class="col-md-10">
                                <input type="date" id="taskStartTime" class="check-input form-control" readonly="readonly">
                            </div>
                        </div>
                        
                        <div class="form-group row" style="display: none;visibility: hidden;">
                            <label class="col-md-2 form-control-label">任务借用结束时间</label>
                            <div class="col-md-10">
                                <input type="date" id="taskOverTime" class="check-input form-control" readonly="readonly">
                            </div>
                        </div>
                        
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">借用开始时间<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <input type="date" id="lendStartTime" name="lendStartTime" class="check-input form-control" >
                            </div>
                        </div>
						
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">借用结束时间<span style="color: red;">*</span></label>
                            <div class="col-md-9">
                                <input type="date" id="lendOverTime" name="lendOverTime" class="check-input form-control" >
                            </div>
                        </div>
					
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="cancelApply()">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addApply()">确认</button>
            </div>
        </div>
   </div>
 </div>
  <!-- 领取任务 =================================end -->
  
  <!-- 引入任务详情div -->
  <%@include file="/common/common-taskDetailDiv.jsp" %> 
  
  <!-- 引入公共弹窗页面 -->
  <%@include file="/common/common-msgAlert.jsp" %>	
  
<%--   指派开发人员
<div class="modal animate-fade" id="appointDeveloperModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <iframe src="plugins/common/common-developerChoose.jsp"></iframe>
        </div>
    </div>
   </div>
  --%>
    <%--人员列表--%>
    <%@include file="/common/userList.jsp" %>
    <script>
        function submitPerson(){
           /*  var nameStr = $("#selectedDevelopers").children("button").text();
            if(!nameStr){
                msgShow("您未选择新的成员！");
                return;
            } */
            var butlist = $("#selectedDevelopers").children("button");
            var idList = "";
            var nameList = "";
            $.each(butlist,function(n,e) {
                var obj = $(e);

                if(n==(butlist.size()-1)){
                    var id = obj.val();
                    var name = obj.text();
                }else{
                    var id = obj.val()+",";
                    var name = obj.text()+",";
                }
                nameList += name;
                idList += id;
            });
            $("#developerIdList").val(idList);
            $("#developerNameList").val(nameList);

        }
    </script>
    <%--人员列表--%>
</body>
<script type="text/javascript">
	
	//展现addTaskDiv
	function showAddTaskDiv() {
		$("#addTaskForm")[0].reset();
		$('#taskAddModal').modal('show') ;
	}
	
	//发布任务
	 function addTask() {
			if(!taskSubmitVerification()){
				return ;
			}
			 $.ajax({
				type : "post",
				url :"${basePath}/TaskPublishController/addTask" ,
				data: $("#addTaskForm").serialize(),
				dataType : 'json', 
				success: function (data) {
					if(data.success){
						window.location.href ="${basePath}/TaskPublishController/taskList"
					}else {
						alert(data.msg);
					}
					$("#addTaskForm")[0].reset();
					$('#taskAddModal').modal('hide') ;
				},
				error: function (data) {
					alert("后台服务器错误");
					$("#addTaskForm")[0].reset();
					$('#taskAddModal').modal('hide') ;
				}
			}); 
		} 
	
	//发布任务前台验证
	function taskSubmitVerification() {
		var taskName = $("#addtaskName").val();
		var peopleNum = $("#addpeopleNum").val();
		var startTime = $("#addstartTime").val();
		var overTime = $("#addoverTime").val();
		var abilityRequired = $("#addabilityRequired").val();
		var taskDesc = $("#addtaskDesc").val();
		var nowDate = getNowFormatDate();
		var flag = true;
		var msg = "";
		if(validateIsNull(taskName)){
			msg ="任务名不能为空！";
			taskAddWrongMsg(msg) ;
            return false;
		}
		if(!peopleNum){
			msg ="人数需求不能为空！";
			taskAddWrongMsg(msg) ;
            return false;
		}else if(validatePositiveNumber(peopleNum) == false){
				msg ="人数必须为正整数！";
				taskAddWrongMsg(msg) ;
	            return false;
		}
		
		if(!startTime){
			msg ="借用开始时间不能为空！";
			taskAddWrongMsg(msg) ;
            return false;
		}else if(!compareDate(startTime,nowDate)){
			msg ="借用开始时间不能小于当前时间！";
			taskAddWrongMsg(msg) ;
            return false;
		}
		if(!overTime){
			msg ="借用结束时间不能为空！";
			taskAddWrongMsg(msg) ;
            return false;
		}else if(!compareDate(overTime,nowDate)){
            msg ="借用结束时间不能小于当前时间！";
            taskAddWrongMsg(msg) ;
            return false;
        }else if(!compareDate(overTime,startTime)){
        	 msg ="借用结束时间不能小于借用开始时间！"
        	 taskAddWrongMsg(msg);
             return false;
        }
		if(!abilityRequired){
			msg = "技能需求不能为空！";
			taskAddWrongMsg(msg);
            return false;
		}
		if(!taskDesc){
			msg ="任务描述不能为空！";
			taskAddWrongMsg(msg) ;
			return false;
		}

			return true;
	}
	
	//信息弹出框点击确认后执行的函数
	function closeTaskAddMsgPromotAfter() {
		$('#taskAddModal').modal('show') ;
	}
	
	function taskAddWrongMsg(msg) {
		$('#taskAddModal').modal('hide') ;
		msgPromptModalShow(msg, 'closeTaskAddMsgPromotAfter()');
		
	}
	
	
	
	//关闭前端验证信息返回窗口 此时信息发布窗口重新显示
	function closeTaskMsgModal() {
		msgBody.style.height = "100px";
		$('#msgModal').modal('hide') ;
		$('#taskAddModal').modal('show') ;
	}
	
	//关闭普通验证窗口 
	function closeNormalMsgModal() {
		$('#msgModal').modal('hide') ;
	}
	
	//关闭领取任务前端验证返回窗口  此时点击为该窗口关闭  领取窗口显示
	function closeRrecieveTaskMsgModal() {
		$('#msgModal').modal('hide') ;
		$('#recieveTaskModal').modal('show') ;
	}
	
	//领取任务前台验证
	function taskRecieveVerification() {
		var applyDeveloperNum = $("#applyDeveloperNum").val();
		var developerNameList = $("#developerNameList").val();
		var taskOverTime  = $("#taskOverTime").val();        //验证人员借出结束时间是否包含任务借出结束时间可能还有问题
        var taskStartTime = $("#taskStartTime").val();
		var lendStartTime = $("#lendStartTime").val();
		var lendOverTime = $("#lendOverTime").val();
		var msg = "";
		var nowDate = getNowFormatDate();
		if(!applyDeveloperNum){
			msg = "借用人数不能为空！"
		    recieveTaskWrongMsg(msg);
            return false;
		}else if(applyDeveloperNum<=0){
			msg = "人数必须为正整数！"
			recieveTaskWrongMsg(msg);
            return false;
		}
		if(!developerNameList){
			msg ="指派人员名单不能为空！"
		    recieveTaskWrongMsg(msg);
            return false;
		}
		if(!lendStartTime){
			msg ="借用开始时间不能为空！"
		    recieveTaskWrongMsg(msg);
            return false;
		}else if(!compareDate(lendStartTime,nowDate)){
            msg = "借用开始时间不能小于当前时间！"
            recieveTaskWrongMsg(msg);
            return false;
        }/* else if(compareDate(lendStartTime,taskStartTime)){
        	 msg = "借用大于任务开始时间！"
             recieveTaskWrongMsg(msg);
             return false;
        } */
		
		if(!lendOverTime){
			msg = "借用结束时间不能为空！"
			recieveTaskWrongMsg(msg);
            return false;
		}else if(!compareDate(lendOverTime,nowDate)){
            msg = "借用结束时间不能小于当前时间！"
            recieveTaskWrongMsg(msg);
            return false;
        }/* else if(!compareDate(lendOverTime,taskOverTime)){
        	  msg = "借用结束时间小于任务结束时间！"
              recieveTaskWrongMsg(msg);
              return false;
        }else if(!compareDate(lendOverTime,lendStartTime)){
            msg ="借用结束时间小于借用开始时间！"
            recieveTaskWrongMsg(msg);
            return false;
        } */
			return true;
	}
	
	function closeRecieveMsgPromotAfter() {
		$('#recieveTaskModal').modal('show') ;
	}
	
	function recieveTaskWrongMsg(msg) {
		$('#recieveTaskModal').modal('hide') ;
		msgPromptModalShow(msg, 'closeRecieveMsgPromotAfter()');
		
	}
	
	/* function recieveTaskWrongMsg(msg) {
		var msgDiv = document.getElementById("msg");
        msgDiv.innerHTML = msg;
        var msgButton = document.getElementById("maskSureMsg");
        msgButton.onclick = closeRrecieveTaskMsgModal;
        $('#msgModal').modal('show') ;
        $('#recieveTaskModal').modal('hide') ;
	} */
	
	//打开领取任务窗口  任务名 id 状态 赋值给form表单
	function applyTask(taskId,taskName,publisherId,taskStartTime,taskOverTime) {
		
		var applyerId = $('#currentUserId').val(); 
		
		//不能领取自己发布的任务
		if(applyerId == publisherId) {
			msgPromptModalShow("不能领取自己发布的任务");
			return;
		}
		
        $.ajax({
            type : 'POST',
            dataType: 'Json',
            url : '${basePath}/TaskPublishController/AppliedWhetherOrNot',
            data : {
                taskId : taskId,
                'applyerId' : applyerId,
            },
            success : function(data) {
                if(data.success){
                    $("#applyForm")[0].reset();
                    //任务名 id 状态 赋值给form表单
                    $("#appTaskId").val(taskId);
                    $("#appTaskName").val(taskName);
                    $("#taskStartTime").val(taskStartTime);
                    $("#taskOverTime").val(taskOverTime);
                    $('#recieveTaskModal').modal('show') ;
                }else{
                	msgPromptModalShow(data.msg)
                    /* var msg = document.getElementById("msg");
                    msg.innerHTML= data.msg;
                    var msgButton = document.getElementById("maskSureMsg");
                    msgButton.onclick = closeNormalMsgModal;
                    var msgBody = document.getElementById("msgBody");
                    msgBody.style.height = "100px";
                    $('#msgModal').modal('show') ; */
                }
            },
            error : function(data) {
                alert("访问服务器端出错！");
            }
        });
        
    }
	
	//取消领取任务
	function cancelApply() {
		$('#recieveTaskModal').modal('hide') ;
	}
	
	//指派开发人员
/*	function appointDeveloper() {
		$('#appointDeveloperModal').modal('show') ;
		var selectesDevelopersId = $("#developerIdList").val();
		window.location.href = "${basePath}/TaskPublishController/getUserList?idsString="+selectesDevelopersId;
	}*/
	

	
	
	//确认添加开发人员时  将确认的开发人员信息回填到领取的弹窗
	function addDevelopers() {
		var developersDiv = document.getElementById("selectedDevelopers");
		var  developers = developersDiv.getElementsByTagName("button");
		var developersName ="";
		var developersId = "";
		for(var  i =0;i<developers.length;i++){
			 developersName = developersName+developers[i].innerHTML;
			 developersId =  developersId+developers[i].value;
			 if(i ==developers.length-1 ){
				 
			 }else{
			    developersName =developersName+ ",";
			    developersId = developersId + ",";
			 }
		}
		$("#developerNameList").val(developersName); //回填已选开发者姓名
		$("#developerIdList").val(developersId);	//回填已选开发者id
		$("#searchDeveloperName").val("");	//删除搜索框内容
		$('#recieveTaskModal').modal('show') ;
		$('#appointDeveloperModal').modal('hide') ;
	}
	
	//点击关闭添加开发人员窗口
	function cancelAdd() {
		$('#appointDeveloperModal').modal('hide') ;
		$('#recieveTaskModal').modal('show') ;
		$("#searchDeveloperName").val("");
		 //关闭时将已选择的清空 selectedDevelopers div中的按钮
		var developersDiv = document.getElementById("selectedDevelopers");
		developersDiv.innerHTML = ""; 
	}
	
	//领取任务
	function addApply() {
		 if(taskRecieveVerification() == false){
			return ;
		} 
		$.ajax({
			type : 'POST',
			dataType: 'Json',
			data:$("#applyForm").serialize(),
			url : '${basePath}/apply/confirmApplyTask',
			success : function(data) {
				if(data.success) {
					$("#applyForm")[0].reset();
					$('#recieveTaskModal').modal('hide') ;
					msgPromptModalShow(data.msg);
				}else{
					$('#recieveTaskModal').modal('hide') ;
					msgPromptModalShow(data.msg);
				}
				
			},
			error : function(data) {
				alert("访问服务器端出错！");
				$("#applyForm")[0].reset();
				$('#recieveTaskModal').modal('hide') ;
				
			}
		});
	}
	
	//获取当前时间，格式YYYY-MM-DD
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year + seperator1 + month + seperator1 + strDate;
        return currentdate;
    }
	
	/* //比较两个时间大小
	function compareDate(date1,date2) {
		var oDate1 = new Date(date1);
	    var oDate2 = new Date(date2);
	    if(oDate1.getTime() >= oDate2.getTime()){
	       return true;
	    } else {
	       return false;
	    }
	} */
</script>
<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>

</html>
