<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/8/24
  Time: 22:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>品牌展示</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<%--条件查询--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">品牌查询</div>
        <div class="panel-body">
            <%-- 表单--%>
            <form class="form-horizontal" id="productSearch">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">品牌名</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" name="name" id="tj_name"  placeholder="请输入品牌">
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="button" class="btn btn-info" onclick="search()"><i class="glyphicon glyphicon-search"></i>查询</button>
                    <button type="reset" class="btn btn-default" ><i class="glyphicon glyphicon-repeat"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%--操作的按钮--%>
<div class="container" >
    <div style="background-color: #ebcccc;width: 100%;height: 35px">
        <button type="button" class="btn btn-info" onclick="addBrand()"><i class="glyphicon glyphicon-plus" ></i>新增</button>
        <button type="button" class="btn btn-danger" onclick="delBatch()"><i class="glyphicon glyphicon-trash"></i>批量删除</button>
    </div>
</div>
<div  id="brandAdd" style="display: none">

    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_brandName" placeholder="请输入品牌">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">图片</label>
            <div class="col-sm-10">
                <input type="file" name="headPhoto" id="add_headPhoto" />
                <input type="hidden"  id="add_photourl"/>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-10">
                <select class="form-control" id="add_sel">
                    <option value="-1" class="s">==请选择</option>
                    <option value="1" class="s">是</option>
                    <option value="2" class="s">否</option>
                </select>
            </div>
        </div>
    </form>
</div>
<div  id="brandUpdate" style="display: none">

    <form class="form-horizontal">
        <input type="hidden" id="update_id">
        <div class="form-group">
            <label  class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_brandName" placeholder="请输入品牌">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">图片</label>
            <div class="col-sm-10">
                <input type="file" name="headPhoto" id="update_headPhoto" />
                <input type="hidden"  id="update_photourl"/>
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-10">
                <select class="form-control" id="update_sel">
                    <option value="-1">==请选择</option>
                    <option value="1">是</option>
                    <option value="2">否</option>
                </select>
            </div>
        </div>
        <input type="hidden" id="delOss" name="ossImgUrl">
    </form>
</div>
<%--列表展示--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">商品列表</div>
        <table class="table table-striped table-bordered" id="example" style="width:100%">
            <thead>
            <tr>
                <th>序号</th>
                <th>品牌</th>
                <th>图片</th>
                <th>是否热销</th>
                <th>排序</th>
                <th>操作</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>序号</th>
                <th>品牌</th>
                <th>图片</th>
                <th>是否热销</th>
                <th>排序</th>
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
       addjsp= $("#brandAdd").html();
       updatejsp= $("#brandUpdate").html();
        initUpload("add_headPhoto","add_photourl");
      /*  initEvent();*/
    })
    function search() {
        var name=$("#tj_name").val();
        var p={"name":name};
        brandTable.settings()[0].ajax.data=p;
        brandTable.ajax.reload();
    }

    var ids=[];
  /*  function initEvent() {
           $("#example tbody").on("click","tr",function () {
              var a_checkbox= $(this).find("input[type='checkbox']")[0];
              console.log(a_checkbox)
               if (a_checkbox.checked) {
                   $(this).css("background-color","")
                   a_checkbox.checked=false;
                   deleteArr(a_checkbox.value)
                   console.log(ids)
               }else {
                   $(this).css("background-color","pink")
                   a_checkbox.checked=true;
                   ids.push(a_checkbox.value)
                   console.log(ids)
               }
           })
    }*/
    function deleteArr(id) {
            for (var i = ids.length-1; i >= 0; i--) {
                if (ids[i] == id) {
                          /*起始下标  删除个数*/
                    ids.splice(i, 1);
                }
            }
    }
    function delBatch() {
        if (ids.length>0) {
            bootbox.confirm({
                title: '提示信息',
                message: "你确定要删除吗？",
                closeButton: false,
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
                    if (result) {
                        if (ids.length > 0) {
                            $.post({
                                "url": "/deltBrands",
                                data: {"ids": ids},
                                success: function (flag) {
                                    if (flag.code == 200) {
                                        brandTable.ajax.reload();
                                        ids=[];
                                    } else {
                                        bootbox.alert("失败")
                                    }
                                }
                            })
                        }

                    }
                }
            })
        }else{
            bootbox.alert({
                message: "<span class='glyphicon glyphicon-info-sign'>至少选一条数据！",
                size: 'small'
            });
        }

    }
    function initUpload(param,photoid) {

        /*修改回显*/
        if (photoid=="update_photourl"){
            var url=$("#"+photoid).val();
           $("#delOss").val(url);
            var urlArr=[];
            urlArr.push(url);
            console.log(urlArr)
        }
        $("#"+param).fileinput({
            dropZoneEnabled : false,
            language : 'zh',//汉化
            showCaption : false,
            browseLabel: '选择头像',
            layoutTemplates:{       //缩略图里的按钮配置
                actionDelete:"",
                actionUpload:"",
            },
            /*初始化预览图片的配置*/
            initialPreview:urlArr,
            initialPreviewAsData:true,
            uploadUrl:"/textOss"//上传的地址
        }).on("fileuploaded",function (event, data, previewId, index) {
            if (param=="update_headPhoto") {
                $("#"+photoid,updateBootbox).val(data.response.data);
            }
            else {
                $("#"+photoid,addbootbox).val(data.response.data);
            }
          /*  if(data.response.ok){
                if (param=="update_headPhoto") {
                    $("#"+photoid,updateBootbox).val(data.response.url);
                }
                else {
                    $("#"+photoid,addbootbox).val(data.response.url);
                }
            }*/
        });
    }
    /*修改品牌*/
    var updateBootbox;
    function toUpdatee(id) {
        event.stopPropagation();
        $.ajax({
            url:"/goUpdateBrand?id="+id,
            type:"post",
            success:function (sun) {
                if (sun.code==200){
                    var brand=sun.data;
                    var ssd={};
                    var name=$("#update_brandName").val(brand.name);
                    var id=$("#update_id").val(brand.id);

                    var imgurl=$("#update_photourl").val(brand.imgurl);
                    var selectedComs = document.getElementById("update_sel");

                    for(var i=0;i<selectedComs.length;i++){
                        if (selectedComs.options[i].value==brand.isHot)
                        selectedComs.options[i].selected = true;
                    }
                    initUpload("update_headPhoto","update_photourl");
                    updateBootbox=   bootbox.dialog({
                        title:"修改商品表",
                        message:$("#brandUpdate form"),
                        closeButton:false,
                        buttons:{
                            shi:{
                                label:"修改",
                                className:"btn-warning",
                                callback:function () {
                                    var ossImgUrl=$("#delOss",updateBootbox).val()
                                    ssd.imgurl=imgurl.val();
                                    ssd.id=id.val();
                                    ssd.name=name.val();
                                    ssd.isHot=$("#update_sel",updateBootbox).val();
                                    console.log(ssd)
                                    $.ajax({
                                        url:"/updateBrand?ossImgUrl="+ossImgUrl,
                                        type:"post",
                                        data:ssd,
                                        success:function (result) {
                                            if (result.code==200){
                                               brandTable.ajax.reload();
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
                    $("#brandUpdate").html(updatejsp);
                }
            }
        })
    }
    /*删除品牌*/
    function delt(id) {
        event.stopPropagation();
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
                        "url":"/deleteBrand?id="+id,
                        success:function (flag) {
                            if (flag.code==200) {
                                brandTable.ajax.reload();
                            }
                        }
                    })
                }
            }
        })
    }
    var addbootbox;
    function addBrand() {
        addbootbox= bootbox.dialog({
            title:"新增品牌表",
            message:$("#brandAdd form"),
            closeButton:false,
            buttons:{
                shi:{
                    label:"保存",
                    className:"btn-warning",
                    callback:function () {
                        var param={};
                        var name=$("#add_brandName",addbootbox).val();
                        var imgurl=$("#add_photourl",addbootbox).val();
                        var isHot=$("#add_sel",addbootbox).val();
                        param.name=name;
                        param.imgurl=imgurl;
                        param.isHot=isHot;
                        $.ajax({
                            url:"/addBrand",
                            type:"post",
                            data:param,
                            async:false,
                            success:function (result) {
                                if (result.code==200) {
                                    brandTable.ajax.reload();
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
        $("#brandAdd").html(addjsp);
        initUpload("add_headPhoto","add_photourl")
    }

    function updateSort(id) {
        bootbox.confirm({
            title: '提示信息',
            message: "你确定要更新吗？",
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
                    var sort=  $("#sort_"+id).val();
                    $.ajax({
                        url:"/updateSort",
                        type:'post',
                        data:{sort:sort,id:id},
                        success:function (result) {
                            if (result.code==200){
                                brandTable.ajax.reload();
                            }
                        }
                    })
                }
            }
        })
    }
    function updateHot(id,isHot) {
          var hot;
          if (isHot==1){
              hot=2
          } else {
              hot=1
          }
        bootbox.confirm({
            title: '提示信息',
            message: "你确定要更新吗？",
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
                    $.ajax({
                        url:"/updateHot",
                        type:'post',
                        data:{isHot:hot,id:id},
                        success:function (result) {
                            if (result.code==200){
                                brandTable.ajax.reload();
                            }
                        }
                    })
                }
            }
        })

    }

    var brandTable;
    function innitTable(){
        brandTable=  $('#example').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching": false,
            "lengthMenu":[5,10,20],
            "ajax": {
                "url": "/queryBrandList",
                "type": "POST",
            },drawCallback:function () {
                   $("#example tbody tr").each(function () {
                       var a_checkbox= $(this).find("input[type='checkbox']")[0];
                       for (var a=0;a<ids.length;a++){
                           if (ids[a]==a_checkbox.value) {
                               a_checkbox.checked=true;
                               $(this).css("background-color","pink")
                           }
                       }

                   })
            },
            "columns": [
                { "data": "id"},
                { "data": "name" },
                { "data": "imgurl",render:function (a,b,c,d) {
                        return "<img src='"+a+"' width='100px'>"
                    } },
              { "data": "isHot",render:function (a,b,c,d) {
                        return a==1?"热销🔥":"非热销"
                    } },
                { "data": "sort",render:function (a,b,c,d) {
                        return "<input value='"+a+"' id='sort_"+c.id+"'><button type='button' onclick=\"updateSort('"+c.id+"')\" class='btn btn-info'>更新</button>  "
                    } },
                { "data": "id",render:function (data,type,row,meta) {
                        return row.isHot==1? "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\" onclick=\"delt('"+data+"')\"><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick=\"toUpdatee('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-warning\" onclick=\"updateHot('"+data+"','"+row.isHot+"')\"><i class='glyphicon glyphicon-pencil'></i>非热销</button>\n" +
                            "</div>":"<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            " <button type=\"button\" class=\"btn btn-danger\" onclick=\"delt('"+data+"')\">删除</button>\n" +
                            "   <button type=\"button\" class=\"btn btn-success\" onclick=\"toUpdatee('"+data+"')\">修改</button>\n" +
                            " <button type=\"button\" class=\"btn btn-danger\" onclick=\"updateHot('"+data+"','"+row.isHot+"')\">热销🔥</button>\n" +
                            " </div>"
                    } }
            ],
            "language":{
                "url":"/commons/bootstrap3.3.7/Chinese.json"
            }
        } );
    }
</script>
</body>
</html>
