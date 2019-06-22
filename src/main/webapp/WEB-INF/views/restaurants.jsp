<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%> <c:set var="contextPath" value="${pageContext.request.contextPath}"/>

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
  <body id="page-top">
  <div class="bg-seamless">
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
    <section id="about" class="about-section text-center">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
            <h2 class="text-white mb-4">Wybierz interesującą Cię restaurację!</h2>
            <p class="text-white-50">Śmiało, nie krępuj się :)</p>
          </div>
        </div>
      </div>
    </section>
  <c:if test="${!empty listRestaurants}">
      <section id="projects" class="projects-section big bg-seamless">
      <div class="container">
      <c:forEach items="${listRestaurants}" var="restaurant">
        <div class="row align-items-center no-gutters mb-4 mb-lg-5">
          <div class="col-xl-8 col-lg-7">
            <a href="/restaurant/${restaurant.name}"><img class="img-fluid mb-3 mb-lg-0 nimg" src="${contextPath}/resources/img/restaurants/restaurant${restaurant.id}/main.jpg" alt="" ></a>
            </div>
            <div class="col-xl-4 col-lg-5">
             <a href="/restaurant/${restaurant.name}"> <div class="featured-text text-center text-lg-left">
               <a class="my-bold"></a><h4>${restaurant.name}</h4>
                <p class="font-green mb-0">${restaurant.description}</p><br>
               <a href="/restaurant/${restaurant.name}" class="btn bnt-green js-scroll-trigger startReveal">Wejdź!</a>
              </div>
             </a>
            </div>
          </div>
      </c:forEach>
      </div>
      </section>
  </c:if>
  </div>

  <jsp:include page="contact.jsp"></jsp:include>
  <jsp:include page="footer.jsp"></jsp:include>
  </body>
</html>