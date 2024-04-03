import torch
from transformers import AutoModelForSpeechSeq2Seq, AutoProcessor, pipeline
from datasets import load_dataset
import os

# Define the relative path to the audio file
relative_path = os.path.join("audio_files", "assets", "intro.mp3")

# Get the absolute path by joining the current working directory with the relative path
absolute_path = os.path.abspath(relative_path)

device = "cuda:0" if torch.cuda.is_available() else "cpu"
torch_dtype = torch.float16 if torch.cuda.is_available() else torch.float32

model_id = "openai/whisper-large-v3"

model = AutoModelForSpeechSeq2Seq.from_pretrained(
    model_id, torch_dtype=torch_dtype, low_cpu_mem_usage=True, use_safetensors=True
)
model.to(device)

processor = AutoProcessor.from_pretrained(model_id)

pipe = pipeline(
    "automatic-speech-recognition",
    model=model,
    tokenizer=processor.tokenizer,
    feature_extractor=processor.feature_extractor,
    max_new_tokens=128,
    chunk_length_s=30,
    batch_size=16,
    return_timestamps=True,
    torch_dtype=torch_dtype,
    device=device,
)

# Load the audio file
with open(absolute_path, "rb") as audio_file:
    sample = audio_file.read()

# Perform transcription
result = pipe(sample)
transcribed_text = result["text"]

# Write the transcribed text to a text file
with open("transcribed_text.txt", "w", encoding="utf-8") as file:
    file.write(transcribed_text)

print("Transcribed text has been written to 'transcribed_text.txt'.")
