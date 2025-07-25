# 📲 Scrape Down YT

A Flutter-based mobile app that combines **web scraping for offline news** with a powerful **YouTube video/audio downloader**. Designed for media enthusiasts and offline users, this app gives you full control over content you want to read, watch, or listen to—**without needing to be online all the time.**

---

## ✨ Features

### 📰 Offline News Scraper
- Scrapes latest articles from websites (text + images)
- Saves pages offline for later reading (upcoming)
- Clean layout optimized for mobile

### 🎥 YouTube Video & Audio Downloader
- Paste YouTube URL and fetch video/audio metadata
- Download videos as `.mp4` or audio as `.mp3`
- Show download progress and save locally
- Displays thumbnail previews

### 🎵 Built-in Offline Media Player
- Play downloaded `.mp3` or `.mp4` files
- Seek bar, pause/play support
- Sleek, music app–like UI inspired by YouTube Music

---

 ### Upcoming Features / TODO
- Add search functionality for scraping news
- Offline News Pages
- Show download progress indicator for videos

## 📸 Screenshots (Add your screenshots here)

| Home Page | News Page | Download Page |
|-----------|-----------|----------------|
| ![Home](screenshots/home.png) | ![News](screenshots/news.png) | ![Download](screenshots/download.png) |

---

## 🛠️ Getting Started
you will find the apk file inside 
"news_scrapper\build\app\outputs\flutter-apk\app-debug.apk"

## 📦 Download APK

You can download the latest version of the app from [app-debug.apk](https://github.com/ashmit-d/scrap-down-yt/blob/main/app-debug.apk?raw=true).



### Prerequisites

- Flutter 3.x
- Dart SDK
- Python 3.x (for backend)
- Git
- FFmpeg (optional, for format conversions)
- [youtube_dl](https://github.com/ytdl-org/youtube-dl) or [pytube](https://github.com/pytube/pytube)

### Clone the Repo
```bash
git clone https://github.com/ashmit-d/scrap-down-yt.git
cd scrap-down-yt
