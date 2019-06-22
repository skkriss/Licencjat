(function($) {
  "use strict";

  var navbarCollapse = function() {
    if ($("#mainNav").offset().top > -1) {
      $("#mainNav").addClass("navbar-shrink");
    } else {
      $("#mainNav").removeClass("navbar-shrink");
    }
  };
  // Collapse now if page is not at top
  navbarCollapse();
  // Collapse the navbar when page is scrolled
  $(window).scroll(navbarCollapse);

})(jQuery);

function hideForm(id) {
  document.getElementById("appManage").style.display = "none";
  document.getElementById("catManage").style.display = "none";
  document.getElementById("userManage").style.display = "none";
  document.getElementById("resManage").style.display = "none";

  document.getElementById(id).style.display = "block";
}

function hideFormUser(id) {
	  document.getElementById("futVisitsManage").style.display = "none";
	  document.getElementById("comVisitsManage").style.display = "none";
	  document.getElementById("opinionsManage").style.display = "none";

	  document.getElementById(id).style.display = "block";
	}

window.sr = ScrollReveal();
sr.reveal('.startReveal', {
  duration :2000,
  origin:'bottom',
  distance:'70px'
})
window.sr = ScrollReveal();
sr.reveal('.explainReveal', {
  duration :1000,
  origin:'bottom',
  distance:'30px'
})
window.sr = ScrollReveal();
sr.reveal('.navbarReveal', {
  duration :1500,
  origin:'top',
  distance:'30px'
})
window.sr = ScrollReveal();
sr.reveal('.slide-left', {
  duration :2000,
  origin:'left',
  distance:'110px'
})
window.sr = ScrollReveal();
sr.reveal('.slide-right', {
  duration :2000,
  origin:'right',
  distance:'110px'
})