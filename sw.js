const CACHE_NAME = 'esp-flash-tool-v1';

const PRECACHE_URLS = [
  '/',
  '/index.html',
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png',
];

const CDN_URLS = [
  'https://cdn.jsdelivr.net/npm/xterm@5.3.0/css/xterm.min.css',
  'https://cdn.jsdelivr.net/npm/xterm@5.3.0/lib/xterm.min.js',
  'https://cdn.jsdelivr.net/npm/xterm-addon-fit@0.8.0/lib/xterm-addon-fit.min.js',
  'https://cdn.jsdelivr.net/npm/crypto-js@4.2.0/crypto-js.js',
  'https://unpkg.com/esptool-js@0.5.7/bundle.js',
];

/* Install: precache local assets */
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(PRECACHE_URLS).catch(() => {
        /* Non-critical: some assets may not be available during first install */
      });
    })
  );
  self.skipWaiting();
});

/* Activate: clean old caches */
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((key) => key !== CACHE_NAME)
          .map((key) => caches.delete(key))
      )
    )
  );
  self.clients.claim();
});

/* Fetch: stale-while-revalidate for CDN, cache-first for local */
self.addEventListener('fetch', (event) => {
  const url = event.request.url;

  /* Skip non-GET requests */
  if (event.request.method !== 'GET') return;

  /* For CDN resources: cache first, then network update */
  if (CDN_URLS.some((cdn) => url.startsWith(cdn.split('?')[0]))) {
    event.respondWith(
      caches.open(CACHE_NAME).then((cache) =>
        cache.match(event.request).then((cached) => {
          const fetchPromise = fetch(event.request)
            .then((response) => {
              if (response.ok) {
                cache.put(event.request, response.clone());
              }
              return response;
            })
            .catch(() => cached);

          return cached || fetchPromise;
        })
      )
    );
    return;
  }

  /* For local resources: cache first */
  event.respondWith(
    caches.match(event.request).then((cached) => {
      if (cached) return cached;
      return fetch(event.request).then((response) => {
        if (response.ok) {
          const clone = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(event.request, clone));
        }
        return response;
      });
    })
  );
});
