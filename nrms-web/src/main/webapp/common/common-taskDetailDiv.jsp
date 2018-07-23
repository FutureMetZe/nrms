<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- 查看任务 =================================start -->
  <div class="modal animate-fade" id="taskDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="myModalLabel">任务详情</h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="card-block">
                    <form action="" method="post" enctype="multipart/form-data" class="form-horizontal ">
                        <div class="form-group row">
                            <label class="col-md-3 form-control-label">任务名</label>
                            <div class="col-md-9">
                                <input type="text" id="detailTaskName" class="check-input form-control" readonly="readonly" >
                             
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-md-3 form-control-label">人数需求</label>
                            <div class="col-md-9">
                                <input type="text" id="detailPeopleNum" class="check-input form-control" readonly="readonly">
                            </div>
                        </div>
						
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">借用开始时间</label>
                            <div class="col-md-9">
                                <input type="date" id="detailStartTime" class="check-input form-control" readonly="readonly">
                            </div>
                        </div>
						
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">借用结束时间</label>
                            <div class="col-md-9">
                                <input type="date" id="detailOverTime" class="check-input form-control" readonly="readonly">
                            </div>
                        </div>
						
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">技术需求</label>
                            <div class="col-md-9">
                                <textarea name="abilityRequired" id="detailAbilityRequired" rows="" cols="" style="width: 350px" readonly="readonly">掌握公司常用开发技术</textarea>
                            </div>
                        </div>
						<div class="form-group row">
                            <label class="col-md-3 form-control-label">任务描述</label>
                            <div class="col-md-9">
                               <textarea  name = "taskDesc" id="detailTaskDesc" rows="" cols="" style="width: 350px" readonly="readonly"></textarea>
                            </div>
                        </div> 
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
   </div>
 </div>
  <!-- 查看任务 =================================end -->
  <script type="text/javascript">
  //查看详情
	function taskDetail(taskId) {
		$.ajax({
			type : 'POST',
			dataType: 'Json',
			url : '${basePath}/TaskPublishController/taskDetail',
			data : {
				taskId:taskId
			},
			success : function(data) {
				if(data.success){
					$("#detailTaskName").val(data.bean.taskName) ;
					$("#detailPeopleNum").val(data.bean.peopleNum);
					$("#detailStartTime").val(data.bean.startTime);
					$("#detailOverTime").val(data.bean.overTime);
					$("#detailAbilityRequired").val(data.bean.abilityRequired);
					$("#detailTaskDesc").val(data.bean.taskDesc); 
					$('#taskDetailModal').modal('show') ;
				}else{
					alert(data.msg);
				}
			},
			error : function(data) {
				alert("访问服务器端出错！");
				
			}
		});
	}
  </script>
 