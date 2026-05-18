# Funções que copiei do projeto visualset pra poder formatar strings e nums 

def pad_num(value, size)
  value.to_s.gsub(/\D/, "").rjust(size, "0")[0, size]
end

def pad_str(value, size)
  value.to_s.ljust(size, " ")[0, size]
end

#ajusta pra 240 caracteres em todas as linhas
def record(*fields)
  line = fields.join
  line.ljust(240, " ") 
end

# Registros ------------------------------------------------------------------

def reg_000
  puts "=== Registro 000 (Cabeçalho do intercâmbio) ==="
  print "Remetente: "
  remetente = gets.chomp

  print "Destinatário: "
  destinatario = gets.chomp

  print "Data (DDMMAA): "
  data = gets.chomp

  print "Hora (HHMM): "
  hora = gets.chomp

  print "Número do intercâmbio: "
  numero = gets.chomp

  record(
    pad_num(000, 3),       
    pad_str(remetente, 35),
    pad_str(destinatario, 35),
    pad_num(data, 6),
    pad_num(hora, 4),
    pad_str(numero, 12),
    pad_str("", 145)       
  )
end

def reg_310
  puts "=== Registro 310 (Cabeçalho da NF) ==="
 
  now = Time.now
  sugestao = "NOTFI" +
             now.strftime("%d%m") +
             now.strftime("%H%M") +
             rand(0..9).to_s

  print "Identificação do documento (ENTER para usar #{sugestao}): "
  iddoc = gets.chomp
  iddoc = sugestao if iddoc.strip == ""

  linha = record(
    pad_num(310, 3),
    pad_str(iddoc, 14),
    pad_str("", 223)
  )

  return linha, iddoc
end

def reg_311
  puts "=== Registro 311 (Emitente) ==="

  print "CNPJ Emitente: "
  cnpj = gets.chomp

  print "Nome Emitente: "
  nome = gets.chomp

  print "Endereço Emitente: "
  endereco = gets.chomp

  record(
    pad_num(311, 3),
    pad_num(cnpj, 14),
    pad_str(nome, 35),
    pad_str(endereco, 50),
    pad_str("", 138)
  )
end

def reg_312
  puts "=== Registro 312 (Destinatário) ==="
  
  print "CNPJ Destinatário: "
  cnpj = gets.chomp

  print "Nome Destinatário: "
  nome = gets.chomp

  print "Endereço Destinatário: "
  endereco = gets.chomp

  record(
    pad_num(312, 3),
    pad_num(cnpj, 14),
    pad_str(nome, 35),
    pad_str(endereco, 50),
    pad_str("", 138)
  )
end

def reg_313
  puts "=== Registro 313 (Dados da NF) ==="

  print "Número da NF: "
  numero = gets.chomp

  print "Série: "
  serie = gets.chomp

  print "Data Emissão (DDMMAAAA): "
  data = gets.chomp

  print "Valor Total: "
  valor_total = gets.chomp.to_f

  record(
    pad_num(313, 3),
    pad_num(numero, 9),
    pad_str(serie, 3),
    pad_num(data, 8),
    pad_num((valor_total * 100).to_i, 15),
    pad_str("", 202)
  )
end

def reg_314
  puts "=== Registro 314 (Mercadoria da NF) ==="

  # Bloco obrigatório
  print "Quantidade de volumes (ex: 10.50): "
  q1 = gets.chomp.to_f

  print "Espécie de acondicionamento: "
  e1 = gets.chomp

  print "Descrição/Nome da mercadoria: "
  m1 = gets.chomp

  # Blocos opcionais (4)
  blocks = []

  4.times do |i|
    print "\nAdicionar bloco opcional #{i+1}? (s/n): "
    break unless gets.chomp.downcase == "s"

    print "Quantidade de volumes: "
    q = gets.chomp.to_f

    print "Espécie de acondicionamento: "
    e = gets.chomp

    print "Descrição/Nome da mercadoria: "
    m = gets.chomp

    blocks << [q, e, m]
  end

  fields = []

  # Identificador
  fields << pad_num(314, 3)

  # Bloco obrigatório
  fields << pad_num((q1 * 100).to_i, 5)
  fields << pad_str(e1, 15)
  fields << pad_str(m1, 30)

  # Blocos opcionais
  blocks.each do |q, e, m|
    fields << pad_num((q * 100).to_i, 5)
    fields << pad_str(e, 15)
    fields << pad_str(m, 30)
  end

  # Preencher blocos faltantes
  (4 - blocks.size).times do
    fields << pad_str("", 5)
    fields << pad_str("", 15)
    fields << pad_str("", 30)
  end

  # Filler final 29 posições
  fields << pad_str("", 29)

  record(*fields)
end


# Execução -------------------------------------------------------------------

linhas = []

linhas << reg_000

linha_310, iddoc = reg_310
linhas << linha_310

linhas << reg_311
linhas << reg_312
linhas << reg_313

# Itens 314
loop do
  linhas << reg_314

  print "Adicionar outro produto? (s/n): "
  break if gets.chomp.downcase != "s"
end

nome_arquivo = "#{iddoc}.TXT"
File.write(nome_arquivo, linhas.join("\n"))

puts "\nArquivo #{nome_arquivo} gerado!"
