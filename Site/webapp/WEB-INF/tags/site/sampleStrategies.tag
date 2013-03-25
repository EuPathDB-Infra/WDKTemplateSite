<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="random" uri="http://jakarta.apache.org/taglibs/random-1.0" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nested" uri="http://jakarta.apache.org/struts/tags-nested" %>

<c:set var="wdkUser" value="${sessionScope.wdkUser}"/>
<c:set var="version" value="${wdkModel.version}"/>
<c:set var="site" value="${wdkModel.displayName}"/>

<%--  <h1>Sample Strategies</h1>  --%>
<br><br>

<div class="tdText7" style="padding:10px">
<%-------------  Set sample strategy signatures in all sites  ----------------%>
<div class="h2center">Click to import a strategy in your workspace</div>

<table border="0" style="margin-left: auto; margin-right: auto" width="90%">

  <tr align = "center" style="font-weight:bold">
    <td>Strategy name</td>
    <td>Example of</td>
    <td>Description</td>
  </tr>

  <tr align="left">
    <td>
      <a href="javascript:void(0);" title="Click to add this strategy to your workspace" onclick="loadSampleStrat('<c:url value="/im.do?s=13b94652dc25882f"/>');">Genes Expressed in both the Primitive and Adult Definitive Lineages</a>
    </td>
    <td>Simple Strategy</td>
    <td>Find all genes significantly expressed (mRNA levels > 400) in both Primitive and Adult Definitive Erythropoiesis by intersecting the results of two searches.</td>
  </tr>

  <tr align="left">
  <td><a title="Click to add this strategy to your workspace" onclick="loadSampleStrat('<c:url value="/im.do?s=44601689dd701c4c"/>');" href="javascript:void(0);">Genes Expressed in both the Primitive and Adult Definitive Lineages</a></td>
<td>Strategy using Weighted Unions</td>
<td>Find all genes significantly expressed (mRNA levels > 400) in both Primitive and Adult Definitive Erythropoiesis using weighted unions.</td>
</tr>

 <tr align="left">
  <td><a title="Click to add this strategy to your workspace" onclick="loadSampleStrat('<c:url value="/im.do?s=c6f5998c67d4c0e3"/>');" href="javascript:void(0);">Transporters Expressed in the Primitive or Adult Definitive Lineages</a></td>
<td>Nested Strategy</td>
<td>Find all transporters significantly expressed (mRNA levels > 400) in either Primitive or Adult Definitive Erythropoiesis by intersecting the results of a GO Term search with a (nested) strategy that uses a union (see <i>Strategy using Weighted Unions</i> example) to identify all genes expressed in either or both lineages.</td>
</tr>

</table>

</div>
</div>