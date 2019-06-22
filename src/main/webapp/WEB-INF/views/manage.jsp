<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <style type="text/css"> html, body {max-width: 100% !important;overflow-x: hidden !important;}</style>
  </head>
  <body id="page-top-login">
    <div class="bg-seamless maxw100">
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
              <c:if test="${!empty restaurant}">
                <h2 class="text-white mb-4">Panel zarządzania restauracją </h2>
                <h1 class="text-white mb-4">${restaurant.name}</h1>
                <p class="text-white-50 ">
                  <button class="btn btn-primary" data-toggle="modal" data-target="#modalAddMenu">Dodaj menu</button>
                  <button class="btn btn-primary" data-toggle="modal" data-target="#modalChangePhoto">Zmień zdjęcie</button>
                  <!-- <button class="btn btn-primary" data-toggle="modal" data-target="#modalChangePhoto">Zmień opis</button>  Do zrobienia -->
                </p>
                <div id="modalAddMenu" class="modal fade" role="dialog">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <a class="modal-title font-weight-bold">Podaj nazwę nowego menu</a>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>
                      <div class="modal-body">
                        <form id="addMenu" method="POST" action="manage/addMenu">
                          <div class="row">
                            <div class="col-8  mt-2">
                              <input type="text" class="form-control" name="menuName">
                              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </div>
                            <div class="col-3">
                              <input type="submit" class="btn btn-primary"  value="Dodaj">
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
                <div id="modalChangePhoto" class="modal fade" role="dialog">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <a class="modal-title font-weight-bold">Wybierz zdjęcie: </a>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>
                      <div class="modal-body">
                        <form id="changePhoto" method="POST" action="manage/changePhoto?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
                          <div class="row">
                            <div class="col-8  mt-2">
                              <input type="file" name="file">
                              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                              <input type="hidden" name="restaurantId" value="${restaurant.id}"/>
                            </div>
                            <div class="col-3">
                              <input type="submit" class="btn btn-primary"  value="Dodaj">
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </c:if>
              <c:if test="${empty restaurant}">
                <h2 class="text-white mb-4">Nie ma restauracji powiązanej z tym kontem. Skontaktuj się z administratorem.</h2>
              </c:if>
            </div>
          </div>
        </div>
      </section>
      <c:if test="${!empty menuMap}">
        <section id="contact" class="contact-section bg-seamless">
          <h1 class="text-center" style=font-size:75px>Lista twoich menu</h1>
          <c:forEach items="${menuMap}" var="map" varStatus="stat">
            <div class="text-center mt-5  mb-2 ">
              <h1>${map.key.name}</h1>
              <div class="row">
                <div class="col-8">
                  <button class="btn btn-secondary" data-toggle="modal" data-target="#modalMenuName">
                  Zmień nazwę
                  </button>
                  <button class="btn btn-secondary" data-toggle="modal" data-target="#modalAddDish">
                  Dodaj danie
                  </button>
                </div>
                
                <div class="col">
					<button class="btn btn-danger" data-toggle="modal" data-target="#modalDeleteMenu">Usuń menu</button>
                </div>
                
                <div id="modalDeleteMenu" class="modal fade" role="dialog">
                	<div class="modal-dialog">
                    	<div class="modal-content">
                      		<div class="modal-header">
                        		<button type="button" class="close" data-dismiss="modal">&times;</button>
                      		</div>
                      		<div class="modal-body">
                        		<form id="${map.key.name}del" method="POST" action="manage/deleteMenu">
                    				<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                    				<input type="hidden"  name="menuId" value="${map.key.id}"/>
                    				<h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć menu - "${map.key.name}"?</h3>
                    				<input class="btn btn-danger" type="submit" value="Usuń"/>
                  				</form>
                      		</div>
                    	</div>
                  	</div>
                </div>
                
              </div>
            </div>
            <div id="modalMenuName" class="modal fade" role="dialog">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <a class="font-weight-bold">Podaj nową nazwę menu</a>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <div class="modal-body text-center">
                    <form id="${map.key.name}edit" method="POST" action="manage/editMenu">
                      <div class="row">
                        <div class="col-8  mt-2">
                          <input type="text" class="form-control" name="newName" placeholder="Nowa nazwa"/>
                          <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                          <input type="hidden"  name="menuId" value="${map.key.id}"/>
                        </div>
                        <div class="col-3">
                          <input type="submit" class="btn btn-primary mr-3" value="Zmień">
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
            <div id="modalAddDish" class="modal fade" role="dialog">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <a class="modal-title font-weight-bold">Dodaj nowe danie</a>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <div class="modal-body">
                    <form id="${map.key.name}add" method="POST" action="manage/addDish?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
                      <div class="row">
                        <div class="col-3">
                          <p class="mt-2">Nazwa:</p>
                          <p class="mt-3">Opis:</p>
                          <p class="mt-4">Cena:</p>
                          <p class="mt-4">Kategoria:</p>
                          <p class="mt-4">Obrazek:</p>
                        </div>
                        <div class="col">
                          <input type="text" class="mb-2 form-control" name="newName" required/>
                          <input type="text" class="mb-2 form-control" name="newDesc"  required/>
                          <input type="text" class="mb-2 form-control" name="newPrice" required pattern="^\d*(\.\d{0,2})?$"/>
                          <select class="form-control" name="cat" class="mt-1" required>
                            <c:if test="${!empty listCategories}">
                              <c:forEach items="${listCategories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                              </c:forEach>
                            </c:if>
                          </select>
                          <input type="file" name="file" required>
                        </div>
                        <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                        <input type="hidden"  name="menuId" value="${map.key.id}"/>
                        <input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
                      </div>
                      <div class="col text-center">
                      	<input type="submit" class="btn btn-primary mr-3" value="Dodaj">
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
            <c:forEach items="${map.value}" var="dish" varStatus="stat">
              <div class="container">
                <div class="row">
                  <div class="col mb-md-2">
                    <img class="img-fluid rounded-circle" src="${contextPath}/resources/img/restaurants/restaurant${restaurant.id}/dishes/${dish.id}.jpg" alt="" style="width:300px; height:300px;"/>
                  </div>
                  <div class="col-md-8 mb-md-2">
                    <div class="card h-100">
                      <div class="row h-100">
                        <div class="col mb-3	 mb-md-0">
                          <div class="card-body text-center h-100 p-0">
                            <br/><br/><br/>
                            <div class="row">
                              <div class="col">
                                <h3 class="font-weight-bold">${dish.name}</h3>
                                <p style="padding-left:5px;"><em>${dish.description}</em></p>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col">
                                <button class="btn btn-secondary" data-toggle="modal" data-target="#modalEditDish${dish.id}">
                                Edytuj
                                </button>
                              </div>
                              <div class="col">
								 <button class="btn btn-danger" data-toggle="modal" data-target="#modalDeleteDish">Usuń</button>
                              </div>
                              
                              <div id="modalDeleteDish" class="modal fade" role="dialog">
                 	 			<div class="modal-dialog">
                    				<div class="modal-content">
                      					<div class="modal-header">
                        					<button type="button" class="close" data-dismiss="modal">&times;</button>
                      					</div>
                      					<div class="modal-body">
                        					<form id="${map.key.name}del" method="POST" action="manage/deleteDish">
                                  				<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                                  				<input type="hidden"  name="dishId" value="${dish.id}"/>
                                  				<h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć danie - "${dish.name}"?</h3>
                                  				<div class="text-center"><input class="btn btn-danger"  type="submit" value="Usuń"></div>
                                			</form>
                      					</div>
                    				</div>
                  				</div>
                			</div>
                			
                              <div id="modalEditDish${dish.id}" class="modal fade" role="dialog">
                                <div class="modal-dialog">
                                  <div class="modal-content">
                                    <div class="modal-header">
                                      <a class="modal-title font-weight-bold">Edytuj danie ${dish.name}</a>
                                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                      <form id="${dish.name}edit" method="POST" action="manage/editDish?${_csrf.parameterName}=${_csrf.token}" enctype="multipart/form-data">
                                        <div class="row">
                                          <div class="col-3">
                                            <p class="mt-2">Nazwa:</p>
                                            <p class="mt-3">Opis:</p>
                                            <p class="mt-4">Cena:</p>
                                            <p class="mt-4">Obrazek: </p>
                                          </div>
                                          <div class="col-5">
                                            <input type="text" name="newName" class="mb-2 form-control"/>
                                            <input type="text" name="newDesc" class="mb-2 form-control"/>
                                            <input type="text" name="newPrice"class="mb-2 form-control" pattern="^\d*(\.\d{0,2})?$"/>
                                            <input type="file" name="file">
                                          </div>
                                          <input type="hidden" name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                                          <input type="hidden" name="dishId" value="${dish.id}"/>
                                          <input type="hidden" name="restaurantId" value="${restaurant.id}"/>                                          
                                        </div>
                                        <div class="col text-center">
                                        	<input type="submit" class="btn btn-primary" value="Zapisz">
                                        </div>
                                      </form>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div class="col-3 mb-3 mb-md-0">
                          <div class="card-body text-center">
                            <br/><br/><br/><br/>
                            <h5 class="font-weight-bold">Cena</h5>
                            <p><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${dish.price}"/> zł</p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </c:forEach>
        </section>
      </c:if>
      <script>
        function clicked(e) {
            if(!confirm('Jesteś pewien?'))e.preventDefault();
        }
      </script>
    </div>
    
    <jsp:include page="contact.jsp"/>
    <jsp:include page="footer.jsp"/>
  </body>
</html>