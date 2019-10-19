#sudo dockerd -H unix:///var/run/docker.sock -H tcp://127.0.0.1:2375 &

#/usr/local/bin/run-jnlp-client "$@"
source /usr/local/bin/run-jnlp-client
java -jar agent.jar -jnlpUrl https://jenkins-kamkie.apps.openshift.oc-test.jit.ninja/computer/slave/slave-agent.jnlp -secret 4cf80c5fd6f8235dd0421e99b63d9472ed4c21057e5010e7ff8a20d3048c1489 -workDir "/home/jenkins"
