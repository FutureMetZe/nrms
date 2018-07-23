<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>

<div class="sidebar">
    <nav class="sidebar-nav">
        <ul class="nav">
            <li class="nav-item text-center">
                <a class="nav-link" href="#"><i class="fa fa-leanpub"></i> 回到门户</a>
            </li>

			
            <li class="nav-item">
                <a class="nav-link " href="${basePath}/TaskPublishController/taskList"><i class="fa fa-user"></i> 任务发布</a>
            </li>
            <li class="nav-item">
                <a class="nav-link " id="myRelease" href="${basePath}/release/myList"><i class="icon-pie-chart"></i> 我发布的</a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="${basePath}/apply/toAppliedListPage"><i class="icon-notebook"></i> 我申请的</a>
            </li>
            <li class="nav-item">
                <a class="nav-link " href="${basePath}/appraise/applyList"><i class="icon-wrench"></i> 我的评价</a>
            </li>
            
        </ul>
    </nav>
</div>
<script type="text/javascript">
	$(document).ready(function(){  
	    $(".nav-item a").each(function(){  
	        $this = $(this);  
	        if(String(window.location).search($this[0].href)!=-1){
	           $this.addClass("active");
	        }else if(String(window.location).includes("release")){
                $("#myRelease").addClass("active");
            }
	    });  
	}); 
</script>
