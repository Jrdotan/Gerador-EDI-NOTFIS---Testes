Gerador de Arquivos NOTFIS (Notas Fiscais)

Este projeto gera arquivos de intercâmbio no padrão NOTFIS, contendo os registros 000, 310, 311, 312, 313 e 314.
O script funciona de forma interativa pelo terminal e cria um arquivo .TXT seguindo o layout fixo de 240 caracteres por linha.

Funcionalidade
Geração dos registros obrigatórios do layout.
Suporte a múltiplos registros 314.
Cada 314 possui um bloco obrigatório e até quatro opcionais.
Nome do arquivo final baseado no campo iddoc do registro 310.
Funções auxiliares garantem o preenchimento correto de campos numéricos e de texto.
Registros Implementados
Registro 000

Cabeçalho do intercâmbio.

Registro 310

Cabeçalho da NF. Gera automaticamente um iddoc caso o usuário deixe em branco.

Registro 311

Dados do Emitente (CNPJ, nome, endereço).

Registro 312

Dados do Destinatário (CNPJ, nome, endereço).

Registro 313

Dados da nota fiscal (número, série, data, valor total).

Registro 314

Mercadorias da NF.
Contém:

1 bloco obrigatório
Até 4 blocos opcionais

Cada bloco possui:

Quantidade
Espécie de acondicionamento
Descrição da mercadoria
Como Executar
Verifique que o Ruby está instalado:

```ruby -v```
Execute o programa:

```ruby app.rb```
Preencha os dados conforme solicitado.

Ao final, será gerado um arquivo .TXT com o nome definido pelo iddoc.

Estrutura das Funções Principais
pad_num(value, size)
Remove caracteres não numéricos.
Preenche com zeros à esquerda.
Garante comprimento fixo.
pad_str(value, size)
Preenche com espaços à direita.
Garante comprimento fixo.
record(*fields)
Junta todos os campos.
Preenche a linha até completar 240 caracteres.
Fluxo de Execução
Reg 000
Reg 310
Reg 311
Reg 312
Reg 313
Um ou mais Reg 314
Escrita do arquivo final <iddoc>.TXT
Saída

Arquivo .TXT contendo cada registro em linhas separadas, todas com 240 caracteres.
