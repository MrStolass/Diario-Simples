import librosa

# carrega apenas o primeiro minuto
audio_path = "musica.mp3"
y, sr = librosa.load(audio_path, duration=60)

# detecta bpm e batidas
tempo, beats = librosa.beat.beat_track(y=y, sr=sr)

# converte batidas para tempo em segundos
beat_times = librosa.frames_to_time(beats, sr=sr)

print("BPM:", tempo)

print("\nBatidas detectadas:")
for t in beat_times:
    print(f"{t:.2f}s")
