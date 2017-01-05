
import js.Browser;
// https://en.wikipedia.org/w/api.php

typedef SearchResult = {
    ns:Int,
    title:String,
    size:Int,
    wordcount:Int,
    snippet:String,
    timestamp:Date
};

typedef WikipediaResponse = {
    var batchcomplete:String;
    var _continue:{
        sroffset:Int,
        _continue:String
    };
    var query:{
        searchinfo:{totalhits:Int},
        search:Array<SearchResult>
    };
}

@:expose
class Main {
    public static var results:Array<SearchResult> = [];
    public static function main() {
        // Web.getEl("search-btn").onclick=search;
    }

    public static function search() {
        var searchBar:js.html.InputElement = cast Web.getEl("search-bar");
        var searchQuery = searchBar.value;
        if (searchQuery == "") return;
        var ajaxObj = {
            url: "https://en.wikipedia.org/w/api.php",
            options: [
                "action" => "query",
                "list"   => "search",
                "callback" => "Main.callback",
                "format" => "json",
                "srsearch" => searchQuery
            ]
        };
        Browser.console.log(ajaxObj);
        Web.ajax(ajaxObj);
    }

    public static function callback(response) {
        Browser.console.log(response);
        if (Reflect.hasField(response, "error")) {
            return;
        }
        for(i in 0...10) {
            results.push(response.query.search[i]);
        }

        var search_results = Web.getEl("search-results");
        search_results.innerHTML = "";
        for(result in results) {
            search_results.innerHTML
            += '<div>'
            + '<h3>${result.title}</h3>'
            + '<p>${result.snippet}</p>'
            + '</div>';
        }
    }
}
