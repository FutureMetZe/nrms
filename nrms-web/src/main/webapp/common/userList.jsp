<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<script>

</script>


<!-- 保存所有的开发者信息 -->
<ul id="allDeveloperData" style="visibility: hidden;display: none;"></ul>

<!--指派开发人员 ==============================start -->
<div class="modal animate-fade" id="appointDeveloperModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	 aria-hidden="true" >
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h6 class="modal-title" id="myModalLabel12">添加团队成员</h6>
				<button type="button" class="close" data-dismiss="modal" onclick="closeDiv()">&times;</button>
			</div>
			<div class="modal-body">
				<div class="form-group row">
					<label class="col-md-2 form-control-label text-right">姓名</label>
					<div class="col-md-7">
						<input type="text" class="check-input form-control"
							   aria-label="" placeholder="输入姓名进行搜索" id="searchDeveloperName">
					</div>
					<button type="button" class="btn btn-primary"  aria-hidden="true" onclick="searchLi()">搜索</button>
				</div>
				<div class="add-user-content" id="hiddenCount">
					<ul class="add-user-list" id="developerListHtml">

					</ul>
				</div>
				<hr>
				<div class="add-user-content" id="selectedDevelopers">

                </div>
			</div>
			<div class="modal-footer">
				<input type="hidden" id="applyId" name="applyId" value="">
				<button type="button" class="btn btn-default" data-dismiss="modal"  onclick="closeDiv()">关闭</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="submitPerson()">确认</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
<!--指派开发人员 ==============================end -->

<script>

    //添加人员按钮 idList回显列表，applyId申请id
    function choosePerson(idList,applyId){
        var count = 1;
        if($("#isExitUser").val()!=1){
            //没有加入过开发人员信息，重新载入
            count = 0;
        }
        $("#applyId").val(applyId);
        $.ajax({
            url:'${basePath}/release/choosePerson',
            type:'post',
            dataType:'json',
            data:{"idStr":idList,"count":count},
            success:function(data){
                if(data.success){
                    if(count==0){
                        //载入开发人员列表
                        var userList = data.dataList;
                        writeUsers(userList);
                    }
					var selectedUsers = data.bean;
                    if(selectedUsers!=null){
                        //回显已选中开发人员
                        //writeSelectedUser(selectedUsers);
                        //遍历回显被选中的样式
                        showSelected(selectedUsers);
                    }
					//显示div
                    $("#appointDeveloperModal").modal('show') ;

                } else {
                    msgPromptModalShow(data.msg);
                }
            },
            error:function(){
                msgPromptModalShow("服务器没有响应，请稍后再试！");
            }
        });
    }

    //将所有开发人员信息写入隐藏DIV
    function writeUsers(userList){
        var tbody = "";
        $.each(userList,function(n,value) {
            var li = " <li value=\""+value.id+"\" id=\"user_"+value.id+"\" onclick=\" changeState(this)\" style=\"\">"+value.firstname+"<i class=\"fa fa-check hide\">1</i></li>";
            tbody += li;
        });
        $("#developerListHtml").append(tbody);

        //同时写入载入标识，根据此标识判断是否载入过开发人员信息
        var isExitUser = "<input type=\"hidden\" id=\"isExitUser\" name=\"isExitUser\" value=\"1\">";
        $("#hiddenCount").append(isExitUser);
    }

    //回显已选中用户 暂时不用，可以通过showSelected()模拟点击实现
    function writeSelectedUser(selectedUsers){
        var tbody = "";
        $.each(selectedUsers,function(n,e) {

            var selectUser = "<button type=\"button\" id='select_"+e.id+"' value='"+e.id+"' class=\"btn btn-default\" onclick=\"removeButton(this)\">"+e.firstname+" </button>";
            tbody += selectUser;
        });
        $("#selectedDevelopers").append(tbody);

    }

    //点击开发者标签
    function changeState(developerDomLi) {
        var selectedObj = $(developerDomLi);
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

        if(selectedObj.children().text()==2){
            //添加按钮
            var selectUser = "<button type=\"button\" id='select_"+selectedObj.val()+"' value='"+selectedObj.val()+"' class=\"btn btn-default\" onclick=\"removeButton(this)\">"+selectedObj.prop ('firstChild').nodeValue+"</button>";
            $("#selectedDevelopers").append(selectUser);
        }
        if(selectedObj.children().text()==1){
            var butId = "select_"+selectedObj.val();
            $("#"+butId+"").remove();
        }
    }

    //回显被选中的样式
    function showSelected(selectedUsers){
        $("#developerListHtml").children().each(function(){
            var idi = $(this).val();
            $.each(selectedUsers,function(n,e) {
                var idj = e.id+"";
                if(idi == idj){
                    $("#user_"+idi+"").click();
                }
            });
        });
    }

    //移除按钮
    function removeButton(button){
        var liId = "user_"+$(button).val();
        $("#"+liId+"").click();
        $(button).remove();
    }


    //搜索
    function searchLi(){
        var userName = $("#searchDeveloperName").val();
        if(userName==""){
            changeLiType(1);
            return ;
		}
        var lilist = $("#developerListHtml").children("li");
        $.each(lilist,function(n,e) {
            var obj = $(e);
            var id = "user_"+obj.val();
            var name = obj.prop ('firstChild').nodeValue;
            //如果名字包含查询的字符，则显示，此处暂时只能显示一个，应将所有符合的结果id放入一个数组，数组内的所有内容回显
			if(name.includes(userName)){
                //隐藏所有li
                changeLiType(0);
                //相同显示
                $("#"+id+"").show();
            }
        });
    }

    //更改所有开发者标签的状态 status 0隐藏，1显示
	function changeLiType(status){
        var lilist = $("#developerListHtml").children("li");
        $.each(lilist,function(n,e) {
            var obj = $(e);
            var id = "user_"+obj.val();
            if(status==0){
                $("#"+id+"").hide();
            }else{
                $("#"+id+"").show();
			}
        });
	}

	/*	取消、关闭开发人员列表，有需要可自己实现
	function closeDiv(){
	   window.location.reload();
	}
	*/

	/*
	 * 提交选择的开发人员列表
	 * 此处的submitPerson()为confirmTeam.jsp页面中的实现，对应修改之后在用到这个的jsp的页面中实现同名方法即可
	 *
	 *
	 function submitPerson(){
        var name = $("#selectedDevelopers").children("button").text();
        if(!name){
            msgShow("您未选择新的成员！");
            return;
        }
        var applyId = $("#applyId").val();
        $.ajax({
            url:'${basePath}/release/addName',
            type:'post',
            dataType:'json',
            data:{"name":name,"applyId":applyId},
            success:function(data){
                msgShow(data.msg);
            },
            error:function(){
                msgShow("服务器没有响应，请稍后再试！");
            }
        });
    }*/















    /**

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
                developerButton.id = allDeveloperLi[i].value;
                developerButton.value = allDeveloperLi[i].value;
                developerButton.onclick = function() {
                    deleteDeveloper(this.value);
                };
                var temp = allDeveloperLi[i].getElementsByTagName("i")[0];
                allDeveloperLi[i].removeChild(allDeveloperLi[i].getElementsByTagName("i")[0])
                developerButton.innerHTML = allDeveloperLi[i].innerHTML+" ";
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


    function addPerson(){
        var name = $("#selectedDevelopers").children("button").text();
        if(!name){
            msgShow("您未选择新的成员！");
            return;
        }
        var applyId = $("#applyId").val();
        $.ajax({
            url:'${basePath}/release/addName',
            type:'post',
            dataType:'json',
            data:{"name":name,"applyId":applyId},
            success:function(data){
                msgShow(data.msg);
            },
            error:function(){
                msgShow("服务器没有响应，请稍后再试！");
            }
        });
    }


    //提交交付
    function submitPerson(applyId){
        $.ajax({
            url:'${basePath}/release/submitPerson',
            type:'post',
            dataType:'json',
            data:{"name":name,"applyId":applyId},
            success:function(data){
                msgShow(data.msg);
            },
            error:function(){
                msgShow("服务器没有响应，请稍后再试！");
            }
        });
    }
    */
</script>
