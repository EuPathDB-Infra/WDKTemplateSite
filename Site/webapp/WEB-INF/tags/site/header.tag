<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>
<%@ taglib prefix="wdk" tagdir="/WEB-INF/tags/wdk" %>

<%@ attribute name="title"
              description="Value to appear in page's title"
%>
<%@ attribute name="refer" 
                          type="java.lang.String"
                          required="false" 
                          description="Page calling this tag"
%>

<%-------- CHECK list below: some are not in use:
	- division being used by login and help, 
	- banner by many pages   
----------------------------------------------------------%>
<%@ attribute name="banner"
              required="false"
              description="Value to appear at top of page"
%>
<%@ attribute name="parentDivision"
              required="false"
%>

<%@ attribute name="parentUrl"
              required="false"
%>
<%@ attribute name="divisionName"
              required="false"
%>

<%@ attribute name="division"
              required="false"
%>
<%@ attribute name="summary"
              required="false"
              description="short text description of the page"
%>

<%@ attribute name="headElement"
              required="false"
              description="additional head elements"
%>

<%@ attribute name="bodyElement"
              required="false"
              description="additional body elements"
%>



<html>

<%--------------------------- HEAD of HTML doc ---------------------%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>
	<c:out value="${title}" default="WDK ${banner}" />
</title>

<wdk:includes /> 

<%-- DECIDE IF ALLSITES IS NEEDED --%>
<%-- When definitions are in conflict, the next one overrides the previous one  --%>
<link rel="StyleSheet" href="<c:url value="/css/style.css" />" 		type="text/css">
<link rel="stylesheet" href="<c:url value="/css/Color.css" />"        	type="text/css" />

<site:jscript refer="${refer}"/>


<!--[if lt IE 8]>
<link rel="stylesheet" href="<c:url value="/css/ie7.css"/>" type="text/css" />
<![endif]-->

<!--[if lt IE 7]>
<link rel="stylesheet" href="<c:url value="/css/ie6.css"/>" type="text/css" />
<![endif]-->



<%-- LETS CHECK WHO IS USING THIS, OR REMOVE ---%>
<SCRIPT TYPE="text/javascript" lang="JavaScript">
<!--

function uncheck(notFirst) {
    var form = document.downloadConfigForm;
    var cb = form.selectedFields;
    if (notFirst) {
        for (var i=1; i<cb.length; i++) {
            cb[i].checked = null;
        }
    } else {
        cb[0].checked = null;
    }
}

function check(all) {
    var form = document.downloadConfigForm;
    var cb = form.selectedFields;
    cb[0].checked = (all > 0 ? null : 'checked');
    for (var i=1; i<cb.length; i++) {
        cb[i].checked = (all > 0 ? 'checked' : null);
    }
}

-->
</SCRIPT>


</head>

<%--------------------------- BODY of HTML doc ---------------------%>
<body>
  <div id="siteLogo">
    <a href="<c:url value="/" />"><img src="<c:url value="/images/strategiesWDK.png" />"
       border="0" alt="Site logo"></a>
  </div>
  <div id="siteBanner">
    <h1>WDK ${banner} website</h1>
  </div>
  <div id="leftLinks">
    [<a href='<c:url value="/showXmlDataList.do" />'> Data Contents</a>]
    [<a href='<c:url value="/" />'> Questions</a>]
  </div>
  <div id="login">
    <site:login/>
  </div>
  <hr />
