// Empty JS for your own code to be here


//检查用户名和密码是否为空
function checkLogin(){
    var username= document.getElementById("username");
    if(username.value.trim()==""){//没有输入用户名是显示提示
        //获取所有子节点
        var findNodes = document.getElementById("name").children;
        if(findNodes.length==0){//只添加一次span
            var appdom= document.createElement("span");
            appdom.innerHTML="*用户名不能为空";
            appdom.style.color="red";
            document.getElementById("name").appendChild(appdom);
        }
        return false;
    }else{//输入了内容后清除节点内容
        var findNodes =document.getElementById("name").children;
        if(findNodes.length>0){
            document.getElementById("name").removeChild(findNodes[0]);
        }
    }
    var userpwd = document.getElementById("userpwd");
    if(userpwd.value.trim()==""){
        var findNodes2 = document.getElementById("pwd").children;
        if(findNodes2.length==0){
            var appdom2 = document.createElement("span");
            appdom2.innerHTML="*密码不能为空";
            appdom2.style.color="red";
            document.getElementById("pwd").appendChild(appdom2);
        }
        return false;
    }else{
        var findNodes2 = document.getElementById("pwd").children;
        if(findNodes2.length>0){
            document.getElementById("pwd").removeChild(findNodes2[0]);
        }
    }
}

//检查注册
function checkRegister(){

    var username= document.getElementById("username");
    if(username.value.trim()==""){//没有输入用户名是显示提示
        //获取所有子节点
        var findNodes = document.getElementById("name").children;
        if(findNodes.length==0){//只添加一次span
            var appdom= document.createElement("span");
            appdom.innerHTML="*用户名不能为空";
            appdom.style.color="red";
            document.getElementById("name").appendChild(appdom);
        }
        return false;
    }else{//输入了内容后清除节点内容
        var findNodes =document.getElementById("name").children;
        if(findNodes.length>0){
            document.getElementById("name").removeChild(findNodes[0]);
        }
    }
    ////
    var userpwd1 = document.getElementById("userpwd1");
    if(userpwd1.value.trim()==""){
        var findNodes2 = document.getElementById("pwd1").children;
        if(findNodes2.length==0){
            var appdom2 = document.createElement("span");
            appdom2.innerHTML="*密码不能为空";
            appdom2.style.color="red";
            document.getElementById("pwd1").appendChild(appdom2);
        }
        return false;
    }else{
        var findNodes2 = document.getElementById("pwd1").children;
        if(findNodes2.length>0){
            document.getElementById("pwd1").removeChild(findNodes2[0]);
        }
    }
    ////
    var userpwd2 = document.getElementById("userpwd2");
    var appdom3 = document.createElement("span");
    if(userpwd2.value.trim()==""){
        var findNodes2 = document.getElementById("pwd2").children;
        if(findNodes2.length>0){
            document.getElementById("pwd2").removeChild(findNodes2[0]);
        }
        appdom3.innerHTML="*请确认密码";
        appdom3.style.color="red";
        document.getElementById("pwd2").appendChild(appdom3);
        return false;
    }else if(userpwd2.value.trim() != userpwd1.value.trim() && userpwd2.value.trim() != "" && userpwd1.value.trim() != ""){
        var findNodes2 = document.getElementById("pwd2").children;
        if(findNodes2.length>0){
            document.getElementById("pwd2").removeChild(findNodes2[0]);
        }
        appdom3.innerHTML="*密码不一致";
        appdom3.style.color="red";
        document.getElementById("pwd2").appendChild(appdom3);
        return false;
    }
    else{
        var findNodes2 = document.getElementById("pwd2").children;
        if(findNodes2.length>0){
            document.getElementById("pwd2").removeChild(findNodes2[0]);
        }
    }


    ////
    var useremail = document.getElementById("useremail");
    if(useremail.value.trim()==""){
        var findNodes2 = document.getElementById("email").children;
        if(findNodes2.length==0){
            var appdom2 = document.createElement("span");
            appdom2.innerHTML="*邮箱不能为空";
            appdom2.style.color="red";
            document.getElementById("email").appendChild(appdom2);
        }
        return false;
    }else{
        var findNodes2 = document.getElementById("email").children;
        if(findNodes2.length>0){
            document.getElementById("email").removeChild(findNodes2[0]);
        }
    }

}