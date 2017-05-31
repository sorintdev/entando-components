<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<ol class="breadcrumb page-tabs-header breadcrumb-position">
    <li><s:text name="title.pageDesigner"/></li>
    <li>
        <a href="<s:url action="viewTree" namespace="/do/Page" />">
            <s:text name="title.pageManagement"/>
        </a>
    </li>
    <li class="page-title-container">
        <s:text name="name.widget"/>
    </li>
</ol>
<h1 class="page-title-container">
    <div>
        <s:text name="title.configPage"/>
        <span class="pull-right">
            <a tabindex="0" role="button" data-toggle="popover" data-trigger="focus" data-html="true" title=""
               data-content="<s:text name="jpwidgetutils.replicator.help" />" data-placement="left"
               data-original-title="">
                <i class="fa fa-question-circle-o" aria-hidden="true"></i>
            </a>
        </span>
    </div>
</h1>
<div class="text-right">
    <div class="form-group-separator"></div>
</div>
<br>

<div id="main" role="main">

    <s:set var="breadcrumbs_pivotPageCode" value="pageCode"/>
    <s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp"/>
    <s:action namespace="/do/Page" name="printPageDetails" executeResult="true" ignoreContextParams="true">
        <s:param name="selectedNode" value="pageCode"></s:param>
    </s:action>

    <div class="panel panel-default">
        <div class="panel-heading">
            <s:include value="/WEB-INF/apsadmin/jsp/portal/include/frameInfo.jsp"/>
        </div>

        <s:include value="/WEB-INF/apsadmin/jsp/common/inc/messages.jsp"/>

        <div class="panel-body">
            <fieldset class="margin-more-top">
                <legend><s:text name="widget.conf.frame"/></legend>
                <p>
                    <strong><s:text name="note.selectedPage"/></strong>:
                    <s:iterator value="langs" status="rowStatus">
                        <s:if test="#rowStatus.index != 0">,
                        </s:if>
                        <span class="monospace">(<abbr title="<s:property value="descr" />"><s:property value="code"/></abbr>)
                        </span>
                        <s:property value="targetPage.getTitles()[code]"/>
                    </s:iterator>.
                </p>

                <p>
                    <s:text name="note.selectAFrame.msg"/>
                </p>
                <div class="form-group">
                    <label class="col-sm-2 control-label">
                        <s:text name="label.frames"/>
                    </label>
                    <div class="col-sm-10">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover no-mb">
                                <thead>
                                    <tr>
                                        <th><s:text name="name.position" /></th>
                                        <th><s:text name="label.description"/></th>
                                        <th><s:text name="name.widget"/></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="targetPage.getWidgets()" var="showlet" status="rowstatus">
                                        <s:set var="frames" value="targetPage.getModel().getFrames()"></s:set>
                                        <s:set var="showletType" value="#showlet.getType()"></s:set>
                                        <tr>
                                            <td class="rightText">
                                                <s:property value="#rowstatus.index"/>
                                            </td>
                                            <td>
                                                <a href="<s:url action="selectFrame" >
                                                    <s:param name="frame" value="frame"/>
                                                    <s:param name="pageCode" value="pageCode"/>
                                                    <s:param name="widgetTypeCode" value="widgetTypeCode"/>
                                                    <s:param name="pageCodeParam" value="pageCodeParam" />
                                                    <s:param name="frameIdParam" value="#rowstatus.index" />
                                                    </s:url>"><s:property value="targetPage.getModel().getFrames()[#rowstatus.index]"/>
                                                </a>
                                            </td>
                                            <td>
                                                <s:if test='%{getTitle(#showletType.getCode(), #showletType.getTitles())!="" }'>
                                                    <s:property value="%{getTitle(#showletType.getCode(), #showletType.getTitles())}"/>
                                                </s:if>
                                            </td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
</div>