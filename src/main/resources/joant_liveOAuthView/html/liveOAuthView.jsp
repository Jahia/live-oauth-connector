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

<template:addResources type="javascript" resources="i18n/live-oauth-connector-i18n_${currentResource.locale}.js" var="i18nJSFile"/>
<c:if test="${empty i18nJSFile}">
    <template:addResources type="javascript" resources="i18n/live-oauth-connector-i18n_en.js"/>
</c:if>

<template:addResources type="javascript" resources="live-oauth-connector/live-controller.js"/>

<md-card ng-controller="LiveController as live">
    <div layout="row">
        <md-card-title flex>
            <md-card-title-text>
                <span class="md-headline" message-key="joant_liveOAuthView"></span>
            </md-card-title-text>
        </md-card-title>
        <div flex layout="row" layout-align="end center">
            <md-button class="md-icon-button" ng-click="live.toggleCard()">
                <md-tooltip md-direction="top">
                    <span message-key="joant_liveOAuthView.tooltip.toggleSettings"></span>
                </md-tooltip>
                <md-icon ng-show="!live.expandedCard">
                    keyboard_arrow_down
                </md-icon>
                <md-icon ng-show="live.expandedCard">
                    keyboard_arrow_up
                </md-icon>
            </md-button>
        </div>
    </div>

    <md-card-content layout="column" ng-show="live.expandedCard">
        <form name="liveForm">

            <md-switch ng-model="live.isActivate">
                <span message-key="joant_liveOAuthView.label.activate"></span>
            </md-switch>

            <div layout="row">
                <md-input-container flex>
                    <label message-key="joant_liveOAuthView.label.apiKey"></label>
                    <input type="text" ng-model="live.apiKey" name="apiKey" required>
                    <div ng-messages="liveForm.apiKey.$error" role="alert">
                        <div ng-message="required" message-key="joant_liveOAuthView.error.apiKey.required"></div>
                    </div>
                </md-input-container>

                <div flex="5"></div>

                <md-input-container flex>
                    <label message-key="joant_liveOAuthView.label.apiSecret"></label>
                    <input type="text" ng-model="live.apiSecret" name="apiSecret" required>
                    <div ng-messages="liveForm.apiSecret.$error" role="alert">
                        <div ng-message="required" message-key="joant_liveOAuthView.error.apiSecret.required"></div>
                    </div>
                </md-input-container>
            </div>

            <div layout="row">
                <md-input-container class="md-block" flex>
                    <label message-key="joant_liveOAuthView.label.scope"></label>
                    <input type="text" ng-model="live.scope" name="scope">
                    <div class="hint" ng-show="!liveForm.scope.$invalid" message-key="joant_liveOAuthView.hint.scope"></div>
                    <div ng-messages="liveForm.scope.$error" role="alert">
                        <div ng-message="required" message-key="joant_liveOAuthView.error.scope.required"></div>
                    </div>
                </md-input-container>
            </div>

            <div layout="row">
                <md-input-container class="md-block" flex>
                    <label message-key="joant_liveOAuthView.label.callbackURL"></label>
                    <input type="url" ng-model="live.callbackUrl" name="callbackUrl">
                    <md-icon class="md-icon-button" ng-click="live.addUrl(liveForm.callbackUrl.$valid)">add</md-icon>
                    <div class="hint" ng-show="liveForm.callbackUrl.$valid" message-key="joant_liveOAuthView.hint.callbackURL"></div>
                    <div ng-messages="liveForm.callbackUrl.$error" ng-show="liveForm.callbackUrl.$invalid" role="alert">
                        <div ng-message="url" message-key="joant_liveOAuthView.error.callbackURL.notAValidURL"></div>
                    </div>
                </md-input-container>
            </div>
            <div layout="row" ng-show="live.callbackUrls.length > 0">
                <md-list flex>
                    <md-list-item ng-repeat="callbackUrl in live.callbackUrls track by $index">
                        <p>{{ callbackUrl }}</p>
                        <md-button class="md-warn" ng-click="live.removeUrl($index)">remove</md-button>
                    </md-list-item>
                </md-list>
            </div>
        </form>

        <md-card-actions layout="row" layout-align="end center">
            <md-button class="md-accent" message-key="joant_liveOAuthView.label.mappers"
                       ng-click="live.goToMappers()"
                       ng-show="live.connectorHasSettings">
            </md-button>
            <md-button class="md-accent" message-key="joant_liveOAuthView.label.save"
                       ng-click="live.saveSettings()">
            </md-button>
        </md-card-actions>

    </md-card-content>
</md-card>