#!/bin/bash

BRANCH=$1
MODULES=\
common,utils,exports,globals,aes,aes-ecb,aes-cbc,aes-ctr,aes-ccm,aes-gcm,\
aes-exports,aes-ecb-exports,aes-cbc-exports,aes-ctr-exports,aes-ccm-exports,\
aes-gcm-exports,hash,sha256,sha256-exports,sha512,sha512-exports,hmac,\
hmac-sha256,hmac-sha512,hmac-sha256-exports,hmac-sha512-exports,rng,\
rng-exports,rng-globals,bn,bn-exports,rsa,rsa-raw,rsa-keygen-exports,\
pbkdf2,pbkdf2-hmac-sha512,pbkdf2-hmac-sha512-exports,\
rsa-raw-exports

if [[ "$BRANCH" = "" ]]; then
    # Build latest tagged release
    BRANCH=$(git describe --tags $(git rev-list --tags --max-count=1))
fi

git checkout $BRANCH
npm install

grunt --with="$MODULES" devel-build

d2u=$(which dos2unix)
if [[ "$d2u" != "" ]]; then
    $d2u asmcrypto.js
fi
