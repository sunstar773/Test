<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/8/18
  Time: 21:48
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户展示</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<style>
    .show-grid [class ^="col-"] {
        padding-top: 10px;
        padding-bottom: 10px;
        background-color: #eee;
        border: 1px solid #ddd;
        background-color: rgba(86, 61, 124, .15);
        border: 1px solid rgba(86, 61, 124, .2);
    }
</style>
     <%--条件查询--%>
   <div class="container">
       <div class="panel panel-success">
           <div class="panel-heading">商品查询</div>
           <div class="panel-body">
             <%-- 表单--%>
               <form class="form-horizontal" id="userForm">
                   <div class="form-group">
                       <label  class="col-sm-2 control-label">用户名</label>
                       <div class="col-sm-4">
                           <input type="email" class="form-control"  name="loginname" id="tj_loginname"  placeholder="请输入用户名">
                       </div>
                       <label  class="col-sm-2 control-label">真实姓名</label>
                       <div class="col-sm-4">
                           <input type="email" class="form-control" name="realname"  id="tj_realname" placeholder="请输入真实姓名">
                       </div>
                   </div>
                   <div class="form-group">
                       <label  class="col-sm-2 control-label">年龄范围</label>
                       <div class="col-sm-4">
                           <div class="input-group">
                               <input type="text" class="form-control" id="tj_minage" name="minage" placeholder="起始年龄" aria-describedby="basic-addon1">
                               <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-triangle-right"></i></span>
                               <input type="text" class="form-control" id="tj_maxage" name="maxage" placeholder="结束年龄" aria-describedby="basic-addon1">
                           </div>
                       </div>
                       <label  class="col-sm-2 control-label">薪资范围</label>
                       <div class="col-sm-4">
                           <div class="input-group">
                               <input type="text" class="form-control" id="tj_minpay" name="minpay" placeholder="最小薪资" aria-describedby="basic-addon1">
                               <span class="input-group-addon" id="basic-addon2"><i class="glyphicon glyphicon-yen"></i></span>
                               <input type="text" class="form-control" id="tj_maxpay"  name="maxpay" placeholder="最大薪资" aria-describedby="basic-addon1">
                           </div>
                       </div>
                   </div>
                   <div class="form-group">
                       <label  class="col-sm-2 control-label">入职时间</label>
                       <div class="col-sm-4">
                           <div class="input-group">
                               <input type="text" class="form-control form_datetime" name="minJointime" id="tj_minJointime" placeholder="开始时间" aria-describedby="basic-addon1">
                               <span class="input-group-addon" id="basic-addon3"><i class="glyphicon glyphicon-calendar"></i></span>
                               <input type="text" class="form-control form_datetime" name="maxJointime" id="tj_maxJointime" placeholder="结束时间" aria-describedby="basic-addon1">
                           </div>
                       </div>
                       <label  class="col-sm-2 control-label">角色</label>
                       <div class="col-sm-4" id="tjbox">

                       </div>
                   </div>
                   <label  class="col-sm-2 control-label">地区</label>
                   <div class="input-group">
                       <div id="tj_sel" class="col-sm-12">

                       </div>
                   </div>
                     <div style="text-align: center">
                         <button type="button" class="btn btn-info" onclick="search()"><i class="glyphicon glyphicon-search"></i>查询</button>
                         <button type="reset" class="btn btn-default" onclick="rest()"><i class="glyphicon glyphicon-repeat"></i>重置</button>
                     </div>
                   <input type="hidden" name="roleIds" id="roleIds">
                   <input type="hidden" name="s1" id="s1" >
                   <input type="hidden" name="s2" id="s2">
                   <input type="hidden" name="s3" id="s3">
               </form>
           </div>
       </div>
   </div>
<%--操作的按钮--%>
<div class="container" >
    <div style="background-color: #ebcccc;width: 100%;height: 35px">
        <button type="button" class="btn btn-info" onclick="addUser()"><i class="glyphicon glyphicon-plus" ></i>新增</button>
        <button type="button" class="btn btn-danger" onclick="deleteBatch()"><i class="glyphicon glyphicon-trash"></i>批量删除</button>
        <button type="button" class="btn btn-success" onclick="exportExcel()"><i class="glyphicon glyphicon-download-alt"></i>导出Excel</button>
        <button type="button" class="btn btn-success" onclick="exportPdf()"><i class="glyphicon glyphicon-download-alt"></i>导出Pdf</button>
        <button type="button" class="btn btn-success" onclick="exportWord()"><i class="glyphicon glyphicon-download-alt"></i>导出Word</button>
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
                      <th>用户名</th>
                      <th>真实姓名</th>
                      <th>性别</th>
                      <th>年龄</th>
                      <th>手机号</th>
                      <th>邮箱</th>
                      <th>薪资</th>
                      <th>入职时间</th>
                      <th>角色</th>
                      <th>状态</th>
                      <th>头像</th>
                      <th>地区</th>
                      <th>操作</th>
                  </tr>
                  </thead>
                  <tfoot>
                  <tr>
                      <th>ID</th>
                      <th>用户名</th>
                      <th>真实姓名</th>
                      <th>性别</th>
                      <th>年龄</th>
                      <th>手机号</th>
                      <th>邮箱</th>
                      <th>薪资</th>
                      <th>入职时间</th>
                      <th>角色</th>
                      <th>状态</th>
                      <th>头像</th>
                      <th>地区</th>
                      <th>操作</th>
                  </tr>
                  </tfoot>
              </table>
      </div>

  </div>

<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<div  id="userAdd" style="display: none">

    <form class="form-horizontal" id="addForm">
        <div class="form-group">
            <label  class="col-sm-2 control-label">账号</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="add_loginname" id="add_loginname" placeholder="请输入账号">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">密码</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" name="add_password" id="add_password"  placeholder="请输入密码">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">确认密码</label>
            <div class="col-sm-10">
                <input type="password" class="form-control" name="add_checkPassword"   placeholder="请输入密码">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">真实姓名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="add_realname" id="add_realname"  placeholder="请输入姓名">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">性别</label>
            <div class="col-sm-10">
                <input type="radio" name="add_sex" value="1" placeholder="Password">男
                <input type="radio"  name="add_sex" value="0" placeholder="Password">女
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">年龄</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="add_age" id="add_age"  placeholder="请输入年龄">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">电话</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="add_phone" id="add_phone"  placeholder="请输入电话">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">邮箱</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="add_email" id="add_email"  placeholder="请输入邮箱">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">薪资</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="add_pay" id="add_pay"  placeholder="请输入薪资">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">入职时间</label>
            <div class="col-sm-10">
                <input type="text" class="form-control form_datetime" name="add_jointime"  id="add_jointime"  placeholder="请选择入职时间">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">角色</label>
            <div class="col-sm-10" id="rcheckbox">

            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">头像</label>
            <div class="col-sm-10" >
                <input type="file" name="headPhoto" id="add_headPhoto" />
                <input type="hidden"  id="add_photourl" />
            </div>
        </div>
        <div class="form-group" id="areaDiv">
            <label  class="col-sm-2 control-label">地区</label>

        </div>
    </form>
</div>
<div  id="userUpdate" style="display: none">

    <form class="form-horizontal">
        <input type="hidden" id="update_id">
        <div class="form-group">
            <label  class="col-sm-2 control-label">账号</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_loginname" placeholder="请输入账号">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">真实姓名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_realname"  placeholder="请输入姓名">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">性别</label>
            <div class="col-sm-10">
                <input type="radio" name="sex" value="1" placeholder="Password">男
                <input type="radio"  name="sex" value="0" placeholder="Password">女
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">年龄</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_age"  placeholder="请输入年龄">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">电话</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_phone"  placeholder="请输入电话">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">邮箱</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_email"  placeholder="请输入邮箱">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">薪资</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="update_pay"  placeholder="请输入薪资">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">入职时间</label>
            <div class="col-sm-10">
                <input type="text" class="form-control form_datetime2"  id="update_jointime"  placeholder="请选择入职时间">
            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">角色</label>
            <div class="col-sm-10" id="update_box">

            </div>
        </div>
        <div class="form-group">
            <label  class="col-sm-2 control-label">头像</label>
            <div class="col-sm-10" >
                <input type="file" name="headPhoto" id="update_headPhoto" />
            <input type="hidden"  id="update_photourl"/>
        </div>
        </div>
        <div class="form-group" id="up_areaDiv">


        </div>
    </form>
</div>
<script>
    function initAreaSel(id,obj,selid) {
        if(obj){
            $(obj).parent().nextAll().remove()
        }
         $.post({
             url:"/AreaList",
             data:{id:id},
             success:function (result) {

                 var list=result.data
                 if (list.length==0){
                     return
                 }
                   var selectHtml=" <div class='col-sm-3' >"
                 selectHtml+="<select name=\"sel\" class=\"form-control\" onchange=\"initAreaSel(this.value,this,'"+selid+"')\"><option value='-1'>==请选择==</option>"
                 for (var a=0;a<list.length;a++){
                     selectHtml+="<option value='"+list[a].id+"'>"+list[a].name+"</option>"
                 }
                 selectHtml+="</select></div>"
                 if (selid=="update"){
                     $("#up_areaDiv",updateBootbox).append(selectHtml)
                 }else if (selid=="tj_sel") {
                     $("#tj_sel").append(selectHtml)
                 }else {
                     $("#areaDiv",addbootbox).append(selectHtml)
                 }

             }
         })
    }

    function initTjAreaSel(id,obj,selid) {
        if(obj){
            $(obj).parent().nextAll().remove()
        }
        $.post({
            url:"/AreaList",
            data:{id:id},
            success:function (result) {

                var list=result.data
                if (list.length==0){
                    return
                }
                var selectHtml=" <div class='col-sm-3' >"
                selectHtml+="<select name=\"sel\" class=\"form-control\" style='width: 200px' onchange=\"initTjAreaSel(this.value,this,'"+selid+"')\"><option value='-1'>==请选择==</option>"
                for (var a=0;a<list.length;a++){
                    selectHtml+="<option value='"+list[a].id+"'>"+list[a].name+"</option>"
                }
                selectHtml+="</select></div>"
                    $("#tj_sel").append(selectHtml)

            }
        })
    }
    function exportExcel() {
        var userForm =document.getElementById("userForm");
        userForm.action="/exportExcel";
        userForm.method="post";
        var s="";
        s=$("#tj").val().join(",");
        var s1=$($("select[name='sel']",$("#userForm"))[0]).val()
        var s2=$($("select[name='sel']",$("#userForm"))[1]).val()
        var s3=$($("select[name='sel']",$("#userForm"))[2]).val()
        $("#s1",$("#userForm")).val(s1)
        $("#s2",$("#userForm")).val(s2)
        $("#s3",$("#userForm")).val(s3)
        $("#roleIds").val(s);
        userForm.submit();
    }
    function exportPdf() {
        var userForm =document.getElementById("userForm");
        userForm.action="/exportPdf";
        userForm.method="post";
        var s="";
        s=$("#tj").val().join(",");
        $("#roleIds").val(s);
        userForm.submit();
    }
    function exportWord(){
        var userForm =document.getElementById("userForm");
        userForm.action="/exportWord";
        userForm.method="post";
        var s="";
        s=$("#tj").val().join(",");
        $("#roleIds").val(s);
        userForm.submit();
    }

    /*清空条件查询的下拉框*/
    function rest() {
        $('#tj').selectpicker('val',['noneSelectedText'])
        $("#tj").selectpicker('refresh');
    }
    /*阻止冒泡事件*/
    function eventStop() {
         event.stopPropagation();
    }
    /*条件查询*/
    function search() {
        var loginname=$("#tj_loginname").val();
        var realname=$("#tj_realname").val();
        var minage=$("#tj_minage").val();
        var maxage=$("#tj_maxage").val();
        var minpay=$("#tj_minpay").val();
        var maxpay=$("#tj_maxpay").val();
        var minJointime=$("#tj_minJointime").val();
        var maxJointime=$("#tj_maxJointime").val();
        var s1=$($("select[name='sel']",$("#userForm"))[0]).val()
        var s2=$($("select[name='sel']",$("#userForm"))[1]).val()
        var s3=$($("select[name='sel']",$("#userForm"))[2]).val()
        var da="";
        var s="";
       /* $("[name='tj_ids']:checked").each(function () {
            da+=","+this.value;

        })*/
   /*     $("#tj option:selected").each(function () {
            da+=","+this.value;
        })
        s = da.substring(1);*/
        s=$("#tj").val().join(",");

        var p={"loginname":loginname,"realname":realname,"minpay":minpay,"maxpay":maxpay,"minJointime":minJointime,"maxJointime":maxJointime,"roleIds":s,"s1":s1,"s2":s2,"s3":s3};
        p.minage=minage;
        p.maxage=maxage;
        console.log(p)
        userTable.settings()[0].ajax.data=p;
        userTable.ajax.reload();
    }
    var addjsp;
    var updatejsp;
    var userTable;
    /*页面加载*/
    $(function() {

        innitTable();
        initSearchDate();
        initTime("add_jointime");
        initTime("update_jointime");
        addjsp= $("#userAdd").html();
        updatejsp=$("#userUpdate").html();
        role2User("rcheckbox","add");
        role2User("tjbox","tj");
        role2User("update_box","update");
        initBindEvent();
       initUpload("add_headPhoto","add_photourl");
       /* checkForm()*/
        initTjAreaSel(0,null,"tj_sel")
    });
    /*function checkForm() {
        $("#addForm").bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                add_loginname: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '用户名是必需的，不能为空'
                        },
                        stringLength: {
                            min: 3,
                            max: 10,
                            message: '长度最少3位，最长10位'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9]+$/,
                            message: '用户名只能由字母和数字组成'
                        },
                        different: {
                            field: 'add_password',
                            message: '用户名和密码不能相同'
                        }
                    }
                },
                add_email: {
                    validators: {
                        notEmpty: {
                            message: '电子邮件地址是必需的，不能为空'
                        },
                        emailAddress: {
                            message: '电子邮件地址无效'
                        }
                    }
                },
                add_password: {
                    validators: {
                        notEmpty: {
                            message: '密码是必需的，不能为空'
                        },
                        different: {
                            field: 'add_loginname',
                            message: '密码和用户名不能相同'
                        },
                        stringLength: {
                            min: 3,
                            message: '密码最小长度不小于3'
                        }, identical: { // 比较是否相同，否的话校验不通过
                            field: 'add_checkPassword', // 和password字段比较
                            message: '两次密码输入不一致'
                        }
                    }
                },
                add_checkPassword: {
                    validators: {
                        notEmpty: {
                            message: '密码是必需的，不能为空'
                        },
                        different: {
                            field: 'add_loginname',
                            message: '密码和用户名不能相同'
                        },
                        stringLength: {
                            min: 3,
                            message: '密码最小长度不小于3'
                        }, identical: { // 比较是否相同，否的话校验不通过
                            field: 'add_password', // 和password字段比较
                            message: '两次密码输入不一致'
                        }
                    }
                },
                add_sex: {
                    validators: {
                        notEmpty: {
                            message: '性别不能为空'
                        }
                    }
                },
                add_age: {
                    notEmpty: {
                        message: '年龄不能为空'
                    },
                    validators: {
                        between: {
                            min: 0,
                            max: 150,
                            message: '请输入正常的年龄,范围为0到150',
                        }
                    }
                },
                add_realname: {
                    validators: {
                        notEmpty: {
                            message: '真实姓名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 10,
                            message: '真实姓名最小长度为1，最大长度为10'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: 'The username can only consist of alphabetical, number and underscore'
                        }
                    }
                }
            }
        });


    }*/

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
            layoutTemplates:{       //缩略图里的按钮配置
                actionDelete:"",
                actionUpload:"",
            },
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

    var ids=",";
    function initBindEvent() {
        // 动态绑定事件【当元素是 动态生成 的则使用动态绑定事件】
        $("#example tbody").on("click", "tr", function () {
            // 当前tr对应的jquery对象
            var v_checkbox = $(this).find("input[type='checkbox']")[0];
            if (v_checkbox.checked) {
                // 取消选中，取消背景色
                $(this).css("background-color", "");
                v_checkbox.checked = false;
                // 从字符串中删除指定id
                ids=ids.replace(v_checkbox.value+",","")
            } else {
                // 选中，改变背景色
                $(this).css("background-color", "pink");
                v_checkbox.checked = true;
                ids+=v_checkbox.value+",";
               
            }

        })

    }
    /*批量删除*/
   function deleteBatch() {

       if (ids.length>1) {

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
                   ids=ids.substring(1,ids.length-1);
                   if (result){
                       $.post({
                           "url":"/deleteBatchUser?ids="+ids,
                           success:function (flag) {
                               if (flag.code==200) {
                                   search();
                                   ids=",";
                               }
                           }
                       })
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

   function role2User(param,prefix) {
        var sun="<select class='selectpicker' title='请选择角色' id ='"+prefix+"'  multiple data-max-options='6'>"
        $.post({
            url:"/queryRlist",
            success:function (result) {
                if (result.code==200){
                    var roleList= result.data
                    for (var a=0;a<roleList.length;a++){
                        sun+="<option  value='"+roleList[a].id+"'>"+roleList[a].name+"</option>"
                    }
                    sun+="</select>"
                        $("#"+param).html(sun)
                    $('.selectpicker').selectpicker();
                  /*  $('.selectpicker').selectpicker('render');*/
                }

            }
        })
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

    function  initSearchDate() {
        $("#tj_minJointime").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            minDate: false, // 最小日期，如'2018/08/15'，则14号及14号前的日期都不可选
            maxDate: false,
            showClear:true
        });
        $("#tj_maxJointime").datetimepicker({
            format: 'YYYY-MM-DD',
            locale: moment.locale('zh-CN'),
            minDate: false, // 最小日期，如'2018/08/15'，则14号及14号前的日期都不可选
            maxDate: false,
            showClear:true
        });
    }
    function huixianCheckBox(ids) {

    /*    $("input[name='update_ids']:checkbox").each(function () {
            if (roleids.indexOf(","+this.value+",")!=-1){
                this.checked=true;
                return;
            }
        })*/
        var arr= ids.split(",");
        console.log(arr)
        $('#update').selectpicker('val', arr); //设置指定选中的值
        /* $("#update_box option:selected").each(function () {
             alert(this.value)
             if (roleids.indexOf(","+this.value+",")!=-1){
                 this.selected=true;

                 return;
             }
         })*/


    }

    function editArea(obj) {

           $(obj).parent().remove()

        initAreaSel(0,null,"update")
        $("#up_areaDiv",updateBootbox).append("<button type=\"button\" class=\"btn btn-success\" onclick=\"cancleEditArea(this)\"><i class='glyphicon glyphicon-pencil'></i>取消</button>")
    }
    function cancleEditArea() {
        $("#up_areaDiv",updateBootbox).html("<label  class=\"col-sm-2 control-label\">地区</label>"+
            "<div>"+seleName+"<button type=\"button\" class=\"btn btn-success\" onclick=\"editArea(this)\"><i class='glyphicon glyphicon-pencil'></i>编辑</button></div>")
    }

    /*修改用户*/
    var updateBootbox;
    var selName;
    function toUpdatee(id) {

        eventStop();
        $.ajax({
            url:"/goUpdateUser?id="+id,
            type:"post",
            success:function (sun) {
               if (sun.code==200){
                   var user=sun.data;
                   var ssd={};
                   var loginname=$("#update_loginname").val(user.loginname);
                   var id=$("#update_id").val(user.id);
                   var realname=$("#update_realname").val(user.realname);
                   $('[name="sex"]').each(function () {
                       if (this.value==user.sex){
                           this.checked=true;
                       }
                   })
                   var age=$("#update_age").val(user.age);
                   var phone=$("#update_phone").val(user.phone);
                   var email=$("#update_email").val(user.email);
                   var pay=$("#update_pay").val(user.pay);
                   var jointime=$("#update_jointime").val(user.jointime);
                   var imgurl=$("#update_photourl").val(user.imgurl);
                   seleName=user.selName
                   $("#up_areaDiv").append("<label  class=\"col-sm-2 control-label\">地区</label>"+"<div>"+seleName+"<button type=\"button\" class=\"btn btn-success\" onclick=\"editArea(this)\"><i class='glyphicon glyphicon-pencil'></i>编辑</button></div>")
                   if (user.roleIds!=null) {
                       huixianCheckBox(user.roleIds)
                   }
                   initUpload("update_headPhoto","update_photourl");

                   updateBootbox=   bootbox.dialog({
                       title:"修改商品表",
                       message:$("#userUpdate form"),
                       closeButton:false,
                       buttons:{
                           shi:{
                               label:"修改",
                               className:"btn-warning",
                               callback:function () {
                                   var rids="";
                                   var sex=$("[name='sex']:checked",updateBootbox).val();
                                 /*  $("[name='update_ids']:checked",updateBootbox).each(function () {
                                       rids+=","+this.value;
                                   })*/
                                   $("#update_box option:selected",updateBootbox).each(function () {
                                       rids+=","+this.value;
                                   })
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
                                       ssd.s1=user.s1;
                                       ssd.s2=user.s2;
                                       ssd.s3=user.s3;
                                   }
                                   var dada= rids.substring(1);
                                   ssd.loginname=loginname.val();
                                   ssd.realname=realname.val();
                                   ssd.sex=sex;
                                   ssd.ids=dada;
                                   ssd.id=id.val();
                                   ssd.age=age.val();
                                   ssd.phone=phone.val();
                                   ssd.email=email.val();
                                   ssd.pay=pay.val();
                                   ssd.jointime=jointime.val();
                                   ssd.imgurl=imgurl.val();
                                   console.log(ssd)
                                   $.ajax({
                                       url:"/updateUser",
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
                   $("#userUpdate").html(updatejsp);
                   role2User("update_box","update");
               }
            }
        })
    }
    /*增加用户*/
    var addbootbox;
    function addUser() {
        initAreaSel(0,null,"add_sel")
        addbootbox= bootbox.dialog({
            title:"新增商品表",
            message:$("#userAdd form"),
            closeButton:false,
            buttons:{
                shi:{
                    label:"保存",
                    className:"btn-warning",
                    callback:function () {
                        var param={};
                        var loginname=$("#add_loginname",addbootbox).val();
                        var password=$("#add_password",addbootbox).val();
                        var realname=$("#add_realname",addbootbox).val();
                        var sex=$("[name='add_sex']:checked",addbootbox).val();
                        var age=$("#add_age",addbootbox).val();
                        var phone=$("#add_phone",addbootbox).val();
                        var email=$("#add_email",addbootbox).val();
                        var pay=$("#add_pay",addbootbox).val();
                        var jointime=$("#add_jointime",addbootbox).val();
                        var imgurl=$("#add_photourl",addbootbox).val();
                        var s1=$($("select[name='sel']",addbootbox)[0]).val()
                        var s2=$($("select[name='sel']",addbootbox)[1]).val()
                        var s3=$($("select[name='sel']",addbootbox)[2]).val()
                        var da="";
                        var s="";
                      /*  $("[name='add_ids']:checked",addbootbox).each(function () {
                              da+=","+this.value;

                        })*/
                        $("#rcheckbox option:selected",addbootbox).each(function () {
                            da+=","+this.value;
                            s = da.substring(1);
                        })
                        param.loginname=loginname;
                        param.password=password;
                        param.realname=realname;
                        param.sex=sex;
                        param.age=age;
                        param.phone=phone;
                        param.email=email;
                        param.pay=pay;
                        param.jointime=jointime;
                        param.imgurl=imgurl;
                        param.ids=s;
                        param.s1=s1;
                        param.s2=s2;
                        param.s3=s3;
                      /*  $('#addForm').bootstrapValidator(checkForm()); //验证配置
                        var validator = $('#addForm').data("bootstrapValidator"); //获取validator对象
                        validator.validate(); //手动触发验证
                        console.log(validator.isValid())
                        if (validator.isValid()) { //通过验证*/
                            $.ajax({
                                url: "/addUser",
                                type: "post",
                                data: param,
                                success: function (result) {
                                    if (result.code == 200) {
                                        search();
                                    }

                                },
                            })
                       /* }else {
                            return;
                        }*/
                    }
                },
                da:{
                    label:"取消",
                    callback:function () {
                    }
                },
            },
          
        })
        initTime("add_jointime");
        $("#userAdd").html(addjsp);
        role2User("rcheckbox","add");
        initUpload("add_headPhoto","add_photourl",addbootbox);
        checkForm()
    }

     /*删除用户*/
    function delt(id) {
        eventStop();
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
                    "url":"/deleteUser?id="+id,
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
     /*账号解锁*/
    function updateCount(id) {
        eventStop();
        bootbox.confirm({
            title: '提示信息',
            message: "你确定要解锁吗？",
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
                        "url":"/updateErrorCount?id="+id,
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
    
    function resetPassword(id) {
        eventStop();
        bootbox.confirm({
            title: '提示信息',
            message: "你确定要重置吗？",
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
                        "url":"/resetPassword?id="+id,
                        success:function (flag) {
                            if (flag.code==200) {
                                bootbox.alert({
                                    message: "<span class='glyphicon glyphicon-info-sign'>重置成功",
                                    size: 'small'
                                });
                                search();
                            }
                        }
                    })
                }
            }
        })
    }


    function innitTable(){

        userTable=$('#example').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching": false,
            "lengthMenu":[5,10,20],
            "ajax": {
                "url": "/queryUserList",
                "type": "POST",
               dataSrc:function (result) {

                   result.draw=result.data.draw;
                    result.recordsTotal=result.data.recordsTotal;
                    result.recordsFiltered=result.data.recordsFiltered;
                    return result.data.data
                }
            }, drawCallback:function (s) {
                // 对比，将当前表格中出现的行的唯一标识和ids对比，一致则回填
                $("#example tbody tr").each(function () {
                    var v_checkbox = $(this).find("input[type='checkbox']")[0];
                    if (v_checkbox) {
                        var id = v_checkbox.value;
                        if (ids.indexOf(","+id+",")>-1){
                            $(this).css("background-color", "pink");
                            v_checkbox.checked=true;
                        }
                    }
                })
            },
            "columns": [
                { "data": "id",render:function (data,type,row,meta) {
                        return "<input type='checkbox' value='"+data+"'>"
                    }},
                { "data": "loginname" },
                { "data": "realname" },
                { "data": "sex",render:function (data,type,row,meta) {
                        return data==1?"男":"女";
                    } },
                { "data": "age" },
                { "data": "phone" },
                { "data": "email" },
                { "data": "pay" },
                { "data": "jointime" },
                { "data": "roleName" },
                { "data": "islock",render:function (data,type,row,meta) {
                        return data==true?"锁定":"正常"
                    } },
                { "data": "imgurl",render:function (data,type,row,meta) {
                        return "<img src='/"+data+"' width='50px'>"
                    } },
                { "data": "selName" },
                { "data": "id",render:function (data,type,row,meta) {
                    return  row.islock==true? "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                        "  <button type=\"button\" class=\"btn btn-danger\" onclick=\"delt('"+data+"')\"><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                        "  <button type=\"button\" class=\"btn btn-success\" onclick=\"toUpdatee('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                        "  <button type=\"button\" class=\"btn btn-success\" onclick=\"updateCount('"+data+"')\"><i class='glyphicon glyphicon-lock'></i>解锁</button>\n" +
                        "  <button type=\"button\" class=\"btn btn-success\" onclick=\"resetPassword('"+data+"')\"><i class='glyphicon glyphicon-refresh'></i>重置密码</button>\n" +
                        "</div>":
                        "<div class=\"btn-group\" role=\"group\" aria-label=\"...\">\n" +
                        "  <button type=\"button\" class=\"btn btn-danger\" onclick=\"delt('"+data+"')\"><i class='glyphicon glyphicon-trash'></i>删除</button>\n" +
                        "  <button type=\"button\" class=\"btn btn-success\" onclick=\"toUpdatee('"+data+"')\"><i class='glyphicon glyphicon-pencil'></i>修改</button>\n" +
                        "  <button type=\"button\" class=\"btn btn-success\" onclick=\"resetPassword('"+data+"')\"><i class='glyphicon glyphicon-refresh'></i>重置密码</button>\n" +
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
