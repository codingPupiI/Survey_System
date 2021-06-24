<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../static/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="../static/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">



        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>用户修改</legend>
        </fieldset>

        <form class="layui-form" action="" layer-filter="example">
            <input type="hidden" value="${admin.id}" name="name" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input">
            <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-block">
                    <br/><p>:${admin.account}</p>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="name" value="${admin.name}" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">手机</label>
                <div class="layui-input-block">
                    <input type="text" name="phone" value="${admin.phone}" lay-verify="required" autocomplete="off" placeholder="请输入手机号码" class="layui-input" value="17805016202">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入备注" value="${admin.remark}" name="remark" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="example">立即提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="../static/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['form','jquery','layer'], function () {
        var form = layui.form
            , layer = layui.layer
            , $ = layui.jquery;
        var index = parent.layer.getFrameIndex(window.name);
        //监听提交
        form.on('submit(example)', function (data) {
            $.ajax({
                url:"update",
                type:"POST",
                contentType:'application/json',
                dataType:'json',
                data:JSON.stringify(data.field),
                success:function (data) {
                    if (data.code == 0) {
                        layer.msg(data.msg, {time: 500},
                            function() {
                                parent.layer.close(index);

                            }
                        );
                    } else {
                        layer.msg(data.msg);
                    }

                }
            })
            return false;
        });
        //表单初始赋值
        form.val('example', {
            "account":"${admin.account}",
            "name":"${admin.name}",
            "phone":"${admin.phone}",
            "remark":"${admin.remark}"
        })
    });
</script>

</body>
</html>