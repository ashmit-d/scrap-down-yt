from flask import Flask, request, jsonify
import yt_dlp
import os

app = Flask(__name__)

download_progress = 0

# Progress hook function
def progress_hook(d):
    global download_progress
    if d['status'] == 'downloading':
        downloaded = d.get('downloaded_bytes', 0)
        total = d.get('total_bytes', 1)
        download_progress = downloaded / total if total > 0 else 0


# Endpoint to search YouTube
@app.route('/search', methods=['GET'])
def search_youtube():
    query = request.args.get('query')
    if not query:
        return jsonify({"error": "No search query provided"}), 400

    ydl_opts = {
        'quiet': True,
        'extract_flat': True,
        'force_generic_extractor': True,
    }
    
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        result = ydl.extract_info(f"ytsearch5:{query}", download=False)
        videos = result.get("entries", [])
    
    return jsonify(videos)

# Endpoint to download a YouTube video
@app.route('/download', methods=['POST'])
def download_video():
    data = request.get_json()
    video_url = data.get("url")
    option = data.get("option")  # New - To identify if audio or video is to be downloaded

    if not video_url:
        return jsonify({"error": "No video URL provided"}), 400

    if option == "audio":
        ydl_opts = {
            'outtmpl': 'downloads/%(title)s.%(ext)s',
            'format': 'bestaudio/best',
            'progress_hooks': [progress_hook],
            'postprocessors': [{
                'key': 'FFmpegExtractAudio',
                'preferredcodec': 'mp3',
                'preferredquality': '192',
            }],
        }
    else:  # Default to video download if option is not audio
        ydl_opts = {
            'outtmpl': 'downloads/%(title)s.%(ext)s',
            'format': 'bestvideo+bestaudio/best',
            'progress_hooks': [progress_hook],
            'merge_output_format': 'mp4',
        }

    global download_progress
    download_progress = 0

    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            info = ydl.extract_info(video_url, download=True)
            filename = ydl.prepare_filename(info)
            return jsonify({"message": "Download complete!", "file": filename})
    except Exception as e:
        return jsonify({"error": str(e)}), 500



# Endpoint to check download progress
@app.route('/progress', methods=['GET'])
def get_progress():
    global download_progress
    return jsonify({"progress": download_progress})


if __name__ == '__main__':
    os.makedirs('downloads', exist_ok=True)
    app.run(host='0.0.0.0', port=5000, debug=True)
