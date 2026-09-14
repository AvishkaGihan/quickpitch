# QuickPitch AI

QuickPitch AI is a simple, intelligent tool that generates compelling 30-second elevator pitches based on your app idea and target audience. 

It consists of a Flutter frontend application and a Python FastAPI backend powered by the Google Gemini API.

## Features
- **Instant Pitches**: Enter an app idea and target audience to instantly get a pitch.
- **Structured Output**: Generates a structured elevator pitch consisting of a hook, the pitch itself (30-second read), and a call to action (CTA).
- **Gemini Powered**: Built with Google's Gemini 2.5 Flash model for fast and accurate generation.

## Project Structure
- `backend/`: FastAPI Python application.
- `mobile/`: Flutter mobile/web application.

## Prerequisites
- [Python 3.9+](https://www.python.org/)
- [Flutter SDK 3.13.3+](https://flutter.dev/docs/get-started/install)
- A [Google Gemini API Key](https://aistudio.google.com/)

## Getting Started

### Backend Setup
1. Navigate to the `backend` directory:
   ```bash
   cd backend
   ```
2. Create and activate a virtual environment (optional but recommended):
   ```bash
   python -m venv .venv
   
   # On Windows:
   .venv\Scripts\activate
   # On macOS/Linux:
   source .venv/bin/activate
   ```
3. Install the required Python dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Set up your environment variables:
   - Copy `.env.example` to `.env` (or create a new `.env` file).
   - Add your Gemini API key to `.env`: 
     ```
     GEMINI_API_KEY=your_api_key_here
     ```
5. Run the FastAPI development server:
   ```bash
   uvicorn app.main:app --reload
   ```
   The backend will start running at `http://127.0.0.1:8000`.

### Mobile Frontend Setup
1. Navigate to the `mobile` directory:
   ```bash
   cd mobile
   ```
2. Fetch the Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app (ensure you have an emulator running or a device connected):
   ```bash
   flutter run
   ```
   *Note: You may need to configure the backend API URL within the Flutter app depending on your emulator/device setup (e.g., using `10.0.2.2` for Android emulators to reach localhost).*

## Tech Stack
- **Frontend**: Flutter, Dart
- **Backend**: Python, FastAPI, Uvicorn, Google GenAI SDK (`google-genai`), Pydantic
