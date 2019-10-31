
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>角色展示</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<div  id="roleAdd" style="display: none">

    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">角色名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_rolename" placeholder="请输入角色">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">权限</label>
            <div class="col-sm-10">
                <ul id="add_menuId" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>
<div  id="roleUpdate" style="display: none" >

    <form class="form-horizontal">
        <input type="hidden" id="update_id">
        <div class="form-group">
            <label  class="col-sm-2 control-label">角色名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_rolename" placeholder="请输入角色">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">权限</label>
            <div class="col-sm-10">
                <ul id="update_menuId" class="ztree"></ul>
            </div>
        </div>
    </form>
</div>
<%--操作的按钮--%>
<div class="container" >
    <div style="background-color: #ebcccc;width: 100%;height: 35px">
        <button type="button" class="btn btn-info" onclick="addRole()"><i class="glyphicon glyphicon-plus" ></i>新增</button>
        <button type="button" class="btn btn-danger" ><i class="glyphicon glyphicon-trash"></i>批量删除</button>
    </div>
</div>
<%--列表展示--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">角色列表</div>
        <table class="table table-striped table-bordered" id="example" style="width:100%">
            <thead>
            <tr>
                <th>ID</th>
                <th>角色</th>
                <th>权限</th>
                <th>操作</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>ID</th>
                <th>角色</th>
                <th>权限</th>
                <th>操作</th>
            </tr>
            </tfoot>
        </table>
    </div>

</div>

<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    $(function () {
        innitTable();
        addjsp=$("#roleAdd").html();
        updatejsp=$("#roleUpdate").html();
        initTree("add_menuId",addbootbox);
        initTree("update_menuId",updateBootbox);
    })

    /*初始化ztree*/
    function initTree(tree,param){
         $.ajax({
            "url":"/queryMenuList",
            "type":"post",
            success:function(result) {
                var setting = {
                    data: {
                        simpleData: {
                            enable: true    /*使用简单数据需要开启*/
                        }

                    },
                    check:{
                      //enable需要设置为true
                        enable:true,
                        chkboxType:{
                            'Y':'s',
                            'N':'s'
                        }
                      /*  //样式设置为checkbox 复选框 也可以设置为单选框 radioButton
                        chkStyle:'checkbox',
                        //Y-勾选节点
                        //N-取消勾选
                        //p 是否关联父节点
                        //s 是否关联子节点
                       */
                    }
                };
                if (param==addbootbox) {
                    $.fn.zTree.init($("#"+tree,param), setting, result.data);
                }else {
                    $.fn.zTree.init($("#"+tree), setting, result.data);
                }

               /!*获取ztree对象*!/
                var menuTree=$.fn.zTree.getZTreeObj(tree);
                /!*默认展开所有节点*!/
                menuTree.expandAll(true);
            }
        })

    }
    var roleTable;
    function innitTable(){

      roleTable=  $('#example').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching": false,
            "lengthMenu":[5,10,20],
            "ajax": {
                "url": "/queryRoleList",
                "type": "POST",
                dataSrc:function (result) {
                    console.log(result)
                    result.draw=result.data.draw;
                    result.recordsTotal=result.data.recordsTotal;
                    result.recordsFiltered=result.data.recordsFiltered;
                    return result.data.data
                }
            },
            "columns": [
                { "data": "id"},
                { "data": "name" },
                { "data": "ids" },
                { "data": "id",render:function (data,type,row,meta) {
                        return "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\" onclick=\"delt('"+data+"')\"><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick=\"toUpdatee('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                            "</div>"
                    } }
            ],
            "language":{
                "url":"/commons/bootstrap3.3.7/Chinese.json"
            }
        } );
    }
    var addbootbox;
    function addRole() {
          addbootbox= bootbox.dialog({
              title:"新增角色表",
              message:$("#roleAdd form"),
              closeButton:false,
              buttons:{
                  shi:{
                      label:"保存",
                      className:"btn-warning",
                      callback:function () {
                          var str="";
                          var menuTree=$.fn.zTree.getZTreeObj("add_menuId");
                           var nodes=menuTree.getCheckedNodes(true);
                           console.log(nodes)
                           for (var a=0;a<nodes.length;a++){
                               str+=nodes[a].id+",";
                           }

                           var ids=str.substring(0,str.length-1)
                          var param={};
                          var rolename=$("#add_rolename",addbootbox).val();
                          param.name=rolename;
                          param.ids=ids;
                          $.ajax({
                              url:"/addRole",
                              type:"post",
                              data:param,
                              async:false,
                              success:function (result) {
                                  if (result.code==200) {
                                      roleTable.ajax.reload();
                                  }else {
                                      bootbox.alert(result.error)

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
        $("#roleAdd").html(addjsp);
        initTree("add_menuId",addbootbox);
    }

    function delt(id) {
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
                        "url":"/deleteRole?id="+id,
                        success:function (flag) {
                            if (flag.code==200) {
                                roleTable.ajax.reload();
                            }else {
                                bootbox.alert(flag.error)
                            }
                        }
                    })
                }
            }
        })
    }


    var updateBootbox;
    function toUpdatee(id) {
        $.ajax({
            url:"/getRole?id="+id,
            type:"post",
            success:function (sun) {
                if (sun.code==200){
                    var role=sun.data;
                    var menuids=sun.data.list;
                $("#update_rolename").val(role.name);
                $("#update_id").val(role.id);

                    var menuTree1=$.fn.zTree.getZTreeObj("update_menuId");
                    for (var a=0;a<menuids.length;a++){
                       var nodee= menuTree1.getNodesByParam("id", menuids[a],null);
                        menuTree1.checkNode(nodee[0], true);
                    }
                    updateBootbox=   bootbox.dialog({
                        title:"修改商品表",
                        message:$("#roleUpdate form"),
                        closeButton:false,
                        buttons:{
                            shi:{
                                label:"修改",
                                className:"btn-warning",
                                callback:function () {
                                   var name= $("#update_rolename",updateBootbox).val();
                                   var id= $("#update_id",updateBootbox).val();
                                    var str="";
                                    var menuTree=$.fn.zTree.getZTreeObj("update_menuId");
                                    var nodes=menuTree.getCheckedNodes(true);
                                    console.log(nodes)
                                    for (var a=0;a<nodes.length;a++){
                                        str+=nodes[a].id+",";
                                    }
                                    var ids=str.substring(0,str.length-1)
                                    $.ajax({
                                        url:"/updateRole",
                                        type:"post",
                                        data:{"name":name,"id":id,"ids":ids},
                                        success:function (result) {
                                            if (result.code==200){
                                                roleTable.ajax.reload();
                                                $("#roleUpdate").html(updatejsp);
                                                initTree("update_menuId",updateBootbox);

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
                                    $("#roleUpdate").html(updatejsp);
                                    initTree("update_menuId",updateBootbox);
                                }
                            },
                        },
                    })

                }
            }
        })
    }
</script>
</body>
</html>
