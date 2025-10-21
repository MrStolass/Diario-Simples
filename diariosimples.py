import tkinter as tk
from tkinter import messagebox, colorchooser
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
    atualizar_contador()
    messagebox.showinfo("Salvo", "Entrada adicionada ao diário!")

def limpar():
    entrada.delete("1.0", tk.END)
    atualizar_contador()

def mudar_cor():
    cor = colorchooser.askcolor(title="Escolha a cor do texto")[1]
    if cor:
        entrada.config(fg=cor)

def atualizar_contador(event=None):
    conteudo = entrada.get("1.0", tk.END)
    contador.config(text=f"Caracteres: {len(conteudo)-1}")

# Interface
janela = tk.Tk()
janela.title("📝 Diário de anotações")
janela.geometry("500x450")
janela.resizable(False, False)
janela.configure(bg="#f4f4f4")

# --------------------
titulo = tk.Label(janela, text="DIÁRIO", font=("Helvetica", 18, "bold"), bg="#f4f4f4")
titulo.pack(pady=10)

# -------------------
entrada = tk.Text(janela, wrap="word", font=("Arial", 12), height=12, width=50, bg="#ffffff", relief="solid")
entrada.pack(padx=10, pady=10)
entrada.bind("<KeyRelease>", atualizar_contador)

# -------------------
contador = tk.Label(janela, text="Caracteres: 0", font=("Arial", 10), bg="#f4f4f4")
contador.pack()

# ------------------------
frame_botoes = tk.Frame(janela, bg="#f4f4f4")
frame_botoes.pack(pady=10)

btn_salvar = tk.Button(frame_botoes, text="Salvar", font=("Arial", 12, "bold"), bg="#4CAF50", fg="white",
                       relief="flat", padx=10, pady=5, command=salvar)
btn_salvar.grid(row=0, column=0, padx=5)

btn_limpar = tk.Button(frame_botoes, text="Limpar", font=("Arial", 12, "bold"), bg="#f44336", fg="white",
                       relief="flat", padx=10, pady=5, command=limpar)
btn_limpar.grid(row=0, column=1, padx=5)

btn_cor = tk.Button(frame_botoes, text="Mudar cor", font=("Arial", 12, "bold"), bg="#2196F3", fg="white",
                    relief="flat", padx=10, pady=5, command=mudar_cor)
btn_cor.grid(row=0, column=2, padx=5)

# --------------------
janela.mainloop()
