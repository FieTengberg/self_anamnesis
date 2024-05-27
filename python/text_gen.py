import torch
import os
from transformers import AutoModelForSpeechSeq2Seq, AutoProcessor, pipeline

# Checking for GPU availability and setting data type 
device = "cuda:0" if torch.cuda.is_available() else "cpu"
datatype = torch.float16 if torch.cuda.is_available() else torch.float32

# Specifying the model to be used
model_id = "openai/whisper-large-v3"

# Loading the model
model = AutoModelForSpeechSeq2Seq.from_pretrained(
    model_id, torch_dtype=datatype, low_cpu_mem_usage=True, use_safetensors=True
)
model.to(device)

# Loading the processor for the model
processor = AutoProcessor.from_pretrained(model_id)

# Setting up the pipeline for automatic speech recognition
pipe = pipeline(
    "automatic-speech-recognition",
    model=model,
    tokenizer=processor.tokenizer,
    feature_extractor=processor.feature_extractor,
    max_new_tokens=128,
    chunk_length_s=30,
    batch_size=16,
    return_timestamps=True,
    # the below is not necessary to successfully running our code but included to ensure compatibility with the model's input
    torch_dtype=datatype,
    device=device,
)

# Constructing the path to the audio file
audio_file_path = os.path.join("..", "data", "audio_data_files", "marie4.mp3")
with open(audio_file_path, "rb") as audio_file:
    sample = audio_file.read()
# Running the automatic speech recognition pipeline on the audio sample
result = pipe(sample)
transcribed_text = result["text"]
# Writing the transcribed text to a text file
with open("transcribed_text.txt", "w", encoding="utf-8") as file:
    file.write(transcribed_text)


