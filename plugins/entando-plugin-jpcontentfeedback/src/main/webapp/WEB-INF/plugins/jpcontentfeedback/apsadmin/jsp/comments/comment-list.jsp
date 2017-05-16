<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<ol class="breadcrumb page-tabs-header breadcrumb-position">
    <li><s:text name="breadcrumb.integrations"/></li>
    <li><s:text name="breadcrumb.integrations.components"/></li>
    <li><s:text name="jpcontentfeedback.title.commentsManager"/></li>
    <li class="page-title-container"><s:text name="jpcontentfeedback.title.comment.list"/></li>
</ol>

<div class="page-tabs-header">
    <div class="row">
        <div class="col-sm-6">
            <h1>
                <s:text name="jpcontentfeedback.title.commentsManager"/>
                <span class="pull-right">
                <a tabindex="0" role="button" data-toggle="popover" data-trigger="focus" data-html="true" title=""
                   data-content="TO be inserted" data-placement="left" data-original-title="">
                    <i class="fa fa-question-circle-o" aria-hidden="true"></i>
                </a>
                </span>
            </h1>
        </div>
        <wp:ifauthorized permission="superuser">
            <div class="col-sm-6">
                <ul class="nav nav-tabs nav-justified nav-tabs-pattern">
                    <li class="active">
                        <a href="<s:url action="list" namespace="/do/jpcontentfeedback/Comments" />">
                            <s:text name="jpcontentfeedback.admin.menu.contentFeedback"/>
                        </a>
                    </li>
                    <li>
                        <a href="<s:url action="edit" namespace="/do/jpcontentfeedback/Config" />">
                            <s:text name="jpcontentfeedback.admin.menu.contentFeedback.edit"/>
                        </a>
                    </li>
                </ul>
            </div>
        </wp:ifauthorized>
    </div>
</div>
<br>


<div id="main">

    <s:form action="search" cssClass="form-horizontal">
        <s:include value="/WEB-INF/apsadmin/jsp/common/inc/messages.jsp"/>

        <div class="searchPanel form-group">
            <div class="well col-md-offset-3 col-md-6">
                <p class="search-label"><s:text name="label.search.by"/>&#32;<s:text
                        name="jpcontentfeedback.status"/></p>
                <div class="form-group">
                    <div class="col-sm-12 has-clear">
                        <s:set var="allStatus" value="%{getAllStatus()}"/>
                        <wpsf:select cssClass="form-control input-lg" list="#allStatus" name="status" id="status"
                                     listKey="key" listValue="value" headerKey=""
                                     headerValue="%{getText('label.all')}"/>
                    </div>
                </div>
                <div class="panel-group" id="accordion-markup">
                    <div class="panel panel-default">
                        <div class="panel-heading" style="padding:0 0 10px;">
                            <p class="panel-title active" style="text-align: end">
                                <a data-toggle="collapse" data-parent="#accordion-markup"
                                   href="#collapseFeedbackSearch">
                                    <s:text name="label.search.advanced"/>
                                </a>
                            </p>
                        </div>
                        <div id="collapseFeedbackSearch" class="panel-collapse collapse form-horizontal">
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="author" class="control-label col-sm-2">
                                        <s:text name="jpcontentfeedback.author"/>
                                    </label>
                                    <div class="col-sm-10">
                                        <wpsf:textfield name="author" id="author" cssClass="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="from_cal" class="control-label col-sm-2">
                                        <s:text name="jpcontentfeedback.date.from"/>
                                    </label>
                                    <div class="col-sm-10">
                                        <wpsf:textfield name="from" id="from_cal" value="%{from}"
                                                        cssClass="form-control datepicker"/>
                                        <span class="help-block">dd/MM/yyyy</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="to_cal" class="control-label col-sm-2">
                                        <s:text
                                                name="jpcontentfeedback.date.to"/>
                                    </label>
                                    <div class="col-sm-10">
                                        <wpsf:textfield name="to" id="to_cal" value="%{to}"
                                                        cssClass="form-control datepicker"/>
                                        <span class="help-block">dd/MM/yyyy</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-12">
                    <div class="form-group">
                        <wpsf:submit type="button" cssClass="btn btn-primary pull-right"
                                     title="%{getText('label.search')}">
                            <span class="sr-only"><s:text name="%{getText('label.search')}"/></span>
                            <s:text name="label.search"/>
                        </wpsf:submit>
                    </div>
                </div>
            </div>
        </div>
        <hr>

        <%--TODO--%>

        <div class="subsection-light">

            <wpsa:subset source="commentIds" count="10" objectName="groupComment" advanced="true" offset="5">
                <s:set var="group" value="#groupComment"/>


                <s:set var="lista" value="commentIds"/>
                <s:if test="!#lista.empty">
                    <table class="table table-bordered">
                        <tr>
                            <th><s:text name="jpcontentfeedback.author"/></th>
                            <th class="text-center"><s:text name="jpcontentfeedback.date.creation"/></th>
                            <th><s:text name="jpcontentfeedback.status"/></th>
                            <th class="text-center"><s:text name="label.actions"/></th>
                        </tr>
                        <s:iterator var="commentoId">
                            <tr>
                                <s:set var="commento" value="%{getComment(#commentoId)}"/>
                                <td><code><s:property value="#commento.username"/></code></td>
                                <td class="text-center"><code><s:date name="#commento.creationDate"
                                                                      format="dd/MM/yyyy HH:mm"/></code></td>
                                <td><s:text name="%{'jpcontentfeedback.label.' + #commento.status}"/></td>
                                <td class="text-center">
                                    <div class="btn-group btn-group-xs">
                                        <a class="btn btn-default"
                                           title="<s:text name="label.edit" />:&#32;<s:date name="#commento.creationDate" format="dd/MM/yyyy HH:mm" />"
                                           href="<s:url action="view"><s:param name="selectedComment" value="#commentoId" /></s:url>">
                                            <span class="icon fa fa-pencil-square-o"></span>
                                            <span class="sr-only"><s:text name="label.edit"/>: <s:property
                                                    value="#ideaInstance_var.code"/></span>
                                        </a>
                                    </div>
                                    <div class="btn-group btn-group-xs margin-small-left">
                                        <a class="btn btn-warning btn-xs"
                                           href="<s:url action="trash"><s:param name="selectedComment" value="#commentoId" /></s:url>"
                                           title="<s:text name="label.remove" />:&#32;<s:date name="#commento.creationDate" format="dd/MM/yyyy HH:mm" />">
                                            <span class="sr-only"></span>
                                            <span class="icon fa fa-times-circle-o"></span>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </s:iterator>
                    </table>
                    <div class="pager">
                        <s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp"/>
                        <s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp"/>
                    </div>
                </s:if>
                <s:else>
                    <p><s:text name="jpcontentfeedback.note.list.empty"/></p>
                </s:else>

            </wpsa:subset>
        </div>
    </s:form>
</div>