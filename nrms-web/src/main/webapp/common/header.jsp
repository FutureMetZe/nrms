<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="app-header navbar">
    <button class="navbar-toggler mobile-sidebar-toggler hidden-lg-up" type="button">☰</button>
    <a class="navbar-brand" href="#"></a>
    <ul class="nav navbar-nav hidden-md-down">
        <li class="nav-item">
            <a class="nav-link navbar-toggler sidebar-toggler" href="#">☰</a>
        </li>
    </ul>
    <ul class="nav navbar-nav ml-auto mr-sm-3">

        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button"
               aria-haspopup="true" aria-expanded="false">
                <img src="${basePath}/resources/images/header_user.jpg" class="img-avatar" alt="admin@bootstrapmaster.com">
                <span class="hidden-md-down">${sessionScope.LOGIN_USER.firstname}</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <a class="dropdown-item" href="#"><i class="fa fa-user"></i> 个人资料</a>
                <a class="dropdown-item" href="#"><i class="fa fa-cog"></i> 设置</a>
                <a class="dropdown-item" href="${basePath}/logOut"><i class="fa fa-reply-all"></i> 退出</a>
            </div>
        </li>

    </ul>
</header>