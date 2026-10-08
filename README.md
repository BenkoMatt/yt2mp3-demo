# YT2MP3 · Demo Station

A simple, static demo site for queuing YouTube videos and generating **local MP3
conversion commands** you run yourself.

**🔗 Live site:** https://benkomatt.github.io/yt2mp3-demo/

## What it does

- 📺 **Watch** — paste any YouTube link (watch / youtu.be / shorts / embed) or
  bare 11-character video ID and it plays right on the page via YouTube's
  official privacy-enhanced embed player.
- 📋 **Queue** — build a playlist, stored only in your browser
  (`localStorage`), with titles pulled from YouTube's public oEmbed API.
- ⤓ **Instant download** — the **Download MP3** button (under the player, and
  a ⤓ icon on every queue row) opens
  [cobalt.tools](https://cobalt.tools) — a free, open-source media converter —
  with the video's link already filled in. One click on *Go* and the MP3 saves
  to your device. Your link is processed by cobalt, not by this site.
- 💾 **Local download** — for full control, the site builds a ready-to-run
  [`yt-dlp`](https://github.com/yt-dlp/yt-dlp) command that extracts the audio
  as a **best-quality VBR MP3** on your own machine — with options for
  thumbnail/metadata embedding, chapter splitting, and save-location.

## What it deliberately doesn't do

It does **not** host a server-side MP3 converter. GitHub Pages is static-only,
and public "YouTube → MP3" web converters operate in a legal gray zone, are
riddled with popups/malvertising, get rate-limited or shut down constantly, and
scale poorly. This project avoids all of that by separating browsing (the
website) from extraction (your local `yt-dlp` run): the site builds the command,
your machine does the work. One copy of the command is a one-liner; a whole
folder or playlist can be converted by pointing it at a text file of URLs.

## Quick start (getting MP3s on your machine)

```bash
git clone https://github.com/BenkoMatt/yt2mp3-demo.git
cd yt2mp3-demo
bash convert.sh     # installs yt-dlp + ffmpeg for your OS
```

Then open the live site, pick a video, hit **Copy**, and paste the command in
your terminal. A `name.mp3` file appears in your current directory (or
`~/Music` if you checked that option).

## Files

| File | Purpose |
|---|---|
| `index.html` | The entire site — single self-contained file, no build step, no dependencies beyond Google Fonts and the YouTube embed iframe. |
| `convert.sh` | One-shot installer for yt-dlp + ffmpeg (macOS/Windows/Linux). |

## Notes

- Videos are always streamed from YouTube; this site never proxies or stores
  media.
- The queue lives in your browser's `localStorage` — no accounts, no database,
  no tracking.
- Only convert content you have the right to download.
- If a video blocks embedded playback, open the standard watch URL instead —
  the Copy-command still works fine even when the iframe can't play.

## License

MIT