<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/8/25
  Time: 18:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>菜单展示</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
    <jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
    <div class="container">
    <div class="panel panel-success">
    <div class="panel-heading">菜单管理
    <button type="button" class="btn btn-success" onclick="addMenu()"><i class="glyphicon glyphicon-plus" ></i>新增</button>
    <button type="button" class="btn btn-danger" onclick="delt()"><i class="glyphicon glyphicon-trash" ></i>删除</button>
    <button type="button" class="btn btn-info" onclick="toUpdatee()"><i class="glyphicon glyphicon-pencil" ></i>修改</button>
    </div>
        <ul id="menuTree" class="ztree"></ul>

    </div>
    </div>
 <%--新增页面--%>
    <div  id="menuAdd" style="display: none">
       <form class="form-horizontal">
           <div class="form-group">
                <label  class="col-sm-2 control-label">菜单名</label>
             <div class="col-sm-10">
                <input type="text" class="form-control" id="add_menuName" placeholder="请输入菜单名">
             </div>
          </div>
       <div class="form-group">
             <label  class="col-sm-2 control-label">菜单类型</label>
            <div class="col-sm-10">
    <input type="radio" name="type" value="1" >菜单
    <input type="radio"  name="type" value="2" >按钮
           </div>
    </div>
        <div class="form-group">
         <label  class="col-sm-2 control-label">菜单路径</label>
           <div class="col-sm-10">
    <input type="text" class="form-control" id="add_url" placeholder="请输入菜单路径">
           </div>
        </div>
      </form>
    </div>
<%--修改页面--%>
     <div  id="menuUpdate" style="display: none">
        <form class="form-horizontal">
        <div class="form-group">
        <label  class="col-sm-2 control-label">菜单名</label>
        <div class="col-sm-10">
        <input type="text" class="form-control" id="update_menuName" placeholder="请输入菜单名">
        </div>
        </div>
    <div class="form-group">
    <label  class="col-sm-2 control-label">菜单类型</label>
    <div class="col-sm-10">
    <input type="radio" name="type" value="1" >菜单
    <input type="radio"  name="type" value="2" >按钮
    </div>
    </div>
    <div class="form-group">
    <label  class="col-sm-2 control-label">菜单路径</label>
    <div class="col-sm-10">
    <input type="text" class="form-control" id="update_url" placeholder="请输入菜单路径">
    </div>
    </div>
        </form>
        </div>
    <jsp:include page="/commons/jsp/script.jsp"></jsp:include>

 <script>

   $(function() {
    initTree();
    addjsp=$("#menuAdd").html()
    updatejsp=$("#menuUpdate").html()
    })
    /*增加菜单*/
    var addbootbox;
      function addMenu() {
        var menuTree=$.fn.zTree.getZTreeObj("menuTree");
        var nodes = menuTree.getSelectedNodes();
        if (nodes.length==1){
        addbootbox= bootbox.dialog({
        title:"新增菜单",
        message:$("#menuAdd form"),
        closeButton:false,
        buttons:{
        shi:{
        label:"保存",
        className:"btn-warning",
        callback:function () {
           var name= $("#add_menuName",addbootbox).val();
           var type=$("[name='type']:checked",addbootbox).val();
           var url= $("#add_url",addbootbox).val();
        $.ajax({
        url:"/addMenu",
        type:"post",
        data:{"pId":nodes[0].id,"name":name,"type":type,"menuurl":url},
        success:function (result) {
            if (result.code==200){
        var menuTree=$.fn.zTree.getZTreeObj("menuTree");
        menuTree.addNodes(nodes[0], {"id":result.data,"pId":nodes[0].id,"name":name,"type":type,"menuurl":url});
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
        $("#menuAdd").html(addjsp);
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
    /*删除菜单*/
        function delt() {
        var menuTree=$.fn.zTree.getZTreeObj("menuTree");
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
            "url":"/deleteMenu",
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
     /*修改菜单*/
        var updateBootbox;
        function toUpdatee() {
        var menuTree=$.fn.zTree.getZTreeObj("menuTree");
        var nodes = menuTree.getSelectedNodes();

         if (nodes.length==1){
             $("#update_menuName").val(nodes[0].name);
             $("#update_url").val(nodes[0].menuurl);
      $('#menuUpdate [name="type"]').each(function () {
    if (this.value==nodes[0].type){
    this.checked=true;
    }
    })
        updateBootbox=   bootbox.dialog({
        title:"修改菜单",
        message:$("#menuUpdate form"),
        closeButton:false,
        buttons:{
        shi:{
        label:"修改",
        className:"btn-warning",
        callback:function () {
               var id=nodes[0].id;
               var name= $("#update_menuName",updateBootbox).val();
               var url= $("#update_url",updateBootbox).val();
                var type=$("[name='type']:checked",updateBootbox).val();
               var pId=nodes[0].pId;
          var param={}
          param.id=id;
          param.name=name;
          param.pId=pId;
          param.menuurl=url;
          param.type=type;

        $.ajax({
        url:"/updateMenu",
        type:"post",
        data:param,
        success:function (result) {
        if (result.code==200){
        nodes[0].name=name;
        nodes[0].type=type;
        nodes[0].menuurl=url;
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
    /*初始化ztree*/
        var sun;
    function initTree(){
      sun=   $.ajax({
        "url":"/queryMenuList",
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
    $.fn.zTree.init($("#menuTree"), setting, result.data);
    /*获取ztree对象*/
    var menuTree=$.fn.zTree.getZTreeObj("menuTree");
    /*默认展开所有节点*/
       menuTree.expandAll(true);
    }
    })

    }
    </script>
</body>
</html>
