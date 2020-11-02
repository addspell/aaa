
<script type="text/javascript">
    var role = __currentUserRole.split(",");
    function dealNullUrl(type){
        if(type==1){
            alert("您还没有给改按钮添加事件！");
        }else{
            alert("您还没有给改按钮添加url！");
        }
    }

    function openDetail(id, action,isRead) {
        debugger
        console.log(isRead)
        if(!isRead){
            var readParam = {
                businessId:id,
                readuserId:__currentUserId,
                readuserName:__currentUserFullname,
                readTime:new Date(),
                type:'系统通知'
            }
            console.log(readParam)
            $.ajax({
                url : __ctx+"/hb/read/addReadRecord",
                async : false,
                type : "POST",
                contentType : 'application/json',
                dataType : 'json',
                data :JSON.stringify(readParam),
                success : function(res) {
                    console.log(res)
                }});
        }
        var title = action == "edit" ? "编辑" : action == "add" ? "添加" : "查看";
        var readonly = action == "edit" ? "" : action == "add" ? "" : "readonly";
        action = action == "add" ? "edit" : action;
        var url = __ctx + "/form/formBus/YPT_SYS_NOTIFY_BD/"+action+"?id="+id;
        windowUtil.openEdit(url, title, "", 'grid', 400, 300, null, null, id, true);
    }

    function exports() {
        var url = __ctx + '/system/query/queryViewShowExport?alias=' + alias + "&sqlAlias=" + sqlAlias;

        debugger;
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
        var columns;

        if(isAdmin()){
            columns = [
                {title:"id",field:"id",sortName:"id",hidden:true
                }, {title:"标题",field:"title",sortName:"title",sortable:false,align:"center",width:50,formatter:McFormatter
                },{title:"发布时间",field:"fbsj",sortName:"fbsj",sortable:false,align:"center",width:20,formatter:dateChinessFormatter
                },{title:"发布人",field:"fbr",sortName:"fbr",sortable:false,align:"center",width:15
                },{title:"是否已读",field:"readuserid",sortName:"readuserid",sortable:false,align:"center",width:15,formatter:function(value,row,index){
                        var ret = '';
                        // row.
                        if(value==null || value==''){
                            ret = "未读";
                        }else{
                            ret = "已读";
                        }
                        return ret;
                    }
                },{ field: 'colMana',  title: '操作', width:15, align: 'center',formatter:managerFormatter}]
        }else{
            columns = [
                {title:"id",field:"id",sortName:"id",hidden:true
                }, {title:"标题",field:"title",sortName:"title",sortable:false,align:"center",width:50,formatter:McFormatter
                },{title:"发布时间",field:"fbsj",sortName:"fbsj",sortable:false,align:"center",width:20,formatter:dateChinessFormatter
                },{title:"发布人",field:"fbr",sortName:"fbr",sortable:false,align:"center",width:15
                },{title:"是否已读",field:"readuserid",sortName:"readuserid",sortable:false,align:"center",width:15,formatter:function(value,row,index){
                        var ret = '';
                        if(value==null || value==''){
                            ret = "未读";
                        }else{
                            ret = "已读";
                        }
                        return ret;
                    }
                }]
        }
        var url = __ctx + '/mobile/engine/notice/getReadSituation?readuserId='+ __currentUserId

        $('#gridList').datagrid($.extend($defaultOptions,{
            //url:__ctx + '/system/query/queryView/data_YPT_SYS_NOTIFY_SQLCX/YPT_SYS_NOTIFY_VIEW.ht',
            url:url,
            idField : "ID",
            fitColumns:true,
            queryParams: postData,
            width:100,
            columns:[columns]
        }));
    }
    function McFormatter(value,row,index){
        if(value){
            var isRead = row.readuserid?true:false;
            return "<a javascript:void(0) onClick=openDetail('"+row.id+"','get',"+isRead+")>"+value+"</a>";
        }
        return "";
    }
    function managerFormatter(value,row,index){
        var aryJson=[];
        var sb="";
        for(var i=0;i<aryJson.length;i++){
            var obj=aryJson[i];
            var url=obj.url;
            var name=obj.name;


            if(obj.triggerType=="onclick"){
                if(!url){
                    sb+= "<a style='margin-left:5px' href='javaScript:void(0)' onclick='dealNullUrl(1)' >"+name+"</a>";
                }else{
                    sb+= "<a style='margin-left:5px' href='javaScript:void(0)' onclick='"+url+"' >"+name+"</a>";
                }
            }
            else{
                if(!url){
                    sb+= "<a style='margin-left:5px' href='javaScript:void(0)' onclick='dealNullUrl(0)' >"+name+"</a>";
                }else{
                    if(!url.startWith("http")){
                        url =__ctx + url;
                    }
                    sb+= "<a style='margin-left:5px' href='"+url+"' target='_blank'>"+name+"</a>";
                }
            }

        }
        var id = row.id;
        var isRead = row.readuserid?true:false;
        sb+="<a class='btn' onClick='openDetail(\"" + id + "\",\"edit\","+isRead+");' herf='javascript:void(0)'><i class='iconfont icon-edit'></i>编辑</a>";
        sb += "<a class='btn' onClick='delData(\"" + id + "\");' herf='javascript:void(0)'><i class='iconfont icon-delete'></i>删除</a>";

        return sb;
    }
    function delData(id){
        $.ajax({
            type : "POST",
            url : __ctx + "/form/formBus/YPT_SYS_NOTIFY_BD/remove?id=ID",
            data: {'ID':id},
            dataType : "json",
            success : function(data) {
                $('#gridList').datagrid('reload');
                parent.parent.loadTabIframe({name:'首页',url:__ctx+getCurrentUser('homeurl')});
                $.topCall.alert('删除成功');

            },
            error : function(data) {
                $.topCall.error('删除失败！');
            }
        });
    }
    function drawingOperation(){
        if(isAdmin()){
            var html = '<a class="btn" id="add" href="javascript:void(0)" onclick="openDetail(\'\',\'add\')"> <i class="iconfont icon-add"></i><span>添加</span> </a>';
            $("#Operation").append(html);
        }

    }
    function isAdmin(){
        for(var i=0;i<role.length;i++){
            if(role[i] == 10000001260105 || role[i] == 10000000010004){
                return true;
                break;
            }else{
                return false;
            }
        }
    }
    $(function(){
        drawingOperation();
    });

</script>
<div class="easyui-layout" fit="true" scroll="no">
    <div id="gridSearch" class="toolbar-search ">
        <div class="toolbar-head">
            <!-- 顶部按钮 -->
            <div class="buttons" id="Operation">



                <a class="btn"  onclick="exports()" href="javaScript:void(0)" >
                    <i class="iconfont icon-export"></i><span>导出</span>
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
                        <div class="col-md-1 col-sm-1 label">标题:</div>
                        <div class="col-md-2 col-sm-2 ">
                            <input type="text" name="title" class="inputText"   />
                        </div>
                        <div class="col-md-6 col-sm-4">
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
                        <div class="col-md-1 col-sm-1 label">发布时间:</div>
                        <div class="col-md-3 col-sm-4 date-group">
                            <input type="text" name="beginFbsj" class="wdateTime dateText" readonly="readonly" datefmt="yyyy-MM-dd" placeholder="开始时间"/>
                            <input type="text" name="endFbsj" class="wdateTime dateText" readonly="readonly" datefmt="yyyy-MM-dd" placeholder="结束时间"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="gridList" class="my-easyui-datagrid" ></div>
</div>