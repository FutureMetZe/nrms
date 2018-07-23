<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
    <!--指派开发人员 ==============================start -->
   <ul id="allDeveloperData" style="visibility: hidden;display: none;"></ul> <!-- 保存所有的开发者信息 -->
  
            <div class="modal-header">
                <h6 class="modal-title" id="myModalLabel12">添加团队成员</h6>
                <button type="button" class="close" data-dismiss="modal" onclick="hiddenDiv()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-group row">
                    <label class="col-md-2 form-control-label text-right">姓名</label>
                    <div class="col-md-7">
                        <input type="text" class="check-input form-control"
                               aria-label="" placeholder="输入姓名进行搜索" id="searchDeveloperName">
                    </div>
                    <button type="button" class="btn btn-primary"  aria-hidden="true" onclick="chooseDeveloper()">搜索</button>
                </div>
                <div class="add-user-content" >
                    <ul class="add-user-list" id="developerListHtml">
                        <c:forEach items="${userList}" var="user">
	                        <c:if test="${user.isSelected == true }">
		                        <li value=" ${user.id } " onclick=" changeState(this)" style="background-color: rgb(43, 131, 193);"> 
		                             ${user.firstname } <i  class="fa fa-check hide">2</i></li>"
		                       
	                        </c:if>
	                        <c:if test="${user.isSelected != true }">
                                <li value=" ${user.id } " onclick=" changeState(this)" > ${user.firstname } <i  class="fa fa-check hide">1</i></li>
                            </c:if>
                        </c:forEach>
                    </ul>

                </div>
                <hr>
                <div class="add-user-content" id="selectedDevelopers">
                       <c:forEach items="${userList}" var="user">
                            <c:if test="${user.isSelected == true }">
                               <button onclick = "deleteDeveloper(${user.id } )" class="btn" value="${user.id }"> ${user.firstname } </button>
                               
                            </c:if>
                        </c:forEach>
                </div>
            </div>
            <div class="modal-footer">
                <button  class="btn btn-default" onclick="cancelAdd()" >关闭</button>
                <button  class="btn btn-primary" onclick="addDevelopers()">确认</button>
            </div>
   
    <!--指派开发人员 ==============================end -->

</body>
<script type="text/javascript">
//按名搜索开发人员
function chooseDeveloper() {
    var searchDeveloperName = $("#searchDeveloperName").val();
    var developerUl = document.getElementById("developerListHtml");
    var allDeveloperData = document.getElementById("allDeveloperData");//隐藏的ul 保存所有开发人员信息
    developerUl.innerHTML = allDeveloperData.innerHTML;//每次搜索都是从所有开发人员搜索
    if(!searchDeveloperName){//若搜索名为空 则显示所有开发人员名单
        return;
    }
    var developerLi = developerUl.getElementsByTagName("li");
    var userResult=new Array();
    var j = 0;
    for(var i = 0;i<developerLi.length;i++){
        var temp = developerLi[i].getElementsByTagName("i")[0];
        developerLi[i].removeChild(developerLi[i].getElementsByTagName("i")[0]);
        var developerName = developerLi[i].innerHTML;
        developerLi[i].appendChild(temp);
        if(developerName.search(searchDeveloperName) != -1 ){
            userResult[j] = developerLi[i];
            j++;
        }
    }
    
    //删除ul下的所有开发人员
    var childs = developerUl.childNodes; 
    for(var i = childs.length - 1; i >= 0; i--) { 
        developerUl.removeChild(childs[i]); 
        }
    
    //添加查询出来的开发人员
    for(var k =0;k<userResult.length;k++){
        developerUl.appendChild(userResult[k]);
    }

}

function changeState(developerDomLi) {
    //全部开发人员
    var allDeveloperLi = document.getElementById("allDeveloperData").getElementsByTagName("li");
    var developerDomI = developerDomLi.getElementsByTagName("i")[0];
    if(developerDomI.innerHTML =='1'){
        developerDomI.innerHTML ='2'
        developerDomLi.style.backgroundColor= "rgb(43, 131, 193)";
        
    }else{
        developerDomI.innerHTML ='1'
        developerDomLi.style.backgroundColor= "";
        
    }
    //同时要改变全部开发人员信息 即ul
    for(var i = 0;i<allDeveloperLi.length;i++){
        if(allDeveloperLi[i].value == developerDomLi.value ){
        /*  alert("developerDomLi.style.backgroundColor: "+developerDomLi.style.backgroundColor); */
            allDeveloperLi[i].style.backgroundColor = developerDomLi.style.backgroundColor;
            allDeveloperLi[i].getElementsByTagName("i")[0].innerHTML= developerDomLi.getElementsByTagName("i")[0].innerHTML;

        }
    }
    // 更新被选中的开发人员
    var selectedDevelopers = document.getElementById("selectedDevelopers");
    selectedDevelopers.innerHTML = "";
    for(var i = 0;i<allDeveloperLi.length;i++){
        if(allDeveloperLi[i].getElementsByTagName("i")[0].innerHTML=="2"){
            var developerButton=document.createElement('button');
            developerButton.className = "btn";
            developerButton.value = allDeveloperLi[i].value;
            developerButton.onclick = function() {
                deleteDeveloper(this.value);
            };
            var temp = allDeveloperLi[i].getElementsByTagName("i")[0];
            allDeveloperLi[i].removeChild(allDeveloperLi[i].getElementsByTagName("i")[0])
            developerButton.innerHTML = allDeveloperLi[i].innerHTML;
            allDeveloperLi[i].appendChild(temp);
            selectedDevelopers.appendChild(developerButton);
        }
    }
}

function deleteDeveloper(developerId) {
    //删除 div  selectedDevelopers 中对应的人员
    var developersDiv = document.getElementById("selectedDevelopers");
    var developers = developersDiv.getElementsByTagName("button");
    for(var i = 0 ;i<developers.length;i++){
        if(developers[i].value == developerId){
            developersDiv.removeChild(developers[i]);
        }
    }
    
    //找到保存所有开发人员信息的隐藏的ul 将li改为未被选择
    var allDeveloperLi = document.getElementById("allDeveloperData").getElementsByTagName("li");
    for(var i = 0;i<allDeveloperLi.length;i++){
        if(allDeveloperLi[i].value == developerId ){
             allDeveloperLi[i].style.backgroundColor ="";
             allDeveloperLi[i].getElementsByTagName("i")[0].innerHTML= "1"; 
        }
    }
    //将开发人员选择列表重新刷新一遍
    var developerUl = document.getElementById("developerListHtml");
    var allDeveloperData = document.getElementById("allDeveloperData");//隐藏的ul 保存所有开发人员信息
    developerUl.innerHTML = allDeveloperData.innerHTML;//每次搜索都是从所有开发人员搜索
}

</script>
</html>