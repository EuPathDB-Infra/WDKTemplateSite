<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- get wdkRecord from proper scope -->
<c:set value="${sessionScope.wdkRecord}" var="wdkRecord"/>

<!-- display page header with recordClass type in banner -->
<c:set value="${wdkRecord.recordClass.type}" var="recordType"/>
<site:header banner="${recordType}"/>

<EM>This is a customized view for records of type EstRecordClasses.EstRecordClass</EM><br>

<table>
<c:forEach items="${wdkRecord.attributes}" var="attr">
<c:if test="${!attr.value.internal}">
  <tr>
    <td><b>${attr.value.displayName}</b></td>
    <td>
      <c:set var="fieldVal" value="${attr.value.value}"/>
      <!-- need to know if fieldVal should be hot linked -->
      <c:choose>
        <c:when test="${fieldVal.class.name eq 'org.gusdb.wdk.model.LinkValue'}">
          <a href="${fieldVal.url}">${fieldVal.visible}</a>
        </c:when>
        <c:otherwise>
          ${fieldVal}
        </c:otherwise>
      </c:choose>
    </td>
  </tr>
</c:if>
</c:forEach>

<!-- show all tables for record -->
<c:forEach items="${wdkRecord.tables}"  var="tblEntry">
  <tr>
    <td valign="top"><b>${tblEntry.key}</b></td>
    <td>
      <c:set var="tbl" value="${tblEntry.value}"/>

      <!-- show one table -->
      <table border="1" cellspacing="0" cellpadding="2">
        <!-- table header -->
        <tr class="headerRow">
          <c:forEach var="hCol" items="${tbl.fields}">
          <c:if test="${!hCol.internal}">
            <th align="left">${hCol.displayName}</th>
          </c:if>
          </c:forEach>
        </tr>

        <!-- table rows -->
        <c:set var="i" value="0"/>
        <c:forEach var="row" items="${tbl.rows}">

          <c:choose>
            <c:when test="${i % 2 == 0}"><tr class="rowLight"></c:when>
            <c:otherwise><tr class="rowDark"></c:otherwise>
          </c:choose>

            <c:forEach var="rCol" items="${row}">
            <c:if test="${!rCol.value.internal}">

              <!-- need to know if value should be hot linked -->
              <td>
              <c:set var="colVal" value="${rCol.value.value}"/>
              <c:choose>
                <c:when test="${colVal.class.name eq 'org.gusdb.wdk.model.LinkValue'}">
                  <a href="${colVal.url}">${colVal.visible}</a>
                </c:when>
                <c:otherwise>
                  ${colVal}
                </c:otherwise>
              </c:choose>
              </td>

            </c:if>
            </c:forEach>
          </tr>
        <c:set var="i" value="${i +  1}"/>
        </c:forEach>
      </table>
      <!-- close resultList -->
      <c:set var="junk" value="close"/>
    </td>
  </tr>
</c:forEach>

</table>

<site:footer/>
