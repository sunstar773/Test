<%--
  Created by IntelliJ IDEA.
  User: 孙Star
  Date: 2019/9/8
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>日志展示</title>
    <jsp:include page="/commons/jsp/head.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/commons/jsp/nav.jsp"></jsp:include>
<%--条件查询--%>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">日志查询</div>
        <div class="panel-body">
            <%-- 表单--%>
            <form class="form-horizontal" id="userForm">
                <div class="form-group">
                    <label  class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control"   id="tj_loginname"  placeholder="请输入用户名">
                    </div>
                    <label  class="col-sm-2 control-label">真实姓名</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control"   id="tj_realname" placeholder="请输入真实姓名">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">状态</label>
                    <div class="col-sm-4">
                        <input type="radio"   name="status" value="1">成功
                        <input type="radio"   name="status" value="2">失败
                    </div>
                    <label  class="col-sm-2 control-label">操作信息</label>
                    <div class="col-sm-4">
                        <input type="email" class="form-control"   id="tj_info" placeholder="请输入信息">
                    </div>
                </div>
                <div class="form-group">
                    <label  class="col-sm-2 control-label">操作时间</label>
                    <div class="col-sm-4">
                        <div class="input-group">
                            <input type="text" class="form-control form_datetime" id="tj_minJointime" placeholder="开始时间" aria-describedby="basic-addon1">
                            <span class="input-group-addon" id="basic-addon3"><i class="glyphicon glyphicon-calendar"></i></span>
                            <input type="text" class="form-control form_datetime"  id="tj_maxJointime" placeholder="结束时间" aria-describedby="basic-addon1">
                        </div>
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="button" class="btn btn-info" onclick="search()"><i class="glyphicon glyphicon-search"></i>查询</button>
                    <button type="reset" class="btn btn-default" onclick="rest()"><i class="glyphicon glyphicon-repeat"></i>重置</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="container">
    <div class="panel panel-success">
        <div class="panel-heading">日志列表</div>
        <table class="table table-striped table-bordered" id="example" >
            <thead>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>操作信息</th>
                <th>真实姓名</th>
                <th>操作时间</th>
                <th>状态</th>
                <th>信息</th>
                <th>错误信息</th>
                <th>参数详情</th>
            </tr>
            </thead>
            <tfoot>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>操作信息</th>
                <th>真实姓名</th>
                <th>操作时间</th>
                <th>状态</th>
                <th>信息</th>
                <th>错误信息</th>
                <th>参数详情</th>
            </tr>
            </tfoot>
        </table>
    </div>

</div>
<jsp:include page="/commons/jsp/script.jsp"></jsp:include>
<script>
    $(function () {
        innitTable();
        initSearchDate();
    })
    function innitTable(){
        logTable=  $('#example').DataTable( {
            "processing": true,
            "serverSide": true,
            "searching": false,
            "lengthMenu":[5,10,20],
            "ajax": {
                "url": "/queryLogList",
                "type": "POST",
            },
            "columns": [
                { "data": "id"},
                { "data": "userName" },
                { "data": "context" },
                { "data": "realName" },
                { "data": "currDate" },
                { "data": "status" ,render:function (a,b,c,d) {
                        return a==1?"成功":"失败"
                    }},
                { "data": "info" },
                { "data": "errorMsg" },
                { "data": "details",/*,render:function (data, type, row, meta) {
                        var html="";
                        html='<div style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap;width:150px;" title='+data+'>'+data+'</div>';
                        if (data==null){
                            return "没有参数"
                        }else {
                            return html;
                        }

                    }*/ },
            ],
            "createdRow": function( row, data, dataIndex ) {
                if( data.details!=null && data.details.length > 20){//只有超长，才有td点击事件
                    $(row).children('td').eq(8).attr('onclick','javascript:changeShowRemarks(this);');
                }
                $(row).children('td').eq(8).attr('content',data.details);
            },
            "columnDefs" : [   //设置列定义初始化属性
                {
                    "targets": 8,     //告诉这个定义是指向那一列或者那几列
                    "render": function (data, type, row, meta) {
                        if (row.details!=null && row.details.length  > 20) {
                            return getPartialRemarksHtml(row.details);//显示部分信息
                        } else {
                            return row.details;//显示原始全部信息            }
                        }
                    }
                }
            ],

            "language":{
                "url":"/commons/bootstrap3.3.7/Chinese.json"
            }
        } );
    }
    //切换显示备注信息，显示部分或者全部
    function changeShowRemarks(obj){//obj是td
        var content = $(obj).attr("content");
        console.log(content)
        if(content != null && content != ''){
            if($(obj).attr("isDetail") == 'true'){//当前显示的是详细备注，切换到显示部分
                //$(obj).removeAttr('isDetail');//remove也可以
                $(obj).attr('isDetail',false);
                $(obj).html(getPartialRemarksHtml(content));
            }else{//当前显示的是部分备注信息，切换到显示全部
                $(obj).attr('isDetail',true);
                $(obj).html(getTotalRemarksHtml(content));
            }
        }
    }
    //部分备注信息
    function getPartialRemarksHtml(remarks){
        return remarks.substr(0,20) + '&nbsp;&nbsp;<a href="javascript:void(0);" ><b>更多</b></a>';
    }

    //全部备注信息
    function getTotalRemarksHtml(remarks){
        return remarks + '&nbsp;&nbsp;<a href="javascript:void(0);" >收起</a>';    //这样会防止链接跳转到其他页面。这么做往往是为了保留链接的样式，但不让链接执行实际操作
    }



    function  initSearchDate() {
        $("#tj_minJointime").datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: moment.locale('zh-CN'),
            minDate: false, // 最小日期，如'2018/08/15'，则14号及14号前的日期都不可选
            maxDate: false,
            showClear:true
        });
        $("#tj_maxJointime").datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: moment.locale('zh-CN'),
            minDate: false, // 最小日期，如'2018/08/15'，则14号及14号前的日期都不可选
            maxDate: false,
            showClear:true
        });
    }
    /*条件查询*/
    function search() {
        var userName=$("#tj_loginname").val();
        var realName=$("#tj_realname").val();
        var status=$("[name='status']:checked").val();
        var info=$("#tj_info").val();
        var minJointime=$("#tj_minJointime").val();
        var maxJointime=$("#tj_maxJointime").val();
        var p={"userName":userName,"realName":realName,"status":status,"info":info,"mindate":minJointime,"maxdate":maxJointime};
        logTable.settings()[0].ajax.data=p;
        logTable.ajax.reload();
    }
</script>
</body>
</html>
