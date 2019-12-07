export const isChromish = navigator.userAgent.indexOf('Chrome') > -1;
export const isSafarish = navigator.userAgent.indexOf('Safari') > -1;
export const isExplorer = navigator.userAgent.indexOf('MSIE') > -1;
export const isFirefox = navigator.userAgent.indexOf('Firefox') > -1;
export const isOpera = navigator.userAgent.toLowerCase().indexOf('op') > -1;
export const isChrome = isChromish && !isOpera;
export const isSafari = isSafarish && !isChromish;
