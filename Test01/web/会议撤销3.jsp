<script type="text/javascript">
    function dealNull789(type){
        if(type==1){
            alert("您还没有给改按钮添加事件！");
        }else{
            alert("您还没有给改按钮添加url！");
        }
    }
    function STARTTIME_DFormater(value, row, index){
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

    /**
     *会议主题格式化函数,返回超链接,可以点击打开会议详情界面
     */
    function HYINFOFormatter(value,row,index){
        if(value){
            var title=value;
            console.log(row.HYWJ);
            if($.trim(row.HYWJ )!="" && row.HYWJ != undefined){
                title=title+"<span style='color: red;'>(附件)</span>";
            }
            return "<a onClick='openDetail(\"" + row.ID + "\",\"get\",\"" + row.SENDBACK + "\");' herf='javascript:void(0)'>"+title+"</a>";
        }
        return "";
    }



    function dealNullUrl(type){
        if(type==1){
            alert("您还没有给改按钮添加事件！");
        }else{
            alert("您还没有给改按钮添加url！");
        }
    }
    var mType = !!__param.M_TYPE ?  __param.M_TYPE : "";

    function openDetail(id, action,sendBack) {
        var title = action == "edit" ? "编辑" : action == "add" ? "添加" : "查看";
        var readonly = action == "edit" ? "" : action == "add" ? "" : "readonly";
        action = action == "add" ? "edit" : action;
        var url = __ctx + "/form/formBus/OA_HYXX_BD/"+action+"?id="+id+"&M_TYPE="+mType;
        if(action=="get"){
            url=__ctx + "/env/meeting/meetingInfo"+"?id="+id+"&M_TYPE="+mType+"&sendBack="+sendBack;
        }
        windowUtil.openEdit(url, title, "", 'grid', 400, 300, null, null, id, true);
    }

    //打开管理员审核会议室界面
    function openSHDetail(id, action) {
        var title = action == "edit" ? "编辑" : action == "add" ? "添加" : "查看";
        var readonly = action == "edit" ? "" : action == "add" ? "" : "readonly";
        action = action == "add" ? "edit" : action;
        var url = __ctx + "/form/formBus/OA_HYXXSH_430121_BD/"+action+"?id="+id;
        windowUtil.openEdit(url, title, "", 'grid', 400, 300, null, null, id, true);
    }
    //查看审核不通过原因
    function openYY(yy,hys) {
        if(yy=="undefined"){
            $.topCall.success("原因:无",{},"审核未通过");
        }else{
            $.topCall.success("原因:"+yy,{},"审核未通过",);
        }
    }
    //删除会议记录
    function deleteData(id){

        debugger

        $.topCall.confirm('确定要删除吗？', function(r){
            if(r){

                $.ajaxSettings.async = false;
                $.post(__ctx+"/meeting/deleteMeeting?id="+id,function(data,status) {
                    if(data){
                        $.topCall.success("删除成功！");
                        jqGridInit();
                    }else{
                        $.topCall.error('操作失败，请重试');
                    }

                });

            }else{

            }
        });


        /*
          $.topCall.confirm("提示信息","确定要删除此条会议记录吗？", function(r) {
            if (r){
              parm={id:id};
              $.ajax({
                type:"POST",
                async:false,
                url:__ctx+"/meeting/deleteMeeting",
                data:parm,
                dataType:'json',
                success:function(result){
                  if(result){
                      $.topCall.success("删除成功");
                    jqGridInit();
                  }else{
                    $.topCall.error("删除失败");
                  }
                },
                error:function(result){
                      $.topCall.error("删除失败"+result);
                }
              });
            }
          });
          */




    }
    function exports() {
        var url = __ctx + '/system/query/queryViewShowExport?alias=' + alias + "&sqlAlias=" + sqlAlias;
        var params = $("#searchForm").serializeArray();
        var data = {};
        $(params).each(function() {
            var name = this.name, value = this.value, str = '{"' + name + '":"' + value + '"}';
            if (value != '') {
                var json = eval('(' + str + ')');
                data = $.extend(data, json);
            }
        });
        var dialog;
        var def = {
            passConf : jQuery.extend({
                search : true,
            }, data),
            title : "导出设置",
            width : "800",
            height : "600",
            modal : true,
            resizable : true,
        };
        dialog = $.topCall.dialog({
            src : url,
            base : def
        });
    }

    function showCustomDialog(obj, alias, resultField) {
        CustomDialog.openCustomDialog(alias, function(data, dialog) {
            dialog.dialog('close');
            if (data.length > 0) {
                $(obj).prev().val(data[0][resultField]);
            } else {
                $(obj).prev().val("");
            }
        });
    }


    function jqGridInit() {
        $('#gridList').datagrid($.extend($defaultOptions,{
            url:__ctx + '/system/query/queryView/data_OA_HYXX_SQLCX/OA_HYXX_ST.ht?M_TYPE='+mType,
            idField : "ID",
            fitColumns:true,
            //queryParams: postData,
            width:100,
            columns:[[


                // {field : "ID",sortName:"ID",checkbox : true}

                // ,
                {title:"行政区",field:"XZQDM",sortName:"XZQDM",sortable:false,align:"center",width:7,formatter:XZQDMShow

                }

                ,

                {title:"会议主题",field:"HYZT",sortName:"HYZT",sortable:false,align:"center",width:30
                    ,formatter:HYINFOFormatter
                }

                ,
                {title:"会议类型",field:"HYLX",sortName:"HYLX",sortable:false,align:"center",width:15
                    ,formatter:HYLXShow
                }

                ,
                {title:"会议开始日期",field:"STARTTIME",sortName:"STARTTIME",sortable:false,align:"center",width:15
                    ,formatter:STARTTIME_DFormater
                }

                ,
                {title:"会议开始时间",field:"HYKSSJ",sortName:"HYKSSJ",sortable:false,align:"center",width:10
                }

                ,
                {title:"会议地点",field:"HYDZ",sortName:"HYDZ",sortable:false,align:"center",width:15
                }

                ,
                {title:"召会单位（人）",field:"HYFBDW",sortName:"HYFBDW",sortable:false,align:"center",width:10
                }

                // ,
                // {title:"会议室审核状态",field:"HYSSHZT",sortName:"HYSSHZT",sortable:false,align:"center",width:10
                //     ,formatter:HYSSHZTShow
                // }
                ,
                {title:"会议状态",field:"HYJSSJ",sortName:"HYKSSJ",sortable:false,align:"center",width:10
                    ,formatter:mettingStatusFormatter
                }
                ,  { field: 'colMana',  title: '操作', width:0, align: 'center',formatter:managerFormatter}
            ]]
        }));
    }

    function mettingStatusFormatter(value,row,index) {
        if(row.HYSSHZT=='3') {
            return '已撤销';
        }
        return getMettingStatus(value,row,index).msg;
    }

    function getMettingStatus(value,row,index) {
        var ret = {};
        if(row.MEETINGTYPE == '2') {
            ret = {status:2,msg:"未开始"};//"未开始";
        } else if(row.MEETINGTYPE == '1') {
            ret = {status:1,msg:"会议中"};//"会议中";
        } else if(row.MEETINGTYPE == '0') {
            ret = {status:0,msg:"已结束"};//"已结束"
        }
        //} else if(startTime>nowDate) {
        //  ret = {status:2,msg:"未开始"};//"未开始"
        //}
        return ret;
    }

    var dateUtil = {
        getFormartDateTime(date,time) {
            var newDate = new Date();
            if(!!date) {
                newDate.setTime(date);
                if(!!time) {
                    var timeArr = time.split(":");
                    newDate.setHours(timeArr[0]);
                    newDate.setMinutes(timeArr[1]);
                }

            }
            return newDate.getTime();
        },
        getToday: function(type,time) {
            var now = new Date();
            if(!!time){now.setTime(time);}
            if (type == 'start') {
                now.setHours(0);
                now.setMinutes(0);
                now.setSeconds(0);
            } else if (type == 'end') {
                now.setHours(23);
                now.setMinutes(59);
                now.setSeconds(59);
            }
            return now;
        },
    }
    //会议类型转换
    function HYLXShow(value,row,index){
        if(value==0){
            if(row.M_TYPE_TERM == "long") {
                return "内部会议 (长期)";
            }else{
                return "内部会议 (短期)";
            }
        }else if(value==1){
            if(row.M_TYPE_TERM == "long") {
                return "外部会议 (长期)";
            }else{
                return "外部会议 (短期)";
            }
        }else{
            return "";
        }
    }
    //行政区转换
    function XZQDMShow(value,row,index){
        if(value==410000){
            return "湖南省";
        }else if(value==1){
            return "湖南省外";
        }else if(value==430121){
            return "长沙县";
        }else{
            return "其他地区";
        }
    }
    //根据当前会议室申请审核状态展示不同功能
    function HYSSHZTShow(value,row,index){
        var result="";
        if(value==0 ){
            //除系统管理员以外，用户是只能审核本人所在行政区的会议室申请
            if(row.XZQDM==__currentUserXzqCode || __currentUserId == "1"){
                result = "<a class='btn btn-default fa fa-edit' onClick='openSHDetail(\"" + row.ID + "\",\"edit\");' herf='javascript:void(0)'>待审核</a>";
            }else{
                result = "待审核";
            }
        }else if(value==1){
            if(row.HYLX==0){
                result = "审核通过";
                //系统管理员可对已审核的会议重新审核
                if(__currentUserId=="1"){
                    //result += " / <a class='fa fa-edit' onClick='openSHDetail(\"" + row.ID + "\",\"edit\");' herf='javascript:void(0)' title='重新审核'></a>"
                }
            }else{
                result = "——";
            }
        }else if(value==2){
            //result = "<a onClick='openSHDetail(\"" + row.ID + "\",\"get\");' herf='javascript:void(0)'>审核不通过</a>";
            //用户可查看申请不通过原因
            result = "<a onClick='openYY(\"" + row.HYSSHYY + "\",\"" + row.HYDZ + "\");' herf='javascript:void(0)'>审核不通过</a>";
            //系统管理员可对已审核的会议重新审核
            if(__currentUserId == "1"){
                //result += " / <a class='fa fa-edit' onClick='openSHDetail(\"" + row.ID + "\",\"edit\");' herf='javascript:void(0)' title='重新审核'></a>"
            }
        }else{
            result= "——";
        }
        return result;
    }


    function revokeMetting(HYSINST_ID) {
        console.log(HYSINST_ID)
        $.topCall.confirm('是否撤销？', function(r){
            if(r){
                $.ajaxSettings.async = false;
                $.post(__ctx+"/meeting/updateMeeting?HYSSHZT="+"3&ID="+HYSINST_ID,function(data,status) {
                    if(data){
                        $.topCall.success("撤销成功！");
                        jqGridInit();
                    }else{
                        $.topCall.error('撤销失败！');
                    }

                });

            }else{

            }
        });
    }

    function managerFormatter(value,row,index){
        var sb="";
        console.log(row);
        var id = row.ID;
        //系统管理员可对所有会议记录进行编辑和删除
        if(__currentUserId==1){
            var status = getMettingStatus(value,row,index).status;
            if(status==2 && row.HYSSHZT!="3"){
                sb+="<a class='btn btn-default fa fa-edit' onClick='revokeMetting(\"" + row.HYSINST_ID + "\");' herf='javascript:void(0)'>撤销</a>";
            } else {
                sb +='—';
            }
            //sb+="<a class='btn btn-default fa fa-edit' onClick='openDetail(\"" + id + "\",\"edit\");' herf='javascript:void(0)'>编辑</a>";
            //sb+="<a class='btn btn-default fa fa-edit' onClick='deleteData(\"" + id + "\");' herf='javascript:void(0)'>删除</a>";
        }else{

            //该条会议的添加人员可在会议申请未审核前对记录进行修改和删除（内部会议会议室才需要审核）
            // if(row.HYLRRID==__currentUserId){//
            //
            if((row.HYSSHZT!=3 && row.HYLX==0) || (row.HYSSHZT!=3 && row.HYLX==1)){
                var status = getMettingStatus(value,row,index).status;
                if(status==2 && row.HYSSHZT!="3"){
                    sb+="<a class='btn btn-default fa fa-edit' onClick='revokeMetting(\"" + row.HYSINST_ID + "\");' herf='javascript:void(0)'>撤销</a>";
                }else{
                    sb +='—';
                }
                //sb+="<a class='btn btn-default fa fa-edit' onClick='openDetail(\"" + id + "\",\"edit\");' herf='javascript:void(0)'>编辑</a>";
                //sb+="<a class='btn btn-default fa fa-edit' onClick='deleteData(\"" + id + "\");' herf='javascript:void(0)'>删除</a>";
            }else{
                sb +='—';
            }
            //}else{
            //    sb +='—';
            //}
        }
        return sb;
    }

    function showHyap(){
        var title = "会议安排";
        var url = __ctx + "/env/meeting/meetingRoomView?id=null&M_TYPE="+mType;
        //var def = {title : '查看会议室',width : 1350,height : 600,modal : true,resizable : false,iconCls : 'fa fa-table',maximizable:true};
        //$.topCall.dialog({src:url,base : def});
        window.openEdit(url, title, "", 'grid', 400, 300, null, null, "test", true);
    }

</script>
<div class="easyui-layout" fit="true" scroll="no">
    <div id="gridSearch" class="toolbar-search ">
        <div class="toolbar-head">
            <!-- 顶部按钮 -->
            <div class="buttons">
                <a class="btn" id="add" href="javascript:void(0)" onclick="openDetail('','add')">
                    <i class="iconfont icon-add"></i><span>添加</span>
                </a>
                <a class="btn" href="javascript:void(0)" onclick="showHyap()">
                    <i class="iconfont icon-view"></i><span>查看会议室</span>
                </a>
            </div>
            <div class="tools">
                <a href="javascript:;" class="collapse">
                    <i class=" fa  fa-angle-double-up"></i>
                </a>
            </div>
        </div>
        <div class="toolbar-body">
            <div class="search-form-box">
                <form id="searchForm" class="search-form">
                    <div class="row">
                        <div class="col-md-1 col-sm-1 label">会议主题:</div>
                        <div class="col-md-2 col-sm-2 " >
                            <input type="text" name="HYZT" class="inputText"   />
                        </div>
                        <!--<div class="col-md-1 col-sm-1 label">会议类型:</div>
                        <div class="col-md-1 col-sm-1 ">
                            <select class="inputText" name="HYLX" >
                                <option value="">全部</option>
                                <option value="0">内部会议</option>
                                <option value="1">外部会议</option>
                            </select>
                        </div>-->

                        <div class="col-md-1 col-sm-1 label">会议日期:</div>
                        <div class="col-md-2 col-sm-3 date-group" style="width:22%;">
                            <input type="text" name="beginSTARTTIME" placeholder="开始日期" class="inputText date" />
                            <input type="text" name="endSTARTTIME" placeholder="结束日期" class="inputText date"  />
                        </div>



                        <div class="col-md-3 col-sm-4">
                            <a class="btn btn-search button-success" href="javaScript:void(0)">
                                <i class="iconfont icon-search"></i><span>查询</span>
                            </a>
                            <a href="javaScript:void(0)" class="btn btn-reset button-default">
                                <i class="iconfont icon-reset"></i><span>重置</span>
                            </a>
                            <a href="javaScript:void(0)" class="btn btn-more button-info">
                                <i class="iconfont icon-more"></i><span>更多</span>
                            </a>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1 col-sm-1 label">会议状态:</div>
                        <div class="col-md-2 col-sm-2 ">
                            <select class="inputText" name="MEETINGTYPE" id="MEETINGTYPE">
                                <option value="" selected>全部</option>
                                <option value="3" >撤销</option>
                                <option value="2">未开始</option>
                                <option value="0">已结束</option>
                                <option value="1">会议中</option>
                            </select>
                        </div>
                        <div class="col-md-1 col-sm-1 label">行政区:</div>
                        <div class="col-md-2 col-sm-2 ">
                            <div class="dic-dropdown" dic-key="XZQBM">
                                <input type="hidden" name="XZQDM"/>
                                <div class="dropdown">
                                    <input type="text" readonly="readonly" style="padding-right:7px;background-color:white;cursor: pointer;" placeholder="请选择" data-toggle="dropdown" />
                                    <i style="position:absolute;right:5px;top:5px;" class="iconfont icon-square-down"></i>
                                    <div class="dropdown-menu" style="width: 100%;">
                                        <ul id="" class="ztree" style="max-height:300px;overflow-y:auto"></ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="gridList" class="my-easyui-datagrid" ></div>
</div>