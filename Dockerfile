# syntax=docker/dockerfile:1
FROM python:3.11-bookworm

# Install specific versions of dependencies to ensure consistency and reduce build time
RUN apt-get update && apt-get -y --no-install-recommends install libgomp1 libxml2-dev libxslt-dev build-essential libmagic-dev openjdk-17-jre-headless libmagic1

# Install tesseract
RUN apt-get install -y \
  tesseract-ocr \
  lsb-release \
  && echo "deb https://notesalexp.org/tesseract-ocr5/$(lsb_release -cs)/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/notesalexp.list > /dev/null \
  && apt-get update -oAcquire::AllowInsecureRepositories=true \
  && apt-get install notesalexp-keyring -oAcquire::AllowInsecureRepositories=true -y --allow-unauthenticated \
  && apt-get update \
  && apt-get install -y \
  tesseract-ocr libtesseract-dev \
  && wget -P /usr/share/tesseract-ocr/5/tessdata/ https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata

# Set working directory
WORKDIR /app

# Upgrade pip and setuptools and install Python packages that don't change often
RUN pip install --upgrade pip==23.1.2 setuptools==65.5.1 && \
    pip install supervisor==4.2.2

# Install nltk
RUN pip install nltk==3.8.1

# Set NLTK data path and download resources early to cache this step
ENV NLTK_DATA /app/nltk_data
RUN mkdir -p /app/nltk_data && \
    python -m nltk.downloader -d /app/nltk_data stopwords && \
    python -m nltk.downloader -d /app/nltk_data punkt

# Verify NLTK data download
RUN ls -R /app/nltk_data

# Copy only the requirements file first to leverage Docker cache
COPY requirements.txt ./

# Install requirements after copying requirements.txt
RUN pip install -r requirements.txt

# Copy the rest of the application files
COPY . ./

# Verify tiktoken installation
RUN python -c "import tiktoken; tiktoken.get_encoding('cl100k_base')"

# Copy supervisord configuration
COPY supervisord.conf /etc/supervisord.conf

# Set supervisord as the entry point
CMD ["supervisord", "-c", "/etc/supervisord.conf"]

EXPOSE 5001


# # syntax=docker/dockerfile:experimental
# FROM python:3.11-bookworm

# # Install dependencies
# RUN apt-get update && apt-get -y --no-install-recommends install libgomp1 libxml2-dev libxslt-dev build-essential libmagic-dev openjdk-17-jre-headless libmagic1

# # Install tesseract
# RUN apt-get install -y \
#   tesseract-ocr \
#   lsb-release \
#   && echo "deb https://notesalexp.org/tesseract-ocr5/$(lsb_release -cs)/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/notesalexp.list > /dev/null \
#   && apt-get update -oAcquire::AllowInsecureRepositories=true \
#   && apt-get install notesalexp-keyring -oAcquire::AllowInsecureRepositories=true -y --allow-unauthenticated \
#   && apt-get update \
#   && apt-get install -y \
#   tesseract-ocr libtesseract-dev \
#   && wget -P /usr/share/tesseract-ocr/5/tessdata/ https://github.com/tesseract-ocr/tessdata/raw/main/eng.traineddata

# # Install additional packages
# RUN apt-get install -y unzip git && apt-get autoremove -y

# WORKDIR /app
# COPY . ./

# # Upgrade pip and setuptools
# RUN pip install --upgrade pip setuptools

# # Install supervisord
# RUN pip install supervisor

# # Install Python dependencies
# RUN pip install -r requirements.txt

# # Copy supervisord configuration
# COPY supervisord.conf /etc/supervisord.conf

# # Set NLTK data path
# ENV NLTK_DATA /app/nltk_data

# # Create NLTK data directory and download resources
# RUN mkdir -p /app/nltk_data
# RUN python -m nltk.downloader -d /app/nltk_data stopwords
# RUN python -m nltk.downloader -d /app/nltk_data punkt

# # Verify NLTK data download
# RUN ls -R /app/nltk_data

# RUN python -c "import tiktoken; tiktoken.get_encoding(\"cl100k_base\")"


# # Set supervisord as the entry point
# CMD ["supervisord", "-c", "/etc/supervisord.conf"]

# # RUN chmod +x run.sh

# EXPOSE 5001
# # CMD ./run.sh