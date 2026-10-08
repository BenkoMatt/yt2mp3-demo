#!/usr/bin/env bash
# convert.sh — install yt-dlp + ffmpeg so the MP3 one-liners from the demo site work.
# Usage:  git clone https://github.com/BenkoMatt/yt2mp3-demo && cd yt2mp3-demo && bash convert.sh
set -euo pipefail

have() { command -v "$1" >/dev/null 2>&1; }

install_yt_dlp() {
  if have yt-dlp; then
    echo "✅ yt-dlp already installed: $(yt-dlp --version)"
    return
  fi
  if have pipx; then
    pipx install yt-dlp
  elif have brew; then
    brew install yt-dlp
  elif have winget; then
    winget install yt-dlp.yt-dlp
  elif have python3 && python3 -m pip --version >/dev/null 2>&1; then
    python3 -m pip install --user yt-dlp
  elif have dnf; then
    sudo dnf install -y yt-dlp
  elif have pacman; then
    sudo pacman -S --noconfirm yt-dlp
  elif have apt-get; then
    sudo apt-get update && sudo apt-get install -y yt-dlp
  else
    echo "❌ Could not find a way to install yt-dlp. See https://github.com/yt-dlp/yt-dlp#installation" >&2
    exit 1
  fi
  echo "✅ yt-dlp installed"
}

install_ffmpeg() {
  if have ffmpeg; then
    echo "✅ ffmpeg already installed: $(ffmpeg -version | head -1)"
    return
  fi
  if have brew; then
    brew install ffmpeg
  elif have winget; then
    winget install Gyan.FFmpeg
  elif have dnf; then
    sudo dnf install -y ffmpeg
  elif have pacman; then
    sudo pacman -S --noconfirm ffmpeg
  elif have apt-get; then
    sudo apt-get update && sudo apt-get install -y ffmpeg
  else
    echo "⚠️  ffmpeg is required for MP3 conversion — install it manually: https://ffmpeg.org/download.html" >&2
    exit 1
  fi
  echo "✅ ffmpeg installed"
}

install_yt_dlp
install_ffmpeg

echo
echo "All set. Open the demo site, pick a video, hit Copy — then paste it right here."
echo "Quick test:"
echo "  yt-dlp -x --audio-format mp3 --audio-quality 0 -o \"%(title)s.%(ext)s\" \"https://www.youtube.com/watch?v=jNQXAC9IVRw\""