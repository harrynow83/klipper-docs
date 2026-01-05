#!/bin/bash

PROJECT_PATH="/Users/admin/Downloads/3D-Printers-Build/klipper-docs"
BRANCH="main"

cd "$PROJECT_PATH" || exit 1

echo "📁 Proyecto: $(pwd)"

# ===== CHECK INDEX =====
if [ ! -f "index.html" ]; then
  echo "❌ ERROR: index.html no existe en la raíz"
  exit 1
fi

# ===== CHECK REAL CHANGES =====
if git diff --quiet && git diff --cached --quiet; then
  echo "⚠️ No hay cambios reales → GitHub Pages NO se actualizará"
  exit 0
fi

# ===== COMMIT & PUSH =====
git add .
git commit -m "update docs $(date '+%Y-%m-%d %H:%M')"
git push origin $BRANCH

echo "✅ DEPLOY CORRECTO"
echo "🌍 https://harrynow83.github.io/klipper-docs/"
