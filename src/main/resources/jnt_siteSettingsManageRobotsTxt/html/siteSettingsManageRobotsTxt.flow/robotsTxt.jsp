<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ page import="org.jahia.registries.ServicesRegistry"%>
<%@ page import="org.jahia.services.templates.JahiaTemplateManagerService"%>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="user" uri="http://www.jahia.org/tags/user" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%--@elvariable id="mailSettings" type="org.jahia.services.mail.MailSettings"--%>
<%--@elvariable id="flowRequestContext" type="org.springframework.webflow.execution.RequestContext"--%>
<%--@elvariable id="flowExecutionUrl" type="java.lang.String"--%>
<%--@elvariable id="issueTemplate" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="issue" type="org.jahia.services.content.JCRNodeWrapper"--%>

<template:addResources type="javascript" resources="jquery.min.js,jquery.form.js,jquery-ui.min.js,jquery.blockUI.js,workInProgress.js,admin-bootstrap.js"/>
<template:addResources type="css" resources="admin-bootstrap.css"/>
<template:addResources type="css" resources="jquery-ui.smoothness.css,jquery-ui.smoothness-jahia.css"/>

<fmt:message var="i18nUpdateFailed" key="robotstxt.errors.update.failed"/><c:set var="i18nUpdateFailed" value="${fn:escapeXml(i18nUpdateFailed)}"/>

<script type="text/javascript">

    function showRobotsTxtErrors(message) {
    $("#robotsTxtFormErrorMessages").text(message);
    $("#robotsTxtFormErrorContainer").show();
    }

    function hideRobotsTxtErrors() {
    $("#robotsTxtFormErrorMessages").empty();
    $("#robotsTxtFormErrorContainer").hide();
    }

    function submitRobotsTxtForm(act, name, type) {
    $('#robotsTxtFormAction').val(act);
    if (name) {
    $('#robotsTxtActionName').val(name);
    }
    if (type) {
    $('#robotsTxtActionType').val(type);
    }

    $('#robotsTxtWebflowForm').submit();
    }

    $(document).ready(function () {
    $("#robotsTxtFormErrorClose").bind("click", function () {
    hideRobotsTxtErrors();
    });
    var robotsTxtFormOptions = {
    beforeSubmit: function (arr, $form, options) {
    },
            success: function () {
            submitRobotsTxtForm("actionPerformed", $("#robotsTxtName").val(), "${'updated'}");
            },
            error: function () {

            showRobotsTxtErrors("${i18nUpdateFailed}");
            }
    };
    $('#robotsTxtForm').ajaxForm(robotsTxtFormOptions);
    });</script>
<div>
    Please refer to this website for more informations about the file <b>robots.txt</b>: <a href="http://robots-txt.com/" target="_blank">robots-txt.com</a></br>
</div>

<div>
    <form action="${flowExecutionUrl}" method="post" style="display: inline;" id="robotsTxtWebflowForm">
        <input type="hidden" name="name" id="robotsTxtActionName"/>
        <input type="hidden" name="type" id="robotsTxtActionType"/>
        <input type="hidden" name="model" value="robotsTxt"/>
        <input type="hidden" name="_eventId" id="robotsTxtFormAction"/>
    </form>

    <c:url var="actionUrl" value="${url.baseEdit}${robotsTxt.path}"/>
    <h2><fmt:message key="robotsTxt.edit"/> - ${fn:escapeXml(robotsTxt.displayableName)}</h2>

    <div class="box-1">
        <div class="alert alert-error" style="display: none" id="robotsTxtFormErrorContainer">
            <button type="button" class="close" id="robotsTxtFormErrorClose">&times;</button>
            <span id="robotsTxtFormErrorMessages"></span>
        </div>

        <form action="${actionUrl}" method="POST" id="robotsTxtForm">
            <input type="hidden" name="jcrNodeType" value="jnt:robotsTxt">

            <fieldset>
                <div class="container-fluid">
                    <div class="row-fluid">
                        <div class="span4">
                            <c:set var="robotsTxtContent" value="${robotsTxt.properties['content']}"/>
                            <label for="robotsTxtContent"><fmt:message key="label.content"/>: <span class="text-error"></span></label>
                            <textarea rows="10" name="content" form="robotsTxtForm" class="span12" id="robotsTxtContent">${fn:escapeXml(robotsTxtContent)}</textarea>
                        </div>
                    </div>
                </div>
            </fieldset>

            <fieldset>
                <div class="container-fluid">
                    <div class="row-fluid">
                        <div class="span12">
                            <button class="btn btn-primary" type="submit">
                                <i class="icon-${'share'} icon-white"></i>
                                &nbsp;<fmt:message key="label.${'update'}"/>
                            </button>
                            <button class="btn" onclick="submitRobotsTxtForm('cancel'); return false;">
                                <i class="icon-ban-circle"></i>
                                &nbsp;<fmt:message key="label.cancel"/>
                            </button>
                        </div>
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
</div>