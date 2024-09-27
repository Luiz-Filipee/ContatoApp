# AgendaApp

AgendaApp é um aplicativo de gerenciamento de contatos desenvolvido com Flutter. Ele permite adicionar, editar, listar e excluir contatos como nome, telefone e e-mail. É um projeto simples, mas serve como exemplo prático de como implementar uma lista de contatos e manipulá-los com a ajuda de widgets do Flutter.

## Funcionalidades

- **Adicionar contato:** O usuário pode cadastrar um novo contato inserindo nome, telefone e e-mail.
- **Editar contato:** O usuário pode atualizar as informações de um contato existente.
- **Deletar contato:** O usuário pode excluir um contato da lista.
- **Listar contatos:** Todos os contatos cadastrados são exibidos em uma lista interativa, permitindo fácil visualização e gerenciamento.

## Estrutura do Projeto

- `lib/`
  - `model/`
    - **contato.dart**: Define a estrutura do modelo de dados `Contato`.
  - `repository/`
    - **contato_repository.dart**: Implementa a lógica para listar, adicionar e remover contatos.
  - `widget/`
    - **listagem.dart**: Tela principal para exibição dos contatos cadastrados.
    - **cadastro.dart**: Tela de cadastro/edição de contatos.
  - **main.dart**: Ponto de entrada do aplicativo, carrega a tela de listagem de contatos.

## Instalação

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/agendaapp.git
   cd agendaapp
