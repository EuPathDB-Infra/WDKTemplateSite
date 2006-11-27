<?xml version="1.0" standalone="yes"?> <%-- This has to be the first line! --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% response.setHeader("Content-Type", "text/xml"); %>

<c:set var="zipCode" value="${param.zip}"/>

<c:choose>
<c:when test="${zipCode == 19104}">
    <zip><city>Philadelphia</city><state>PA</state></zip></c:when>
<c:when test="${zipCode == 19406}">
    <zip><city>King of Prussia</city><state>PA</state></zip></c:when>
<c:when test="${zipCode == 19703}">
    <zip><city>Claymont</city><state>DE</state></zip></c:when>
<c:when test="${zipCode == 11724}">
    <zip><city>Cold Spring Harbor</city><state>NY</state></zip></c:when>
<c:when test="${zipCode == 8628}">
    <zip><city>Trenton</city><state>NJ</state></zip></c:when>
<c:otherwise>
    <zip>invalid zip code: ${zipCode}</zip></c:otherwise>
</c:choose>
