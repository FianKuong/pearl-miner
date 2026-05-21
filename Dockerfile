FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04

RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download pearl_miner_v4 from Pearlhash
RUN curl -L "https://pearlhash.xyz/downloads/pearl_miner_v4.tar.gz" -o pearl_miner_v4.tar.gz \
    && tar -xzf pearl_miner_v4.tar.gz \
    && rm pearl_miner_v4.tar.gz \
    && chmod +x pearl-miner || chmod +x pearl_miner || true

# Find and make executable whatever binary is in there
RUN find /app -type f -executable | head -5 && ls -la /app/

ENTRYPOINT ["sh", "-c", "exec /app/pearl_miner_v4/pearl-miner --host ${POOL_HOST:-84.32.220.219:9000} --user ${WALLET}"]
