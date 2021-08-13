'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "4b6db237b3514a88107a422469adfb0f",
"splash/img/light-2x.png": "7d44bcc50b8238750f950429768c1f8d",
"splash/img/light-3x.png": "29b541f66333233181d1c4ec189a122d",
"splash/img/dark-3x.png": "29b541f66333233181d1c4ec189a122d",
"splash/img/dark-2x.png": "7d44bcc50b8238750f950429768c1f8d",
"splash/img/dark-1x.png": "8495cf9d20d6ea14d0c12e4bdf8de9ef",
"splash/img/light-1x.png": "8495cf9d20d6ea14d0c12e4bdf8de9ef",
"splash/style.css": "9e69e26c7b076022a7791c7f82b7112c",
"index.html": "8b379a6c5f657ed74942d3660f449fe7",
"/": "8b379a6c5f657ed74942d3660f449fe7",
"main.dart.js": "9b70772fc5f5091fa84c25d5a34e1a41",
"README.md": "5a7ab8bac20b65312d17806424f2141a",
"favicon.png": "043a28ca5c9f49b30c6d1ad5de93acdc",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "15f73b7e8a8209c2206210b3ac8dea1b",
".git/config": "da3ea826b23bba97f156b5010558bcaf",
".git/objects/61/1f6255a63548797a83fdc11cb94399c47f9607": "5fd645a462f6961d3f22f97bbe97d4bf",
".git/objects/92/65271423f84461d77884d2951fb8bc3d1fd82a": "b19ea62170f08eea8d0867d33c16947d",
".git/objects/3e/7130e6d2dbca697d5ce01fe303fdbd0af7d5ee": "4b5962cbceb66e5b7245c352f3080b51",
".git/objects/32/46ad559eeae0370195978eaed83f1053ee13fd": "a043dbc0a0bda96ce2127799ccc27506",
".git/objects/93/3cc3d1aaab53770e9833f391aa20dc54668590": "4afe2be01096515b32f07ec72319e5b0",
".git/objects/9d/55e33e167ff8fb007083af35c7a6578503a429": "1f134c44f15e36b42ff4cfafa3d6e34a",
".git/objects/b5/1d162eaea4bce4f8fcaf486b578838dba5549d": "bc2d7c17d8a3eba4305111c253f320f7",
".git/objects/c1/da5b936c42ef90336ae98b949b8da9511a543f": "61488eab4906d612963cf5ab48ea7c4e",
".git/objects/4e/e3b4d0a4f0361a20d639c0deb4e861572b9b79": "64da31f131585d04dec01af293c23fea",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/27/c6ac9af2105ecb0e74ab740209d97753afefbb": "3d91ec36942ab8113db5bf8af2007ace",
".git/objects/pack/pack-17fe2952d3caf6439d56d25570958e8159a47769.idx": "ae7fe3914c795cf34c206038b41782ed",
".git/objects/pack/pack-17fe2952d3caf6439d56d25570958e8159a47769.pack": "060cd1631b1c8c470ef562f74d3f1143",
".git/objects/7d/a479d7a35144d5e344e8c66030d4cccd04ee9f": "0c78bdf27378ba2e680115afe95074e8",
".git/objects/7c/9203ddc543de5a45219d7bcbdcc0d4f8668e9c": "8d3b1a6fdf05db744c1103108888c0b7",
".git/objects/16/a2f3a01ccc22e2874252c507eff19f38f6c5db": "035eb883d4ae40e5e0766b34c363c114",
".git/objects/89/2b10203353a2072ead20954e9e81069fbd0f9d": "10ca323b649c97550bdd7c970a5bd7d8",
".git/objects/21/c9f052c1363db308990bc5af6f5fe8172b65fb": "20ac946899309305b9b0baa1271834fb",
".git/objects/4d/2027ac0f677a0e4b0b93cfa46a2175057d8d20": "b21f46dd0024cd9a803ce9dd75351426",
".git/objects/4d/9b9f0c01451f3fc37471a25a4fc5fc81aec577": "41b77fac8341085b1de6eb441a6327cd",
".git/objects/86/64024f1b5b679305cf6e07ba6945913cfd5510": "40323ea53a9df1ae0c8a50bd8a5b49fc",
".git/objects/43/b56877e7c59dc9e890cca3a400d5a4756ef974": "a7b170f6b5c3cd4d5c15717bccbff969",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/5c/81ef9daf6134c9604260f6b551a7943fcd981b": "c1d9ed559871cde2982a88756ac1ed5f",
".git/objects/98/0f5d087bd3d9a58d0d2911998a22f9e6beb238": "44a9fa4228b3662ad7cfc9ea4475b6ea",
".git/objects/6d/6b8cfc66f1e47828f81193e05ed8354b8a2cc1": "fc7dce3e766cb78adfe560aad5b9e095",
".git/objects/dd/1284110623652fc881819e8e366dc6ad4e35d8": "b9a61c15663d9f9d74cb49f1b0f85dc6",
".git/objects/dc/c57bdd6014e03149e75d71ef9e9d109cb822f8": "44aa6df514ebb238f845b57abff331f5",
".git/objects/dc/6ee9352c4c6badbebfb4a64fd20a7d8ae31804": "a8d962d88ca56c5d989685649b8619da",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/a8/beffd3ad4fe54d6cabccf83a05477d6a986cd0": "6677888e4a051c7838b5b240c09f0981",
".git/objects/de/5ce2e146005c2d0d91df4af58969a20a367bfd": "ac5a2e16e3a0f90f8ce6e0f069b70726",
".git/objects/fa/4c49ffef0ac18251e8dab7bfa0ed8eba5e5019": "ac6d97c818a1972888f49296eeab1c23",
".git/objects/e9/d942b1b6658555c5538d24c5c660c4fe6690f3": "fdf83bb1a2f5d472eb339add79203303",
".git/objects/41/de173d9014b38f8290acf270c490b37fc79a60": "d2a9d01215e9d65fd0456ded49e98878",
".git/objects/77/e6ec66d91e31f51bf877057e49fadae4376eea": "1e4a068d958d1e23417a046f3a4a951e",
".git/objects/8c/012917dab71a26d535ff8c614582477a123a6d": "22939eff7a0cb1fc6bb53c9bf363b949",
".git/objects/1c/f06a49ae93318993b5464e4c46a0bb9aa045f5": "2811e434f8c67b9cba6c12a8e517049e",
".git/objects/47/84f12a4eb8d84a6e0c889fabd9cf10c036eb27": "db40951ec0021a19724f137430a5b660",
".git/objects/22/4c8598e66ff992b3a1d9cd15b8c5a406c577ef": "408024dedeadd3ef83449265f889ff00",
".git/objects/25/4d3b06baa0368416c22ddbf146a349c27633c7": "2d8843e6699b897227f2846dc8d89923",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "955306ee277e9310b5cfe4ece1babbae",
".git/logs/refs/heads/main": "955306ee277e9310b5cfe4ece1babbae",
".git/logs/refs/remotes/origin/HEAD": "679ebb4fc6ddc88318d3a0f7432d882d",
".git/logs/refs/remotes/origin/main": "dccb50c2aeea927bb558efe177406e82",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/refs/heads/main": "3feee01fcae31e69af825badd9ffc405",
".git/refs/remotes/origin/HEAD": "98b16e0b650190870f1b40bc8f4aec4e",
".git/refs/remotes/origin/main": "3feee01fcae31e69af825badd9ffc405",
".git/index": "ac04742bd665612508af3bed88aafb8d",
".git/packed-refs": "af8185ac1c9cf61520a947e4440541af",
".git/COMMIT_EDITMSG": "c085f9acd3be1296f727b0ea4e7dda0d",
".git/FETCH_HEAD": "ce63c269e25a2b6b81e273f9c79aca3a",
"assets/flutter_logo.png": "8ba1d5b022cd7f5999bea3085e87ceb0",
"assets/revoAI_splash.png": "5b3cbbbd1c1effa052d359e585795fda",
"assets/AssetManifest.json": "adb85c964156290e0dbd913186b3e2b4",
"assets/NOTICES": "01dbf4b2ace780006bffd04b81d4338f",
"assets/FontManifest.json": "902ce225e20752e4e247924745cb9719",
"assets/packages/fluent_ui/fonts/FluentIcons.ttf": "271d442bc916d844bd9cac2735f640f2",
"assets/packages/fluent_ui/assets/AcrylicNoise.png": "81f27726c45346351eca125bd062e9a7",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/revoAI_logo.png": "757294e11c364ad40e17e1f654b0264f",
"assets/assets/fonts/segoeuil.ttf": "2f33e5b8296ff8a949d21f8222467896",
"assets/assets/fonts/segoeuisl.ttf": "8fcda7866f16c3ab1d7b2c013f3e8d63",
"assets/assets/fonts/seguisb.ttf": "51b30c88c46360fa96a4e0cfa7adec53",
"assets/assets/fonts/segoeuib.ttf": "a11bd197c1de7c57b310e6bb0ec02e6c",
"assets/assets/fonts/segoeui.ttf": "f8eba47b5b1a6cea939065d461e0f4f1"
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
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
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
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
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
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
