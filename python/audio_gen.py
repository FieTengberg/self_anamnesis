import requests

CHUNK_SIZE = 1024
url = "https://api.elevenlabs.io/v1/text-to-speech/21m00Tcm4TlvDq8ikWAM"

headers = {
  "Accept": "audio/mpeg",
  "Content-Type": "application/json",
  "xi-api-key": "50c3b39252b5ddfc0816eea3d64641f5"
}

data = {
  "text": "Tak! Dine svar bliver nu sendt videre til din fysioterapeut, som vil læse det igennem, inden du kaldes ind til videre undersøgelse og tests. I mellemtiden kan du finde dig til rette i venteværelset med et magasin og en kop te eller kaffe.",
  "model_id": "eleven_multilingual_v2",
  "voice_settings": {
    "stability": 0.5,
    "similarity_boost": 0.5
  }
}

response = requests.post(url, json=data, headers=headers)
with open('output.mp3', 'wb') as f:
    for chunk in response.iter_content(chunk_size=CHUNK_SIZE):
        if chunk:
            f.write(chunk)
