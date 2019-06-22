<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>FoodTalk</title>
    <link href="${contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="${contextPath}/resources/css/grayscale.min.css" rel="stylesheet">
  </head>
  <body id="page-top" scroll="no" style="overflow: hidden">
    <div class="mastheada">
      <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
        <div class="container">
          <a class="navbar-brand js-scroll-trigger" href="${contextPath}/welcome">FoodTalk</a>
          <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fas fa-bars"></i>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
              <c:if test="${pageContext.request.userPrincipal.name != null}">
                <form id="logoutForm" method="POST" action="${contextPath}/logout">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <c:if test='${role.contains("ROLE_USER")}'>
                  <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="${contextPath}/user">Twoje konto</a>
                  </li>
                </c:if>
                <c:if test='${role.contains("ROLE_ADMIN")}'>
                  <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="${contextPath}/admin">Panel administratora</a>
                  </li>
                </c:if>
                <c:if test='${role.contains("ROLE_MANAGER")}'>
                  <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="${contextPath}/manage">Zarządzanie restauracją</a>
                  </li>
                </c:if>
                <li>
                  <a class="nav-link js-scroll-trigger" onclick="document.forms['logoutForm'].submit()" style="cursor:pointer;"> Wyloguj</a>
                </li>
              </c:if>
              <c:if test="${pageContext.request.userPrincipal.name == null}">
                <li class="nav-item">
                  <a class="nav-link" href="${contextPath}/login">Logowanie</a>
                </li>
              </c:if>
            </ul>
          </div>
        </div>
      </nav>
        <div class="container d-flex h-100 align-items-center" >
          <div class="mx-auto text-center">
            <h1 class="mx-auto my-0 text-uppercase">#403</h1>
            <h2 class="text-white mx-auto mt-2 mb-5">Nie masz uprawnień do wejścia na tę stronę!</h2>
            <a href="${contextPath}/" class="btn btn-primary js-scroll-trigger">Powrót</a>
          </div>
        </div>
      <jsp:include page="footerClear.jsp"/>
    </div>
  </body>
</html>