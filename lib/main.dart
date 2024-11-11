import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CadastroScreen(),
  ));
}

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _telefoneController = TextEditingController();

  bool _mostrarSenha = false;

  // Função para validar o campo Nome Completo
  String? validarNome(String? nome) {
    if (nome == null || nome.isEmpty) {
      return 'Por favor, insira seu nome completo';
    }
    List<String> palavras = nome.trim().split(' ');
    if (palavras.length < 2) {
      return 'Por favor, insira ao menos dois nomes';
    }
    return null;
  }

  // Função para validar o campo Email
  String? validarEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Por favor, insira seu email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  // Função para validar o campo Senha
  String? validarSenha(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Por favor, insira uma senha';
    }
    if (senha.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres';
    }
    final senhaRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');
    if (!senhaRegex.hasMatch(senha)) {
      return 'A senha deve ter letras maiúsculas, minúsculas e números';
    }
    return null;
  }

  // Função para validar o campo Confirmação de Senha
  String? validarConfirmacaoSenha(String? confirmacaoSenha) {
    if (confirmacaoSenha == null || confirmacaoSenha != _senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  // Função para validar o campo Telefone
  String? validarTelefone(String? telefone) {
    if (telefone == null || telefone.isEmpty) {
      return 'Por favor, insira seu número de telefone';
    }
    final telefoneRegex = RegExp(r'^\d{8,15}$');
    if (!telefoneRegex.hasMatch(telefone)) {
      return 'Insira um número de telefone válido (8-15 dígitos)';
    }
    return null;
  }

  // Função para limpar todos os campos do formulário
  void limparFormulario() {
    _formKey.currentState?.reset();
    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    _confirmarSenhaController.clear();
    _telefoneController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome Completo'),
                validator: validarNome,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: validarEmail,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(_mostrarSenha
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _mostrarSenha = !_mostrarSenha;
                      });
                    },
                  ),
                ),
                obscureText: !_mostrarSenha,
                validator: validarSenha,
              ),
              TextFormField(
                controller: _confirmarSenhaController,
                decoration: InputDecoration(labelText: 'Confirmar Senha'),
                obscureText: !_mostrarSenha,
                validator: validarConfirmacaoSenha,
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: validarTelefone,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: limparFormulario,
                    child: Text('Limpar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Cadastro realizado com sucesso!')),
                        );
                      }
                    },
                    child: Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
