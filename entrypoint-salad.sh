#!/bin/bash
# Setup SSH key from env
if [ -n "$SSH_PUBLIC_KEY" ]; then
    mkdir -p /root/.ssh
    echo "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/authorized_keys
fi

# Start SSH daemon
/usr/sbin/sshd

# Start miner
cd /app/pearl_miner_v4
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
WORKER=${WORKER_NAME:-salad-$(hostname | cut -c1-8)}

exec ./pearl-miner --host ${POOL_HOST:-84.32.220.219:9000} --user ${WALLET} --worker $WORKER
