<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/10/21
  Time: 21:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>会员管理</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<%--条件查询--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">会员查询</div>
        <div class="panel-body">
            <%-- 表单--%>
            <form class="form-horizontal" id="MemberForm">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">会员名</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"  id="tj_name"  placeholder="请输入会员名">
                    </div>
                    <label  class="col-sm-2 control-label">出生日期</label>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control" id="tj_mindate" name="mindate" placeholder="起始日期" aria-describedby="basic-addon1">
                            <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-triangle-right"></i></span>
                            <input type="text" class="form-control" id="tj_maxdate" name="maxdate" placeholder="结束日期" aria-describedby="basic-addon1">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">真实姓名</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control"  id="tj_realname"  placeholder="请输入真实姓名">
                    </div>
                    <label  class="col-sm-2 control-label">地区</label>
                    <div class="input-group">
                        <div id="tj_sel" class="col-sm-12">

                        </div>
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
<%--列表展示--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">会员列表</div>
        <table class="table table-striped table-bordered" id="example" style="width:100%">
            <thead>
            <tr>
                <th>ID</th>
                <th>会员名</th>
                <th>真实姓名</th>
                <th>手机号</th>
                <th>出生日期</th>
                <th>地区</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>ID</th>
                <th>会员名</th>
                <th>真实姓名</th>
                <th>手机号</th>
                <th>出生日期</th>
                <th>地区</th>
            </tr>
            </tfoot>
        </table>
    </div>

</div>


<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    $(function () {
        innitTable();
        initTjAreaSel(0,null,"tj_sel")
        initSearchDate()
    })
    /*条件查询*/
    function search() {
        var name=$("#tj_name").val();
        var realname=$("#tj_realname").val();
        var minJointime=$("#tj_mindate").val();
        var maxJointime=$("#tj_maxdate").val();
        var s1=$($("select[name='sel']",$("#MemberForm"))[0]).val()
        var s2=$($("select[name='sel']",$("#MemberForm"))[1]).val()
        var s3=$($("select[name='sel']",$("#MemberForm"))[2]).val()
        var p={"name":name,"realname":realname,"minBirthday":minJointime,"maxBirthday":maxJointime,"c1":s1,"c2":s2,"c3":s3};
        memberTable.settings()[0].ajax.data=p;
        memberTable.ajax.reload();
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
    var memberTable;
    function innitTable(){
        memberTable=  $('#example').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching": false,
            "lengthMenu":[5,10,20],
            "ajax": {
                "url": "/findMemList",
                "type": "POST",
                dataSrc:function (result) {
                    result.draw=result.data.draw;
                    result.recordsTotal=result.data.recordsTotal;
                    result.recordsFiltered=result.data.recordsFiltered;
                    return result.data.data
                }
            },
            "columns": [
                { "data": "id"},
                { "data": "name" },
                { "data": "realname" },
                { "data": "phone" },
                { "data": "birthday" },
                { "data": "areaName" },
            ],
            "language":{
                "url":"/commons/bootstrap3.3.7/Chinese.json"
            }
        } );
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
</script>
</body>
</html>
