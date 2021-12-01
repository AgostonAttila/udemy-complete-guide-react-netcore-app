Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,n=new Array(r),o=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(o[i],i,o)&&(n[l++]=o[i]);else for(;++i!==r;)i in this&&t.call(e,o[i],i,o)&&(n[l++]=o[i]);return n.length=l,n}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null===this||void 0===this)throw new TypeError('"this" is null or not defined');var n=Object(this),o=n.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<o;){var l;r in n&&(l=n[r],t.call(e,l,r,n)),r++}}),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var n=Object(this),o=n.length>>>0;if(0===o)return-1;var l=0|e;if(l>=o)return-1;for(r=Math.max(l>=0?l:o-Math.abs(l),0);r<o;){if(r in n&&n[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,n,o=document,l=[];if(o.querySelectorAll)return o.querySelectorAll("."+t);if(o.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=o.evaluate(r,o,null,0,null);n=e.iterateNext();)l.push(n);else for(e=o.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),n=0;n<e.length;n++)r.test(e[n].className)&&l.push(e[n]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),n=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),n.push(e);return document._qsa=null,n}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],n=r.length;return function(o){if("function"!=typeof o&&("object"!=typeof o||null===o))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in o)t.call(o,l)&&s.push(l);if(e)for(i=0;i<n;i++)t.call(o,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug:location.href.indexOf("usidebug") != -1,
		
		log:function(msg) {
			if (this.debug) {
				if (msg instanceof Error) {
					console.log(msg.name + ': ' + msg.message);
				} else {
					console.log.apply(console, arguments);
				}
			}
		},
		log_error: function(msg) {
			if (this.debug) {
				if (msg instanceof Error) {
					console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
				} else {
					console.log('%c USI Error:', usi_commons.log_styles.error, msg);
				}
			}
		},
		log_success: function(msg) {
			if (this.debug) {
				console.log('%c USI Success:', usi_commons.log_styles.success, msg);
			}
		},
		dir:function(obj) {
			if (this.debug) {
				console.dir(obj);
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://www.upsellit.com",
		cdn: "https://upsellit-14516.kxcdn.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
			var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
			var regex = new RegExp(regexS);
			var results = regex.exec(window.location.href);
			if (results == null) return "";
			else return results[1];
		},
		load_script:function(source, callback) {
			if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source; //upgrade non-secure requests
			var docHead = document.getElementsByTagName("head")[0];
			if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			if (typeof callback == "function") newScript.onload = callback;
			docHead.appendChild(newScript);
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			usiKey = usiKey || "";
			var source = this.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
			this.load_script(source, callback);
		},
		load_facebook:function(usiQS, usiSiteID, usiKey) {
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
				usiKey = usiKey || "";
				var usi_append = "";
				if (this.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + this.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_id_cache") != null) usi_append += "&usi_id_cache=" + usi_cookies.get("usi_id_cache");
				if (this.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = this.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				if (typeof(this.last_view) !== "undefined" && this.last_view == usiSiteID+"_"+usiKey) return;
				this.last_view = usiSiteID+"_"+usiKey;
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
				this.load_script(source, callback);
			}
		},
		remove_loads:function() {
			if (document.getElementById("usi_obj") != null) {
				document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
			}
			if (typeof(usi_commons.usi_loads) !== "undefined") {
				for (var i in usi_commons.usi_loads) {
					if (document.getElementById("usi_"+i) != null) {
						document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
					}
				}
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			usiKey = usiKey || "";
			var usi_append = "";
			if (this.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + this.gup("usi_force_date");
			else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
			if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_id_cache") != null) usi_append += "&usi_id_cache=" + usi_cookies.get("usi_id_cache");
			if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
			var source = this.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
			this.load_script(source, callback);
			if (typeof(usi_commons.usi_loads) === "undefined") {
				usi_commons.usi_loads = new Map();
			}
			usi_commons.usi_loads[usiSiteID] = usiSiteID;
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			var source = this.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&domain=" + encodeURIComponent(this.domain);
			this.load_script(source, callback);
		},
		load_mail:function(qs, siteID, callback) {
			var source = this.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(this.domain);
			this.load_script(source, callback);
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|");
					if (info.extra) queryString += "|" + info.extra;
					var filetype = real_time ? "jsp" : "js";
					this.load_script(this.domain + "/active/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				this.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			if (typeof usi_cookies === 'undefined') {
				usi_commons.log_error('usi_cookies is not defined');
				return;
			}
			expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
			if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
			var value = null;
			var qsValue = usi_commons.gup(name);
			if (qsValue !== '') {
				value = qsValue;
				usi_cookies.set(name, value, expireSeconds, forceCookie);
			} else {
				value = usi_cookies.get(name);
			}
			return (value || '');
		},
		get_id: function() {
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
				usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		}
	};
}

if (typeof usi_app === 'undefined') {
	try {
		if("undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,o,i){try{var n=-1;if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n=t.getTime()}var r=window.top||window,s=0;null!=o&&-1!=o.indexOf("=")&&(o=o.replace(new RegExp("=","g"),"USIEQLS")),null!=o&&-1!=o.indexOf(";")&&(o=o.replace(new RegExp(";","g"),"USIPRNS"));for(var c=r.name.split(";"),u="",a=0;a<c.length;a++){var l=c[a].split("=");3==l.length?(l[0]==e&&(l[1]=o,l[2]=n,s=1),null!=l[1]&&"null"!=l[1]&&(u+=l[0]+"="+l[1]+"="+l[2]+";")):""!=c[a]&&(u+=c[a]+";")}0==s&&(u+=e+"="+o+"="+n+";"),r.name=u}catch(e){}},flush_window_name:function(e){try{for(var o=window.top||window,i=o.name.split(";"),n="",t=0;t<i.length;t++){var r=i[t].split("=");3==r.length&&(0==r[0].indexOf(e)||(n+=i[t]+";"))}o.name=n}catch(e){}},get_from_window_name:function(e){try{for(var o=(window.top||window).name.split(";"),i=0;i<o.length;i++){var n=o[i].split("=");if(3==n.length){if(n[0]==e)if(-1!=(t=n[1]).indexOf("USIEQLS")&&(t=t.replace(new RegExp("USIEQLS","g"),"=")),-1!=t.indexOf("USIPRNS")&&(t=t.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=n[2]&&usi_cookies.datediff(n[2])<0))return"undefined"==typeof usi_cookieless&&usi_cookies.create_cookie(n[0],t,usi_cookies.datediff(n[2])/1e3),usi_results=[t,n[2]],usi_results}else if(2==n.length){var t;if(n[0]==e)return-1!=(t=n[1]).indexOf("USIEQLS")&&(t=t.replace(new RegExp("USIEQLS","g"),"=")),-1!=t.indexOf("USIPRNS")&&(t=t.replace(new RegExp("USIPRNS","g"),";")),usi_results=[t,(new Date).getTime()+6048e5],usi_results}}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),o=e[e.length-1];if("com"==o||"net"==o||"org"==o||"us"==o||"co"==o||"ca"==o)return e[e.length-2]+"."+e[e.length-1]}catch(e){}return document.domain},create_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(o)+n+"; path=/;domain="+s+"; "+r}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;for(var o=e+"=",i=document.cookie.split(";"),n=0;n<i.length;n++){for(var t=i[n];" "==t.charAt(0);)t=t.substring(1,t.length);if(0==t.indexOf(o))return decodeURIComponent(t.substring(o.length,t.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e)}catch(e){}},get:function(e){var o=null;try{if(null!=localStorage&&null!=(o=localStorage.getItem(e)))return decodeURIComponent(o)}catch(e){}var i=usi_cookies.get_from_window_name(e);if(null!=i&&i.length>1)try{o=decodeURIComponent(i[0])}catch(e){return i[0]}else o=usi_cookies.read_cookie(e);return o},get_json:function(e){var o=null,i=usi_cookies.get(e);if(null==i)return null;try{o=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{o=JSON.parse(JSON.parse(i))}catch(e){try{o=JSON.parse(i)}catch(e){}}}return o},search_cookies:function(e){e=e||"";var o=[];return document.cookie.split(";").forEach(function(i){var n=i.split("=")[0].trim();""!==e&&0!==n.indexOf(e)||o.push(n)}),o},set:function(e,o,i,n){"undefined"!=typeof usi_nevercookie&&(n=!1),void 0===i&&(i=-1);try{o=o.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}if("undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",o+"",i),"undefined"==typeof usi_cookieless||n||null==o){if(null!=o){if(null==usi_cookies.read_cookie(e))if(!n)if(usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);o.length>usi_cookies.max_cookie_length&&(usi_cookies.report_error('Cookie "'+e+'" truncated ('+o.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length),o=o.substring(0,usi_cookies.max_cookie_length-1))}usi_cookies.create_cookie(e,o,i)}try{null!=localStorage&&localStorage.setItem(e,o)}catch(e){}},set_json:function(e,o,i,n){var t=JSON.stringify(o).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,t,i,n)},flush:function(e){e=e||"usi_";var o,i,n,t=document.cookie.split(";");for(o=0;o<t.length;o++)0==(i=t[o]).trim().toLowerCase().indexOf(e)&&(n=i.trim().split("=")[0],usi_cookies.del(n));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(x in localStorage)0==x.indexOf("usi_")&&localStorage.removeItem(x)}catch(e){}},print:function(){for(var e=document.cookie.split(";"),o="",i=0;i<e.length;i++){var n=e[i];0==n.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(n.trim())+" (cookie)"),o+=","+n.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(x in localStorage)0==x.indexOf("usi_")&&"string"==typeof localStorage[x]&&-1==o.indexOf(","+x+",")&&(console.log(x+"="+localStorage[x]+" (localStorage)"),o+=","+x+",")}catch(e){}var t=(window.top||window).name.split(";");for(i=0;i<t.length;i++){var r=t[i].split("=");if(3==r.length&&0==r[0].indexOf("usi_")&&-1==o.indexOf(","+r[0]+",")){var s=r[1];-1!=s.indexOf("USIEQLS")&&(s=s.replace(new RegExp("USIEQLS","g"),"=")),-1!=s.indexOf("USIPRNS")&&(s=s.replace(new RegExp("USIPRNS","g"),";")),console.log(r[0]+"="+s+" (window.name)"),o+=","+n.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,o;for(e=0;e<arguments.length;e++)if(""===(o=usi_cookies.get(arguments[e]))||null===o||"null"===o||"undefined"===o)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup))try{""!=usi_commons.gup("usi_email_id")&&usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0)}catch(e){usi_commons.report_error(e)}
"undefined"==typeof usi_dom&&(usi_dom={},usi_dom.get_elements=function(e,t){return t=t||document,Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.count_elements=function(e,t){return t=t||document,usi_dom.get_elements(e,t).length},usi_dom.get_nth_element=function(e,t,n){var o=null;n=n||document;var r=usi_dom.get_elements(t,n);return r.length>=e&&(o=r[e-1]),o},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"===Object.prototype.toString.call(e)){for(var n=null,o=0;o<e.length;o++){var r=e[o];if(null!=(n=usi_dom.get_first_element(r,t)))break}return n}return t.querySelector(e)},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var o=0;o<e.childNodes.length;++o)3===e.childNodes[o].nodeType&&(n+=e.childNodes[o].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){if("string"==typeof e){return(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()}},usi_dom.encode=function(e){if("string"==typeof e){var t=encodeURIComponent(e);return t=t.replace(/[-_.!~*'()]/g,function(e){return"%"+e.charCodeAt(0).toString(16).toUpperCase()})}},usi_dom.get_closest=function(e,t){for(e=e||document,"function"!=typeof Element.prototype.matches&&(Element.prototype.matches=Element.prototype.matchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector||Element.prototype.oMatchesSelector||Element.prototype.webkitMatchesSelector||function(e){for(var t=(this.document||this.ownerDocument).querySelectorAll(e),n=t.length;--n>=0&&t.item(n)!==this;);return n>-1});null!=e&&e!==document;e=e.parentNode)if(e.matches(t))return e;return null},usi_dom.get_classes=function(e){var t=[];return null!=e&&null!=e.classList&&(t=Array.prototype.slice.call(e.classList)),t},usi_dom.add_class=function(e,t){if(null!=e){var n=usi_dom.get_classes(e);-1===n.indexOf(t)&&(n.push(t),e.className=n.join(" "))}},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.get_currency_string_from_content=function(e){if("string"!=typeof e)return"";try{e=e.trim();var t=e.match(/^([^\$]*?)(\$(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/)||[];return 4===t.length?t[2]:""}catch(e){return usi_commons.log("Error: "+e.message),""}},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_number=function(e,t){var n="";if("number"==typeof e){t=t||0;var o=e.toFixed(t).split(/\./g);if(1==o.length||2==o.length)n=o[0].replace(/./g,function(e,t,n){return t&&"."!==e&&(n.length-t)%3==0?","+e:e}),2==o.length&&(n+="."+o[1])}return n},usi_dom.format_currency=function(e,t,n){var o="";return e=Number(e),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},o=e.toLocaleString(t,n)):o=e),o},usi_dom.to_decimal_places=function(e,t){if(null!=e&&"number"==typeof e&&null!=t&&"number"==typeof t){if(0==t)return parseFloat(Math.round(e));for(var n=10,o=1;o<t;o++)n*=10;return parseFloat(Math.round(e*n)/n)}return null},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,o),o.addEventListener?o.addEventListener(e,t,!1):o.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);o.removeEventListener?o.removeEventListener(e,t,!1):o.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e)return!1;if(""===(t||""))return!1;var n=!0,o=e;return t.split(".").forEach(function(e){!0===n&&(null==o||"object"!=typeof o||!1===o.hasOwnProperty(e)?n=!1:o=o[e])}),n},usi_dom.observe=function(e,t,n){var o=location.href,r=window.MutationObserver||window.WebkitMutationObserver;return t=t||{onUrlUpdate:!1,observerOptions:{childList:!0,subtree:!0}},function(e,n){var i=null,u=function(){var e=location.href;t.onUrlUpdate&&e!==o?(n(),o=e):n()};return r?(i=new r(function(e){var r=location.href,i=e[0].addedNodes.length||e[0].removedNodes.length;i&&t.onUrlUpdate&&r!==o?(n(),o=r):i&&n()})).observe(e,t.observerOptions):window.addEventListener&&(e.addEventListener("DOMNodeInserted",u,!1),e.addEventListener("DOMNodeRemoved",u,!1)),i}}(),usi_dom.params_to_object=function(e){var t={};""!=(e||"")&&e.split("&").forEach(function(e){var n=e.split("=");2===n.length?t[decodeURIComponent(n[0])]=decodeURIComponent(n[1]):1===n.length&&(t[decodeURIComponent(n[0])]=null)});return t},usi_dom.object_to_params=function(e){var t=[];if(null!=e)for(var n in e)!0===e.hasOwnProperty(n)&&t.push(encodeURIComponent(n)+"="+(null==e[n]?"":encodeURIComponent(e[n])));return t.join("&")},usi_dom.interval_with_timeout=function(e,t,n,o){if("function"!=typeof e)throw new Error("usi_dom.interval_with_timeout(): iterationFunction must be a function");if(null==t)t=function(e){return e};else if("function"!=typeof t)throw new Error("usi_dom.interval_with_timeout(): timeoutCallback must be a function");if(null==n)n=function(e){return e};else if("function"!=typeof n)throw new Error("usi_dom.interval_with_timeout(): completeCallback must be a function");var r=(o=o||{}).intervalMS||20,i=o.timeoutMS||2e3;if("number"!=typeof r)throw new Error("usi_dom.interval_with_timeout(): intervalMS must be a number");if("number"!=typeof i)throw new Error("usi_dom.interval_with_timeout(): timeoutMS must be a number");var u=!1,l=new Date,a=setInterval(function(){var o=new Date-l;if(o>=i)return clearInterval(a),t({elapsedMS:o});!1===u&&(u=!0,e(function(e,t){if(u=!1,!0===e)return clearInterval(a),(t=t||{}).elapsedMS=new Date-l,n(t)}))},r)},usi_dom.load_external_stylesheet=function(e,t,n){if(""!==(e||"")){""===(t||"")&&(t="usi_stylesheet_"+(new Date).getTime());var o={url:e,id:t},r=document.getElementsByTagName("head")[0];if(null!=r){var i=document.createElement("link");i.type="text/css",i.rel="stylesheet",i.id=o.id,i.href=e,usi_dom.attach_event("load",function(){if(null!=n)return n(null,o)},i),r.appendChild(i)}}else if(null!=n)return n(null,o)},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},o={};for(var r in n)t.hasOwnProperty(r)?o[r]=t[r]:o[r]=n[r];var i=Object.prototype.toString.call(e);function u(e,t){var n,o,r,i,u,l,a,s;r=e.innerHTML,u=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),i=function(e){var t=window.getComputedStyle(e,null);return(e.clientWidth-parseInt(t.getPropertyValue("padding-left"),10)-parseInt(t.getPropertyValue("padding-right"),10))/u}(e),o=function(e){var t=window.getComputedStyle(e,null);return(e.clientHeight-parseInt(t.getPropertyValue("padding-top"),10)-parseInt(t.getPropertyValue("padding-bottom"),10))/u}(e),i&&(t.widthOnly||o)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===r.indexOf("textFitted")?((n=document.createElement("span")).className="textFitted",n.style.display="inline-block",n.innerHTML=r,e.innerHTML="",e.appendChild(n)):n=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),l=t.minFontSize,s=t.maxFontSize;for(var c=l,d=1e3;l<=s&&d>0;)d--,a=s+l-.1,n.style.fontSize=a+"em",n.scrollWidth/u<=i&&(t.widthOnly||n.scrollHeight/u<=o)?(c=a,l=a+.1):s=a-.1;n.style.fontSize!==c+"em"&&(n.style.fontSize=c+"em")}"[object Array]"!==i&&"[object NodeList]"!==i&&"[object HTMLCollection]"!==i&&(e=[e]);for(var l=0;l<e.length;l++)u(e[l],o)});
'undefined'==typeof usi_url&&(usi_url={},usi_url.URL=function(a){a=a||location.href;var b=document.createElement('a');if(b.href=a,this.full=b.href||'',this.protocol=(b.protocol||'').split(':')[0],this.host=b.host||'',-1!=this.host.indexOf(':')&&(this.host=this.host.substring(0,this.host.indexOf(':'))),this.port=b.port||'',this.hash=b.hash||'',this.baseURL='',this.tld='',this.domain='',this.subdomain='',this.domain_tld='',''!==this.protocol&&''!==this.host){this.baseURL=this.protocol+'://'+this.host+'/';var c=this.host.split(/\./g);if(2<=c.length){if(-1<['co','com','org','net','int','edu','gov','mil'].indexOf(c[c.length-2])&&2===c[c.length-1].length){var d=c.pop(),e=c.pop();this.tld=e+'.'+d}else this.tld=c.pop()}0<c.length&&(this.domain=c.pop(),0<c.length&&(this.subdomain=c.join('.'))),this.domain_tld=this.domain+'.'+this.tld}var f=b.pathname||'';0!==f.indexOf('/')&&(f='/'+f),this.path=new usi_url.Path(f),this.params=new usi_url.Params((b.search||'').substr(1))},usi_url.URL.prototype.build=function(a,b,c){var d='';return''!==this.protocol&&''!==this.host&&(null==a&&(a=!0),null==b&&(b=!0),null==c&&(c=!0),!0==a&&(d+=this.protocol+':'),d+='//'+this.host,''!==this.port&&(d+=':'+this.port),!0==b&&(d+=this.path.full,!0==c&&0<Object.keys(this.params.parameters).length&&(d+='?',d+=this.params.build()))),d},usi_url.Path=function(a){a=a||'',this.full=a,this.directories=[],this.filename='';for(var b=a.substr(1).split(/\//g);0<b.length;)1===b.length?this.filename=b.shift():this.directories.push(b.shift());this.has_directory=function(a){return-1<this.directories.indexOf(a)},this.contains=function(a){return-1<this.full.indexOf(a)}},usi_url.Params=function(a){a=a||'',this.full=a,this.parameters=function(a){var b={};if(1===a.length&&''===a[0])return b;for(var c,d,e,f=0;f<a.length;f++)if(e=a[f].split('='),c=e[0]&&e[0].replace(/\+/g,' '),d=e[1]&&e[1].replace(/\+/g,' '),1===e.length)b[c]='';else try{b[c]=decodeURIComponent(d)}catch(a){b[c]=d}return b}(a.split('&')),this.count=Object.keys(this.parameters).length,this.get=function(a){return a in this.parameters?this.parameters[a]:null},this.has=function(a){return a in this.parameters},this.set=function(a,b){this.parameters[a]=b,this.count=Object.keys(this.parameters).length},this.remove=function(a){!0===this.has(a)&&delete this.parameters[a],this.count=Object.keys(this.parameters).length},this.build=function(){var a=this,b=[];for(var c in a.parameters)!0===a.parameters.hasOwnProperty(c)&&b.push(c+'='+encodeURIComponent(a.parameters[c]));return b.join('&')},this.remove_usi_params=function(a){var b=this;for(var c in a=a||[],-1===a.indexOf('usi_')&&a.push('usi_'),b.parameters)if(!0===b.parameters.hasOwnProperty(c)){var d=!1;a.forEach(function(a){0===c.indexOf(a)&&(d=!0)}),d&&b.remove(c)}},this.remove_all=function(){var a=this;for(var b in a.parameters)!0===a.parameters.hasOwnProperty(b)&&a.remove(b)}});

		usi_cookieless = true;
		usi_app = {};
		usi_app.main = function () {
			try {
				// General
				usi_app.url = new usi_url.URL(location.href.toLowerCase());
				usi_app.country = "hu";
				usi_app.coupon = usi_cookies.value_exists("usi_coupon_applied") ? "" : usi_commons.gup_or_get_cookie("usi_coupon", usi_cookies.expire_time.week, true);

				// Pages
				usi_app.is_checkout_page = usi_app.url.path.full === "/cart/checkout/";
				usi_app.is_cart_page = usi_app.url.path.full === "/cart/";
				usi_app.is_login_page = usi_app.url.path.contains("/join/login-popup/");
				usi_app.is_promo_page = usi_app.url.path.contains("/gift-promo-code/redeem/");
				usi_app.is_confirmation_page = usi_app.url.path.contains("/cart/success/");

				// Booleans
				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.day, true) != "";
				usi_app.is_suppressed = usi_app.is_confirmation_page;

				if (location.href.toLowerCase().indexOf("utm_source=aff-campaign") != -1) {
					usi_cookies.set("usi_aff", "1", usi_cookies.expire_time.month, true);
				}
				usi_app.is_affiliate_traffic = usi_cookies.value_exists("usi_aff");

				// Load pixel on confirmation page
				if (usi_app.is_confirmation_page && typeof USI_orderID == "undefined") {
					usi_commons.load_script("//www.upsellit.com/active/udemy_pixel.jsp");
				}

				// Apply coupon
				if (usi_app.coupon !== "") {
					if (usi_app.is_login_page) {
						usi_app.boostbar.load("Please log in to redeem coupon");
						return;
					} else if (usi_app.is_promo_page) {
						usi_app.apply_coupon();
						return;
					}
				}

				// Check suppressions
				if (usi_app.is_suppressed) {
					return usi_commons.log("[ main ] Company is suppressed");
				}

				// Save cart data
				if (usi_app.is_cart_page) {
					usi_app.save_cart();
				}

				// Load campaigns
				usi_app.load();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load = function () {
			try {
				// Clean up previous solutions
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				if (usi_app.is_affiliate_traffic && (usi_app.is_cart_page || usi_app.is_checkout_page) && "US,CA,AU,UK".indexOf(usi_app.country.toUpperCase()) != -1 && usi_cookies.value_exists("usi_prod_image_1", "usi_prod_name_1", "usi_prod_price_1", "usi_prod_original_price_1")) {
					usi_commons.load_view("XvQnu7VvZqft6PL5kl3XtSi", "38251", usi_commons.device);
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.save_cart = function () {
			try {
				var prod_prefix = "usi_prod_";
				usi_cookies.flush(prod_prefix);
				usi_cookies.del("usi_subtotal");

				// Scrape cart
				usi_app.cart = {
					items: usi_app.scrape_cart(),
					subtotal: usi_app.scrape_subtotal()
				}

				// Save cart items
				if (typeof usi_app.cart.items != "undefined") {
					usi_app.cart.items.forEach(function (product, index) {
						var prop;
						if (index >= 1) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(prod_prefix + prop + "_" + (index + 1), encodeURIComponent(product[prop]), usi_cookies.expire_time.week);
							}
						}
					});
				}

				usi_commons.log('[ save_cart ] cart:', usi_app.cart);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_subtotal = function () {
			try {
				var subtotal = document.querySelector("div[data-purpose='total-price'] .course-price-text span span");
				if (subtotal != null) {
					subtotal = usi_dom.string_to_decimal(subtotal.textContent).toFixed(2);
					usi_cookies.set("usi_subtotal", encodeURIComponent(subtotal), usi_cookies.expire_time.week);
					return subtotal;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart = function () {
			try {
				var items = [], product;
				if (window['localStorage'] && window['localStorage']['shoppingCartStorage:storage-1.0']) {
					var cart_data = JSON.parse(window['localStorage']['shoppingCartStorage:storage-1.0']);
					if (cart_data['state'] && cart_data['state']['lists'] && cart_data['state']['lists']['cart']) {
						var cart_rows = cart_data['state']['lists']['cart'];
						cart_rows.forEach(function (item) {
							usi_commons.log('[ scrape_cart ] item:', item);
							var buyable = item['buyable'];
							if (buyable && item['purchase_price'] && item['list_price']) {
								product = {};
								product.pid = buyable['id'];
								product.name = buyable['title'];
								product.price = item['purchase_price']['amount'];
								product.original_price = item['list_price']['amount'];
								product.image = buyable['image_480x270'] || buyable['image_240x135'] || buyable['image_125_H'] || buyable['image_100x100'];
								
								items.push(product);
							}
						});
					}
				}
				return items;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.boostbar = {
			load: function (boost_txt) {
				try {
					if (boost_txt.length > 0 && !document.getElementById('usi_boost_container')) {
						// Assign boost bar styles according to condition
						var bg_color = "#EC5252";
						var close_right = "0";
						var padding = "1.1em 0";
						var usi_boost_container = document.createElement('div');
						var close_button = '<a href="javascript:usi_app.boostbar.close();" style="min-width: 50px; height:100%; width:20px; right:' + close_right + '; top:0; bottom:0; position:absolute; color:#fff !important; font-size:1.5em; text-decoration:none; line-height:1.5em">&times;</a>';
						usi_boost_container.innerHTML = [
							'<div id="usi_boost_container" style="position:fixed; bottom:0; left:0; width:100%; text-align:center; font-size:1.2em; background:' + bg_color + '; color:#fff; padding:' + padding + '; line-height: 1.2em; z-index:99999999999;">',
							close_button,
							'<p style="color: white !important; margin: 0 20%;">' + boost_txt + '</p>',
							'</div>'
						].join('');
						document.body.appendChild(usi_boost_container);
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
			},
			close: function () {
				try {
					var bar = document.getElementById('usi_boost_container');
					if (bar != null) {
						usi_cookies.set('usi_suppress_boost', '1', usi_cookies.expire_time.day);
						bar.parentNode.removeChild(bar);
					}
				} catch (err) {
					usi_commons.report_error(err);
				}
			}
		};

		usi_app.apply_coupon = function () {
			try {
				var coupon_input = document.querySelector("#formBasicWithHelpBlockText");
				var coupon_button = document.querySelector("button[data-purpose='redeem-code-button']");
				if (coupon_input !== null && coupon_button !== null) {
					var customEvent = new Event('input', {bubbles: true});
					var lastValue = coupon_input.value;
					customEvent.simulated = true;
					coupon_input.value = usi_app.coupon;
					coupon_input.defaultValue = usi_app.coupon;
					var tracker = coupon_input._valueTracker;
					if (tracker) {
						tracker.setValue(lastValue);
					}
					coupon_input.dispatchEvent(customEvent);
					usi_cookies.set("usi_coupon_applied", usi_app.coupon, usi_cookies.expire_time.week);
					usi_cookies.del("usi_coupon");
					usi_app.coupon = "";
					coupon_button.click();
					setTimeout(usi_app.post_apply_coupon, 2000);
					usi_commons.log("[ apply_coupon ] Coupon applied");
				} else {
					if (usi_app.coupon_attempts == undefined) {
						usi_app.coupon_attempts = 0;
					} else if (usi_app.coupon_attempts >= 5) {
						usi_commons.report_error("[ apply_coupon ] Coupon elements not found");
						return;
					}
					usi_app.coupon_attempts++;
					usi_commons.log("[ apply_coupon ] Coupon elements missing, trying again. Tries: " + usi_app.coupon_attempts);
					setTimeout(usi_app.apply_coupon, 1000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.post_apply_coupon = function () {
			try {
				var error_element = document.querySelector(".help-block div[data-purpose='safely-set-inner-html:form:error']");
				var error_message_exists = error_element != null && error_element.textContent.trim() != "";
				if (error_message_exists) {
					usi_commons.report_error("[ post_apply_coupon ] Coupon error message seen");
				} else {
					usi_commons.log_success("[ post_apply_coupon ] Coupon application was successful");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_dom.ready(function () {
			try {
				usi_app.main();
			} catch (err) {
				usi_commons.report_error(err);
			}
		});
	} catch (err) {
		usi_commons.report_error(err);
	}
}
