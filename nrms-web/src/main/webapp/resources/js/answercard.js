var HH = 0;//时
var mm = 0;//分
var ss = 0;//秒
var timeState = true;//时间状态 默认为true 开启时间
var questions= QuestionJosn;
var itemList=["A","B","C","D","E","F"]
var activeQuestion=0; //当前操作的考题编号
var questioned = 0; //
var checkQues = []; //已做答的题的集合
/*实现倒计时*/
var interval = 1000;
function ShowCountDown(year,month,day,divname)
{
    var now = new Date();
    var endDate = new Date(year, month-1, day);
    var leftTime=endDate.getTime()-now.getTime();
    var leftsecond = parseInt(leftTime/1000);
//var day1=parseInt(leftsecond/(24*60*60*6));
    var day1=Math.floor(leftsecond/(60*60*24));
    var hour=Math.floor((leftsecond-day1*24*60*60)/3600);
    var minute=Math.floor((leftsecond-day1*24*60*60-hour*3600)/60);
    var second=Math.floor(leftsecond-day1*24*60*60-hour*3600-minute*60);
    var cc = document.getElementById(divname);
    cc.innerHTML = "剩余时间 ："+hour+":"+minute+":"+second;
}
//截止时间
window.setInterval(function(){ShowCountDown(2010,4,20,'examTime');}, interval);

//展示考卷信息
function showQuestion(id){
    $(".questioned").text(id+1);
    questioned = (id+1)/questions.length
    if(activeQuestion!=undefined){
        $("#ques"+activeQuestion).removeClass("question_id").addClass("active_question_id");
    }
    activeQuestion = id;
    $(".question").find(".question_info").remove();
    var question = questions[id];
    $(".exam-ans-title").html("<strong>第 "+(id+1)+" 题 .</strong>"+question.questionTitle);
    var items = question.questionItems.split(";");
    var item="";
    for(var i=0;i<items.length;i++){
        item ="<li class='question_info' onclick='clickTrim(this)' id='item"
            +i+"'><input type='radio' name='item' value='"+itemList[i]+"'>&nbsp;"+itemList[i]+"."+items[i]+"</li>";
        $(".question").append(item);
    }
    $(".question").attr("id","question"+id);
    $("#ques"+id).removeClass("active_question_id").addClass("question_id");
    for(var i=0;i<checkQues.length;i++){
        if(checkQues[i].id==id){
            $("#"+checkQues[i].item).find("input").prop("checked","checked");
            $("#"+checkQues[i].item).addClass("clickTrim");
            $("#ques"+activeQuestion).removeClass("question_id").addClass("clickQue");
        }
    }
    progress();
}

/*答题卡*/
function answerCard(){
    $(".question_sum").text(questions.length);
    for(var i=0;i<questions.length;i++){
        var questionId ="<li id='ques"+i+"'onclick='saveQuestionState("+i+")' class='questionId'><a>"+(i+1)+"</a></li>";
        $("#answerCard ul").append(questionId);
    }
}

/*选中考题*/
var Question;
function clickTrim(source){
    var id = source.id;
    $("#"+id).find("input").prop("checked","checked");
    $("#"+id).addClass("clickTrim");
    $("#ques"+activeQuestion).removeClass("question_id").addClass("clickQue");
    var ques =0;
    for(var i=0;i<checkQues.length;i++){
        if( checkQues[i].id==activeQuestion&&checkQues[i].item!=id){
            ques = checkQues[i].id;
            checkQues[i].item = id;//获取当前考题的选项ID
            checkQues[i].answer =$("#"+id).find("input[name=item]:checked").val();//获取当前考题的选项值
        }
    }
    if(checkQues.length==0||Question!=activeQuestion&&activeQuestion!=ques){
        var check ={};
        check.id=activeQuestion;//获取当前考题的编号
        check.item = id;//获取当前考题的选项ID
        check.answer =$("#"+id).find("input[name=item]:checked").val();//获取当前考题的选项值
        checkQues.push(check);
    }
    $(".question_info").each(function(){
        var otherId =$(this).attr("id");
        if(otherId!=id){
            $("#"+otherId).find("input").prop("checked",false);
            $("#"+otherId).removeClass("clickTrim");
        }
    })
    Question = activeQuestion;
}

/*设置进度条*/
function progress(){
    var prog = ($(".active_question_id").length+1)/questions.length;
    var pro = $(".progress").parent().width() * prog;
    $(".progres").text((prog*100).toString().substr(0,5)+"%")
    $(".progress").animate({
        width: pro,
        opacity: 0.5
    }, 1000);
}

/*保存考题状态 已做答的状态*/
function saveQuestionState(clickId){
    showQuestion(clickId)
}

$(function(){
    $(".middle-top-left").width($(".middle-top").width()-$(".middle-top-right").width())
    $(".progress-left").width($(".middle-top-left").width()-200);
    progress();
    answerCard();
    showQuestion(0);
    /*alert(QuestionJosn.length);*/
    /*实现进度条信息加载的动画*/
//    var str = '';

    //提交试卷
    $("#submitQuestions").click(function(){
        /*alert(JSON.stringify(checkQues));*/
        alert("已做答:"+($(".clickQue").length)+"道题,还有"+(questions.length-($(".clickQue").length))+"道题未完成");
    })
    //进入下一题
    $("#nextQuestion").click(function(){
        if((activeQuestion+1)!=questions.length) showQuestion(activeQuestion+1);
        showQuestion(activeQuestion)
    })

    $("#upperQuestion").click(function(){
        if((activeQuestion-1)!=questions.length) showQuestion(activeQuestion-1);
        showQuestion(activeQuestion)
    })
})/**
 * Created by W on 10/26 0026.
 */
