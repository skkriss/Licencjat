<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<section id="contact" class="contact-section bg-black">
  <div class="container">
    <div class="row">
      <div class="col-md-4 mb-3 mb-md-0">
        <div class="card py-4 h-100">
          <div class="card-body text-center">
            <i class="fas fa-map-marked-alt text-primary mb-2"></i>
            <h4 class="text-uppercase m-0">Adres</h4>
            <hr class="my-4">
            <div class="small text-black-50">Jana Bażyńskiego 8, Gdańsk</div>
          </div>
        </div>
      </div>
      <div class="col-md-4 mb-3 mb-md-0">
        <div class="card py-4 h-100">
          <div class="card-body text-center">
            <i class="fas fa-envelope text-primary mb-2"></i>
            <h4 class="text-uppercase m-0">Email</h4>
            <hr class="my-4">
            <div class="small text-black-50">ug@poczta.pl</div>
          </div>
        </div>
      </div>
      <div class="col-md-4 mb-3 mb-md-0">
        <div class="card py-4 h-100">
          <div class="card-body text-center">
            <i class="fas fa-mobile-alt text-primary mb-2"></i>
            <h4 class="text-uppercase m-0">Telefon</h4>
            <hr class="my-4">
            <div class="small text-black-50">+48 58 523 30 00</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>