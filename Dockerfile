FROM node:22-slim

WORKDIR /workspace

RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

COPY compatible-fullstack-versions.txt ./ 
COPY test-compatibility.sh ./ 

RUN chmod +x test-compatibility.sh

CMD ["./test-compatibility.sh"]
