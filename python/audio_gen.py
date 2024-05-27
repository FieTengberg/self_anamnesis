import requests

# Initializing chunk size for streaming response content
CHUNK_SIZE = 1024

# API endpoint URL
url = "https://api.elevenlabs.io/v1/text-to-speech/21m00Tcm4TlvDq8ikWAM"

# Request headers including accept, content type, and API key
headers = {
  "Accept": "audio/mpeg",
  "Content-Type": "application/json",
  #not active key anymore, but was utilized in the project
  "xi-api-key": "50c3b39252b5ddfc0816eea3d64641f5"
}

# Data payload for the text-to-speech request
data = {
  "text": "Hvor ondt har du på en skala fra 1 til 10",
  "model_id": "eleven_multilingual_v2",
  "voice_settings": {
    "stability": 0.5,
    "similarity_boost": 0.5
  }
}

# Sending a POST request to the API endpoint with the specified data and headers
response = requests.post(url, json=data, headers=headers)
# Writing the received audio content to an output file
with open('output.mp3', 'wb') as f:
    # Streaming the response content in chunks and writing to the output file
    for chunk in response.iter_content(chunk_size=CHUNK_SIZE):
        if chunk:
            f.write(chunk)