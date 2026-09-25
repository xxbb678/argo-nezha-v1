#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
FRONTEND="$ROOT/frontend/nezha-dash-v2"

docker run --rm \
  -v "$FRONTEND:/src" \
  -w /src \
  node:22-bookworm \
  bash -lc 'corepack enable && corepack prepare pnpm@11.5.1 --activate && pnpm install --frozen-lockfile && pnpm exec vitest run src/test/components/server-cards.test.tsx src/test/lib/utils.test.ts && pnpm run build'

mkdir -p "$ROOT/frontend/dist"
cp -a "$FRONTEND/dist/." "$ROOT/frontend/dist/"
docker build -t argo-nezha-v1:virtualization "$ROOT"