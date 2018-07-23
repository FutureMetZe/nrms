/**
 * Created by W on 10/23 0023.
 */

/* ---------- Main Menu Open/Close, Min/Full ---------- */



//选择多项
$(function(){
    var lList = $("#lList");
    var rList = $("#rList");
    var items = $(".add-user-list li");
    for(var i = 0;i<items.length;i++){
        items[i].onclick = itemsclick;
    }
    function itemsclick(){
        var classname = this.className;
        if(classname === "selected"){
            this.className = "";
        }else{
            this.className="selected";
        }
    }
});


// 菜单滑动
$('.navbar-toggler').click(function(){

    if ($(this).hasClass('sidebar-toggler')) {
        $('body').toggleClass('sidebar-hidden');
        resizeBroadcast();
    }

    if ($(this).hasClass('aside-menu-toggler')) {
        $('body').toggleClass('aside-menu-hidden');
        resizeBroadcast();
    }

    if ($(this).hasClass('mobile-sidebar-toggler')) {
        $('body').toggleClass('sidebar-mobile-show');
        resizeBroadcast();
    }

});

$('.sidebar-close').click(function(){
    $('body').toggleClass('sidebar-opened').parent().toggleClass('sidebar-opened');
});



//check btn
;(function($){
    $.extend({
        inputStyle:function(){
            function check(el,cl){
                $(el).each(function(){
                    $(this).parent('i').removeClass(cl);

                    var checked = $(this).prop('checked');
                    if(checked){
                        $(this).parent('i').addClass(cl);
                    }
                })
            }
            $('input[type="radio"]').on('click',function(){
                check('input[type="radio"]','radio_bg_check');
            })
            $('input[type="checkbox"]').on('click',function(){
                check('input[type="checkbox"]','checkbox_bg_check');
            })
        }

    })

})(jQuery)

//调用
$(function(){
    $.inputStyle();
})


//addTag 添加标签
var lablId = -1;


$(function () {

    $("#addBlank").blur(function () {

        if (isNan(this.value) != false) {

            this.value = '用空格分隔多个标签';

            this.style.color = '#999';

        }

    });

});

$(document).ready(function () {

    $("#addBlank").keydown(function (event) {

        if (event.keyCode == 13) {

            var str = $("#addBlank").val();

            if (isNan(str) != true) {

                var li_id = $(".addBlank_list li:last-child").attr('id');

                if (li_id != undefined) {

                    li_id = li_id.split('_');

                    li_id = parseInt(li_id[1]) + 1;

                } else {

                    li_id = 0;

                }

                $(".addBlank_box").css("display", "block");

                var text = "<li id='li_" + li_id + "'><a href='javascript:;' onclick='deletes(" + li_id + ");' >" + str + "<i  class='fa fa-close'></i></a><input type='hidden' name='label[" + li_id + "].name' value='" + str + "'></li>";

                $(".addBlank_list").append(text);

            }

            $("#addBlank").val("");

        }

    })

});

function isNan(obj) {

    try {

        return obj == 0 ? true : !obj

    } catch (e) {

        return true;

    }

}


function deletes(id) {

    $("#li_" + id).remove();

    var li_id = $(".addBlank_list li:last-child").attr('id');

    if (li_id == undefined) {

        $(".addBlank_box").css("display", "none");

    }

}


function addlabl(id) {

    if (lablId == id) {

        return;

    }

    lablId = id;

    var str = $("#add_" + id).text();

    var li_id = $(".addBlank_list li:last-child").attr('id');

    if (li_id != undefined) {

        li_id = li_id.split('_');

        li_id = parseInt(li_id[1]) + 1;

    } else {

        li_id = 0;

    }

    $(".addBlank_box").css("display", "block");

    var text = "<li id='li_" + li_id + "'><a href='javascript:;' onclick='deletes(" + li_id + ");' >" + str + "<img src='images/label_03.png' class='label-pic'></a><input type='hidden' name='label[" + li_id + "].name' value='" + str + "'></li>";

    $(".addBlank_list").append(text);

}


