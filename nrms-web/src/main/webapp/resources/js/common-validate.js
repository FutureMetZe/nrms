//验证所输内容是否为空，若输入空字符串也视为空
function validateIsNull(param) {
	var input = /^[\s]*$/;  
	if (input.test(param)) { 
	    return true;  
	 }
	return false;
}

//验证所输内容是否大于最大长度
function validateMaxLength(param, maxLength) {
	if(param.length > maxLength){
		return true;
	}
	return false;
}

//验证所输数字是否为正整数
function validatePositiveNumber(param) {
	var input = /^\+?[1-9][0-9]*$/;
	if(input.test(param)){
		return true;
	}
	return false;
}

//验证所输内容是否在某个长度范围内
function validateLength(param, minLength, maxLength) {
	if(param.length > maxLength || param.length < minLength){
		return false;
	}
	return true;
}

//比较两个时间大小(第一个时间大时返回true)
function compareDate(date1,date2) {
	var oDate1 = new Date(date1);
    var oDate2 = new Date(date2);
    if(oDate1.getTime() >= oDate2.getTime()){
       return true;
    } else {
       return false;
    }
}
