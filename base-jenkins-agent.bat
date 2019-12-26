docker build ^
  --build-arg ONEC_VERSION=%ONEC_VERSION% ^
  --build-arg DOCKER_USERNAME=%DOCKER_USERNAME% ^
  -t %DOCKER_USERNAME%/base-jenkins-agent:%ONEC_VERSION% ^
  -f base-jenkins-agent/Dockerfile .
