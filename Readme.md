# GenAI Project with Ollama and Open WebUI

This project sets up an AI generation environment using Ollama and Open WebUI with GPU support.

## Prerequisites

- Docker
- Docker Compose
- NVIDIA GPU with drivers installed (for GPU acceleration)

## Quick Start

1. Clone this repository:
   ```
   git clone <repo-url>
   cd <repo-name>
   ```

2. Start the services:
   ```
   docker-compose up -d
   ```

3. Access the Web Interface:
   Open your browser and go to `http://localhost:3000`

## Environments

### Ollama

- Port: 11434
- Model: Mistral
- Supports GPU acceleration

### Open WebUI

- Port: 3000
- User interface for interacting with Ollama

## Configuration

- The `docker-compose.yml` file defines the services and their configurations.
- `ollama.Dockerfile` contains instructions for building the Ollama image with GPU support.

## Volumes

- `./data:/root/.ollama`: Stores Ollama data
- `./backend/data:/app/backend/data`: Stores Open WebUI data

## Network

Services use a Docker network named `genai-network`.

## Environment Variables

- `OLLAMA_ACCEPT_LICENSES=true`: Automatically accepts Ollama licenses
- `OLLAMA_HOST=0.0.0.0`: Allows access to Ollama from outside the container
- `MODEL_NAME=mistral`: Specifies the model to use
- `OLLAMA_BASE_URL=http://ollama-service:11434`: Base URL for Open WebUI to communicate with Ollama
- `DISABLE_HTTPS=true`: Disables HTTPS for Open WebUI (for development purposes)

## Note

Make sure you have the appropriate NVIDIA drivers and Docker runtime installed to use GPU acceleration.

