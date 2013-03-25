<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<c:set var="wdkUser" value="${sessionScope.wdkUser}"/>
<c:set var="wdkModel" value="${applicationScope.wdkModel}"/>

<%-- <imp:helpStrategies wdkModel="${wdkModel}" wdkUser="${wdkUser}" /> --%>

<imp:helpStrategies />
