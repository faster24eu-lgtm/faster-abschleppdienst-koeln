(function(){
  var nav=document.querySelector("nav.menu");
  if(!nav) return;
  var en=/^\/en(\/|$)/.test(location.pathname);
  if(en){
    nav.setAttribute("aria-label","Main navigation");
    nav.innerHTML='<a href="/en/">Towing</a><a href="/en/kontakt/">Vehicle disposal</a><a href="/en/koeln/pannenhilfe/">Services</a><a href="/en/ratgeber/">Guides</a>';
  } else {
    nav.setAttribute("aria-label","Hauptnavigation");
    nav.innerHTML='<a href="/">Abschleppdienst</a><a href="/kontakt/">Autoentsorgung</a><a href="/koeln/pannenhilfe/">Leistungen</a><a href="/ratgeber/">Ratgeber</a>';
  }
})();
