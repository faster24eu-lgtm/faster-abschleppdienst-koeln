(function(){
  window.dataLayer = window.dataLayer || [];
  if (typeof window.gtag !== 'function') {
    window.gtag = function(){ dataLayer.push(arguments); };
  }
  if (!document.querySelector('script[src*="gtag/js?id=AW-18517785509"]')) {
    var s = document.createElement('script');
    s.async = true;
    s.src = 'https://www.googletagmanager.com/gtag/js?id=AW-18517785509';
    document.head.appendChild(s);
    gtag('js', new Date());
    gtag('config', 'AW-18517785509');
  }
  gtag('config', 'AW-18517785509/FgL9CJ2g8KQdEKX3-_1E', {
    'phone_conversion_number': '+49 176 41956993'
  });
})();
