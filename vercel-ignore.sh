#!/bin/bash

if [[ "$VERCEL_GIT_COMMIT_REF" == "main" || "$VERCEL_GIT_COMMIT_REF" == "develop" || -n "$VERCEL_GIT_PULL_REQUEST_ID" ]] ; then
  echo "✅ - Deployment is allowed (main/develop branch or PR preview). Proceeding with build."
  exit 1;
else
  echo "🛑 - Deployment is not from main/develop and is not a PR preview. Skipping build."
  exit 0;
fi
