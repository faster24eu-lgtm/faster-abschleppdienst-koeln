(function(){
  window.dataLayer = window.dataLayer || [];
  if (typeof window.gtag !== 'function') {
    window.gtag = function(){ dataLayer.push(arguments); };
  }
  if (!document.querySelector('script[src*="gtag/js?id=AW-10963026341"]')) {
    var s = document.createElement('script');
    s.async = true;
    s.src = 'https://www.googletagmanager.com/gtag/js?id=AW-10963026341';
    document.head.appendChild(s);
    gtag('js', new Date());
    gtag('config', 'AW-10963026341');
  }
  gtag('config', 'AW-10963026341/1eHUCNemnIwdEKWDyuso', {
    'phone_conversion_number': '+49 176 41956993'
  });
})();
