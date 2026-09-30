(function(){
  if (typeof gtag === 'function') {
    gtag('config', 'AW-10963026341/1eHUCNemnIwdEKWDyuso', {
      'phone_conversion_number': '+49 176 41956993'
    });
  }
  var nav=document.querySelector("nav.menu");
  var path=location.pathname;
  var en=/^\/en(\/|$)/.test(path);
  if(nav){
    if(en){
      nav.setAttribute("aria-label","Main navigation");
      nav.innerHTML='<a href="/en/">Towing</a><a href="/en/autoentsorgung/">Vehicle disposal</a><a href="/en/leistungen/">Services</a><a href="/en/ratgeber/">Guides</a>';
    } else {
      nav.setAttribute("aria-label","Hauptnavigation");
      nav.innerHTML='<a href="/">Abschleppdienst</a><a href="/autoentsorgung/">Autoentsorgung</a><a href="/leistungen/">Leistungen</a><a href="/ratgeber/">Ratgeber</a>';
    }
  }
  var dePath=en?path.replace(/^\/en/,'')||'/':path;
  var enPath=en?path:(path==='/'?'/en/':'/en'+path);
  if(dePath.charAt(dePath.length-1)!=='/') dePath+='/';
  if(enPath.charAt(enPath.length-1)!=='/') enPath+='/';
  if(dePath==='//') dePath='/';

  var old=document.querySelector(".btn-lang");
  if(!old) return;
  var wrap=document.createElement("div");
  wrap.className="lang-drop";
  wrap.innerHTML='<button type="button" class="btn-lang" aria-expanded="false" aria-haspopup="listbox">'+(en?'EN':'DE')+' <span class="lang-caret" aria-hidden="true">&#9662;</span></button><ul class="lang-menu" hidden><li><a href="'+dePath+'">Deutsch</a></li><li><a href="'+enPath+'">English</a></li></ul>';
  old.parentNode.replaceChild(wrap, old);
  var btn=wrap.querySelector("button");
  var menu=wrap.querySelector(".lang-menu");
  function close(){menu.hidden=true;btn.setAttribute("aria-expanded","false");}
  function open(){menu.hidden=false;btn.setAttribute("aria-expanded","true");}
  btn.addEventListener("click",function(e){e.stopPropagation();if(menu.hidden)open();else close();});
  document.addEventListener("click",function(){close();});
})();
