<script type="text/javascript">
    function dealNullUrl(type){
        if(type==1){
            alert("您还没有给改按钮添加事件！");
        }else{
            alert("您还没有给改按钮添加url！");
        }
    }
    function openDetail(id, action,type) {
        debugger
        var title = action == "edit" ? "编辑" : action == "add" ? "添加" : "查看";
        var readonly = action == "edit" ? "" : action == "add" ? "" : "readonly";
        action = action == "add" ? "edit" : action;
        if(type==0){
            var url = __ctx + "/form/formBus/YPT_SYS_NOTIFY_BD/"+action+"?id="+id;
        }
        if(type==1){
            var url = __ctx + "/form/formBus/YPT_MEETING_INFO_BD/"+action+"?id="+id;
        }
        windowUtil.openEdit(url, title, "", 'grid', 400, 300, null, null, id, true);
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
        $('#gridList').datagrid($.extend($defaultOptions,{url:__ctx + '/system/query/queryView/data_HQBZ_WDRC/WDRC2.ht',
            idField : "",
            fitColumns:true,
            queryParams: postData,
            width:100,
            columns:[[

                {title:"类型",field:"TYPE",sortName:"TYPE",sortable:true,align:"center"
                }

                ,
                {title:"日期",field:"DATE",sortName:"DATE",sortable:true,align:"center",formatter:dateFormatter
                }

                ,
                {title:"标题",field:"TITLE",sortName:"TITLE",sortable:true,align:"center"
                }

                ,
                {title:"开始时间",field:"KSTIME",sortName:"KSTIME",sortable:false,align:"center"
                }

                ,
                {title:"结束时间",field:"JSTIME",sortName:"JSTIME",sortable:false,align:"center"
                }

                ,
                {title:"发布人",field:"FBR",sortName:"FBR",sortable:false,align:"center"
                }

                ,
                {title:"接收人",field:"RECEIVER",sortName:"RECEIVER",sortable:false,align:"center"
                }

                ,{ field: 'colManage',  title: '操作', width:0, align: 'center',formatter:managerFormatter}
            ]]
        }));
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
            }else{
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
        var id = row.ID;
        var type=row.TYPE;
        if(type=="通知"){
            sb += "<a class='btn' onClick='openDetail(\"" + id + "\",\"get\","+0+");' herf='javascript:void(0)'><i class='iconfont icon-view'></i>明细</a>";
        }
        if(type=="会议"){
            sb += "<a class='btn' onClick='openDetail(\"" + id + "\",\"get\","+1+");' herf='javascript:void(0)'><i class='iconfont icon-view'></i>明细</a>";
        }
        return sb;
    }
    function dateFormater(value, row, index){
        var fmt = "yyyy年MM月dd日";
        var date = new Date();
        date.setTime(value);
        var o = {
            "M+": date.getMonth() + 1, //月份
            "d+": date.getDate(), //日
            "h+": date.getHours(), //小时
            "m+": date.getMinutes(), //分
            "s+": date.getSeconds(), //秒
            "q+": Math.floor((date.getMonth() + 3) / 3), //季度
            "S": date.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
<div class="easyui-layout" fit="true" scroll="no">
    <div id="gridSearch" class="toolbar-search ">
        <div class="toolbar-head">
            <!-- 顶部按钮 -->
            <div class="buttons">
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
            <form id="searchForm" class="search-form">
                <div class="search-form-box">
                    <div class="row">
                        <div class="col-md-1 col-sm-1 label">类型:</div>
                        <div class="col-md-2 col-sm-2 ">
                            <input type="text" name="TYPE" class="inputText"   />
                        </div>
                        <div class="col-md-1 col-sm-1 label">日期:</div>
                        <div class="col-md-2 col-sm-3 date-group" style="width:22%;">
                            <input type="text" name="beginDATE" placeholder="开始" class="inputText date"   />
                            <input type="text" name="endDATE" placeholder="结束" class="inputText date"   />
                        </div>
                        <div class="col-md-1 col-sm-1 label">标题:</div>
                        <div class="col-md-2 col-sm-2 ">
                            <input type="text" name="TITLE" class="inputText"   />
                        </div>
                        <a class="btn btn-search button-success" id="btnSearch" href="javaScript:void(0)">
                            <i class="iconfont icon-search"></i><span>搜索</span>
                        </a>
                        <a href="javaScript:void(0)" class="btn btn-reset button-default">
                            <i class="iconfont icon-reset"></i><span>重置</span>
                        </a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div id="gridList" class="my-easyui-datagrid" ></div>
</div>