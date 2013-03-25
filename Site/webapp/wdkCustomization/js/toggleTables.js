/*

we support two types of toggling, one compatible with Safari the other for the rest of the
browsers	.
	
the version that works on Safari causes Netscape to lose focus on a click.

the version that works on Netscape doesn't work at all on Safari, as it seems the DOM tricks
in sayShowOrHide don't work

taken from the api project

*/

function toggleLayer(controllingLayerName, textLayerName) {
    //alert("toggleLayer: " + controllingLayerName);
    var controllingLayer ;
    if (document.getElementById) { // this is the way the standards work
	controllingLayer = document.getElementById(controllingLayerName);
    } else if (document.all) { // this is the way old msie versions work
	controllingLayer = document.all[controllingLayerName];
    } else if (document.layers) { // this is the way nn4 works
	controllingLayer = document.layers[controllingLayerName];
    }
    var style = controllingLayer.style;
    style.display = style.display? "":"block"; // toggle it
    sayShowOrHide(controllingLayerName, textLayerName, style);
    storeIntelligentCookie("show" + controllingLayerName, style.display == "block"? 1:0);
}

function sayShowOrHide(controllingLayerName, textLayerName, style) {
    var content = style.display == "block"? "Hide" : "Show";
    // don't use # shortcut for id lookup here...special characters
    // in element id cause problems, and for some reason escaping
    // with \\ (as spec'd in jquery docs) is not working.
    jQuery("div[id='" + textLayerName + "'] a").text(content);
    return true;
}

function showLayer(whichLayer) {
 //alert("showLayer: " + whichLayer);
    if (document.getElementById) {
	// this is the way the standards work
	var style2 = document.getElementById(whichLayer).style;
	style2.display = "block";
    }
    else if (document.all) {
	// this is the way old msie versions work
	var style2 = document.all[whichLayer].style;
	style2.display = "block";
    } else if (document.layers) {
	// this is the way nn4 works
	var style2 = document.layers[whichLayer].style;
	style2.display = "block";
    }
    return true;
}

function hideLayer(whichLayer) {
    //alert("hideLayer: " + whichLayer);
    if (document.getElementById) {
	// this is the way the standards work
	var style2 = document.getElementById(whichLayer).style;
	style2.display = "";
    }
    else if (document.all) {
	// this is the way old msie versions work
	var style2 = document.all[whichLayer].style;
	style2.display = "";
    } else if (document.layers) {
	// this is the way nn4 works
	var style2 = document.layers[whichLayer].style;
	style2.display = "";
    }
    return true;
}


function getCookie(name) {

 var start = document.cookie.indexOf(name + "=");

 if ( (!start) && name != document.cookie.substring(0,name.length) ) {
 return null;
 }

 if (start == -1) {
 return null;
 }

 var len = start + name.length + 1;
 var end = document.cookie.indexOf(";",len);
 if (end == -1) {
 end = document.cookie.length;
 }

 return unescape(document.cookie.substring(len,end));
} 

function setCookie(name, value, expires, path, domain, secure) {

  document.cookie = name + "=" + escape(value) +
  ( (expires) ? ";expires=" + expires.toGMTString() : "") +
( (path) ? ";path=" + path : "") +
( (domain) ? ";domain=" + domain : "") +
( (secure) ? ";secure" : "");
}



function deleteCookie(name, path, domain) {
 if (getCookie(name)) {
 document.cookie = name + "=" +
 ( (path) ? ";path=" + path : "") +
 ( (domain) ? ";domain=" + domain : "") +
 ";expires=Thu, 01-Jan-70 00:00:01 GMT";
 }
} 

function storeMasterCookie() {
 if (!getCookie('MasterCookie')) {
 setCookie('MasterCookie','MasterCookie');
 }
} 

function storeIntelligentCookie(name, value, expires, path, domain, secure) {
 if (!getCookie('MasterCookie')) {
 storeMasterCookie();
 }
 var IntelligentCookie = getCookie(name);
 if ((!IntelligentCookie) || (IntelligentCookie != value)) {
 setCookie(name, value, expires, path, domain, secure);
 var IntelligentCookie = getCookie(name);
 if ((!IntelligentCookie) || (IntelligentCookie != value)) {
 deleteCookie('MasterCookie');
 }
 }
} 