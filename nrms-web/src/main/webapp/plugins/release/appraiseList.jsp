<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta name="keyword" content="">
<link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.png">
<title>查看评价</title>
<link href="${basePath}/resources/css/style.min.css" rel="stylesheet">
<link href="${basePath}/resources/css/style.css" rel="stylesheet">
<link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
<link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
<script src="${basePath}/resources/js/libs/jquery-2.1.4.min.js"></script>
<script src="${basePath}/resources/js/libs/bootstrap.min.js"></script>
<script src="${basePath}/resources/js/require.js"></script>
<script src="${basePath}/resources/js/main.js"></script>
<!- -[if lt IE]>
<script src="${basePath}/resources/js/libs/respond.min.js"></script>
<script src="${basePath}/resources/js/libs/html5shiv.min.js"></script>
<![endif]- ->

            <div class="container-fluid">
                <div class="animated fadeIn">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="from-search">
                                <form id="searchForm" action="${basePath}/release/appraiseList">
                                    <input type="hidden" id="pageNum" name="pageNum" value="1">
                                    <ul class="form-inline">
                                        <input type="hidden" name="appraiseIdList" value="${appraiseIdList}">
                                        <li class="form-group">
                                            <label for="userName">开发人员</label>
                                            <select type="text" id="userName" name="userName" class="form-control" onchange="submitSearch()">

                                                <c:if test="${userName!=null}">
                                                    <option value="${userName}">${userName}</option>
                                                </c:if>
                                                <option value="">全部</option>
                                                <c:forEach items="${users}" var="User">
                                                    <c:if test="${userName!=User.firstname}">
                                                        <option value="${User.firstname}">${User.firstname}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </li>

                                    </ul>
                                </form>
                            </div>
                            <div class="card">

                                <div class="card-header">
                                    <i class="fa fa-code"></i> 评价列表
                                </div>
                                <div class="card-block">
                                    <table class="table user-table table-striped">
                                        <thead>
                                        <tr>
                                            <th>开发人员</th>
                                            <th>任务名</th>
                                            <th>本次得分</th>
                                            <th>评价人</th>
                                            <th>评价</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${beans}" var="Appraise">
                                            <tr>
                                                <td>${Appraise.developerName}</td>
                                                <td>${Appraise.taskName}</td>
                                                <td>${Appraise.score}</td>
                                                <td>${Appraise.appraiserName}</td>
                                                <td>${Appraise.appraiseContent}</td>
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
                    $("#myModal").show();
                }else{
                    msgPromptModalShow(data.msg,'hideMsg()');
                }
            },
            error:function(){
                msgPromptModalShow("服务器没有响应，请稍后再试！",'hideMsg()');
            }
        });
    }

    function submitSearch(username,idList){
        document.getElementById("searchForm").submit();
    }


</script>
<script>
    function msgShow(textMsg){
        $("#msg").text(textMsg);
        $("#msgModal").show();

    }
    function hideMsg(){
        $("#msgModal").hide();
        $("#msgModal").text("");
        window.location.reload();
    }
</script>
<!--操作信息返回div ==============================end -->