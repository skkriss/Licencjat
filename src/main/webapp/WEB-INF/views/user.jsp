<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <body id="page-top" class="bg-seamless">
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
              <li class="nav-item">
                <a class="nav-link js-scroll-trigger" href="${contextPath}/restauratorForm">Wniosek o restaurację</a>
              </li>
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
 <!-- ------------------------------ Menu --------------------------------- -->   
 
 <section id="admin" class="about-section text-center">
	<div class="container">
		<div class="row">
			<div class="col-lg-8 mx-auto startReveal">
				<h1 class="text-white mb-4">Twoje konto</h1>
				<p class="text-white-50">Przeglądaj wizyty oraz oceniaj odwiedzone restauracje</p>
			</div>
		</div>
	</div>
</section>

<section id="main">
	<div class="contarier">
		<div class="row">
			<div class="col">
			</div>
			<div class="col-8">
				<div class="row">
					<div class="col-md-4 p-2 mt-5">
						<img class="w-25 mx-auto d-block iconReveal" src="${contextPath}/resources/img/ikony/futVisits.png" alt="">
					</div>
					<div class="col-md-4 p-2 mt-5">
						<img class="w-25 mx-auto d-block iconReveal" src="${contextPath}/resources/img/ikony/comVisits.png" alt="">
					</div>
					<div class="col-md-4 p-2 mt-5">
						<img class="w-25 mx-auto d-block iconReveal" src="${contextPath}/resources/img/ikony/opinions.png" alt="">
					</div>
				</div>
				<div class="row">
					<div class="col-md-4 p-2 mb-5">
						<button class="btn btn-block btn-info p-5 buttonReveal-R" onclick='hideFormUser("futVisitsManage")'>Przyszłe wizyty</button>
					</div>
					<div class="col-md-4 p-2 mb-5">
						<button class="btn btn-block btn-secondary p-5 buttonReveal-L" onclick='hideFormUser("comVisitsManage")'>Zakończone wizyty</button>
					</div>
					<div class="col-md-4 p-2 mb-5">
						<button class="btn btn-block btn-warning p-5 buttonReveal-R" onclick='hideFormUser("opinionsManage")'>Twoje opinie</button>
					</div>					
				</div>
			</div>
			<div class="col">
			</div>
		</div>
	</div>
</section>

<!-- ----------------------------------Przyszłe wizyty---------------------------------------------- -->
    
    <section id="futVisitsManage" style="display:none;">
      <c:if test="${!empty futureVisits}">
        <c:forEach items="${futureVisits}" var="visit" varStatus="stat">
          <section id="contact" class="contact-section p-5">
            <div class="container">
              <div class="card py-4 w-100 h-25">

              <div class="row ml-3 mr-3">
                <div class="col-5 mb-1">	
                    <h3 class="text-center font-weight-bold">Restauracja</h3>
                    <h2 class="text-center font-weight-bold mb-5">${visit.restaurant.name}</h2>
                    <h3 class="text-center font-weight-bold">Rozpoczęcie:</h3>
                    <div class="text-center"><a> ${visit.start_date }</a></div>
                </div>
                <div class="col-6 mb-5 ml-3 mr-3">
                	<div class="row">
                		<div class="col text-center">
                    		<h2 class=" font-weight-bold">Opis</h2>
                    	</div>
					</div>
					<div class="row">
						<div class="col">
                    		<p class="text-center">${visit.description}</p>
                   		</div>
					</div>					
					<div class="row">
                        <div class="col">
                            <h2 class=" font-weight-bold">Goście</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <c:forEach items="${visit.guests}" var="guest" varStatus="stats">
                                <p>${guest.username}</p>
                            </c:forEach>
                        </div>
                    </div>
				</div>
                </div>
                  <div class="col-7 mb-5">
                      <button class="btn btn-secondary" data-toggle="modal" data-target="#modalEditVisit">Edytuj</button>

                      <button class="btn btn-danger" data-toggle="modal" data-target="#modalDeleteVisit">Odwołaj</button>

                  </div>

                <div id="modalEditVisit" class="modal fade" role="dialog">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <a class="modal-title font-weight-bold">Edytuj wizytę</a>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>
                      <div class="modal-body">
                        <form id="${visit.start_date}edit" method="POST" action="user/editVisit">
                          <div class="row">
                            <div class="col-2">
                              <p class="mt-3">Od:</p>
                              <p class="mt-4">Do:</p>
                              <p class="mt-4">Opis:</p>
                            </div>
                            <div class="col  mt-2">
                              <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                              <input type="hidden"  name="visitId" value="${visit.id}"/>
                              <div class="form-group ${status.error ? 'has-error' : ''}">
                                <input type="datetime-local" name="start_dateString" class="form-control" placeholder="Start" autofocus="true"></input>
                                <errors path="start_dateString">
                                <errors>
                              </div>
                              <div class="form-group ${status.error ? 'has-error' : ''}">
                                <input type="datetime-local" name="end_dateString" class="form-control" placeholder="End"></input>
                                <errors path="end_dateString"></errors>
                              </div>
                              <input type="text" class="form-control"name="newDesc" placeholder="Nowy opis">
                            </div>

                            <div class="col text-center">
                            	<input type="submit" class="btn btn-primary mt-3 mr-3" value="Edytuj">
                            </div>

                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
                
                <div id="modalDeleteVisit" class="modal fade" role="dialog">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                      </div>
                      <div class="modal-body">
                        <form id="${visit.start_date}delete" method="POST" action="user/deleteVisit">
                          <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                          <input type="hidden"  name="visitId" value="${visit.id}"/>
                          <h3 class="font-weight-bold text-center">Czy na pewno chcesz odwołać wizytę?</h3>
                          <div class="text-center"><input class="btn btn-danger" type="submit" value="Odwołaj"></div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              </div>
               </div>

          </section>
        </c:forEach>
      </c:if>
    </section>
    
    <!-- ----------------------------------Zakończone wizyty---------------------------------------------- -->
<section id="comVisitsManage" style="display:none;">
    <c:if test="${!empty previousVisits}">
      <c:forEach items="${previousVisits}" var="visit" varStatus="stat">
        <section id="contact" class="contact-section p-5">
           <div class="container">
              <div class="card py-4 w-100 h-25">
              <div class="row ml-3 mr-3">
                <div class="col-5 mb-1">	
                    <h3 class="text-center font-weight-bold">Restauracja</h3>
                    <h2 class="text-center font-weight-bold mb-5">${visit.restaurant.name}</h2>
                    <h3 class="text-center font-weight-bold">Rozpoczęcie:</h3>
                    <div class="text-center"><a> ${visit.start_date }</a></div>
                </div>
                <div class="col-6 mb-5 ml-3 mr-3">
                	<div class="row">
                		<div class="col text-center">
                    	<h2 class=" font-weight-bold">Opis</h2>
                    	</div>
					</div>
					<div class="row">
						<div class="col">
                    		<p class="text-center">${visit.description}</p>
                   		</div>
					</div>					
					<div class="row">
						<div class="col">
                    	<div  class="text-center mt-1 mb-1">
                     		<button class="btn btn-secondary" data-toggle="modal" data-target="#modalAddOpinion">
                      			Dodaj opinie
                      		</button>	
                    	</div>
                    	</div>
					</div>
                </div>     
                  
                  		
                  <div id="modalAddOpinion" class="modal fade" role="dialog">
                    <div class="modal-dialog">
                      <div class="modal-content">
                        <div class="modal-header">
                          <a class="modal-title font-weight-bold">Dodaj opinie</a>
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                          <form id="${visit.start_date}addOpinion" method="POST" action="user/addOpinion">
                            <div class="row">
                            
                              <div class="col-3">
                                <p class="mt-3">Ocena:</p>
                                <p class="mt-4">Tytuł:</p>
                                <p class="mt-4">Opis:</p>
                              </div>
                              <div class="col mt-2">
                                <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                                <input type="hidden" name="opinionId" value="${opinion.id}"/>
                                <input type="hidden" name="userId" value="${user.id}"/>
                                <input type="hidden" name="restaurantId" value="${visit.restaurant.id}"/>
                                <p><input type="number" class="form-control" name="star" min="0" max="10" placeholder="Od 0 do 10"/></p>
                                <p><input type="text" class="form-control" name="name" placeholder="" required/></p>
                                <p><input type="text" class="form-control" name="desc" placeholder="" required/></p>
                              </div>
                           	</div> 	
                            <div class="col text-center">
                            	<input type="submit" class="btn btn-primary mt-3 mr-3" value="Dodaj">
                           	</div>
                           	 
                            </form>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </c:forEach>
    </c:if>
    </section>
    
    <!-- ----------------------------------Twoje opinie --------------------------------------->
    
   <section id="opinionsManage" style="display:none;">
    <c:if test="${!empty listOpinions}">
      <c:forEach items="${listOpinions}" var="opinion" varStatus="stat">
        <section id="contact" class="contact-section p-5">
         	<div class="container">
              <div class="card py-4 w-100 h-25">
              <div class="row ml-3 mr-3">
                <div class="col-5 mb-1">	
                    <h3 class="text-center font-weight-bold">Restauracja</h3>
                    <h2 class="text-center font-weight-bold mb-5">${opinion.restaurant.name}</h2>
                    <h3 class="text-center font-weight-bold">Ocena:</h3>
                    <div class="text-center"><a> ${opinion.star }</a></div>
                </div>
                <div class="col-6 mb-5 ml-3 mr-3">
                	<div class="row">
                		<div class="col text-center">
                    	<h2 class=" font-weight-bold">"${opinion.name }"</h2>
                    	</div>
					</div>
					<div class="row">
						<div class="col">
                    		<p class="text-center">${opinion.description}</p>
                   		</div>
					</div>					
					<div class="row">
						<div class="col">
                    	<div  class="text-center mt-1 mb-1">
                     		<button class="btn btn-secondary" data-toggle="modal" data-target="#modalEditOpinion">
                      			Edytuj
                      		</button>	
                    	</div>
                    	</div>
                    	
                    	<div class="col">
                    	<div  class="text-center mt-1 mb-1">
                     		<button class="btn btn-danger" data-toggle="modal" data-target="#modalDeleteOpinion">
                      			Usuń
                      		</button>	
                    	</div>
                    	</div>
					</div>
                </div> 
              
              <div id="modalEditOpinion" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="modal-title font-weight-bold">Edytuj opinie</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                      <form id="${opinion.name}edit" method="POST" action="user/editOpinion">
                        <div class="row">
                          <div class="col-3">
                            <p class="mt-2">Ocena:</p>
                            <p class="mt-4">Tytuł:</p>
                            <p class="mt-4">Opis:</p>
                          </div>
                          <div class="col  mt-2">
                            <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                            <input type="hidden" name="opinionId" value="${opinion.id}"/>
                            <input type="hidden" name="userId" value="${user.id}"/>
                            <input type="hidden" name="restaurantId" value="${visit.restaurant.id}"/>
                            <p><input class="form-control" type="number" name="newStar" min="0" max="10" placeholder="Ocena"/></p>
                            <p><input class="form-control" type="text" name="newName" placeholder="Tytuł"></p>
                            <p><input class="form-control" type="text" name="newDesc" placeholder="Opis"></p>
                          </div>                                                    
                        </div>                        
                        <div class="col  text-center mt-2">
                          	<input type="submit" class="btn btn-primary mr-3" value="Edytuj">
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
              <div id="modalDeleteOpinion" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                      <form id="${opinion.name}delete" method="POST" action="user/deleteOpinion">
                        <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                        <input type="hidden"  name="opinionId" value="${opinion.id}"/>
                        <h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć opinię?</h3>
                        </br>
                        <div class="text-center"><input class="btn btn-danger"  type="submit" value="Usuń"></div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </c:forEach>
    </c:if>
   </section>

    <jsp:include page="contact.jsp"></jsp:include>
    <jsp:include page="footer.jsp"></jsp:include>
  </body>
</html>