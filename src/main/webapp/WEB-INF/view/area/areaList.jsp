<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/8/22
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>地区页面</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    $(function () {
        initTree();
       addjsp= $("#areaAdd").html();
       updatejsp= $("#areaUpdate").html();
    })
    /*初始化ztree*/
    function initTree(){
        $.ajax({
            url:"/AreaList",
            type:"post",
            success:function (result) {
                var areaSetting = {
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
                $.fn.zTree.init($("#areaTree"),areaSetting,result.data);
                var areaTree=$.fn.zTree.getZTreeObj("areaTree");
                areaTree.expandAll(true);
            }
        })
    }
    var addbootbox;
    function addArea() {
        var areaTree=$.fn.zTree.getZTreeObj("areaTree");
        var nodes=areaTree.getSelectedNodes();
        if (nodes.length==1){
            addbootbox= bootbox.dialog({
                title:"新增地区",
                message:$("#areaAdd form"),
                closeButton:false,
                buttons:{
                    shi:{
                        label:"保存",
                        className:"btn-warning",
                        callback:function () {
                            var name= $("#add_areaName",addbootbox).val();
                            $.ajax({
                                url:"/addArea",
                                type:"post",
                                data:{"pId":nodes[0].id,"name":name},
                                success:function (result) {
                                    if (result.code==200){
                                        var areaTree=$.fn.zTree.getZTreeObj("areaTree");
                                        areaTree.addNodes(nodes[0], {"id":result.data,"pId":nodes[0].id,"name":name});
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
            $("#areaAdd").html(addjsp);
        } else if (nodes.length>1){
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>只能选择一个节点！",
                size: 'small'
            });
        } else {
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>最少选择一个节点！",
                size: 'small'
            });
        }
    }

    var updateBootbox;
    function toUpdatee() {
        var areaTree=$.fn.zTree.getZTreeObj("areaTree");
        var nodes=areaTree.getSelectedNodes();
        if (nodes.length==1){
            $("#update_areaName").val(nodes[0].name);
            updateBootbox=   bootbox.dialog({
                title:"修改菜单",
                message:$("#areaUpdate form"),
                closeButton:false,
                buttons:{
                    shi:{
                        label:"修改",
                        className:"btn-warning",
                        callback:function () {
                            var id=nodes[0].id;
                            var name= $("#update_areaName",updateBootbox).val();
                            var pId=nodes[0].pId;
                            var param={}
                            param.id=id;
                            param.name=name;
                            param.pId=pId;

                            $.ajax({
                                url:"/updateArea",
                                type:"post",
                                data:param,
                                success:function (result) {
                                    if (result.code==200){
                                        nodes[0].name=name;
                                        console.log(nodes[0])
                                        areaTree.updateNode(nodes[0]);
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

            $("#menuUpdate").html(updatejsp);
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
</script>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">地区管理
            <button type="button" class="btn btn-success" onclick="addArea()"><i class="glyphicon glyphicon-plus" ></i>新增</button>
            <button type="button" class="btn btn-danger" onclick="delt()"><i class="glyphicon glyphicon-trash" ></i>删除</button>
            <button type="button" class="btn btn-info" onclick="toUpdatee()"><i class="glyphicon glyphicon-pencil" ></i>修改</button>
        </div>
        <ul class="ztree" id="areaTree"></ul>

    </div>
</div>
<%--新增页面--%>
<div  id="areaAdd" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">地区名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_areaName" placeholder="请输入地区名">
            </div>
        </div>
    </form>
</div>
<%--修改页面--%>
<div  id="areaUpdate" style="display: none">
    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">地区名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_areaName" placeholder="请输入地区名">
            </div>
        </div>
    </form>
</div>
</body>
</html>
