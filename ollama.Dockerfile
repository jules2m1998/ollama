# Utiliser l'image officielle Ubuntu 22.04 LTS comme base
FROM ubuntu:22.04

# Exposer le port par défaut d'Ollama
EXPOSE 11434

# Installer les dépendances requises, Ollama et le toolkit NVIDIA en une seule étape
RUN apt-get update && apt-get install -y curl gpg && \
    curl -sSfL https://ollama.ai/install.sh | sh && \
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && \
    apt-get update && \
    apt-get install -y nvidia-container-toolkit && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ajouter Ollama au PATH et accepter les accords de licence
ENV PATH="/root/.ollama/bin:${PATH}" \
    OLLAMA_ACCEPT_LICENSES=true

# Télécharger le modèle Mistral en utilisant Ollama
RUN ollama serve & \
    curl --retry 10 --retry-connrefused --retry-delay 1 http://localhost:11434/ && \
    curl -X POST -d '{"name": "${MODEL_NAME}"}' http://localhost:11434/api/pull

# Démarrer le service Ollama
CMD ["ollama", "start"]
