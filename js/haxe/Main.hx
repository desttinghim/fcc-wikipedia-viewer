
import js.Browser;
// https://en.wikipedia.org/w/api.php


@:expose
class Main {
    public static function main() {
        Web.ajax({
            url: "http://en.wikipedia.org/w/api.php",
            options: [
                "action" => "query",
                "list"   => "search",
                "callback" => "Main.callback",
                "format" => "json",
                "srsearch" => "albert"
            ]
        });
    }

    public static function callback(response) {
        Browser.console.log(response);
        var search_results = Web.getEl("search-results");
        search_results.innerHTML = "";
        for(i in 0...10) {
            search_results.innerHTML += '<p>${response.query.search[i]}</p>';
        }
    }
}
