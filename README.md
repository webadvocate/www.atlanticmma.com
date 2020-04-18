# www.atlanticmma.com

Years ago, a dynamic site was built for <https://www.atlanticmma.com>. That site is now mostly defunct, but does carry some SEO value for the owner, who also operates the active sites <https://fightforitcompany.com/> and <https://store.atlanticmma.com/>.

To keep that SEO value without having to "keep the site running" on a managed server, this repo:

1. Took a snapshot of the dynamic site using [HTTrack website copier](http://www.httrack.com/)
2. Pages original at a URL like `/zip/zap` became `/zip/zap.html`. So, to keep a similar "dynamic site URL", copies of `/zip/zap.html` were made at `/zip/zap/index.html` (which properly configured web servers will display when asked for the original `/zip/zap` URL)
3. Updated all links to point to the dynamic-like URLs enabled by step 2.

## Hosting

This site is now hosted here at GitHub on their Pages feature.
