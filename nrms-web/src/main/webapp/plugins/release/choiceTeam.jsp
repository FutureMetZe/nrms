<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>

<html>
<%@include file="/common/common-ui.jsp" %>
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
                <li class="breadcrumb-item active">选择团队</li>
            </ol>


            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="card">

                                <div class="card-header">
                                    <i class="fa fa-code"></i> 领取任务团队列表
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
                                            <th style="text-align: center">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <c:forEach items="${beans}" var="Apply">
                                            <tr>
                                                <td>${Apply.applyerName}</td>
                                                <td>${Apply.developerNameList}</td>
                                                <td>${Apply.applyDate}</td>
                                                <td>${Apply.lendStartTime}</td>
                                                <td>${Apply.lendOverTime}</td>
                                                <td>
                                                    <a class="badge badge-star" onclick="agreeApply('${Apply.applyId}')" >确认申请</a>
                                                    <a class="badge badge-pwd" onclick="toAppraiseList('${Apply.developerIdList}')">查看评价</a>
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
<script>

    //同意申请，将申请状态设置为1
    function agreeApply(applyId){
        $.ajax({
            url:"${basePath}/release/agreeApply",
            type:"post",
            dataType:"json",
            data:{"applyId":applyId},
            success:function(data){
                msgPromptModalShow(data.msg,'hideMsg()');

            },
            error:function(){
                msgPromptModalShow("服务器暂无响应，请稍后再试！",'hideMsg()');
            }
        });
    }


    function toAppraiseList(appraiseIdList) {
        window.open ("${basePath}/release/appraiseList?appraiseIdList="+appraiseIdList, "newwindow", "height=500, width=1100, top=150, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no")&nbsp;
    }
</script>


<script>
    function msgShow(textMsg){
        $("#msg").text(textMsg);
        $("#msgModal").modal('show');

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
