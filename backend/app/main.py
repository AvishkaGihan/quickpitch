import os
import json
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from dotenv import load_dotenv
from google import genai

load_dotenv()

app = FastAPI(title="QuickPitch API")

# Allow the Flutter app (mobile + web) to call this API from anywhere.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY")
if not GEMINI_API_KEY:
    raise RuntimeError("GEMINI_API_KEY environment variable is not set")

client = genai.Client(api_key=GEMINI_API_KEY)


class PitchRequest(BaseModel):
    idea: str
    target_audience: str


class PitchResponse(BaseModel):
    hook: str
    pitch: str
    cta: str


@app.get("/")
def root():
    return {"status": "QuickPitch API is running"}


@app.post("/api/pitch", response_model=PitchResponse)
def generate_pitch(request: PitchRequest):
    if not request.idea.strip():
        raise HTTPException(status_code=400, detail="idea cannot be empty")
    if not request.target_audience.strip():
        raise HTTPException(status_code=400, detail="target_audience cannot be empty")

    prompt = f"""You are a startup pitch coach. Create a compelling 30-second elevator pitch.

App idea: {request.idea}
Target audience: {request.target_audience}

Respond ONLY with valid JSON in exactly this format, no extra text, no markdown fences:
{{
  "hook": "one punchy attention-grabbing sentence",
  "pitch": "a 30-second spoken elevator pitch, 3-5 sentences",
  "cta": "one short call to action sentence"
}}
"""

    try:
        response = client.models.generate_content(
            model="gemini-2.5-flash",
            contents=prompt,
        )
        text = response.text.strip()

        # In case the model wraps the JSON in ```json ... ``` fences, strip them.
        if text.startswith("```"):
            text = text.strip("`")
            if text.startswith("json"):
                text = text[4:]
            text = text.strip()

        data = json.loads(text)

        return PitchResponse(
            hook=data["hook"],
            pitch=data["pitch"],
            cta=data["cta"],
        )
    except json.JSONDecodeError:
        raise HTTPException(
            status_code=502,
            detail="The AI returned an unexpected format. Please try again.",
        )
    except KeyError:
        raise HTTPException(
            status_code=502,
            detail="The AI response was missing expected fields. Please try again.",
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Something went wrong: {str(e)}")