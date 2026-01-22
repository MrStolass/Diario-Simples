import tkinter as tk
from tkinter import messagebox, colorchooser
from datetime import datetime
from pathlib import Path

arquivo_diario = Path("diario.txt")

def salvar(event=None): # Aceita event para o bind do teclado
    texto = entrada.get("1.0", tk.END).strip()
    if not texto:
        messagebox.showwarning("Aviso", "Escreva algo antes de salvar!")
        return

    try:
        with open(arquivo_diario, "a", encoding="utf-8") as f:
            data = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            f.write(f"[{data}]\n{texto}\n{'-'*20}\n") # Divisória visual no txt
        
        entrada.delete("1.0", tk.END)
        atualizar_contador()
        messagebox.showinfo("Salvo", "Entrada adicionada ao diário!")
    except Exception as e:
        messagebox.showerror("Erro", f"Falha ao salvar: {e}")

def limpar():
    if messagebox.askyesno("Limpar", "Deseja apagar o texto atual?"):
        entrada.delete("1.0", tk.END)
        atualizar_contador()

def mudar_cor():
    cor = colorchooser.askcolor(title="Escolha a cor do texto")[1]
    if cor:
        entrada.config(fg=cor)

def atualizar_contador(event=None):
    conteudo = entrada.get("1.0", tk.END)
    contador.config(text=f"Caracteres: {len(conteudo)-1}")

# Funções de efeito visual (Hover)
def on_enter(e): e.widget['background'] = '#333333'
def on_leave(e, color): e.widget['background'] = color

# Interface
janela = tk.Tk()
janela.title("📝 Diário de anotações")
janela.geometry("500x480")
janela.resizable(False, False)
janela.configure(bg="#f4f4f4")

# Atalho global: Ctrl + S para salvar
janela.bind('<Control-s>', salvar)

titulo = tk.Label(janela, text="MEU DIÁRIO", font=("Helvetica", 18, "bold"), bg="#f4f4f4", fg="#333")
titulo.pack(pady=10)

entrada = tk.Text(janela, wrap="word", font=("Arial", 12), height=12, width=50, bg="#ffffff", relief="solid", borderwidth=1)
entrada.pack(padx=10, pady=10)
entrada.bind("<KeyRelease>", atualizar_contador)
entrada.focus_set() # Foca no texto ao abrir

contador = tk.Label(janela, text="Caracteres: 0", font=("Arial", 10, "italic"), bg="#f4f4f4")
contador.pack()

frame_botoes = tk.Frame(janela, bg="#f4f4f4")
frame_botoes.pack(pady=15)

# Dicionário para facilitar a criação dos botões com estilo
botoes = [
    ("Salvar", "#4CAF50", salvar),
    ("Limpar", "#f44336", limpar),
    ("Cor", "#2196F3", mudar_cor)
]

for i, (texto, cor, comando) in enumerate(botoes):
    btn = tk.Button(frame_botoes, text=texto, font=("Arial", 10, "bold"), bg=cor, fg="white",
                    relief="flat", width=10, pady=5, command=comando)
    btn.grid(row=0, column=i, padx=5)
    # Bind dos eventos de hover
    btn.bind("<Enter>", on_enter)
    btn.bind("<Leave>", lambda e, c=cor: on_leave(e, c))

janela.mainloop()
