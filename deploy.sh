#!/bin/bash

# ===== CONFIG =====
PROJECT_PATH="/Users/admin/Downloads/3D-Printers-Build/klipper-install-doc"
REPO_NAME="klipper-install-doc"
COMMIT_MSG="update website"
BRANCH="main"

# ===== GO TO PROJECT =====
cd "$PROJECT_PATH" || exit

# ===== CHECK INDEX =====
if [ ! -f "index.html" ]; then
  echo "❌ ERROR: index.html no existe"
  exit 1
fi

# ===== INIT GIT =====
if [ ! -d ".git" ]; then
  echo "🔧 Inicializando git..."
  git init
  git branch -M $BRANCH
fi

# ===== CREATE REPO IF NOT EXISTS =====
if ! gh repo view "$REPO_NAME" &>/dev/null; then
  echo "🌍 Creando repo en GitHub..."
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
else
  echo "🔗 Repo ya existe"
fi

# ===== PUSH UPDATES =====
git add .
git commit -m "$COMMIT_MSG" || echo "ℹ️ Nada nuevo para commitear"
git push origin $BRANCH

# ===== ENABLE GITHUB PAGES =====
echo "🚀 Activando GitHub Pages..."
gh api \
  -X POST \
  repos/:owner/$REPO_NAME/pages \
  -f source.branch=$BRANCH \
  -f source.path="/"

echo "✅ DEPLOY COMPLETO"

