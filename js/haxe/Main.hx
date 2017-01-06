
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
        Web.ajax(ajaxObj);
    }

    public static function callback(response) {
        if (Reflect.hasField(response, "error")) {
            return;
        }
        results = [];
        for(i in 0...10) {
            results.push(response.query.search[i]);
        }

        var search_results = Web.getEl("search-results");
        while (search_results.hasChildNodes()) {
            search_results.removeChild(search_results.lastChild);
        }
        for(result in results) {
            search_results.innerHTML
            += '<div>'
            + '<a href="https://en.wikipedia.org/wiki/${result.title}"><h3>${result.title}</h3></a>'
            + '<p>${result.snippet}</p>'
            + '</div>';
        }
    }
}
