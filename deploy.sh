#!/bin/bash

# ===== CONFIG =====
PROJECT_PATH="/Users/admin/Downloads/3D-Printers-Build/klipper-docs"
REPO_NAME="klipper-docs"
BRANCH="main"
COMMIT_MSG="update docs $(date '+%Y-%m-%d %H:%M')"

# ===== GO TO PROJECT =====
cd "$PROJECT_PATH" || exit 1

echo "📁 Proyecto: $(pwd)"

# ===== CHECK INDEX =====
if [ ! -f "index.html" ]; then
  echo "❌ ERROR: index.html no existe en la raíz"
  exit 1
fi

# ===== INIT GIT IF NEEDED =====
if [ ! -d ".git" ]; then
  echo "🔧 Inicializando git..."
  git init
  git branch -M $BRANCH
  git remote add origin https://github.com/harrynow83/$REPO_NAME.git
fi

# ===== ADD & COMMIT =====
git add .
git commit -m "$COMMIT_MSG" || echo "ℹ️ Nada nuevo para commitear"

# ===== PUSH =====
git push origin $BRANCH

# ===== ENABLE GITHUB PAGES =====
echo "🚀 Verificando GitHub Pages..."
gh api \
  -X POST \
  repos/:owner/$REPO_NAME/pages \
  -f source.branch=$BRANCH \
  -f source.path="/" \
  2>/dev/null || echo "ℹ️ GitHub Pages ya estaba activo"

echo "✅ DEPLOY COMPLETO"
echo "🌍 https://harrynow83.github.io/$REPO_NAME/"

