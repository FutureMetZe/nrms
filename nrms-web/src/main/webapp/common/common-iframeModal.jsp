<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- /.modal-content -->
<!-- chengq：包含iframe的modal
	 使用场景：页面需要modal显示内容，内容因不同参数而异
 -->
<div class="modal animate-fade" id="iframeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title" id="iframeModal-title">添加评价</h6>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="card-block">
                	<!-- frameborder -- 边框
                		 scrolling -- 滚动条
                		 allowtransparency -- 允许透明
                		 onload = ... 将iframe的高度设置为包含html文档的总高度，避免同时显示modal和iframe双滚动条
            		 -->
                    <iframe 
	                    id="iframeModal-frame" 
	                    name="iframeModal-frame" 
	                    width="100%" 
	                    frameborder="no" 
	                    scrolling="auto" 
	                    allowtransparency="true" 
	                    onload="this.height=this.contentWindow.document.documentElement.scrollHeight">
                    		你的浏览器版本过低，不支持iframe
                	</iframe>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="iframeModal-btn-submit" type="button" class="btn btn-primary">确认</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<script>
//title 选填 modal的标题
//src 选填 iframe的链接  get   参数title和src应该同时传入
//func 选填 函数名字符串，包含圆括号（误：不包含圆括号），js语句也可以作为参数。 确认按钮的显示以及onclick处理函数，不填则隐藏确认按钮
function showIframeModal(title, src, func){
	//不传入参数时，显示上次内容
	if(arguments.length === 0){
		$('#iframeModal').modal('show');
		return;
	}
	$('#iframeModal-title').text(title);
	//如果src和当前src相同，内容不用重新加载。如果有需要，自行在src后添加随机请求参数
	if($('#iframeModal-frame').attr('src') !== src){
		$('#iframeModal-frame').attr('src',src);
	}
	if(arguments.length === 3){
		$('#iframeModal-btn-submit').show();
		$('#iframeModal-btn-submit').removeAttr('onclick');
		$('#iframeModal-btn-submit').attr('onclick',func);
	}else{
		$('#iframeModal-btn-submit').hide();
	}
	$('#iframeModal').modal('show');
}

function hideIframeModal(){
	$('#iframeModal').modal('hide');
}
</script>