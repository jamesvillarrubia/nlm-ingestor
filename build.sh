# docker buildx build --platform linux/amd64,linux/arm64 -t jamesmtc/nlm-ingestor:latest . --push

# docker buildx build --platform linux/arm64 -t jamesmtc/nlm-ingestor:arm64 . --push

# docker buildx build --platform linux/arm64 -t nasamadi/madi-parser-nlm:arm64 . 
# docker buildx build --platform linux/amd64 -t jamesmtc/nlm-ingestor:amd64 . --push




docker buildx build --platform linux/amd64,linux/arm64 -t nasamadi/madi-parser-nlm:latest .
docker buildx build --platform linux/amd64 -t nasamadi/madi-parser-nlm:amd64 .
docker buildx build --platform linux/arm64 -t nasamadi/madi-parser-nlm:arm64 .

# docker tag nasamadi/madi-parser-nlm:latest us-east4-docker.pkg.dev/hq-madi-dev-4ebd7d92/docker-images/madi-parsers-nlm:latest
# docker tag nasamadi/madi-parser-nlm:amd64  us-east4-docker.pkg.dev/hq-madi-dev-4ebd7d92/docker-images/madi-parsers-nlm:amd64
# docker push us-east4-docker.pkg.dev/hq-madi-dev-4ebd7d92/docker-images/madi-parsers-nlm:latest
docker push nasamadi/madi-parser-nlm:latest
docker push nasamadi/madi-parser-nlm:amd64
docker push nasamadi/madi-parser-nlm:arm64

# docker run -it --rm nasamadi/madi-parser-nlm:latest


# Build the Docker image for the specified platform and tag it locally
# docker buildx build --platform linux/arm64 -t us-east4-docker.pkg.dev/hq-madi-dev-4ebd7d92/docker-images/madi-parsers-nlm:latest .

# Push the Docker image to the specified GCR repository
# docker push us-east4-docker.pkg.dev/hq-madi-dev-4ebd7d92/docker-images/madi-parsers-nlm:latest