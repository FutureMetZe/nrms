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
    <div id="wrap" class="">
        <!--    头部 和  菜单 start -->
        	<%@include file="/common/headAndLeft.jsp" %>
        <!--    头部 和  菜单 end -->
        
        <!-- 内容start -->
        <main class="main">

            <!-- Breadcrumb -->
            <ol class="breadcrumb">
                <li class="breadcrumb-item">当前位置</li>
                <li class="breadcrumb-item active">我发布的
                </li>
                <%--<li class="breadcrumb-item active">用户管理</li>--%>
            </ol>


            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="from-search">
                                <form id="searchForm" action="${basePath}/release/myList" type="post">
                                    <input type="hidden" id="pageNum" name="pageNum" value="1">
                                    <ul class="form-inline">
                                        <li class="form-group">
                                            <label for="taskName">任务名</label>
                                            <input type="text" class="form-control" id="taskName" name="taskName" value="${taskName}">
                                        </li>

                                        <li class="form-group">
                                            <label for="taskStatus">任务状态</label>
                                            <select type="text" id="taskStatus" name="taskStatus" class="form-control ">
                                                <c:if test="${taskStatus == null}">
                                                    <option value="">全部</option>
                                                    <option value="1">开启</option>
                                                    <option value="2">关闭</option>
                                                </c:if>
                                                <c:if test="${taskStatus == 1}">
                                                    <option value="1">开启</option>
                                                    <option value="">全部</option>
                                                    <option value="2">关闭</option>
                                                </c:if>
                                                <c:if test="${taskStatus == 2}">
                                                    <option value="2">关闭</option>
                                                    <option value="">全部</option>
                                                    <option value="1">开启</option>
                                                </c:if>
                                            </select>
                                        </li>
                                        <li class="form-group-btn">
                                            <%--<button type="submit" class="btn btn-secondary">重置</button>--%>
                                            <button type="submit" class="btn btn-primary">搜索</button>
                                        </li>
                                    </ul>
                                </form>
                            </div>
                            <div class="card">

                                <div class="card-header">
                                    <i class="fa fa-code"></i> 我发布的

                                </div>
                                <div class="card-block">
                                    <table class="table user-table table-striped">
                                        <thead>
                                        <tr>
                                            <th>任务名</th>
                                            <th>人数需求</th>
                                            <th>借用开始时间</th>
                                            <th>借用截至时间</th>
                                            <th>任务状态</th>
                                            <th>发布时间</th>
                                            <th>申请团队数</th>

                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${beans}" var="Task">
                                            <tr>
                                                <td>${Task.taskName}</td>
                                                <td>${Task.peopleNum}</td>
                                                <td>${Task.startTime}</td>
                                                <td>${Task.overTime}</td>
                                                <td>
                                                    <c:if test="${Task.taskStatus==1}">
                                                        开启
                                                    </c:if>
                                                    <c:if test="${Task.taskStatus==2}">
                                                        关闭
                                                    </c:if>
                                                    <c:if test="${Task.taskStatus==3}">
                                                        作废
                                                    </c:if>
                                                </td>
                                                <td>${Task.createdTime}</td>

                                                <td>${Task.teamCount}</td>
                                                <td>
                                                    <c:if test="${Task.taskStatus==1}">
                                                        <a class="badge badge-edit" href="${basePath}/release/choiceTeam?taskId=${Task.taskId}">选择团队</a>
                                                        <a class="badge badge-edit" href="${basePath}/release/confirmTeam?taskId=${Task.taskId}">人员交付</a>
                                                        <a class="badge badge-star" onclick="showConfirm('${Task.taskId}',2)">关闭任务</a>
                                                        <a class="badge badge-pwd" onclick="showConfirm('${Task.taskId}',3)">取消任务</a>
                                                    </c:if>
                                                    <c:if test="${Task.taskStatus==2}">
                                                        <a class="badge badge-edit" href="${basePath}/release/confirmTeam?taskId=${Task.taskId}">人员交付</a>
                                                        <a class="badge badge-pwd"  data-toggle="modal" onclick="getTask('${Task.taskId}');">查看</a>
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

    </div>
</body>

<!-- /.modal-content -->
<script>
    function getTask(taskId){
        $.ajax({
            url:'${basePath}/release/getApplyTeam',
            type:'post',
            dataType:'json',
            data:{"taskId":taskId},
            success:function(data){
                if(data.success){
                    var applyList = data.dataList;
                    DisplayListItems(applyList)
                   // $("#myModal").show();
                    $('#myModal').modal({backdrop:'static',keyboard:false,show:true});
                }else{
                    msgPromptModalShow(data.msg);
                }
            },
            error:function(){
                msgPromptModalShow("服务器没有响应，请稍后再试！");
            }
        });
    }

    function DisplayListItems(list){
        $("#applyList").text("");
        $.each(list, function(index, element) {
            var isAppoint = "未交付";
            if(element.isAppoint==1){
                isAppoint = "已交付";
            }
            var itemHTML = ["<label class=\"form-group row\" style=\"color: #943b2d\">团队",index+1,"(",isAppoint,")","</label>",

                "<div class=\"form-group row\">\n" +
                "   <label class=\"col-md-2 form-control-label\">负责人</label>\n" +
                "   <div class=\"col-md-10\">\n" +
                "        <input type=\"text\" value=",element.applyerName," class=\"check-input form-control\"  disabled=\"disabled\">\n" +
                "   </div>\n" +
                "</div>",

                "<div class=\"form-group row\">\n" +
                "   <label class=\"col-md-2 form-control-label\">团队成员</label>\n" +
                "   <div class=\"col-md-10\">\n" +
                "        <input type=\"text\" value=",element.developerNameList," class=\"check-input form-control\"  disabled=\"disabled\">\n" +
                "   </div>\n" +
                "</div>",

                "<div class=\"form-group row\">\n" +
                "   <label class=\"col-md-2 form-control-label\">借出日期</label>\n" +
                "   <div class=\"col-md-10\">\n" +
                "        <input type=\"text\" value=",element.lendStartTime," class=\"check-input form-control\"  disabled=\"disabled\">\n" +
                "   </div>\n" +
                "</div>",

                "<div class=\"form-group row\">\n" +
                "   <label class=\"col-md-2 form-control-label\">完成日期</label>\n" +
                "   <div class=\"col-md-10\">\n" +
                "        <input type=\"text\" value=",element.lendOverTime," class=\"check-input form-control\"  disabled=\"disabled\">\n" +
                "   </div>\n" +
                "</div>",
                "<div>",

                ].join('\n');

            $("#applyList").append(itemHTML);
            });
    }

    function hiddenDiv(){
        $("#myModal").hide();
    }

    function setTaskStatus(taskId,status){
        $.ajax({
            url:"${basePath}/release/updateTaskStatus",
            type:"post",
            dataType:"json",
            data:{"status":status,"taskId":taskId},
            success:function (data) {
                msgPromptModalShow(data.msg,'hideMsg()');
            },
            error:function(){
                msgPromptModalShow("服务器没有响应，请稍后再试！","hideMsg()");
            }
        })

    }

    //显示确认提示框
    function showConfirm(taskId,status){
        $("#confirmTaskId").val(taskId);
        $("#confirmTaskStatus").val(status);
        if(status==2){
            $("#msg2").text("您确认要关闭该任务？");
        } else {
            $("#msg2").text("您确认要取消该任务？");
        }
        $("#msgModal2").show();
        $('#msgModal2').modal({backdrop:'static',keyboard:false,show:true});
    }

    //确认提示框确定操作
    function confirmTrue(){
        var taskId=$("#confirmTaskId").val();
        var status=$("#confirmTaskStatus").val();
        setTaskStatus(taskId,status);
        confirmClose();
    }

    //确定提示框取消操作
    function confirmClose(){
        $("#msgModal2").hide();
    }


</script>
<div class="modal animate-fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
    <%-- aria-hidden="true"--%>>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="myModalLabel">参与团队列表</h6>
                <button type="button" class="close" data-dismiss="modal" onclick="hiddenDiv()" >&times;</button>
            </div>
            <div class="modal-body">
                <div class="card-block" id="applyList">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="hiddenDiv()">关闭</button>

            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!--确认框 -->
<div class="modal animate-fade" id="msgModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="myModalLabel3">请确认</h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="confirmClose()">&times;</button>
            </div>
            <div class="modal-body" id="msg2Body" style="height:100px;">
                <div class="card-block"  >
                    <div id="msg2" style="text-align: center;">
                        您确认要取消该申请？
                    </div>
                </div>
            </div>
            <div align="center">
                <input type="hidden" id="confirmTaskId" value="">
                <input type="hidden" id="confirmTaskStatus" value="">

                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirmTrue()">确认</button>
                &nbsp;&nbsp;
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirmClose()">取消</button>
                <h6>&nbsp;&nbsp;</h6>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!--  确认框  -->

<script>
    function msgShow(textMsg){
        $("#msg").text(textMsg);
        $("#msgModal").modal('show');
        $('#msgModal').modal({backdrop:'static',keyboard:false,show:true});


    }
    function hideMsg(){
        $("#msgModal").modal('hide');
        $("#msgModal").text("");
        window.location.reload();
    }
</script>
<!--操作信息返回div ==============================end -->

<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>

</html>
