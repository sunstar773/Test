
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分类管理</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">分类管理
            <button type="button" class="btn btn-success" onclick="addClass()"><i class="glyphicon glyphicon-plus" ></i>新增</button>
            <button type="button" class="btn btn-danger" onclick="delt()"><i class="glyphicon glyphicon-trash" ></i>删除</button>
            <button type="button" class="btn btn-info" onclick="toUpdatee()"><i class="glyphicon glyphicon-pencil" ></i>修改</button>
        </div>
        <ul id="classTree" class="ztree"></ul>

    </div>
</div>

<%--新增页面--%>
<div  id="classAdd" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">分类名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_name" placeholder="请输入类名">
            </div>
        </div>
    </form>
</div>
<%--修改页面--%>
<div  id="classUpdate" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">分类名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_name" placeholder="请输入类名">
            </div>
        </div>
    </form>
</div>
<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    $(function () {
        initTree();
        addjsp=$("#classAdd").html()
        updatejsp=$("#classUpdate").html()
    })
    /*新增*/
    var addbootbox;
    function addClass() {
        var menuTree=$.fn.zTree.getZTreeObj("classTree");
        var nodes = menuTree.getSelectedNodes();
        if (nodes.length==1){
            addbootbox= bootbox.dialog({
                title:"新增类别",
                message:$("#classAdd form"),
                closeButton:false,
                buttons:{
                    shi:{
                        label:"保存",
                        className:"btn-warning",
                        callback:function () {
                            var name= $("#add_name",addbootbox).val();
                            $.ajax({
                                url:"/addClass",
                                type:"post",
                                data:{"pId":nodes[0].id,"name":name},
                                success:function (result) {
                                    if (result.code==200){
                                        var menuTree=$.fn.zTree.getZTreeObj("classTree");
                                        menuTree.addNodes(nodes[0], {"id":result.data,"pId":nodes[0].id,"name":name});
                                    } else{
                                        bootbox.alert({
                                            message: "<span class='glyphicon glyphicon-info-sign'>添加失败！",
                                            size: 'small'
                                        });
                                    }

                                },
                            })
                        }
                    },
                    da:{
                        label:"取消",
                        callback:function () {
                        }
                    },
                },

            })
            $("#classAdd").html(addjsp);
        } else if (nodes.length>1){
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>只能选择一个节点！",
                size: 'small'
            });
        }else {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>至少选择一个节点！",
                size: 'small'
            });
        }

    }

    /*删除*/
    function delt() {
        var menuTree=$.fn.zTree.getZTreeObj("classTree");
        var nodes = menuTree.getSelectedNodes();
        if (nodes.length>0){
            var nodes1 = menuTree.transformToArray(nodes);
            console.log(nodes1)
            var ids=[];
            for (var a=0;a<nodes1.length;a++){
                ids.push(nodes1[a].id)
            }
            bootbox.confirm({
                title: '提示信息',
                message: "你确定要删除吗？",
                closeButton:false,
                buttons: {
                    confirm: {
                        label: '确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '取消',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if (result){
                        $.post({
                            "url":"/deleteClass",
                            data:{"ids":ids},
                            success:function (flag) {
                                if (flag.code==200) {
                                    for (var i=nodes1.length-1; i>=0; i--) {
                                        menuTree.removeNode(nodes1[i]);
                                    }

                                }else {
                                    bootbox.alert("失败")
                                }
                            }
                        })




                    }
                }
            })
        } else {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>至少选择一个节点！",
                size: 'small'
            });
        }
    }
    /*修改*/
    var updateBootbox;
    function toUpdatee() {
        var menuTree=$.fn.zTree.getZTreeObj("classTree");
        var nodes = menuTree.getSelectedNodes();
        if (nodes.length==1){
            $("#update_name").val(nodes[0].name);
            updateBootbox=   bootbox.dialog({
                title:"修改类别",
                message:$("#classUpdate form"),
                closeButton:false,
                buttons:{
                    shi:{
                        label:"修改",
                        className:"btn-warning",
                        callback:function () {
                            var id=nodes[0].id;
                            var name= $("#update_name",updateBootbox).val();
                            var pId=nodes[0].pId;
                            var param={}
                            param.id=id;
                            param.name=name;
                            param.pId=pId;

                            $.ajax({
                                url:"/updateClass",
                                type:"post",
                                data:param,
                                success:function (result) {
                                    if (result.code==200){
                                        nodes[0].name=name;
                                        console.log(nodes[0])
                                        menuTree.updateNode(nodes[0]);
                                    } else {
                                        bootbox.alert("修改失败")
                                    }
                                },
                            })
                        }
                    },
                    da:{
                        label:"取消",
                        callback:function () {
                        }
                    },
                },
            })

            $("#classUpdate").html(updatejsp);
        } else if (nodes.length==0) {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>至少选一个节点！",
                size: 'small'
            });
        }else {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>只能选一个节点！",
                size: 'small'
            });
        }


    }
    /*初始化ztree*/
    var sun;
    function initTree(){
        sun=   $.ajax({
            "url":"/queryClassify",
            "type":"post",
            success:function(result) {
                var setting = {
                    data: {
                        simpleData: {
                            enable: true    /*使用简单数据需要开启*/
                        },
                    },
                    check:{
                        //enable需要设置为true
                        enable:true,
                        /*  //样式设置为checkbox 复选框 也可以设置为单选框 radioButton
                        chkStyle:'checkbox',
                        //Y-勾选节点
                        //N-取消勾选
                        //p 是否关联父节点
                        //s 是否关联子节点*/
                        chkboxType:{
                            'Y':'',
                            'N':'s'
                        }
                    }
                };
                $.fn.zTree.init($("#classTree"), setting, result.data);
                /*获取ztree对象*/
                var menuTree=$.fn.zTree.getZTreeObj("classTree");
                /*默认展开所有节点*/
                menuTree.expandAll(true);
            }
        })

    }
</script>
</body>
</html>
