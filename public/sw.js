// Self-destructing service worker to clear browser caches automatically
self.addEventListener('install', (e) => {
  self.skipWaiting();
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.map((key) => caches.delete(key))
      );
    }).then(() => {
      return self.clients.claim();
    })
  );
});

// Force all page requests to fetch directly from network instead of cache
self.addEventListener('fetch', (e) => {
  e.respondWith(fetch(e.request));
});
