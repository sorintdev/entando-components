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
        <s:text name="name.widget"/>
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


<wpsa:set name="showletConfig" value="showlet.config"/>

<div id="main" role="main">

    <s:set var="breadcrumbs_pivotPageCode" value="pageCode"/>
    <s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp"/>
    <s:action namespace="/do/Page" name="printPageDetails" executeResult="true" ignoreContextParams="true">
        <s:param name="selectedNode" value="pageCode"></s:param>
    </s:action>

    <s:form action="saveConfig" cssClass="form-horizontal">

        <div class="panel panel-default">
            <div class="panel-heading">
                <s:include value="/WEB-INF/apsadmin/jsp/portal/include/frameInfo.jsp"/>
            </div>

            <s:include value="/WEB-INF/apsadmin/jsp/common/inc/messages.jsp"/>

            <s:set var="pageTreeStyleVar"><wp:info key="systemParam" paramName="treeStyle_page"/></s:set>

            <p class="sr-only">
                <wpsf:hidden name="pageCode"/>
                <wpsf:hidden name="frame"/>
                <wpsf:hidden name="widgetTypeCode" value="%{showlet.type.code}"/>
                <wpsf:hidden name="frameIdParam" value="%{#showletConfig.get('frameIdParam')}"/>
                <s:if test="#pageTreeStyleVar == 'classic'">
                    <s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar">
                        <wpsf:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"></wpsf:hidden>
                    </s:iterator>
                </s:if>
            </p>

            <s:if test="%{#showletConfig.get('frameIdParam') == null}">
                <div class="panel-body">
                    <fieldset class="margin-large-top">
                        <legend><s:text name="title.selectSourcePage"/></legend>
                        <div class="form-group<s:property value="#controlGroupErrorClass" />">
                            <label class="col-sm-2 control-label" for="pageCode">
                                <s:text name="title.treePosition"/>
                            </label>
                            <div class="col-sm-10">

                                <s:set var="pageTreeStyleVar"><wp:info key="systemParam" paramName="treeStyle_page"/></s:set>
                                <div class="table-responsive overflow-visible">
                                    <table id="pageTree" class="table table-bordered table-hover table-treegrid">
                                        <thead>
                                            <tr>
                                                <th style="width: 68%;">
                                                    <s:text name="title.pageTree"/>
                                                    <s:if test="#pageTreeStyleVar == 'classic'">
                                                        <button type="button" class="btn-no-button expand-button"
                                                                id="expandAll">
                                                            <i class="fa fa-plus-square-o treeInteractionButtons"
                                                               aria-hidden="true"></i>&#32;Expand All
                                                        </button>
                                                        <button type="button" class="btn-no-button" id="collapseAll">
                                                            <i class="fa fa-minus-square-o treeInteractionButtons"
                                                               aria-hidden="true"></i>&#32;Collapse All
                                                        </button>
                                                    </s:if>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <s:set var="inputFieldName" value="'pageCodeParam'"/>
                                            <s:set var="selectedTreeNode" value="%{#showletConfig.get('pageCodeParam')}"/>
                                            <s:set var="selectedPage" value="%{getPage(#showletConfig.get('pageCodeParam'))}"/>
                                            <s:set var="liClassName" value="'page'"/>
                                            <s:set var="treeItemIconName" value="'fa-folder'"/>

                                            <wpsa:groupsByPermission permission="managePages" var="groupsByPermission"/>

                                            <s:if test="#pageTreeStyleVar == 'classic'">
                                                <wpsa:pageTree allowedGroups="${groupsByPermission}" var="currentRoot" online="false"/>
                                                <s:include value="/WEB-INF/apsadmin/jsp/portal/include/entryPage_treeBuilderPages.jsp"/>
                                            </s:if>
                                            <s:elseif test="#pageTreeStyleVar == 'request'">
                                                <style>
                                                    .table-treegrid span.collapse-icon, .table-treegrid span.expand-icon {
                                                        cursor: pointer;
                                                        display: none;
                                                    }
                                                </style>
                                                <s:set var="treeNodeActionMarkerCode" value="treeNodeActionMarkerCode"/>
                                                <s:set var="targetNode" value="%{parentPageCode}"/>
                                                <s:set var="treeNodesToOpen" value="treeNodesToOpen"/>

                                                <wpsa:pageTree allowedGroups="${groupsByPermission}" var="currentRoot"
                                                               online="false" onDemand="true"
                                                               open="${treeNodeActionMarkerCode!='close'}"
                                                               targetNode="${targetNode}"
                                                               treeNodesToOpen="${treeNodesToOpen}"/>
                                                <s:include value="/WEB-INF/apsadmin/jsp/portal/include/entryPage_treeBuilder-request-linksPages.jsp"/>
                                            </s:elseif>
                                        </tbody>
                                    </table>
                                </div>
                                <s:if test="#hasFieldErrorVar">
                                    <p class="text-danger padding-small-vertical">
                                        <s:iterator value="#fieldErrorsVar">
                                            <s:property/>
                                        </s:iterator>
                                    </p>
                                </s:if>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </s:if>

            <s:else>
                <div class="panel-body">
                    <fieldset class="margin-large-top">
                        <legend><s:text name="title.configuration"/></legend>
                        <s:set var="targetPage" value="%{getPage(#showletConfig.get('pageCodeParam'))}"/>
                        <input type="hidden" name="pageCodeParam" value="<s:property value="%{#targetPage.code}" />"/>
                        <div class="input-group">
                            <strong><s:text name="label.selectedPage"/>:</strong><br/>
                            <s:iterator value="langs" status="rowStatus">
                                <s:if test="#rowStatus.index != 0">, </s:if><span class="monospace">(<abbr
                                    title="<s:property value="descr" />"><s:property
                                    value="code"/></abbr>)</span>&#32;<s:property
                                    value="#targetPage.getTitles()[code]"/>
                            </s:iterator>
                            &#32;
                            <span class="input-group-btn">
                                <wpsf:submit action="reset" value="%{getText('label.reconfigure')}" cssClass="btn btn-info"/>
                            </span>
                        </div>
                        <div class="input-group">
                            <strong><s:text name="label.selectedFrame"/>:</strong><br/>
                            <s:set var="targetFrame" value="%{#showletConfig.get('frameIdParam')}"/>
                            <s:set var="targetShowlet" value="#targetPage.getShowlets()[(#targetFrame - 0)]"/>
                            <s:property value="#targetFrame"/> &ndash;
                            <s:property value="#targetPage.getModel().getFrames()[(#targetFrame - 0)]"/> &ndash;
                            <s:if test="%{#targetShowlet != null}">
                                <s:property value="getTitle(#targetShowlet.type.code, #targetShowlet.type.titles)"/>
                            </s:if>
                            <s:else>
                                <s:text name="note.emptyFrame"></s:text>
                            </s:else>
                            &#32;
                            <span class="input-group-btn">
                                <wpsf:submit action="browseFrames" value="%{getText('label.browseFrames')}" cssClass="btn btn-info"/>
                            </span>
                        </div>
                    </fieldset>
                </div>

            </s:else>
        </div>
        <s:if test="%{#showletConfig.get('frameIdParam') == null}">
            <div class="form-group">
                <div class="col-sm-12 margin-small-vertical">
                    <wpsf:submit action="browseFrames" type="button" cssClass="btn btn-primary pull-right">
                        <s:text name="label.continue"/>
                    </wpsf:submit>
                </div>
            </div>
        </s:if>
        <s:else>
            <div class="form-group">
                <div class="col-sm-12 margin-small-vertical">
                    <wpsf:submit type="button" cssClass="btn btn-primary pull-right">
                        <s:text name="label.save"/>
                    </wpsf:submit>
                </div>
            </div>
        </s:else>

    </s:form>

</div>

<script>
    $(document).ready(function () {
        $("#expandAll").click(function () {
            $(".childrenNodes").removeClass("hidden");
        });
        $("#collapseAll").click(function () {
            $(".childrenNodes").addClass("hidden");
        });
        var isTreeOnRequest = <s:property value="#pageTreeStyleVar == 'request'"/>;
        $('.table-treegrid').treegrid(null, isTreeOnRequest);
        $(".treeRow ").on("click", function (event) {
            $(".treeRow").removeClass("active");
            $(".moveButtons").addClass("hidden");
            $(this).find('.subTreeToggler').prop("checked", true);
            $(this).addClass("active");
            $(this).find(".moveButtons").removeClass("hidden");
        });
    });
</script>
