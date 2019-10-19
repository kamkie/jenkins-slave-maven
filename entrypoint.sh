#sudo dockerd -H unix:///var/run/docker.sock -H tcp://127.0.0.1:2375 &

#/usr/local/bin/run-jnlp-client "$@"
source /usr/local/bin/run-jnlp-client
java -jar agent.jar -jnlpUrl ${JENKINS_URL}computer/slave/slave-agent.jnlp -secret ${JENKINS_SECRET} -workDir "/home/jenkins" -tunnel $JENKINS_TUNNEL
