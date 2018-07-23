<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta name="keyword" content="">
<link rel="shortcut icon" href="${basePath}/resources/images/favicon_logo.png">
<title>研发任务发布系统</title>
<link href="${basePath}/resources/css/style.min.css" rel="stylesheet">
<link href="${basePath}/resources/css/style.css" rel="stylesheet">
<link href="${basePath}/resources/css/font-awesome.min.css" rel="stylesheet">
<link href="${basePath}/resources/css/simple-line-icons.css" rel="stylesheet">
<script src="${basePath}/resources/js/libs/jquery-2.1.4.min.js"></script>
<script src="${basePath}/resources/js/libs/bootstrap.min.js"></script>
<!- -[if lt IE]>
<script src="${basePath}/resources/js/libs/respond.min.js"></script>
<script src="${basePath}/resources/js/libs/html5shiv.min.js"></script>
<![endif]- ->
    <script type="text/javascript">

        $(document).ready(function() {
            document.onkeydown = function(e) {
                var ev = document.all ? window.event : e;
                if (ev.keyCode == 13) {
                    doLogin();
                }
            }
        });

        function doLogin() {

            var loginName = $("#loginName").val();
            var pwd = $("#pwd").val();
            $.ajax({
                type : 'POST',
                url : '${basePath}/doLogin',
                data : {
                    'loginName' : loginName,
                    'pwd' : pwd
                },
                dataType : 'json',
                success : function(data) {
                    if (data.success) {
                        window.location.href = "${basePath}/TaskPublishController/taskList";
                    } else {
                        alert(data.msg);
                    }
                },
                error : function(data) {
                    alert("服务器没有响应，请稍后再试！");
                }
            });

        }
        document.onkeydown = keyListener;
        function keyListener(e) {
            e = e ? e : event;// 兼容FF
            if (e.keyCode == 13) {
                doLogin();
            }
        }


       /* function refreshValidateCode(){
            $("#validateCodeImg").attr("src" , basePath+"/validate?date="+new Date())
        }*/
    </script>

<body class="login">
<div class="login-body">
    <div class="login-logo">
        <span>研发任务发布系统<span class="login-logo-text">SYS</span></span>
    </div>
    <div class="login-from">
        <div class="login-padding">
            <div>
                <h2>用户名:</h2>
                <label>
                    <input type="text" id="loginName" class="txt-input" autocomplete="off">
                </label>
                <h2>密码:</h2>
                <label>
                    <input type="password" id="pwd" class="txt-input" autocomplete="off">
                </label>
            </div>
            <div class="operate-box">
                <label class="remember-me">
                    <span class="remember-icon"><span class="remember-box"></span></span>
                    <input type="checkbox" name="remember-me" id="remember-me" checked>
                    <span>记住密码</span></label>
                <span class="forgot-pwd"><a href="javascript:void(0);">忘记密码?</a></span>
            </div>
            <div class="login-button">
                <input type="button" class="sub-button" name="button" id="button" value="登 录" onclick="doLogin()">
            </a>

            </div>
        </div>
    </div><!--login_boder end-->
</div><!--login_m end-->

<script>
    //    remember
    $("#remember-me").click(function () {
        var n = document.getElementById("remember-me").checked;
        if (n) {
            $(".remember-box").show();
        } else {
            $(".remember-box").hide();
        }
    });

    //login_bg
    var winHeight = $(window).height();
    $(".login").css("height", winHeight);
    $(window).resize(function () {
        winHeight = $(window).height();
        $(".login").css("height", winHeight);
    });
</script>
</body>
</html>