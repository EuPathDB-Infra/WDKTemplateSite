<%@ taglib prefix="imp" tagdir="/WEB-INF/tags/imp" %>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="nested" uri="http://jakarta.apache.org/struts/tags-nested" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- get wdkXmlAnswer saved in request scope -->
<c:set var="xmlAnswer" value="${requestScope.wdkXmlAnswer}"/>

<c:set var="banner" value="${xmlAnswer.question.displayName}"/>

<c:set var="wdkModel" value="${applicationScope.wdkModel}"/>

<imp:header title="${wdkModel.displayName}: FAQ"/>

<div style="margin-top: -6px; padding-left:20px; padding-right:20px; padding-top:10px">


  <h1 style="text-align:left; margin-left:0; font-size:16pt">WDK Template FAQ</h1>
  <p>Here are some questions and answers about the WDK Template Website.</p>

  <div style="margin-left:50px;border-left:solid 2px #460101">
    
    <!-- list of questions -->
    
    <ul style="margin-left:25px">
      <c:forEach items="${xmlAnswer.recordInstances}" var="record">
	<c:set var="question" value="${record.attributesMap['question']}"/>
	<c:set var="tag" value="${record.attributesMap['tag']}"/>
	<li><a href="#${tag}">${question}</a></li>
      </c:forEach>
    </ul>
    
  </div>

  <%-- second pass, show the records --%>
  <c:set var="i" value="0"/>
  <c:set var="alreadyPrintedSomething" value="false"/>
  <c:forEach items="${xmlAnswer.recordInstances}" var="record">

    <c:if test="${alreadyPrintedSomething}">&nbsp;</c:if>
    <c:set var="alreadyPrintedSomething" value="true"/>

    <c:set var="question" value="${record.attributesMap['question']}"/>
    <c:set var="answer" value="${record.attributesMap['answer']}"/>
    <c:set var="tag" value="${record.attributesMap['tag']}"/>

    <a name="${tag}"></a><h2 style="margin:0">${question}</h2>
    <p>${answer}</p>

    <c:set var="i" value="${i+1}"/>
  </c:forEach>

  <!-- main body end -->



</div>

<imp:footer/>
