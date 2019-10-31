<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/8/24
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品展示</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<%--条件查询--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">商品查询</div>
        <div class="panel-body">
            <%-- 表单--%>
            <form class="form-horizontal" id="productSearch">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">商品</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control" name="name" id="tj_name"  placeholder="请输入商品名">
                    </div>
                    <label  class="col-sm-2 control-label">日期范围</label>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="tj_mindate" name="mindate" placeholder="起始日期" aria-describedby="basic-addon1">
                            <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-triangle-right"></i></span>
                            <input type="text" class="form-control" id="tj_maxdate" name="maxdate" placeholder="结束日期" aria-describedby="basic-addon1">
                        </div>
                    </div>
                </div>
                <div class="form-group">

                    <label  class="col-sm-2 control-label">价格范围</label>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="tj_minprice" name="minprice" placeholder="最小价格" aria-describedby="basic-addon1">
                            <span class="input-group-addon" id="basic-addon2"><i class="glyphicon glyphicon-yen"></i></span>
                            <input type="text" class="form-control" id="tj_maxprice" name="maxprice" placeholder="最大价格" aria-describedby="basic-addon1">
                        </div>
                    </div>

                </div>
                <label  class="col-sm-2 control-label">分类</label>
                <div class="input-group">
                    <div id="tj_sel">

                    </div>
                </div>
                <input type="hidden" name="s1" id="s1" >
                <input type="hidden" name="s2" id="s2">
                <input type="hidden" name="s3" id="s3">
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
        <button type="button" class="btn btn-info" onclick="addProduct()"><i class="glyphicon glyphicon-plus" ></i>新增</button>
        <button type="button" class="btn btn-danger" ><i class="glyphicon glyphicon-trash"></i>批量删除</button>
        <button type="button" class="btn btn-success" onclick="exportExcel()"><i class="glyphicon glyphicon-download-alt"></i>导出Excel</button>
        <button type="button" class="btn btn-success" onclick="exportPdf()"><i class="glyphicon glyphicon-download-alt"></i>导出Pdf</button>
        <button type="button" class="btn btn-success" onclick="exportWord()"><i class="glyphicon glyphicon-download-alt"></i>导出Word</button>
        <button type="button" class="btn btn-danger" onclick="cleanCache()"><i class="glyphicon glyphicon-trash"></i>清理缓存</button>
    </div>
</div>
<%--列表展示--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">商品列表</div>
        <table class="table table-striped table-bordered" id="example" style="width:100%">
            <thead>
            <tr>
                <th>ID</th>
                <th>商品</th>
                <th>价格</th>
                <th>图片</th>
                <th>生产日期</th>
                <th>库存</th>
                <th>是否热销</th>
                <th>是否上架</th>
                <th>品牌</th>
                <th>分类</th>
                <th>操作</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>ID</th>
                <th>商品</th>
                <th>价格</th>
                <th>图片</th>
                <th>生产日期</th>
                <th>库存</th>
                <th>是否热销</th>
                <th>是否上架</th>
                <th>品牌</th>
                <th>分类</th>
                <th>操作</th>
            </tr>
            </tfoot>
        </table>
    </div>

</div>
<div  id="productAdd" style="display: none">

    <form class="form-horizontal">
        <div class="form-group">
            <label  class="col-sm-2 control-label">商品</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_productName" placeholder="请输入品牌">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">价格</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_productPrice" placeholder="请输入价格">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">生产日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_productDate" placeholder="请选择日期">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-10">
                <input type="radio" name="isHot" value="1" placeholder="Password">是
                <input type="radio"  name="isHot" value="2" placeholder="Password">否
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">库存</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="add_productNum" placeholder="请输入库存">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否上架</label>
            <div class="col-sm-10">
                <input type="radio" name="isOut" value="1" placeholder="Password">是
                <input type="radio"  name="isOut" value="2" placeholder="Password">否
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
            <label  class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-10" id="add_brandId">
            </div>
        </div>
        <div class="form-group" style="width: 500px">
            <label  class="col-sm-2 control-label">分类</label>
            <div id="classifyDiv" class="col-sm-10">

            </div>
        </div>
    </form>


</div>
<div  id="productUpdate" style="display: none">

    <form class="form-horizontal">
        <input type="hidden" id="update_id">
        <div class="form-group">
            <label  class="col-sm-2 control-label">商品</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_productName" placeholder="请输入品牌">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">价格</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_productPrice" placeholder="请输入价格">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">生产日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_productDate" placeholder="请选择日期">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否热销</label>
            <div class="col-sm-10">
                <input type="radio" name="isHot" value="1" >是
                <input type="radio"  name="isHot" value="2" >否
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">是否上架</label>
            <div class="col-sm-10">
                <input type="radio" name="isOut" value="1" >是
                <input type="radio"  name="isOut" value="2" >否
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">库存</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_productNum" placeholder="请输入库存">
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
            <label  class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-10" id="update_brandId">
            </div>
        </div>
        <div class="form-group" style="width: 500px">
            <label  class="col-sm-2 control-label">分类</label>
            <div id="up_classifyDiv">
                <div id="update_classifyDiv" class="col-sm-10">

                </div>
            </div>

        </div>

    </form>
</div>

<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    $(function () {
        innitTable();
       addJsp= $("#productAdd").html()
       updateJsp= $("#productUpdate").html()
        initUpload("add_headPhoto","add_photourl");
        initTime("add_productDate")
        initTime("update_productDate")
        initSearchDate()
        initClassify(1,null,"tj_sel");
    })
     function initClassify(id,obj,sid) {
        $(obj).parent().nextAll().remove();
         $.post({
             "url":"/queryClassify",
             data:{id:id},
             success:function (result) {
                 var list= result.data
                 if (list.length==0){
                     return
                 }
                 if (result.code==200){
                     var selectHtml="<select name=\"sel\" class=\"form-control\" style='width: 140px' onchange=\"initClassify(this.value,this,'"+sid+"')\"><option value='-1'>==请选择==</option>"
                     for (var a=0;a<list.length;a++){
                          selectHtml+="<option value='"+list[a].id+"'>"+list[a].name+"</option>"
                     }
                     selectHtml+="</select>"
                     var sdiv="<div class=\"col-sm-3\">"
                     sdiv+=selectHtml
                     sdiv+="</div>"
                     if (sid=="classifyDiv") {
                         $("#"+sid,addbootbox).append(sdiv)
                     }else if(sid=="up_classifyDiv"){
                         $("#"+sid,updateBootbox).append(sdiv)
                     }else{
                         $("#"+sid).append(sdiv)
                     }

                 }
             }
         })
     }

    /*清除缓存*/
    function cleanCache() {
        $.post({
            url:"/cleanCache",
            success:function (result) {
                if (result.code==200){
                    bootbox.alert("成功")
                }
            }
        })
    }

    function initSelect(ele,seleId,brandId) {
        $.post({
            "url":"/queryBrandAll",
            async:false,
            success:function (result) {
               var list= result.data
                if (result.code==200){
                    var selectHtml="<select id='"+seleId+"' class='form-control'><option value='-1'>====请选择</option>"
                    for (var a=0;a<list.length;a++){
                        if (list[a].id==brandId){
                            selectHtml+="<option value='"+list[a].id+"' selected>"+list[a].name+"</option>"
                        } else {
                            selectHtml+="<option value='"+list[a].id+"'>"+list[a].name+"</option>"
                        }
                    }
                    selectHtml+="</select>"
                    $("#"+ele).html(selectHtml)
                }
            }
        })
    }

    function exportExcel() {
        var userForm =document.getElementById("productSearch");
        userForm.action="/productExportExcel";
        userForm.method="post";
        var s1=$($("select[name='sel']",$("#productSearch"))[0]).val()
        var s2=$($("select[name='sel']",$("#productSearch"))[1]).val()
        var s3=$($("select[name='sel']",$("#productSearch"))[2]).val()
        $("#s1",$("#productSearch")).val(s1)
        $("#s2",$("#productSearch")).val(s2)
        $("#s3",$("#productSearch")).val(s3)
        userForm.submit();
    }
    function exportPdf() {
        var userForm =document.getElementById("productSearch");
        userForm.action="/productExportPdf";
        userForm.method="post";
        userForm.submit();
    }
    function exportWord(){
        var userForm =document.getElementById("productSearch");
        userForm.action="/productExportWord";
        userForm.method="post";
        userForm.submit();
    }
    function  initSearchDate() {
        $("#tj_mindate").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            minDate: false, // 最小日期，如'2018/08/15'，则14号及14号前的日期都不可选
            maxDate: false,
            showClear:true
        });
        $("#tj_maxdate").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            minDate: false, // 最小日期，如'2018/08/15'，则14号及14号前的日期都不可选
            maxDate: false,
            showClear:true
        });
    }
    /*条件查询*/
    function search() {
        var name=$("#tj_name").val();
        var mindate=$("#tj_mindate").val();
        var maxdate=$("#tj_maxdate").val();
        var minprice=$("#tj_minprice").val();
        var maxprice=$("#tj_maxprice").val();
        var s1=$($("select[name='sel']",$("#productSearch"))[0]).val()
        var s2=$($("select[name='sel']",$("#productSearch"))[1]).val()
        var s3=$($("select[name='sel']",$("#productSearch"))[2]).val()
        var p={"name":name,"minprice":minprice,"maxprice":maxprice,"mindate":mindate,"maxdate":maxdate,"s1":s1,"s2":s2,"s3":s3};
        productTable.settings()[0].ajax.data=p;
        productTable.ajax.reload();
    }
    function initTime(param) {
        $("#"+param).datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            minDate: false, // 最小日期，如'2018/08/15'，则14号及14号前的日期都不可选
            maxDate: false,
            showClear:true
        });
    }
    function initUpload(param,photoid) {
        /*修改回显*/
        if (photoid=="update_photourl"){
            var url=$("#"+photoid).val();
            var urlArr=[];
            urlArr.push(url);
            console.log(urlArr)
        }
        $("#"+param).fileinput({
            dropZoneEnabled : false,
            language : 'zh',//汉化
            showCaption : false,
            browseLabel: '选择头像',
            /*初始化预览图片的配置*/
            initialPreview:urlArr,
            initialPreviewAsData:true,
            uploadUrl:"/uploadPhoto?type=user"//上传的地址
        }).on("fileuploaded",function (event, data, previewId, index) {
            if(data.response.ok){
                if (param=="update_headPhoto") {
                    $("#"+photoid,updateBootbox).val(data.response.url);
                }
                else {
                    $("#"+photoid,addbootbox).val(data.response.url);
                }
            }
        });
    }
    /*上下架*/
    function updateButton(id) {
        bootbox.confirm({
            title: '提示信息',
            message: "你确定要更改吗？",
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
                        "url":"/updateButton?id="+id,
                        success:function (flag) {
                            if (flag.code==200) {
                                search();
                            }
                        }
                    })
                }
            }
        })
    }

    function editClass(obj) {
        $(obj).parent().remove()
        /*替换文本*/
        initClassify(1,null,"up_classifyDiv");
        /*替换按钮*/
        $("#up_classifyDiv",updateBootbox).html(" <div id=\"quxiao\" width='200px'><button type=\"button\" class=\"btn btn-success\" onclick=\"cancleEditClass()\"><i class='glyphicon glyphicon-pencil'></i>取消</button></div>")
    }
    function cancleEditClass() {
        /*替换下拉框*/
         $("#up_classifyDiv",updateBootbox).html(seleName)
        /*替换按钮*/
        $("#up_classifyDiv",updateBootbox).append("<div id=\"quxiao\" width='200px'><button type=\"button\" class=\"btn btn-success\" onclick=\"editClass(this)\"><i class='glyphicon glyphicon-pencil'></i>编辑</button></div>")
    }
    /*修改商品*/
    var updateBootbox;
    var seleName;
    function toUpdatee(id) {
        $.ajax({
            url:"/goUpdateProduct?id="+id,
            type:"post",
            success:function (sun) {
                if (sun.code==200){
                    var product=sun.data;
                    console.log(product)
                    var ssd={};
                    var name=$("#update_productName").val(product.name);
                    var id=$("#update_id").val(product.id);
                    var price=$("#update_productPrice").val(product.price);
                    var createDate=$("#update_productDate").val(product.createDate);
                    var imgurl=$("#update_photourl").val(product.imgurl);
                    var num=$("#update_productNum").val(product.num);
                    var brandId=product.brandId;
                     seleName=product.selName
                    $("#update_classifyDiv").append(seleName+"<button type=\"button\" class=\"btn btn-success\" onclick=\"editClass(this)\"><i class='glyphicon glyphicon-pencil'></i>编辑</button>");
                    $('[name="isHot"]').each(function () {
                        if (this.value==product.isHot){
                            this.checked=true;
                        }
                    })
                    $('[name="isOut"]').each(function () {
                        if (this.value==product.isOut){
                            this.checked=true;
                        }
                    })
                    initSelect("update_brandId","update_sel",brandId)
                    initUpload("update_headPhoto","update_photourl");
                    updateBootbox=   bootbox.dialog({
                        title:"修改商品表",
                        message:$("#productUpdate form"),
                        closeButton:false,
                        buttons:{
                            shi:{
                                label:"修改",
                                className:"btn-warning",
                                callback:function () {
                                    var isHot= $("[name='isHot']:checked",updateBootbox).val();
                                    var isOut= $("[name='isOut']:checked",updateBootbox).val();
                                    var s1=$($("select[name='sel']",updateBootbox)[0]).val()
                                    var s2=$($("select[name='sel']",updateBootbox)[1]).val()
                                    var s3=$($("select[name='sel']",updateBootbox)[2]).val()
                                    var selArray=$("select[name='sel']",updateBootbox)
                                    console.log(selArray)
                                    if (selArray.length==3 && $(selArray[2]).val() != -1){
                                        ssd.s1=s1;
                                        ssd.s2=s2;
                                        ssd.s3=s3;
                                    } else {
                                        ssd.s1=product.s1;
                                        ssd.s2=product.s2;
                                        ssd.s3=product.s3;
                                    }
                                    ssd.imgurl=imgurl.val();
                                    ssd.id=id.val();
                                    ssd.name=name.val();
                                    ssd.price=price.val();
                                    ssd.createDate=createDate.val();
                                    ssd.isHot=isHot;
                                    ssd.isOut=isOut;
                                    ssd.num=num.val();
                                    ssd.brandId=$("#update_sel").val();
                                    console.log(ssd)
                                    $.ajax({
                                        url:"/updateProduct",
                                        type:"post",
                                        data:ssd,
                                        success:function (result) {
                                            if (result.code==200){
                                                search();
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
                    initTime("update_jointime");
                    $("#productUpdate").html(updateJsp);
                    initTime("update_productDate")
                }
            }
        })
    }
    /*删除商品*/
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
                        "url":"/deleteProduct?id="+id,
                        success:function (flag) {
                            if (flag.code==200) {
                                search();
                            }
                        }
                    })
                }
            }
        })
    }
    var addbootbox;
    function addProduct() {
        initSelect("add_brandId","add_sel")
        initClassify(1,null,"classifyDiv")
        addbootbox= bootbox.dialog({
            title:"新增商品表",
            message:$("#productAdd form"),
            closeButton:false,
            buttons:{
                shi:{
                    label:"保存",
                    className:"btn-warning",
                    callback:function () {
                        var param={};
                        var name=$("#add_productName",addbootbox).val();
                        var price=$("#add_productPrice",addbootbox).val();
                        var createDate=$("#add_productDate",addbootbox).val();
                        var imgurl=$("#add_photourl",addbootbox).val();
                        var num=$("#add_productNum",addbootbox).val();
                        var brandId=$("#add_sel",addbootbox).val();
                         var isHot= $("[name='isHot']:checked",addbootbox).val();
                         var isOut= $("[name='isOut']:checked",addbootbox).val();
                         var s1=$($("select[name='sel']",addbootbox)[0]).val()
                         var s2=$($("select[name='sel']",addbootbox)[1]).val()
                         var s3=$($("select[name='sel']",addbootbox)[2]).val()
                        param.name=name;
                        param.price=price;
                        param.createDate=createDate;
                        param.imgurl=imgurl;
                        param.isHot=isHot;
                        param.isOut=isOut;
                        param.num=num;
                        param.brandId=brandId;
                        param.s1=s1;
                        param.s2=s2;
                        param.s3=s3;

                        $.ajax({
                            url:"/addProduct",
                            type:"post",
                            data:param,
                            async:false,
                            success:function (result) {
                                if (result.code==200) {
                                  search();
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
        $("#productAdd").html(addJsp);
        initUpload("add_headPhoto","add_photourl");
        initTime("add_productDate")
    }
    var productTable;
    function innitTable(){
        productTable=  $('#example').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching": false,
            "lengthMenu":[5,10,20],
            "ajax": {
                "url": "/queryProductList",
                "type": "POST",
            },
            "columns": [
                { "data": "id"},
                { "data": "name" },
                { "data": "price" },
                { "data": "imgurl",render:function (a,b,c,d) {
                        return "<img src='/"+a+"' width='100px'>"
                    } },
                { "data": "createDate" },
                { "data": "num" },
                { "data": "isHot",render:function (a,b,c,d) {
                        return a==1?"热销":"否";
                    } },
                { "data": "isOut",render:function (a,b,c,d) {
                        return a==1?"上架":"下架";
                    } },
                {"data":"brandName"},
                {"data":"selName"},
                { "data": "id",render:function (data,type,row,meta) {
                        return row.isOut==1?"<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\" onclick=\"delt('"+data+"')\"><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick=\"toUpdatee('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\" onclick=\"updateButton('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>下架</button>\n" +
                            "</div>":"<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                            "  <button type=\"button\" class=\"btn btn-danger\" onclick=\"delt('"+data+"')\"><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick=\"toUpdatee('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                            "  <button type=\"button\" class=\"btn btn-success\" onclick=\"updateButton('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>上架</button>\n" +
                            "</div>"
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
