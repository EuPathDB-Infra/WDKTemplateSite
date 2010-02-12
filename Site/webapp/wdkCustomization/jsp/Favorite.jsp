<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="w" uri="http://www.servletsuite.com/servlets/wraptag" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="wdkUser" value="${sessionScope.wdkUser}"/>

<!-- display page header with recordClass type in banner -->
<site:header banner="Favorite page"/>

<c:set var="favorites" value="${wdkUser.favorites}" />
<c:choose>
	<c:when test="${fn:length(favorites) == 0}">
		<p>You don't have any favorite records. You can create favorite record on the record page.</p>
	</c:when>
	<c:otherwise> <%-- has favorites --%>
		<c:forEach var="fav_item" items="${favorites}">
			<c:set var="favorite" value="${fav_item.value}" />
			<c:set var="recordClass" value="${favorite.recordClass}" />
			<div class="favorite">
				<h3>My Favorite ${recordClass.type} records (${favorite.count} records)</h3>
				<table class="favorite-list">
					<tr><th></th><th>Record</th></tr>
					<c:forEach var="record" items="${favorite.recordInstances}">
						<tr>
							<c:set var="primaryKey" value="${record.primaryKey}"/>
							<c:set var="pkValues" value="${primaryKey.values}" />
							<c:set var="url" value="/showRecord.do?recordClass=${recordClass.fullName}">
							<c:forEach var="pk_item" items="${pkValues}">
								<c:set var="url" value="${url}&${pk_item.key}=${pk_item.value}" />
							</c:forEach>
							<td><a href="<c:url value='${url}' />">${primaryKey.value}</a></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</c:forEach>
	</c:otherwise> <%-- END has favorites --%>
</c:choose>

<site:footer/>
