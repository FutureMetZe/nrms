<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<script>
    function toNextPage(toPageNum){
    	if($("#nextPage").val()) {
    		$("#pageNum").val(toPageNum);
            $("#searchForm").submit();
    	}
    }
    
    function toPrePage(toPageNum){
    	if($("#prePage").val()) {
    		$("#pageNum").val(toPageNum);
            $("#searchForm").submit();
    	}
    }
    
    function JumpToPage(toPageNum){
   		if(toPageNum <= $("#pageCount").val()){
   			$("#pageNum").val(toPageNum);
            $("#searchForm").submit();
   		}else{
   			msgPromptModalShow("所输页码应小于总页数");
   		}
   	}

    function changeNum() {
        var pageNum = $("#toPageNum").val();
        if(pageNum == ""){
            return ;
        }
        var inputStr =  /^[0-9]*$/;
        if(!inputStr.test(pageNum)){
        	msgPromptModalShow("所输页码应为正整数");
            return;
        }
        JumpToPage(pageNum);
    }

</script>

	<span class="pagination float-left">共有${page.dataCount }条数据,页次:${page.pageNum  }/${page.pageCount == 0 ? 1 : page.pageCount }&emsp;</span>

	<input type="hidden" id= "nextPage" value= ${page.nextPage}>
	<input type="hidden" id= "prePage" value= ${page.prePage}>
	<input type="hidden" id= "pageCount" value= ${page.pageCount}>
	
<ul class="pagination float-right">
	<li class="page-item">
		<a class="page-link" onclick="toPrePage(${page.pageNum-1})">上一页</a>
	</li>

	<li class="page-item">
		<%--<a class="page-link" href="#">1</a>--%>
		<a class="page-link">${page.pageNum}</a>
	</li>

		<a class="page-link" onclick="toNextPage(${page.pageNum+1})">下一页</a>
	</li>
	&nbsp;&nbsp;
	<a class="page-link">转到</a>
	<input type="text" id="toPageNum" class="page-link" style="width:45px;" minlength="1" maxlength="2"/>
	<a class="page-link">页</a>
	<a class="page-link" onclick="changeNum()">确定</a>
</ul>

