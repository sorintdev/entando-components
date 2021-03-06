<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="i18n_parent_attribute_name"><s:property value="#attribute.name" /></s:set>

<s:set var="masterCompositeAttributeTracer" value="#attributeTracer" />
<s:set var="masterCompositeAttribute" value="#attribute" />
<s:iterator value="#attribute.attributes" var="attribute">
	<s:set var="attributeTracer" value="#masterCompositeAttributeTracer.getCompositeTracer(#masterCompositeAttribute)"></s:set>
	<s:set var="parentAttribute" value="#masterCompositeAttribute"></s:set>
	<s:set var="i18n_attribute_name">jpaddressbook_ATTR<s:property value="%{i18n_parent_attribute_name}" /><s:property value="#attribute.name" /></s:set>
	<s:set var="attribute_id">jpaddressbook_<s:property value="%{i18n_parent_attribute_name}" /><s:property value="#attribute.name" /></s:set>
	
	<s:include value="/WEB-INF/plugins/jpaddressbook/aps/jsp/internalServlet/inc/iteratorAttribute.jsp" />

</s:iterator>
<s:set var="attributeTracer" value="#masterCompositeAttributeTracer" />
<s:set var="attribute" value="#masterCompositeAttribute" />
<s:set var="parentAttribute" value=""></s:set>