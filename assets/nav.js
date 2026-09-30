(function(){
  var nav=document.querySelector("nav.menu");
  if(!nav) return;
  var en=/^\/en(\/|$)/.test(location.pathname);
  if(en){
    nav.setAttribute("aria-label","Main navigation");
    nav.innerHTML='<a href="/en/">Towing</a><a href="/en/autoentsorgung/">Vehicle disposal</a><a href="/en/leistungen/">Services</a><a href="/en/ratgeber/">Guides</a>';
  } else {
    nav.setAttribute("aria-label","Hauptnavigation");
    nav.innerHTML='<a href="/">Abschleppdienst</a><a href="/autoentsorgung/">Autoentsorgung</a><a href="/leistungen/">Leistungen</a><a href="/ratgeber/">Ratgeber</a>';
  }
})();
