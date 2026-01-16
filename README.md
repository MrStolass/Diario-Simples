# 📝 Diário de Anotações com Persistência Local em Python

Este projeto consiste em uma aplicação desktop para registro de notas e reflexões diárias, desenvolvida em Python. O foco principal foi a criação de uma interface funcional (GUI) e a manipulação de arquivos para armazenamento de dados offline de forma simples e direta.


## Tecnologias e Ferramentas
* **Python 3.x**: Linguagem base do projeto.
* **Tkinter**: Biblioteca para criação da interface gráfica (GUI).
* **Pathlib & Datetime**: Gerenciamento de arquivos e carimbos de data/hora (timestamps).
* **Git**: Controle de versão e organização do fluxo de trabalho.

## O que foi implementado
1. **Interface Customizada**: Criação de uma janela com elementos de UX (inputs, botões coloridos e labels) para facilitar o uso.
2. **Sistema de Persistência**: As anotações são salvas em um arquivo `diario.txt`, preservando o histórico com marcações de tempo precisas (`%Y-%m-%d %H:%M:%S`).
3. **Contador em Tempo Real**: Implementação de *event binding* (`<KeyRelease>`) para atualizar a contagem de caracteres dinamicamente.
4. **Customização Visual**: Integração com o `colorchooser` para permitir a troca da cor da fonte pelo usuário.


---
