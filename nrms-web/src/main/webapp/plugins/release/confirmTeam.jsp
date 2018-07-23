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
                <li class="breadcrumb-item">我发布的
                </li>
                <li class="breadcrumb-item active">查看团队</li>
            </ol>


            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="card">

                                <div class="card-header">
                                    <i class="fa fa-code"></i> 未确认团队列表
                          <%--          <button type="button" class="btn btn-success float-right" data-toggle="modal"
                                            data-target="#myModal">添加用户
                                    </button>--%>
                                </div>
                                <div class="card-block">
                                    <table class="table user-table table-striped">
                                        <thead>
                                        <tr>
                                            <th>负责人</th>
                                            <th>团队成员</th>
                                            <th>领取任务时间</th>
                                            <th>借出开始时间</th>
                                            <th>借出截止时间</th>
                                            <th>交付状态</th>
                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${beans}" var="Apply">
                                            <tr>
                                                <td>${Apply.applyerName}</td>
                                                <td>
                                                    ${Apply.developerNameList}
                                                </td>
                                                <td>${Apply.applyDate}</td>
                                                <td>${Apply.lendStartTime}</td>
                                                <td>${Apply.lendOverTime}</td>
                                                <td>
                                                    <c:if test="${Apply.isAppoint==0}">
                                                        未交付
                                                    </c:if>
                                                    <c:if test="${Apply.isAppoint==1}">
                                                        已交付
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${Apply.isAppoint==0}">
                                                        <a class="badge badge-star" onclick="choosePerson('${Apply.developerIdList}','${Apply.applyId}')">人员交付</a>
                                                        <a class="badge badge-pwd" onclick="showConfirm('${Apply.applyId}')">取消申请</a>
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

<%--人员列表--%>
<%@include file="/common/userList.jsp" %>
<script>
    //确认交付按钮
    function submitPerson(){
        var nameStr = $("#selectedDevelopers").children("button").text();
        if(!nameStr){
            msgPromptModalShow("您未选择新的成员！");
            return;
        }
        var applyId = $("#applyId").val();

        var butlist = $("#selectedDevelopers").children("button");
        var nameList = "";
        $.each(butlist,function(n,e) {
            var obj = $(e);
            if(n==(butlist.size()-1)){
                var name = obj.text();
            }else{
                var name = obj.text()+" ";
            }
            nameList += name
        });


        $.ajax({
            url:'${basePath}/release/addName',
            type:'post',
            dataType:'json',
            data:{"name":nameList,"applyId":applyId},
            success:function(data){
                msgPromptModalShow(data.msg,'hideMsg()');
            },
            error:function(){
                msgPromptModalShow("服务器没有响应，请稍后再试！",'hideMsg()');
            }
        });
    }

    function closeDiv(){
        window.location.reload();
    }
</script>
<%--人员列表--%>

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
                <input type="hidden" id="confirmApplyId" value="">

                <button type="button" class="btn btn-primary" style="" onclick="confirmTrue()">确认</button>
                &nbsp;&nbsp;
                <button type="button" class="btn btn-primary" style="" onclick="confirmClose()">取消</button>
                <h6>&nbsp;&nbsp;</h6>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!--  确认框  -->

<script>
    //显示错误提示框（错误提示内容）
    function msgShow(textMsg){
        $("#msg").text(textMsg);
        $("#msgModal").show();

    }

    //隐藏错误提示框
    function hideMsg(){
        $("#msgModal").hide();
        $("#msgModal").text("");
        window.location.reload();
    }

    //显示确认框
    function showConfirm(applyId){
        $("#confirmApplyId").val(applyId);
        $("#msgModal2").modal('show');
    }

    //确认框确认操作
    function confirmTrue(){
        var applyId=$("#confirmApplyId").val();
        cancelApplyById(applyId);
        confirmClose();
    }

    //确认框关闭操作
    function confirmClose(){
        $("#msgModal2").modal('hide');
    }

    //取消申请
    function cancelApplyById(applyId){
        $.ajax({
            url:'${basePath}/release/cancelApply',
            type:'post',
            dataType:'json',
            data:{"name":name,"applyId":applyId},
            success:function(data){
                msgPromptModalShow(data.msg,'hideMsg()');
            },
            error:function(){
                msgPromptModalShow("服务器没有响应，请稍后再试！",'hideMsg()');
            }
        });
    }
</script>
<!--操作信息返回div ==============================end -->



<script>
    function Cmd(obj) {
        $(obj).parent("li").next("li").find("form ").each(function () {
            $(this).hide();
        });
        $("#div" + obj.value).show();
    }

    function showDiv() {
        $("#myModal").show();
    }

    function hiddenDiv(){
        $("#myModal").hide();
    }

    $('.multiselect').multiselect({setMaxOptionNum: 6, selectedHtmlValue: '多选'});


</script>
<script src="${basePath}/resources/js/index.js"></script>
<script src="${basePath}/resources/js/formgroup.js"></script>
</html>
