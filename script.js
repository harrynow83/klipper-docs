<script>
document.addEventListener("click", async (e) => {
  const btn = e.target.closest(".copy-btn");
  if (!btn) return;

  const code = btn.nextElementSibling.innerText;

  let copied = false;

  // 1️⃣ Clipboard API (si existe y está permitido)
  if (navigator.clipboard && window.isSecureContext) {
    try {
      await navigator.clipboard.writeText(code);
      copied = true;
    } catch {}
  }

  // 2️⃣ Fallback clásico (file:// compatible)
  if (!copied) {
    const textarea = document.createElement("textarea");
    textarea.value = code;
    textarea.style.position = "fixed";
    textarea.style.opacity = "0";
    document.body.appendChild(textarea);
    textarea.select();
    try {
      document.execCommand("copy");
      copied = true;
    } catch {}
    document.body.removeChild(textarea);
  }

  // Feedback accesible
  if (copied) {
    btn.textContent = "Copiado";
    btn.classList.add("copied");
    setTimeout(() => {
      btn.textContent = "Copiar";
      btn.classList.remove("copied");
    }, 1400);
  } else {
    btn.textContent = "Error";
  }
});
</script>
