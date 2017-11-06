<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<c:set var="liveNode"/>
<c:forEach var="node" items="${jcr:getDescendantNodes(renderContext.site, 'joant:liveOAuthSettings')}">
    <c:set var="liveNode" value="${node}"/>
</c:forEach>

<c:if test="${(not renderContext.liveMode and liveNode eq '') or (liveNode ne '' and not liveNode.properties.isActivate.boolean)}">
    <div style="color: red;">
        <fmt:message key="joant_liveButton.error.connectorNotConfigured"/>
    </div>
</c:if>

<c:if test="${liveNode ne '' and liveNode.properties.isActivate.boolean and (not renderContext.loggedIn or renderContext.editMode)}">
    <c:set var="cssClass" value="${currentNode.properties['cssClass'].string}"/>
    <c:set var="htmlId" value="${currentNode.properties['htmlId'].string}"/>
    <c:set var="tagType" value="${currentNode.properties['tagType'].string}"/>
    <template:addResources type="css" resources="joaFontRoboto.css"/>
    <template:addResources type="css" resources="joaLiveButton.unified.css"/>

    <template:addResources>
        <script>
            function connectToLive${fn:replace(currentNode.identifier, '-', '')}() {
                var popup = window.open('', "Live Authorization", "menubar=no,status=no,scrollbars=no,width=1145,height=725,modal=yes,alwaysRaised=yes");
                var xhr = new XMLHttpRequest();
                xhr.open('GET', '<c:url value="${url.base}${renderContext.site.home.path}"/>.connectToLiveAction.do');
                xhr.setRequestHeader('Accept', 'application/json;');
                xhr.send();

                xhr.onreadystatechange = function () {
                    if (xhr.readyState != 4 || xhr.status != 200)
                        return;
                    var json = JSON.parse(xhr.responseText);
                    popup.location.href = json.authorizationUrl;
                    window.addEventListener('message', function (event) {
                        if (event.data.authenticationIsDone) {
                            setTimeout(function () {
                                popup.close();
                                if (event.data.isAuthenticate) {
                                    window.location.search = 'site=${renderContext.site.siteKey}';
                                }
                            }, 3000);
                        }
                    });
                };
            }
        </script>
    </template:addResources>

    <c:choose>
        <c:when test="${tagType eq 'button'}">
            <button class="live-btn custom-btn-theme ${cssClass}" type="button"
                    <c:if test="${not renderContext.editMode}"> onclick="connectToLive${fn:replace(currentNode.identifier, '-', '')}()" </c:if>
                    <c:if test="${not empty htmlId}"> id="${htmlId}"</c:if>
                    <c:if test="${renderContext.editMode}">disabled</c:if> >
                        <span class="custom-icon-svg">
                            <svg height="16px" width="16px" enable-background="new 0 0 50 50" id="Layer_1" version="1.1" viewBox="0 0 50 50" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                <path d="M11.9,34.7l8.8,1.3V25.9h-8.8V34.7z M11.9,24.1h8.8V13.9l-8.8,1.8V24.1z M22.3,36.5l11.8,1.8  V25.9H22.3V36.5z M22.3,13.5v10.6h11.8V11.7L22.3,13.5z" fill="#0CB3EE" id="Win8_2_"/>
                                <path d="M25,1C11.7,1,1,11.7,1,25s10.7,24,24,24s24-10.7,24-24S38.3,1,25,1z M25,44C14.5,44,6,35.5,6,25S14.5,6,25,6  s19,8.5,19,19S35.5,44,25,44z" fill="#0CB3EE"/>
                            </svg>
                        </span>
                        <p class="btn-text">${currentNode.displayableName}</p>
            </button>
        </c:when>
        <c:otherwise>
            <a href="#" class="live-btn custom-btn-theme ${cssClass}"
               <c:if test="${not renderContext.editMode}"> onclick="connectToLive${fn:replace(currentNode.identifier, '-', '')}();
                       return false;" </c:if>
               <c:if test="${not empty htmlId}"> id="${htmlId}"</c:if>
               <c:if test="${renderContext.editMode}">disabled</c:if> >
                   <span class="custom-icon-svg">
                       <svg height="16px" width="16px" enable-background="new 0 0 50 50" id="Layer_1" version="1.1" viewBox="0 0 50 50" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                           <path d="M11.9,34.7l8.8,1.3V25.9h-8.8V34.7z M11.9,24.1h8.8V13.9l-8.8,1.8V24.1z M22.3,36.5l11.8,1.8  V25.9H22.3V36.5z M22.3,13.5v10.6h11.8V11.7L22.3,13.5z" fill="#0CB3EE" id="Win8_2_"/>
                           <path d="M25,1C11.7,1,1,11.7,1,25s10.7,24,24,24s24-10.7,24-24S38.3,1,25,1z M25,44C14.5,44,6,35.5,6,25S14.5,6,25,6  s19,8.5,19,19S35.5,44,25,44z" fill="#0CB3EE"/>
                       </svg>
                   </span>
                   <p class="btn-text">${currentNode.displayableName}</p>
            </a>
        </c:otherwise>
    </c:choose>
</c:if>
