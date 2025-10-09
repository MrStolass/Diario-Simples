import tkinter as tk
from tkinter import messagebox
from datetime import datetime
from pathlib import Path


arquivo_diario = Path("diario.txt")


def salvar():
    texto = entrada.get("1.0", tk.END).strip()
    if not texto:
        messagebox.showwarning("Aviso", "Escreva algo antes de salvar!")
        return

    with open(arquivo_diario, "a", encoding="utf-8") as f:
        data = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        f.write(f"[{data}]\n{texto}\n\n")

    entrada.delete("1.0", tk.END)
    messagebox.showinfo("Salvo", "Entrada adicionada ao diário!")

# Interface
janela = tk.Tk()
janela.title("📝 Diário de anotações")
janela.geometry("500x400")
janela.resizable(False, False)
janela.configure(bg="#f4f4f4")

# --------------------
titulo = tk.Label(janela, text="DIÁRIO", font=("Helvetica", 18, "bold"), bg="#f4f4f4")
titulo.pack(pady=10)

# -------------------
entrada = tk.Text(janela, wrap="word", font=("Arial", 12), height=12, width=50, bg="#ffffff", relief="solid")
entrada.pack(padx=10, pady=10)

# ------------------------
btn_salvar = tk.Button(janela, text="Salvar", font=("Arial", 12, "bold"), bg="#4CAF50", fg="white",
                       relief="flat", padx=10, pady=5, command=salvar)
btn_salvar.pack(pady=10)

# --------------------
janela.mainloop()
