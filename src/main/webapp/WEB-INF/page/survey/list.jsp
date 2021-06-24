<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>问卷列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../static/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="../static/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>查询条件</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">标题</label>
                            <div class="layui-input-inline">
                                <input type="text" name="title" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">状态</label>
                            <div class="layui-input-inline">
                                <select name="state" lay-filter="state">
                                    <option value="">请选择状态</option>
                                    <option value="创建">创建</option>
                                    <option value="执行中">执行中</option>
                                    <option value="结束">结束</option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-sm data-add-btn" lay-event="edit"> 修改 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
                <button class="layui-btn layui-btn-sm layui-btn-sm data-delete-btn" lay-event="editque"> 设计问卷 </button>
                <button class="layui-btn layui-btn-sm layui-btn-sm data-delete-btn" lay-event="preview"> 预览问卷 </button>
                <button class="layui-btn layui-btn-sm layui-btn-sm data-delete-btn" lay-event="publish"> 发布问卷 </button>
                <button class="layui-btn layui-btn-sm layui-btn-sm data-delete-btn" lay-event="query_detail"> 问卷详情 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="../static/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: 'query',
            toolbar: '#toolbarDemo',
            contentType: 'application/json',
            method:"post",
            defaultToolbar: ['filter', 'exports', 'print'],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 80, title: 'ID', sort: true},
                {field: 'title', title: '问卷标题'},
                {field: 'url',width:500, title: '问卷URL'},
                {field: 'startTime', width: 200, title: '开始时间'},
                {field: 'endTime', width: 200, title: '结束时间'},
                {field: 'state', width: 130, title: '状态'},
                {field: 'name', width: 100, title: '创建人',templet:'<div>{{d.admin.name}}</div>'},
                {field: 'createTime',width: 200,title: '创建时间'}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line'
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                },
                contentType: 'application/json'
                , where: {
                    "title": data.field.title || null,
                    "state": data.field.state || null,
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加问卷',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'create',
                    end: function () {
                        table.reload('currentTableId');
                    }
                });
                $(window).on("resize", function () {
                    //layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                var arr=[];
                for (index in data){
                    arr.push(data[index].id);
                }
                if (arr.length < 1) {
                    layer.msg("请选择一行数据");
                    return;
                }
                $.ajax({
                    url:"delete",
                    type:"POST",
                    data:JSON.stringify(arr),
                    success:function (data) {
                        if (data.code == 0) {
                            layer.msg(data.msg, {time: 500},
                                function() {
                                    table.reload('currentTableId');
                                });
                        } else {
                            layer.msg(data.msg);
                        }
                    }
                });
            } else if (obj.event === 'edit') {  // 监听添加操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                var arr=[];
                for (index in data){
                    arr.push(data[index].id);
                }
                if (arr.length != 1) {
                    layer.msg("请选择一行数据");
                    return;
                }
                var index = layer.open({
                    title: '修改问卷',
                    type: 2,
                    shade: 0.2,
                    maxmin: true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'detail?id=' + arr[0],
                    end: function () {
                        table.reload('currentTableId');
                    }
                });
                $(window).on("resize", function () {
                    //layer.full(index);
                });
            } else if (obj.event === 'editque') {  // 监听添加操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                var arr=[];
                for (index in data){
                    arr.push(data[index].id);
                }
                if (arr.length != 1) {
                    layer.msg("请选择一行数据");
                    return;
                }
                var index = layer.open({
                    title: '设计问卷',
                    type: 2,
                    shade: 0.2,
                    maxmin: true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: 'question?id=' + arr[0],
                    end: function () {
                        table.reload('currentTableId');
                    }
                });
                $(window).on("resize", function () {
                    //layer.full(index);
                });
            } else if (obj.event === 'preview') {  // 监听添加操作
                console.log("搁这1");
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                var arr=[];
                for (index in data){
                    arr.push(data[index].id);
                }
                if (arr.length != 1) {
                    layer.msg("请选择一行数据");
                    return;
                }
                window.open("preview/" + arr[0]);
            } else if (obj.event === 'publish') {  // 监听添加操作
                console.log("搁这1");
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                var arr=[];
                for (index in data){
                    arr.push(data[index].id);
                }
                if (arr.length != 1) {
                    layer.msg("请选择一行数据");
                    return;
                }
                $.ajax({
                    url:"publish",
                    type:"POST",
                    dataType:'json',
                    data:'ids='+arr[0],
                    success:function (data) {
                        layer.msg(data.msg);
                        table.reload('currentTableId');
                    }
                })
            } else if (obj.event === 'query_detail') {
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                var arr=[];
                for(index in data){
                    arr.push(data[index].id);
                }
                if(arr.length !=1){
                    layer.msg("请选择一行数据查看",{time:1000});
                    return;
                }
                if(data[0].url == ""){
                    layer.msg("请先发布再查看详情",{time:1000});
                    return;
                }
                window.open("query_detail/"+arr[0]);
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑问卷',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '../static/page/table/edit.html',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除行么', function (index) {
                    obj.del();
                    layer.close(index);
                });
            }
        });

    });
</script>

</body>
</html>