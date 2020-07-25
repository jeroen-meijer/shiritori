'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "78d4086ae70c66185006553a31abece7",
"assets/NOTICES": "dbf8f08a96bdfd993147044e4fec284b",
"assets/assets/images/png/background_main.png": "344332b848e0323fb1616d581eda1b4f",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_Thin.otf": "615be1d79e6a6fb252d3594561aec966",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_Hairline.otf": "5f0c67466f09c73abf4aea4021f2b0f1",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_SemiBold.otf": "b28e5dfcd2aafa4a88933c9956d5039c",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_Italic.otf": "7463798a3018cf4a205d3b2a238e993b",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_Black.otf": "f8008876b55dde09abe1e21c0ffc8202",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_BoldItalic.otf": "eb0638ad283586e93f249cb0814c977a",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_BlackItalic.otf": "1cfb2f18a932dfd986912541c33129ed",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_SemiBoldItalic.otf": "4d5012c96a024133bae17a1de32b9db3",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_ThinItalic.otf": "8c8b1e1922cc7fad270476781a341067",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_Light.otf": "5988d74518540196eab93df313717030",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_HairlineItalic.otf": "5c8672bfb3cab3925c9b46ab7c8cb658",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_LightItalic.otf": "cdab2405f46561157af85d49796d18ab",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans.otf": "9a1c38b146fdefa536071a96f0a2de5a",
"assets/assets/fonts/HurmeGeometricSans/HurmeGeometricSans_Bold.otf": "5388ff962f52857cd5c503ebc8760558",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "5a37ae808cf9f652198acde612b5328d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "2aa350bd2aeab88b601a593f793734c0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2bca5ec802e40d3f4b60343e346cedde",
"assets/AssetManifest.json": "3422900c4e980e86f5c0c3ee5123ed7b",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/FontManifest.json": "bd92d232006ecbe75336936a53f66c8b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "96a7f3dbcef4359bdc350de9aa01ff3a",
"/": "96a7f3dbcef4359bdc350de9aa01ff3a",
"main.dart.js": "78dec5622b813536d16ab1369415d0d2",
"CNAME": "f8d7c1c5188c3b9c766848af0f1433d0"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
