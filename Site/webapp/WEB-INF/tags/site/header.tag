<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="site" tagdir="/WEB-INF/tags/site" %>

<%@ attribute name="title"
              description="Value to appear in page's title"
%>
<%@ attribute name="banner"
              required="false"
              description="Value to appear at top of page"
%>
<%@ attribute name="refer" 
                          type="java.lang.String"
                          required="false" 
                          description="Page calling this tag"
%>

<%-------- OLD set of attributes,  division being used by login and help, banner by many pages   ---------------------%>

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
<head>
<title>
<c:out value="${title}" default="${banner}" />
</title>
<link rel="StyleSheet" href="<c:url value="/css/style.css" />" type="text/css">

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
<body>
<table width="100%">
<tr><td width="15%">
       <a href="<c:url value="/" />"><img src="<c:url value="/images/wdkToySiteLogo.gif" />"
          border="0" alt="Site logo"></a></td>
    <td width="85%">
       <table border="0" cellpadding="3" width="100%">
         <tr><td colspan="2" align="center"><h1>${banner}</h1></td></tr>
         <tr valign="bottom" align="right">
            <td align="right" valign="bottom">
              [<a href='<c:url value="/showXmlDataList.do" />'> Data Contents</a>]
              [<a href='<c:url value="/" />'> Questions</a>]

            </td>
          </tr>
	  <tr>
	    <td>
		<site:login/>
	    </td>
	  </tr>
        </table>
    </td>
</tr>
</table>
<hr>
