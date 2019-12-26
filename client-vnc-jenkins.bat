docker build ^
  --build-arg ONEC_VERSION=%ONEC_VERSION% ^
  --build-arg DOCKER_USERNAME=%DOCKER_USERNAME% ^
  -t %DOCKER_USERNAME%/onec-client-vnc-jenkins:%ONEC_VERSION% ^
  -f client-vnc-jenkins/Dockerfile .
