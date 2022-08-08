FROM python:latest

RUN useradd runner

ENV AGENT_TOOLSDIRECTORY=/opt/hostedtoolcache
RUN mkdir -p /opt/hostedtoolcache
RUN chown runner /opt/hostedtoolcache
ARG GH_RUNNER_VERSION="2.287.0"
ARG TARGETPLATFORM="linux"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /actions-runner
COPY install_actions.sh /actions-runner

RUN chmod +x /actions-runner/install_actions.sh \
  && /actions-runner/install_actions.sh ${GH_RUNNER_VERSION} ${TARGETPLATFORM} \
  && rm /actions-runner/install_actions.sh 

COPY entrypoint.sh /
COPY deregister.sh /actions-runner/
RUN chmod +x /entrypoint.sh /actions-runner/deregister.sh
USER runner
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["./bin/Runner.Listener", "run", "--startuptype", "service"]
