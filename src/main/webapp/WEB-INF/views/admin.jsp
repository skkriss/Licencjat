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
	<script src="https://unpkg.com/scrollreveal"></script>
	<link href="${contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="${contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="${contextPath}/resources/css/grayscale.min.css" rel="stylesheet">
</head>
<body id="page-top" class="bg-seamless">
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
	<div class="navbarReveal container">
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
<section id="admin" class="about-section text-center">
	<div class="container">
		<div class="row">
			<div class="col-lg-8 mx-auto startReveal">
				<h1 class="text-white mb-4">Panel administracyjny</h1>
				<p class="text-white-50">Zarządzaj aplikacją w sprawny i przejrzysty sposób</p>
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
					<div class="col-md-3 p-2 mt-5">
						<img id="test2" class="w-25 mx-auto d-block iconReveal" src="${contextPath}/resources/img/ikony/category.jpg" alt="">
					</div>
					<div class="col-md-3 p-2 mt-5">
						<img class="w-25 mx-auto d-block iconReveal" src="${contextPath}/resources/img/ikony/users.png" alt="">
					</div>
					<div class="col-md-3 p-2 mt-5">
						<img class="w-25 mx-auto d-block iconReveal" src="${contextPath}/resources/img/ikony/restaurant.png" alt="">
					</div>
					<div class="col-md-3 p-2 mt-5">
						<img class="w-25 mx-auto d-block iconReveal" src="${contextPath}/resources/img/ikony/survey.png" alt="">
					</div>
				</div>
				<div class="row">	
					<div  class="col-md-3 p-2 mb-5">
						<button class="btn btn-block btn-danger p-5 buttonReveal-L" onclick='hideForm("catManage")' >Kategorie</button>
					</div>
					<div class="col-md-3 p-2 mb-5">
						<button class="btn btn-block btn-info p-5 buttonReveal-R" onclick='hideForm("userManage")'>Użytkownicy</button>
					</div>
					<div class="col-md-3 p-2 mb-5">
						<button class="btn btn-block btn-success p-5 buttonReveal-L" onclick='hideForm("resManage")'>Restauracje</button>
					</div>
					<div class="col-md-3 p-2 mb-5">
						<button class="btn btn-block btn-warning p-5 buttonReveal-R" onclick='hideForm("appManage")'>Wnioski</button>
					</div>					
				</div>
			</div>
			<div class="col">
			</div>
		</div>
	</div>
</section>
<!-- -----------------------    Modal   --------------------------------- -->
<section>
	<div id="modalAddCategory" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                	<a class="font-weight-bold">Podaj nazwę</a>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                 </div>
             <div class="modal-body text-center">
				<form id="categoryAdd" method="POST" action="admin/addCategory">
					<div class="row">
						<div class="col-3">
							<p class="mt-3">Nazwa:</p>
						</div>
						<div class="col">
							<input type="text" class="mb-2 mt-2 form-control" name="categoryName" required/>
						</div>
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="submit" class="btn btn-primary mr-3" value="Dodaj">
					</div>
				</form>
             </div>
            </div>
        </div>
    </div> 
           					

</section>
<section id="catManage" class="p-5" style="display:none;">
	<div>
		<div class="text-center">
			<button class="btn btn-primary" data-toggle="modal" data-target="#modalAddCategory">Nowa kategoria</button>
		</div>

		<c:if test="${!empty listCategories}">
			<c:set var="listSize" value="${fn:length(listCategories)}"/>
			<c:forEach items="${listCategories}" var="category" varStatus="stat">
				<c:choose>
					<c:when test="${ stat.count == 1 }">
						<section id="contact" class="contact-section">
							<div class="container">
								<div class="row">
									<div class="col-md-4 mb-3 mb-md-0">
										<div class="card py-4 h-100">
											<div class="card-body text-center ">
												<h3> ${category.name}</h3>
								
								<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditCat${category.id}">Edytuj</button>
								<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelCat${category.id}">Usuń</button>
								             				
           						<div id="modalEditCat${category.id}" class="modal fade" role="dialog">
                         			<div class="modal-dialog">
                                    	<div class="modal-content">
                                    		<div class="modal-header">
                    							<a class="font-weight-bold">Podaj nową nazwę</a>
                                          		<button type="button" class="close" data-dismiss="modal">&times;</button>
                  							</div>
                  						<div class="modal-body text-center">
                   							 <form id="${category.name}edit" method="POST" action="admin/editCategory" style="display:block">
                      							<div class="row">
													<div class="col-3">
														<p class="mt-3">Nazwa:</p>
													</div>                      							
                       								<div class="col mt-2">
                          								<input type="text" class="mb-2 form-control" name="newName"/>
                          								<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                          								<input type="hidden"  name="categoryId" value="${category.id}"/>
                        							</div>                        						
                          							<input type="submit" class="btn btn-primary btn-xs mr-3" value="Wyślij">                        						
                      							</div>
                    						</form>		
                  						</div>
                						</div>
              						</div>
            					</div> 

												
              <div id="modalDelCat${category.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                      <form id="${category.name}delete" method="POST" action="admin/deleteCategory" style="display:block">
                        <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                        <input type="hidden"  name="categoryId" value="${category.id}"/>
                        <h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć kategorię? </h3>
                        <div class="text-center"><input class="btn btn-danger"  type="submit" value="Usuń"></div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
									
											</div>
										</div>
									</div>
					</c:when>
					<c:when test="${ stat.count == listSize }">
					<div class="col-md-4 mb-3 mb-md-0">
						<div class="card py-4 h-100">
							<div class="card-body text-center ">
								<h3> ${category.name}</h3>
																
								<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditCat${category.id}">Edytuj</button>
           						<div id="modalEditCat${category.id}" class="modal fade" role="dialog">
                         			<div class="modal-dialog">
                                    	<div class="modal-content">
                                    		<div class="modal-header">
                    							<a class="font-weight-bold">Podaj nową nazwę</a>
                                          		<button type="button" class="close" data-dismiss="modal">&times;</button>
                  							</div>
                  						<div class="modal-body text-center">
                   							 <form id="${category.name}edit" method="POST" action="admin/editCategory" style="display:block">
                      							<div class="row">
													<div class="col-3">
														<p class="mt-3">Nazwa:</p>
													</div>                      							
                       								<div class="col mt-2">
                          								<input type="text" class="mb-2 form-control" name="newName"/>
                          								<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                          								<input type="hidden"  name="categoryId" value="${category.id}"/>
                        							</div>                        						
                          							<input type="submit" class="btn btn-primary btn-xs mr-3" value="Wyślij">                        						
                      							</div>
                    						</form>	
                  						</div>
                						</div>
              						</div>
            					</div>
            					
												<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelCat${category.id}">Usuń</button>
												
              <div id="modalDelCat${category.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                      <form id="${category.name}delete" method="POST" action="admin/deleteCategory" style="display:block">
                        <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                        <input type="hidden"  name="categoryId" value="${category.id}"/>
                        <h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć kategorię? </h3>
                        <div class="text-center"><input class="btn btn-danger"  type="submit" value="Usuń"></div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
							</div>
						</div>
					</div>
				</div>
		</section>
		
					</c:when>
					<c:when test="${stat.count % 3 == 0 && stat.count < listSize }">
						<div class="col-md-4 mb-3 mb-md-0 ">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${category.name}</h3>

								<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditCat${category.id}">Edytuj</button>
           						<div id="modalEditCat${category.id}" class="modal fade" role="dialog">
                         			<div class="modal-dialog">
                                    	<div class="modal-content">
                                    		<div class="modal-header">
                    							<a class="font-weight-bold">Podaj nową nazwę</a>
                                          		<button type="button" class="close" data-dismiss="modal">&times;</button>
                  							</div>
                  						<div class="modal-body text-center">
                   							 <form id="${category.name}edit" method="POST" action="admin/editCategory" style="display:block">
                      							<div class="row">
													<div class="col-3">
														<p class="mt-3">Nazwa:</p>
													</div>                      							
                       								<div class="col mt-2">
                          								<input type="text" class="mb-2 form-control" name="newName"/>
                          								<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                          								<input type="hidden"  name="categoryId" value="${category.id}"/>
                        							</div>                        						
                          							<input type="submit" class="btn btn-primary btn-xs mr-3" value="Wyślij">                        						
                      							</div>
                    						</form>	
                  						</div>
                						</div>
              						</div>
            					</div>
            					
													<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelCat${category.id}">Usuń</button>
												
              <div id="modalDelCat${category.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                      <form id="${category.name}delete" method="POST" action="admin/deleteCategory" style="display:block">
                        <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                        <input type="hidden"  name="categoryId" value="${category.id}"/>
                        <h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć kategorię? </h3>
                        <div class="text-center"><input class="btn btn-danger"  type="submit" value="Usuń"></div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
								</div>
							</div>
						</div>
					</div>
				</section>
				<section id="contact" class="contact-section">
					<div class="container">
						<div class="row">
					</c:when>
					<c:otherwise>
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${category.name}</h3>
									
								<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditCat${category.id}">Edytuj</button>
           						<div id="modalEditCat${category.id}" class="modal fade" role="dialog">
                         			<div class="modal-dialog">
                                    	<div class="modal-content">
                                    		<div class="modal-header">
                    							<a class="font-weight-bold">Podaj nową nazwę</a>
                                          		<button type="button" class="close" data-dismiss="modal">&times;</button>
                  							</div>
                  						<div class="modal-body text-center">
                   							 <form id="${category.name}edit" method="POST" action="admin/editCategory" style="display:block">
                      							<div class="row">
													<div class="col-3">
														<p class="mt-3">Nazwa:</p>
													</div>                      							
                       								<div class="col mt-2">
                          								<input type="text" class="mb-2 form-control" name="newName"/>
                          								<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                          								<input type="hidden"  name="categoryId" value="${category.id}"/>
                        							</div>                        						
                          							<input type="submit" class="btn btn-primary btn-xs mr-3" value="Wyślij">                        						
                      							</div>
                    						</form>
                  						</div>
                						</div>
              						</div>
            					</div>
            									
			<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelCat${category.id}">Usuń</button>
												
              <div id="modalDelCat${category.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                      <form id="${category.name}delete" method="POST" action="admin/deleteCategory" style="display:block">
                        <input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
                        <input type="hidden"  name="categoryId" value="${category.id}"/>
                        <h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć kategorię? </h3>
                        <div class="text-center"><input class="btn btn-danger"  type="submit" value="Usuń"></div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
</section>
<section id="resManage" class="p-5" style="display:none">
	<div>
		<c:if test="${!empty listRestaurants}">
			<c:set var="listSize" value="${fn:length(listRestaurants)}"/>
			<c:forEach items="${listRestaurants}" var="restaurant" varStatus="stat">
				<c:choose>
					<c:when test="${ stat.count == 1 }">
						<section id="contact" class="contact-section">
							<div class="container">
								<div class="row">
									<div class="col-md-4 mb-3 mb-md-0">
										<div class="card py-4 h-100">
											<div class="card-body text-center ">
												<h3> ${restaurant.name}</h3>
												<p> ${restaurant.description}
												<p>
												<p>
													ul.
													<c:out value=" "/>
														${restaurant.address.street }
													<c:out value=" "/>
														${restaurant.address.number }<br/>
														${restaurant.address.post_code}
													<c:out value=" "/>
														${restaurant.address.city}
												</p>
												
										
			<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditRes${restaurant.id}">Edytuj</button>
			<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelRes${restaurant.id}">Usuń</button>
					
			<div id="modalEditRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj restauracje - "${restaurant.name}"</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
					<form id="${restaurant.name}edit" method="POST" action="admin/editRestaurant">
							<div class="row">	
								<div class="col-4">
									<div class="row ml-4 mt-2">Nazwa:</div>
									<div class="row ml-4 mt-4">Ulica:</div>
									<div class="row ml-4 mt-4">Numer:</div>
									<div class="row ml-4 mt-4">Kod:</div>
									<div class="row ml-4 mt-3">Miasto:</div>
								</div>					
								<div class="col-6 ml-3">
									<div class="row p-1"><input type="text" class="form-control" name="newName" placeholder="Nazwa"/></div>
									<div class="row p-1"><input type="text" class="form-control" name="newStreet" placeholder="Ulica"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newNumber" placeholder="Numer"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCode" placeholder="Kod"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCity" placeholder="Miasto"></div>
								</div>
							</div>	
							<div class="row">
								<div class="col-3">Opis:</div>
							</div>				
							<div class="row ml-4 mr-4">
								<textarea class="form-control" rows="6" cols="6" name="newDesc" placeholder="Opis restauracji"></textarea>
							</div>							
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<input type="submit" value="Wyślij" class="btn btn-primary mt-3">
					</form>
                    </div>
                  </div>
                </div>
              </div>
              
              
     
              
              <div id="modalDelRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${restaurant.name}delete" method="POST" action="admin/deleteRestaurant">
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć restauracje - "${restaurant.name}"? </h3>
						<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>				


											</div>
										</div>
									</div>
					</c:when>
					<c:when test="${ stat.count == listSize }">
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${restaurant.name}</h3>
									<p> ${restaurant.description} <p>
									<p> ul. <c:out value=" "/> ${restaurant.address.street } <c:out value=" "/> ${restaurant.address.number }<br/>
											${restaurant.address.post_code} <c:out value=" "/> ${restaurant.address.city} </p>

			<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditRes${restaurant.id}">Edytuj</button>
			<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelRes${restaurant.id}">Usuń</button>
					
			<div id="modalEditRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj restauracje - "${restaurant.name}"</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
					<form id="${restaurant.name}edit" method="POST" action="admin/editRestaurant">
							<div class="row">	
								<div class="col-4">
									<div class="row ml-4 mt-2">Nazwa:</div>
									<div class="row ml-4 mt-4">Ulica:</div>
									<div class="row ml-4 mt-4">Numer:</div>
									<div class="row ml-4 mt-4">Kod:</div>
									<div class="row ml-4 mt-3">Miasto:</div>
								</div>					
								<div class="col-6 ml-3">
									<div class="row p-1"><input type="text" class="form-control" name="newName" placeholder="Nazwa"/></div>
									<div class="row p-1"><input type="text" class="form-control" name="newStreet" placeholder="Ulica"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newNumber" placeholder="Numer"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCode" placeholder="Kod"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCity" placeholder="Miasto"></div>
								</div>
							</div>	
							<div class="row">
								<div class="col-3">Opis:</div>
							</div>				
							<div class="row ml-4 mr-4">
								<textarea class="form-control" rows="6" cols="6" name="newDesc" placeholder="Opis restauracji"></textarea>
							</div>							
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<input type="submit" value="Wyślij" class="btn btn-primary mt-3">
					</form>
                    </div>
                  </div>
                </div>
              </div>
              
              <div id="modalDelRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${restaurant.name}delete" method="POST" action="admin/deleteRestaurant">
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć restauracje - "${restaurant.name}"? </h3>
						<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>	
              
								</div>
							</div>
						</div>
					</div>
			</section>
					</c:when>
						<c:when test="${stat.count % 3 == 0 && stat.count < listSize }">
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${restaurant.name}</h3>
									<p> ${restaurant.description} <p>
									<p> ul. <c:out value=" "/> ${restaurant.address.street } <c:out value=" "/> ${restaurant.address.number }<br/>
											${restaurant.address.post_code} <c:out value=" "/> ${restaurant.address.city} </p>

			<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditRes${restaurant.id}">Edytuj</button>
			<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelRes${restaurant.id}">Usuń</button>
					
			<div id="modalEditRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj restauracje - "${restaurant.name}"</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
					<form id="${restaurant.name}edit" method="POST" action="admin/editRestaurant">
							<div class="row">	
								<div class="col-4">
									<div class="row ml-4 mt-2">Nazwa:</div>
									<div class="row ml-4 mt-4">Ulica:</div>
									<div class="row ml-4 mt-4">Numer:</div>
									<div class="row ml-4 mt-4">Kod:</div>
									<div class="row ml-4 mt-3">Miasto:</div>
								</div>					
								<div class="col-6 ml-3">
									<div class="row p-1"><input type="text" class="form-control" name="newName" placeholder="Nazwa"/></div>
									<div class="row p-1"><input type="text" class="form-control" name="newStreet" placeholder="Ulica"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newNumber" placeholder="Numer"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCode" placeholder="Kod"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCity" placeholder="Miasto"></div>
								</div>
							</div>	
							<div class="row">
								<div class="col-3">Opis:</div>
							</div>				
							<div class="row ml-4 mr-4">
								<textarea class="form-control" rows="6" cols="6" name="newDesc" placeholder="Opis restauracji"></textarea>
							</div>							
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<input type="submit" value="Wyślij" class="btn btn-primary mt-3">
					</form>
                    </div>
                  </div>
                </div>
              </div>
              
              <div id="modalDelRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${restaurant.name}delete" method="POST" action="admin/deleteRestaurant">
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć restauracje - "${restaurant.name}"? </h3>
						<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>	
								</div>
							</div>
						</div>
					</div>
				</section>
				<section id="contact" class="contact-section">
					<div class="container">
						<div class="row">
					</c:when>
					<c:otherwise>
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${restaurant.name}</h3>
									<p> ${restaurant.description} <p>
									<p> ul. <c:out value=" "/> ${restaurant.address.street } <c:out value=" "/> ${restaurant.address.number }<br/>
											${restaurant.address.post_code} <c:out value=" "/> ${restaurant.address.city} </p>

			<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditRes${restaurant.id}">Edytuj</button>
			<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelRes${restaurant.id}">Usuń</button>
					
			<div id="modalEditRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj restauracje - "${restaurant.name}"</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
					<form id="${restaurant.name}edit" method="POST" action="admin/editRestaurant">
							<div class="row">	
								<div class="col-4">
									<div class="row ml-4 mt-2">Nazwa:</div>
									<div class="row ml-4 mt-4">Ulica:</div>
									<div class="row ml-4 mt-4">Numer:</div>
									<div class="row ml-4 mt-4">Kod:</div>
									<div class="row ml-4 mt-3">Miasto:</div>
								</div>					
								<div class="col-6 ml-3">
									<div class="row p-1"><input type="text" class="form-control" name="newName" placeholder="Nazwa"/></div>
									<div class="row p-1"><input type="text" class="form-control" name="newStreet" placeholder="Ulica"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newNumber" placeholder="Numer"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCode" placeholder="Kod"></div>
									<div class="row p-1"><input type="text" class="form-control" name="newCity" placeholder="Miasto"></div>
								</div>
							</div>	
							<div class="row">
								<div class="col-3">Opis:</div>
							</div>				
							<div class="row ml-4 mr-4">
								<textarea class="form-control" rows="6" cols="6" name="newDesc" placeholder="Opis restauracji"></textarea>
							</div>							
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<input type="submit" value="Wyślij" class="btn btn-primary mt-3">
					</form>
                    </div>
                  </div>
                </div>
              </div>
              
              <div id="modalDelRes${restaurant.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${restaurant.name}delete" method="POST" action="admin/deleteRestaurant">
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="hidden"  name="restaurantId" value="${restaurant.id}"/>
						<h3 class="font-weight-bold text-center">Czy na pewno chcesz usunąć restauracje - "${restaurant.name}"? </h3>
						<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>	

								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
</section>
<section id="userManage" class="p-5" style="display:none">
	<div>
		<c:if test="${!empty listUsers}">
			<c:set var="listSize" value="${fn:length(listUsers)}"/>
			<c:forEach items="${listUsers}" var="user" varStatus="stat">
				<c:choose>
					<c:when test="${ stat.count == 1 }">
						<section id="contact" class="contact-section">
							<div class="container">
								<div class="row">
									<div class="col-md-4 mb-3 mb-md-0">
										<div class="card py-4 h-100">
											<div class="card-body text-center ">
												<h3> ${user.username}</h3>												
												<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditUsr${user.id}">Edytuj</button>
												<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelUsr${user.id}">Usuń</button>
												
												
			<div id="modalEditUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj użytkownika - ${user.username}</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}edit" method="POST" action="admin/editUser" style="display:block">
							<div class="row">
								<div class="col-6">
								<a class="text-center">Nowa nazwa</a>
								</div>
								<div class="col-6">
								<a class="text-center">Rola</a>
								</div>
								
							</div>
							<div class="row">
								<div class="col-6 mb-3">
									<input type="text" class="form-control" name="newUsername"/>
								</div>
								<div class="col-6 mt-2 mb-3">
								<select name="newRole">
								<c:if test="${!empty listRoles}">
									<c:forEach items="${listRoles}" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</c:if>
								</select>
								</div>
							</div>
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<input type="submit" value="Wyślij" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}delete" method="POST" action="admin/deleteUser" style="display:block">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<h3> 
								<div class="font-weight-bold text-center">
									Czy na pewno chcesz usunąć użytkownika - "${user.username}" ?
								</div>
							</h3>
							<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
             </div>
			</div>
			</div>
			</div>
					</c:when>
					<c:when test="${ stat.count == listSize }">
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${user.username}</h3>

									<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditUsr${user.id}">Edytuj</button>
									<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelUsr${user.id}">Usuń</button>
												
												
			<div id="modalEditUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj użytkownika - ${user.username}</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}edit" method="POST" action="admin/editUser" style="display:block">
							<div class="row">
								<div class="col-6">
								<a class="text-center">Nowa nazwa</a>
								</div>
								<div class="col-6">
								<a class="text-center">Rola</a>
								</div>
								
							</div>
							<div class="row">
								<div class="col-6 mb-3">
									<input type="text" class="form-control" name="newUsername"/>
								</div>
								<div class="col-6 mt-2 mb-3">
								<select name="newRole">
								<c:if test="${!empty listRoles}">
									<c:forEach items="${listRoles}" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</c:if>
								</select>
								</div>
							</div>
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<input type="submit" value="Wyślij" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}delete" method="POST" action="admin/deleteUser" style="display:block">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<h3> 
								<div class="font-weight-bold text-center">
									Czy na pewno chcesz usunąć użytkownika - "${user.username}" ?
								</div>
							</h3>
							<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>
								</div>
							</div>
						</div>
					</div>
			</section>
					</c:when>
					<c:when test="${stat.count % 3 == 0 && stat.count < listSize }">
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${user.username}</h3>
										<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditUsr${user.id}">Edytuj</button>
										<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelUsr${user.id}">Usuń</button>
												
												
			<div id="modalEditUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj użytkownika - ${user.username}</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}edit" method="POST" action="admin/editUser" style="display:block">
							<div class="row">
								<div class="col-6">
								<a class="text-center">Nowa nazwa</a>
								</div>
								<div class="col-6">
								<a class="text-center">Rola</a>
								</div>
								
							</div>
							<div class="row">
								<div class="col-6 mb-3">
									<input type="text" class="form-control" name="newUsername"/>
								</div>
								<div class="col-6 mt-2 mb-3">
								<select name="newRole">
								<c:if test="${!empty listRoles}">
									<c:forEach items="${listRoles}" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</c:if>
								</select>
								</div>
							</div>
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<input type="submit" value="Wyślij" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}delete" method="POST" action="admin/deleteUser" style="display:block">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<h3> 
								<div class="font-weight-bold text-center">
									Czy na pewno chcesz usunąć użytkownika - "${user.username}" ?
								</div>
							</h3>
							<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>
								</div>
							</div>
						</div>
					</div>
				</section>
				<section id="contact" class="contact-section">
					<div class="container">
						<div class="row">
					</c:when>
					<c:otherwise>
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> ${user.username}</h3>
										<button class="btn btn-primary" data-toggle="modal" data-target="#modalEditUsr${user.id}">Edytuj</button>
										<button class="btn btn-danger" data-toggle="modal" data-target="#modalDelUsr${user.id}">Usuń</button>
												
												
			<div id="modalEditUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a class="font-weight-bold">Edytuj użytkownika - ${user.username}</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}edit" method="POST" action="admin/editUser" style="display:block">
							<div class="row">
								<div class="col-6">
								<a class="text-center">Nowa nazwa</a>
								</div>
								<div class="col-6">
								<a class="text-center">Rola</a>
								</div>
								
							</div>
							<div class="row">
								<div class="col-6 mb-3">
									<input type="text" class="form-control" name="newUsername"/>
								</div>
								<div class="col-6 mt-2 mb-3">
								<select name="newRole">
								<c:if test="${!empty listRoles}">
									<c:forEach items="${listRoles}" var="role">
										<option value="${role.id}">${role.name}</option>
									</c:forEach>
								</c:if>
								</select>
								</div>
							</div>
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<input type="submit" value="Wyślij" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelUsr${user.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
						<form id="${user.username}delete" method="POST" action="admin/deleteUser" style="display:block">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="userId" value="${user.id}"/>
							<h3> 
								<div class="font-weight-bold text-center">
									Czy na pewno chcesz usunąć użytkownika - "${user.username}" ?
								</div>
							</h3>
							<input type="submit" value="Usuń" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
</section>
<section id="appManage" class="p-5" style="display:none">
	<div>
		<c:if test="${!empty listApplications}">
			<c:set var="listSize" value="${fn:length(listUsers)}"/>
			<c:forEach items="${listApplications}" var="application" varStatus="stat">
				<c:choose>
				<c:when test="${ stat.count == 1 }">
					<section id="contact" class="contact-section">
						<div class="container">
							<div class="row">
								<div class="col-md-4 mb-3 mb-md-0">
									<div class="card py-4 h-100">
										<div class="card-body text-center ">
											<h3> Wniosek nr ${application.id}</h3>
											<p>Użytkownik: ${application.user.username}</p>
											<p>Restauracja: ${application.name}</p>
											<p>Opis: ${application.description}</p>
											<p>
												Adres: ul.
												<c:out value=" "></c:out>
													${application.street}
												<c:out value=" "></c:out>
													${application.number}<br/>
													${application.post_code}
												<c:out value=" "></c:out>
													${application.city}
											</p>
											
	<button class="btn btn-primary align-self-end" data-toggle="modal" data-target="#modalAccApp${application.id}1">Zatwierdz</button>
	<button class="btn btn-danger align-self-end" data-toggle="modal" data-target="#modalDelApp${application.id}">Odrzuć</button>

											
			<div id="modalAccApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    	<h3 class="text-center font-weight-bold">Czy na pewno chcesz zatwierdzić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}approve" method="POST" action="admin/approveApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value = "Zatwierdz" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a>Odrzuć</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    	<h3 class="font-weight-bold text-center">Czy na pewno chcesz odrzucić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}delete" method="POST" action="admin/discardApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value="Odrzuć" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>

										</div>
									</div>
								</div>
						</c:when>
						<c:when test="${ stat.count == listSize }">
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> Wniosek nr ${application.id}</h3>
									<p>Adres: ul. <c:out value=" "></c:out> ${application.street} <c:out value=" "></c:out> ${application.number}<br/>
											${application.post_code}<c:out value=" "></c:out>${application.city}</p>

									<button class="btn btn-primary align-self-end" data-toggle="modal" data-target="#modalAccApp${application.id}">Zatwierdz</button>
									<button class="btn btn-danger align-self-end" data-toggle="modal" data-target="#modalDelApp${application.id}">Odrzuć</button>
		
											
			<div id="modalAccApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    	<h3 class="text-center font-weight-bold">Czy na pewno chcesz zatwierdzić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}approve" method="POST" action="admin/approveApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value = "Zatwierdz" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a>Odrzuć</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    	<h3 class="font-weight-bold text-center">Czy na pewno chcesz odrzucić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}delete" method="POST" action="admin/discardApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value="Odrzuć" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>
              
								</div>
							</div>
						</div>
					</div>
			</section>
					</c:when>
					<c:when test="${stat.count % 3 == 0 && stat.count < listSize }">
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> Wniosek nr ${application.id}</h3>
									<p>Adres: ul. <c:out value=" "></c:out> ${application.street} <c:out value=" "></c:out> ${application.number}<br/>
											${application.post_code}<c:out value=" "></c:out>${application.city}</p>

											<button class="btn btn-primary align-self-end" data-toggle="modal" data-target="#modalAccApp${application.id}">Zatwierdz</button>
											<button class="btn btn-danger align-self-end" data-toggle="modal" data-target="#modalDelApp${application.id}">Odrzuć</button>
		
											
			<div id="modalAccApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    	<h3 class="text-center font-weight-bold">Czy na pewno chcesz zatwierdzić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}approve" method="POST" action="admin/approveApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value = "Zatwierdz" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a>Odrzuć</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <h3 class="font-weight-bold text-center">Czy na pewno chcesz odrzucić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}delete" method="POST" action="admin/discardApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value="Odrzuć" class="btn btn-danger ">
						</form>
                    </div>
                  </div>
                </div>
              </div>
              
								</div>
							</div>
						</div>
					</div>
				</section>
				<section id="contact" class="contact-section">
					<div class="container">
						<div class="row">
					</c:when>
					<c:otherwise>
						<div class="col-md-4 mb-3 mb-md-0">
							<div class="card py-4 h-100">
								<div class="card-body text-center ">
									<h3> Wniosek nr ${application.id}</h3>
									<p>Adres: ul. <c:out value=" "></c:out> ${application.street} <c:out value=" "></c:out> ${application.number}<br/>
											${application.post_code}<c:out value=" "></c:out>${application.city}</p>
											<button class="btn btn-primary align-self-end" data-toggle="modal" data-target="#modalAccApp${application.id}">Zatwierdz</button>
											<button class="btn btn-danger align-self-end" data-toggle="modal" data-target="#modalDelApp${application.id}">Odrzuć</button>
		
											
			<div id="modalAccApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    	<h3 class="text-center font-weight-bold">Czy na pewno chcesz zatwierdzić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}approve" method="POST" action="admin/approveApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value = "Zatwierdz" class="btn btn-primary">
						</form>
                    </div>
                  </div>
                </div>
              </div>

			<div id="modalDelApp${application.id}" class="modal fade" role="dialog">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <a>Odrzuć</a>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <h3 class="font-weight-bold text-center">Czy na pewno chcesz odrzucić "Wniosek nr ${application.id}"?</h3>
						<form id="${application.id}delete" method="POST" action="admin/discardApp">
							<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
							<input type="hidden"  name="applicationId" value="${application.id}"/>
							<input type="submit" value="Odrzuć" class="btn btn-danger">
						</form>
                    </div>
                  </div>
                </div>
              </div>
              
								</div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:if>
</section>
<script src="${contextPath}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>