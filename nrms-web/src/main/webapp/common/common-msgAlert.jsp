<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!--信息提示弹框 -->
<div class="modal animate-fade" id="msgPromptModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="msgPromptModalTitle">操作结果</h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeMsgPromptModal" onclick="msgPromptModalHide()">&times;</button>
            </div>
            <div class="modal-body" id="msgBody" style="height:100px;">
                <div class="card-block"  >
                    <div id="msgPromptModalContent" style="text-align: center;">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="msgPromptModalOkButton" data-dismiss="modal" onclick="msgPromptModalHide()">确认</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!--确认操作弹框 -->
<div class="modal animate-fade" id="msgConfirmModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="msgConfirmModalTitle"></h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="msgConfirmModalHide()">&times;</button>
            </div>
            <div class="modal-body" id="msg2Body" style="height:100px;">
                <div class="card-block"  >
                    <div id="msgConfirmModalContent" style="text-align: center;">
                    </div>
                </div>
            </div>
            <div align="center" id="hidenParamsDiv">
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="msgConfirmModalOkButton" >确认</button>
                &nbsp;&nbsp;
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="msgConfirmModalCancelButton" onclick="msgConfirmModalHide()">取消</button>
                <hr>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!--  确认框  -->
<script>

	function msgPromptModalShow(content,func){
		$("#msgPromptModalContent").text(content);
		$('#msgPromptModal').modal('show');
		//取消默认关闭按钮的绑定事件
		if(arguments.length == 2) {
			$("#msgPromptModalOkButton").removeAttr("onclick");
			$("#closeMsgPromptModal").removeAttr("onclick");
			$("#msgPromptModalOkButton").attr('onclick', func);
			$("#closeMsgPromptModal").attr('onclick', func);
		}
	}
	
    function msgPromptModalHide(){
    	$("#msgPrompt").text("");
    	$('#msgPromptModal').modal('hide');
    }
    
    //前三个参数必传
    function msgConfirmModalShow(title,content,confirmFunc,cancelFunc){
		$("#msgConfirmModalTitle").text(title);
		$("#msgConfirmModalContent").text(content);
		$('#msgConfirmModal').modal('show');
		//取消默认关闭按钮的绑定事件
		if(arguments.length == 3) {
			$("#msgConfirmModalOkButton").removeAttr("onclick");
			$("#msgPromptModalOkButton").attr('onclick', confirmFunc);
		}
		if(arguments.length == 4) {
			$("#msgConfirmModalOkButton").removeAttr("onclick");
			$("#msgConfirmModalCancelButton").removeAttr("onclick");
			$("#msgPromptModalOkButton").attr('onclick', confirmFunc);
			$("#closeMsgPromptModal").attr('onclick', cancelFunc);
		}
	}
    
    function msgConfirmModalHide(){
    	$("#msgPromptModalTitle").text("");
    	$("#msgConfirmModalContent").text("");
    	$('#msgConfirmModal').modal('hide');
    }
</script>
<!--操作信息返回div ==============================end -->


 