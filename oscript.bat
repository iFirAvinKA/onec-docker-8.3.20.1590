docker build ^
  --build-arg DOCKER_USERNAME=%DOCKER_USERNAME% ^
  --build-arg BASE_IMAGE=onec-client-vnc ^
  --build-arg BASE_TAG=%ONEC_VERSION% ^
  -t %DOCKER_USERNAME%/client-oscript:%ONEC_VERSION% ^
  -f oscript/Dockerfile .
