#!/bin/bash
set -e

# ========= CONFIG =========
PROJECT_PATH="/Users/admin/Downloads/3D-Printers-Build/klipper-docs"
BRANCH="main"
SITE_URL="https://harrynow83.github.io/klipper-docs/"

# ========= GO TO PROJECT =========
cd "$PROJECT_PATH" || {
  echo "❌ No se puede acceder al proyecto"
  exit 1
}

echo "📁 Proyecto: $(pwd)"

# ========= CHECK GIT =========
if [ ! -d ".git" ]; then
  echo "❌ Este directorio no es un repositorio git"
  exit 1
fi

# ========= CHECK REMOTE (SSH) =========
REMOTE_URL=$(git remote get-url origin)
if [[ "$REMOTE_URL" != git@github.com:* ]]; then
  echo "❌ El remote NO usa SSH:"
  echo "   $REMOTE_URL"
  exit 1
fi
echo "🔐 Remote SSH OK"

# ========= CHECK INDEX =========
if [ ! -f "index.html" ]; then
  echo "❌ No existe index.html en la raíz"
  exit 1
fi

# ========= SHOW CHANGES =========
echo ""
echo "🔎 Cambios detectados:"
git status --short

if git diff --quiet && git diff --cached --quiet; then
  echo ""
  echo "⚠️ No hay cambios reales → deploy cancelado"
  exit 0
fi

# ========= CONFIRM =========
echo ""
read -p "🚀 ¿Confirmas deploy de estos cambios? (y/n): " CONFIRM
[[ "$CONFIRM" != "y" ]] && {
  echo "⏹ Deploy cancelado por el usuario"
  exit 0
}

# ========= COMMIT & PUSH =========
COMMIT_MSG="deploy $(date '+%Y-%m-%d %H:%M')"
git add .
git commit -m "$COMMIT_MSG"

echo ""
echo "⬆️ Subiendo cambios a GitHub..."
git push origin "$BRANCH"

# ========= FINAL =========
echo ""
echo "✅ DEPLOY COMPLETADO"
echo "🌍 $SITE_URL"
echo "🕒 Espera ~30 segundos y recarga con Cmd+Shift+R"
