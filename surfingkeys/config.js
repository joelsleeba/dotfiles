// Remove default search engines
api.removeSearchAlias("b", "s");
api.removeSearchAlias("e", "s");
api.removeSearchAlias("d", "s");
api.removeSearchAlias("g", "s");
api.removeSearchAlias("h", "s");
api.removeSearchAlias("w", "s");
api.removeSearchAlias("y", "s");
api.removeSearchAlias("s", "s");

// Search aliases
api.addSearchAlias("1337", "1337x", "https://1337x.to/search/");
api.addSearchAlias(
  "aa",
  "annas archive",
  "https://annas-archive.gd/search?q=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=firefox&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "add",
  "Firefox Add-ons",
  "https://addons.mozilla.org/en-US/firefox/search/?q=",
  "s",
  "https://addons.mozilla.org/api/v5/addons/search/?app=firefox&sort=relevance&q=",
  function (response) {
    const res = JSON.parse(response.text);

    if (!res.results) return [];

    return res.results.map(function (addon) {
      return {
        title: `${addon.name} ⭐ ${addon?.average_rating || "N/A"}`,
        url: addon.url,
      };
    });
  },
);
api.addSearchAlias(
  "alt",
  "alternativeto",
  "https://alternativeto.net/browse/search/?q=",
);
api.addSearchAlias(
  "amz",
  "amazon",
  "https://www.amazon.com/s?k=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=firefox&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "apt",
  "Columbia Court",
  "https://bryten.myresman.com/Portal/Access/SignIn/CACC",
);
api.addSearchAlias(
  "arch",
  "arch packages",
  "https://archlinux.org/packages/?q=",
  "s",
  "https://archlinux.org/packages/search/json/?q=",
  function (response) {
    const res = JSON.parse(response.text);

    return res.results.map(function (pkg) {
      return {
        title: `${pkg.pkgname} (${pkg.repo})`,
        url: `https://archlinux.org/packages/${pkg.repo}/${pkg.arch}/${pkg.pkgname}/`,
      };
    });
  },
);
api.addSearchAlias(
  "arwk",
  "arch wiki",
  "https://wiki.archlinux.org/index.php?search=",
  "s",
  "https://wiki.archlinux.org/api.php?action=opensearch&format=json&formatversion=2&search=",
  function (response) {
    var res = JSON.parse(response.text);

    // res format:
    // [query, [titles], [descriptions], [urls]]

    var titles = res[1] || [];
    var urls = res[3] || [];

    return titles.map(function (title, i) {
      return {
        title: title,
        url: urls[i],
      };
    });
  },
);
api.addSearchAlias(
  "aur",
  "Arch User Repository",
  "https://aur.archlinux.org/packages?O=0&K=",
  "s",
  "https://aur.archlinux.org/rpc/?v=5&type=search&arg=",
  function (response) {
    const res = JSON.parse(response.text || response);

    if (!res || !Array.isArray(res.results)) return [];

    return res.results.map((pkg) => ({
      title: `${pkg.Name} (${pkg.NumVotes} votes)`,
      url: `https://aur.archlinux.org/packages/${pkg.Name}/`,
    }));
  },
);
api.addSearchAlias("b", "bing", "https://www.bing.com/search?q=");
api.addSearchAlias(
  "camel",
  "camel",
  "https://camelcamelcamel.com/search?sq=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=firefox&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "cb",
  "cineby",
  "https://www.cineby.at/",
  "s",
  "https://db.speedracelight.com/3/search/multi?language=en&page=1&query=",
  function (response) {
    var res = JSON.parse(response.text);

    if (!res.results) return [];
    return res.results
      .filter(function (r) {
        return r.media_type === "movie" || r.media_type === "tv";
      })
      .map(function (r) {
        var title = r.name || r.title || "unknown";
        var url = "https://www.cineby.sc/" + r.media_type + "/" + r.id;

        return {
          title: title,
          url: url,
        };
      });
  },
);
api.addSearchAlias(
  "cr",
  "crossref",
  "https://search.crossref.org/search/works?q=",
);
api.addSearchAlias("d", "duckduckgo", "https://duckduckgo.com/?q=");
api.addSearchAlias("ddg", "duckduckgo html", "https://duckduckgo.com/html?q=");
api.addSearchAlias(
  "deb",
  "debian packages",
  "https://packages.debian.org/search?keywords=",
);
api.addSearchAlias("doi", "doi", "https://doi.org/");
api.addSearchAlias("fdroid", "fdroid", "https://search.f-droid.org/?q=");
api.addSearchAlias(
  "fontaw",
  "fontawesome",
  "https://fontawesome.com/search?q=",
);
api.addSearchAlias("flipk", "flipkart", "https://www.flipkart.com/search?q=");
api.addSearchAlias(
  "fx",
  "flixer",
  "https://www.flixer.gd/",
  "s",
  "https://plsdontscrapemelove.flixer.gd/api/tmdb/search/multi?language=en-US&query=",
  function (response) {
    var res = JSON.parse(response.text);

    if (!res.results) return [];
    return res.results
      .filter(function (r) {
        return r.media_type === "movie" || r.media_type === "tv";
      })
      .map(function (r) {
        var title = r.name || r.title || "unknown";
        var url =
          "https://flixer.gd/watch/" + r.media_type + "/" + r.id + "/1/1";

        return {
          title: title,
          url: url,
        };
      });
  },
);
api.addSearchAlias(
  "gadd",
  "Chrome Webstore",
  "https://chromewebstore.google.com/search/",
  "s",
  "https://suggestqueries.google.com/complete/search?client=chrome&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "gh",
  "github",
  "https://github.com/search?q=",
  "s",
  "https://github.com/search/suggest?q=",
  function (response) {
    var res = JSON.parse(response.text);
    if (!res.repositories) {
      return [];
    }

    return res.repositories.map(function (r) {
      return r.name;
    });
  },
);
api.addSearchAlias(
  "ghr",
  "github repo",
  "https://github.com/search?q=",
  "s",
  "https://api.github.com/search/repositories?q=",
  function (response) {
    const res = JSON.parse(response.text);

    if (!res.items) return [];

    return res.items.map(function (repo) {
      return {
        title: `${repo.full_name} ⭐ ${repo.stargazers_count}`,
        url: repo.html_url,
      };
    });
  },
);
api.addSearchAlias(
  "ghrj",
  "github joelsleeba",
  "https://github.com/joelsleeba/",
);
api.addSearchAlias(
  "gg",
  "google",
  "https://www.google.com/search?q=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=chrome&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "gi",
  "google images",
  "https://www.google.com/search?tbm=isch&q=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=chrome&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "git",
  "git scm",
  "https://git-scm.com/search/results?search=",
);
api.addSearchAlias(
  "gmap",
  "google maps",
  "https://www.google.com/maps/search/",
  "s",
  "https://nominatim.openstreetmap.org/search?format=json&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res.map(function (place) {
      return place.display_name;
    });
  },
);
api.addSearchAlias(
  "gsch",
  "google scholar",
  "https://scholar.google.com/scholar?hl=en&q=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=chrome&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "gw",
  "gentoo wiki",
  "https://wiki.gentoo.org/index.php?title=Special:Search&search=",
);
api.addSearchAlias("heb", "heb", "https://www.heb.com/search?esc=true&q=");
api.addSearchAlias("imdb", "imdb", "https://www.imdb.com/find?q=");
api.addSearchAlias(
  "lb",
  "libgen",
  "https://libgen.li/index.php?req=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=firefox&q=",
  function (response) {
    var res = JSON.parse(response.text);

    return res[1];
  },
);
api.addSearchAlias(
  "man",
  "arch man pages",
  "https://man.archlinux.org/search?q=",
  "s",
  "https://duckduckgo.com/ac/?q=site%3Aman.archlinux.org+",
  function (response) {
    var res = JSON.parse(response.text);

    return res.map(function (r) {
      return r.phrase.replace(/^site:man\.archlinux\.org\s*/, "");
    });
  },
);
api.addSearchAlias(
  "mdn",
  "mdn",
  "https://developer.mozilla.org/en-US/search?q=",
);
api.addSearchAlias("mov", "movie web", "https://movie-web.us/#/browse/");
api.addSearchAlias(
  "mstack",
  "math stackexchange",
  "https://math.stackexchange.com/search?q=",
);
api.addSearchAlias("oeis", "oeis", "https://oeis.org/search?q=");
api.addSearchAlias("ping", "fast speed test", "https://fast.com");
api.addSearchAlias(
  "ppd",
  "piped video",
  "https://piped.video/results?search_query=",
);
api.addSearchAlias(
  "pydoc",
  "python docs",
  "https://docs.python.org/3/search.html?q=",
);
api.addSearchAlias(
  "q",
  "Quant",
  "https://www.qwant.com/?q=",
  "s",
  "https://api.qwant.com/v3/suggest?q=%s",
  function (response) {
    var res = JSON.parse(response.text);
    return res.data.items.map(function (item) {
      return item.value;
    });
  },
);
api.addSearchAlias(
  "r",
  "reddit",
  "https://www.reddit.com/search/?q=",
  "s",
  "https://www.reddit.com/search.json?q=",
  function (response) {
    var res = JSON.parse(response.text);
    return res.data.children.map(function (post) {
      return "[" + post.data.subreddit + "] " + post.data.title;
    });
  },
);
api.addSearchAlias(
  "rtt",
  "rotten tomatoes",
  "https://www.rottentomatoes.com/search?search=",
);
api.addSearchAlias("rx", "arxiv", "https://arxiv.org/search/?query=");
api.addSearchAlias("rxpdf", "arxiv pdf", "https://arxiv.org/pdf/");
api.addSearchAlias("shub", "scihub", "https://sci-hub.se/");
api.addSearchAlias(
  "sp",
  "startpage",
  "https://www.startpage.com/do/search?query=",
);
api.addSearchAlias("spt", "spotify", "https://open.spotify.com/search/");
api.addSearchAlias(
  "sr",
  "subreddit",
  "https://reddit.com/r/",
  "s",
  "https://www.reddit.com/api/subreddit_autocomplete_v2.json?include_over_18=true&query=",
  function (response) {
    var res = JSON.parse(response.text);
    return res.data.children.map(function (child) {
      var name = child.data.display_name; // e.g. javascript

      return {
        title: "r/" + name,
        url: "https://reddit.com/r/" + name,
      };
    });
  },
);
api.addSearchAlias("srx", "searx", "https://searx.thegpm.org/?q=");
api.addSearchAlias(
  "stkofl",
  "stackoverflow",
  "https://stackoverflow.com/search?q=",
);
api.addSearchAlias(
  "uhlib",
  "UH libraries",
  "https://uh.primo.exlibrisgroup.com/discovery/search?vid=01UHO_INST:UHMAIN&query=any,contains,",
);
api.addSearchAlias(
  "wk",
  "Wikipedia",
  "https://en.wikipedia.org/w/index.php?search=",
  "s",
  "https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=",
  function (response) {
    var res = JSON.parse(response.text);
    return res[1]; // suggestion titles
  },
);
api.addSearchAlias(
  "yt",
  "Youtube",
  "https://www.youtube.com/results?search_query=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=",
  function (response) {
    var res = JSON.parse(response.text);
    return res[1];
  },
);
api.addSearchAlias(
  "ytm",
  "Youtube Music",
  "https://music.youtube.com/search?q=",
  "s",
  "https://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=",
  function (response) {
    var res = JSON.parse(response.text);
    return res[1];
  },
);
api.addSearchAlias("zb", "zbMATH", "https://zbmath.org/?q=");

// api.addSearchAlias(
//   "pdf",
//   "pdf invert tool",
//   'javascript:void(document.getElementById("viewer").style.filter="invert(100%) hue-rotate(180deg)")',
//
// );

settings.defaultSearchEngine = "q";
settings.scrollStepSize = 140;
settings.tabsThreshold = 0;
settings.tabsMRUOrder = false;

// Always use Omnibar for tabs
api.mapkey("<Space>", "Choose a tab with omnibar", function () {
  api.Front.openOmnibar({ type: "Tabs" });
});

// Open Hint in new tab
api.map("F", "C");
api.unmap("C");

// --- Nav ---
// Open Clipboard URL in current tab
api.mapkey("p", "Open the clipboard's URL in the current tab", () => {
  Clipboard.read(function (response) {
    window.location.href = response.data;
  });
});

// Open Clipboard URL in new tab
api.map("P", "cc");

// Open a URL in current tab
// api.map("s", "o"); // shift the function of 'o' to 's'
// api.map("o", "go");

// Choose a buffer/tab
api.map("b", "T");
api.unmap("T");

// Edit current URL, and open in same tab
api.map("O", ";U");

// Edit current URL, and open in new tab
api.map("T", ";u");

// History Back/Forward
api.map("H", "S");
api.map("L", "D");
api.unmap("S");
api.unmap("D");

// Scroll Page Down/Up
api.mapkey("<Ctrl-d>", "Scroll down", () => {
  api.Normal.scroll("pageDown");
});
api.mapkey("<Ctrl-u>", "Scroll up", () => {
  api.Normal.scroll("pageUp");
});
api.map("<Ctrl-b>", "U"); // scroll full page up
//map('<Ctrl-f>', 'P');  // scroll full page down -- looks like we can't overwrite browser-native binding

// Next/Prev Page
// api.map('K', '[[');
// api.map('J', ']]');

// Open Chrome Flags
api.unmap("gs");
api.mapkey("gs", "#12Open Chrome Settings", () => {
  api.tabOpenLink("helium://settings/");
});
api.mapkey("gF", "#12Open Chrome Flags", () => {
  api.tabOpenLink("helium://flags/");
});

// --- Tabs ---
// Tab Delete/Undo
api.map("d", "x");
api.unmap("x");
// api.mapkey("d", "#3Close current tab", () => {
//   api.RUNTIME("closeTab");
// });
api.mapkey("u", "#3Restore closed tab", () => {
  api.RUNTIME("openLast");
});

// Move Tab Left/Right w/ one press
api.map(">", ">>");
api.map("<", "<<");

// Tab Next/Prev
api.map("K", "R");
api.map("J", "E");

// Change focused frame
api.map("gf", "w");

// ---- Unmap -----
api.unmap("E");
api.unmap("R");
api.unmap("x");
// Proxy Stuff
api.unmap("spa");
api.unmap("spb");
api.unmap("spc");
api.unmap("spd");
api.unmap("sps");
api.unmap("cp");
api.unmap(";cp");
api.unmap(";ap");

// Emoji
api.unmap(":");

// Misc
api.unmap(";t");
api.unmap("si");
api.unmap("ga");
api.unmap("gc");
api.unmap("gn");
api.unmap("gr");
api.unmap("ob");
api.unmap("og");
api.unmap("od");
api.unmap("oy");

api.iunmap("<Ctrl-a>");

// set theme
settings.theme = `
.sk_theme {
    font-family: Noto Sans, Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;
// click `Save` button to make above settings to take effect.
