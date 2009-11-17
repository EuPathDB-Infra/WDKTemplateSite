<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<%@ taglib prefix="logic" uri="http://jakarta.apache.org/struts/tags-logic" %>
<%@ taglib prefix="bean" uri="http://jakarta.apache.org/struts/tags-bean" %>

<c:set var="wdkUser" value="${sessionScope.wdkUser}"/>
<table border="0" cellspacing="5">
<c:choose>
  <c:when test="${wdkUser != null && wdkUser.guest != true}">

      <tr>
        <td valign="top">
           <c:set var="firstName" value="${wdkUser.firstName}"/>
	   Welcome: ${firstName}! 
        </td>
        <td valign="top">
           <a href="<c:url value='/profile.jsp'/>">Profile</a>
        </td>
        <td>
	   <html:form method="POST" action='/processLogout.do' >
              <input type="submit" value="Logout">
           </html:form>
        </td>
      </tr>

  </c:when>

  <c:otherwise>

     <c:if test="${requestScope.loginError != null}">
       <tr>
          <td colspan="2">
             <font color="red">${requestScope.loginError}</font>
          </td>
       </tr>
     </c:if>
     <tr>
       <td align="left">
          <html:form method="POST" action='/processLogin.do' >
            <b>Email: </b> <input type="text" name="email">
            <b>Password: </b> <input type="password" name="password">
            <a href="<c:url value='/resetpwd.jsp'/>">forget?</a>
            <c:if test="${requestScope.refererUrl != null}">
               <input type="hidden" name="refererUrl" value="${requestScope.refererUrl}">
            </c:if>
            <input type="submit" value="Log In">
          </html:form>
       </td>
       <td valign="top">
           &nbsp;|&nbsp;
           <a href="<c:url value='/register.jsp'/>">Register</a>
       </td>
    </tr>


  </c:otherwise>

</c:choose>

</table>
