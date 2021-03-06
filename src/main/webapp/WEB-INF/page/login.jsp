<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理-登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="http://localhost:8080/survey/static/lib/layui-v2.6.3/css/layui.css" media="all">
    <!--[if lt IE 9]>
    <script src="http://localhost:8080/survey/static/js/html5.min.js"></script>
    <script src="http://localhost:8080/survey/static/js/respond.min.js"></script>
    <![endif]-->
    <style>
        html, body {width: 100%;height: 100%;overflow: hidden}
        body {background: #1E9FFF;background: url("http://localhost:8080/survey/static/images/1.jpg");background-repeat: no-repeat;background-size: 100% 100%;background-size: cover;}
        body:after {content:'';background-repeat:no-repeat;background-size:cover;-webkit-filter:blur(3px);-moz-filter:blur(3px);-o-filter:blur(3px);-ms-filter:blur(3px);filter:blur(3px);position:absolute;top:0;left:0;right:0;bottom:0;z-index:-1;}
        .layui-container {width: 100%;height: 100%;overflow: hidden}
        .admin-login-background {width:360px;height:300px;position:absolute;left:50%;top:40%;margin-left:-180px;margin-top:-100px;}
        .logo-title {text-align:center;letter-spacing:2px;padding:14px 0;}
        .logo-title h1 {color:#1E9FFF;font-size:25px;font-weight:bold;}
        .login-form {background-color:#fff;border:1px solid #fff;border-radius:3px;padding:14px 20px;box-shadow:0 0 8px #eeeeee;}
        .login-form .layui-form-item {position:relative;}
        .login-form .layui-form-item label {position:absolute;left:1px;top:1px;width:38px;line-height:36px;text-align:center;color:#d2d2d2;}
        .login-form .layui-form-item input {padding-left:36px;}
        .captcha {width:60%;display:inline-block;}
        .captcha-img {display:inline-block;width:34%;float:right;}
        .captcha-img img {height:34px;border:1px solid #e6e6e6;height:36px;width:100%;}
    </style>
</head>
<body>
<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form" action="">
                <div class="layui-form-item logo-title">
                    <h1>调查问卷系统登录</h1>
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username"></label>
                    <input type="text" id="account" name="account" lay-verify="required|account" placeholder="账号" autocomplete="off" class="layui-input" value="">
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-password"></label>
                    <input type="password" id="password" name="password" lay-verify="required|password" placeholder="密码" autocomplete="off" class="layui-input" value="">
                </div>
                <div class="layui-form-item">
                    <input type="checkbox" name="rememberMe" value="true" lay-skin="primary" title="记住密码">
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="login">登 入</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="http://localhost:8080/survey/static/lib/jquery-3.4.1/jquery-3.4.1.min.js" charset="utf-8"></script>
<script src="http://localhost:8080/survey/static/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'jquery'], function () {
        var form = layui.form,
            layer = layui.layer;
            $ = layui.jquery;
        // 登录过期的时候，跳出ifram框架
        if (top.location != self.location) top.location = self.location;

        $(function(){
            //cookie数据保存格式是key=value;key=value;形式，loginInfo为保存在cookie中的key值，具体看controller代码
            console.log("1");
            var str = getCookie("user");
            str = str.substring(1,str.length-1);
            var username = str.split(",")[0];
            var password = str.split(",")[1];
            console.log(username + "+" + password);
            //自动填充用户名和密码
            $("#account").val(username);
            $("#password").val(password);
        });

        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for(var i=0; i<ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0)==' ') c = c.substring(1);
                if (c.indexOf(name) != -1) {
                    console.log(c.substring(name.length, c.length));
                    return c.substring(name.length, c.length);

                }
            }
            return "";
        }

        // 进行登录操作
        form.on('submit(login)', function (data) {
            data = data.field;
            alert(JSON.stringify(data));
            if (data.username == '') {
                layer.msg('用户名不能为空');
                return false;
            }
            if (data.password == '') {
                layer.msg('密码不能为空');
                return false;
            }
            if (data.captcha == '') {
                layer.msg('验证码不能为空');
                return false;
            }
            $.ajax({
                url:'login',
                type:'POST',
                data:JSON.stringify(data),
                contentType:'application/json',
                dataType:'json',
                success:function (data) {
                    if (data.code == 0) {
                        location.href = "index";
                    } else {
                        layer.msg(data.msg);
                    }
                }
            })
            return false;
        });
    });
</script>
</body>
</html>