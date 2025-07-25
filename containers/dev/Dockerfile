# SPDX-FileCopyrightText: Copyright 2024 LG Electronics Inc.
# SPDX-License-Identifier: Apache-2.0

# FROM ghcr.io/eclipse-pullpiri/pullpiribuilder:latest AS builder
FROM localhost/pullpiribuilder:latest AS builder
WORKDIR /piccolo

COPY ./src/common/ /piccolo/common
COPY ./src/agent/ /piccolo/agent
COPY ./src/server/ /piccolo/server/
COPY ./src/player/ /piccolo/player

# Build server binaries
WORKDIR /piccolo/server
RUN cargo build --release

# Build agent binaries
WORKDIR /piccolo/agent
RUN cargo build --release

# Build player binaries
WORKDIR /piccolo/player
RUN cargo build --release


# FROM ghcr.io/eclipse-pullpiri/pullpirirelease:latest
FROM localhost/pullpirirelease:latest
WORKDIR /piccolo

COPY ./src/settings.yaml .
COPY --from=builder \
    /piccolo/server/target/release/apiserver \
    /piccolo/server/target/release/monitoringserver \
    /piccolo/server/target/release/policymanager \
    /piccolo/agent/target/release/nodeagent \
    /piccolo/player/target/release/actioncontroller \
    /piccolo/player/target/release/statemanager \
    /piccolo/player/target/release/filtergateway ./

CMD [ "sh" ]
