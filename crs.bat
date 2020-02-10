docker build ^
  --build-arg ONEC_USERNAME=%ONEC_USERNAME% ^
  --build-arg ONEC_PASSWORD=%ONEC_PASSWORD% ^
  --build-arg ONEC_VERSION=%ONEC_VERSION% ^
  --build-arg DOCKER_USERNAME=%DOCKER_USERNAME% ^
  -t %DOCKER_USERNAME%/crs:%ONEC_VERSION% ^
  -f crs/Dockerfile .
