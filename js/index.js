(function (console, $hx_exports) { "use strict";
var HxOverrides = function() { };
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Main = $hx_exports.Main = function() { };
Main.main = function() {
	Web.ajax({ url : "http://en.wikipedia.org/w/api.php", options : (function($this) {
		var $r;
		var _g = new haxe_ds_StringMap();
		if(__map_reserved.action != null) _g.setReserved("action","query"); else _g.h["action"] = "query";
		if(__map_reserved.list != null) _g.setReserved("list","search"); else _g.h["list"] = "search";
		if(__map_reserved.callback != null) _g.setReserved("callback","Main.callback"); else _g.h["callback"] = "Main.callback";
		if(__map_reserved.format != null) _g.setReserved("format","json"); else _g.h["format"] = "json";
		if(__map_reserved.srsearch != null) _g.setReserved("srsearch","albert"); else _g.h["srsearch"] = "albert";
		$r = _g;
		return $r;
	}(this))});
};
Main.callback = function(response) {
	window.console.log(response);
	var search_results = Web.getEl("search-results");
	search_results.innerHTML = "";
	var _g = 0;
	while(_g < 10) {
		var i = _g++;
		search_results.innerHTML += "<p>" + response.query.search[i] + "</p>";
	}
};
var Web = function() { };
Web.getEl = function(el) {
	return window.document.getElementById(el);
};
Web.ajax = function(request) {
	var script;
	var _this = window.document;
	script = _this.createElement("script");
	script.src = request.url + "?";
	var first = true;
	var $it0 = request.options.keys();
	while( $it0.hasNext() ) {
		var key = $it0.next();
		if(!first) script.src += "&"; else first = false;
		script.src += "" + key + "=" + request.options.get(key);
	}
	window.document.head.appendChild(script);
};
var haxe_IMap = function() { };
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	get: function(key) {
		if(__map_reserved[key] != null) return this.getReserved(key);
		return this.h[key];
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,keys: function() {
		var _this = this.arrayKeys();
		return HxOverrides.iter(_this);
	}
	,arrayKeys: function() {
		var out = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) out.push(key);
		}
		if(this.rh != null) {
			for( var key in this.rh ) {
			if(key.charCodeAt(0) == 36) out.push(key.substr(1));
			}
		}
		return out;
	}
};
var __map_reserved = {}
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}}, typeof window != "undefined" ? window : exports);
