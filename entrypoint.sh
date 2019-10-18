sudo dockerd -H unix:///var/run/docker.sock -H tcp://127.0.0.1:2375 &

/usr/local/bin/run-jnlp-client "$@"
