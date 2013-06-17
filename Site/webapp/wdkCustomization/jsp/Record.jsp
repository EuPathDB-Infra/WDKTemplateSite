<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  <!-- get wdkRecord from proper scope -->
  <c:set value="${requestScope.wdkRecord}" var="wdkRecord"/>

  <!-- display page header with recordClass type in banner -->
  <c:set value="${wdkRecord.recordClass.displayName}" var="recordType"/>

<imp:header refer="record" headElement="${recordType} Record page"/>

<imp:record record="${wdkRecord}"/>

<imp:footer />

