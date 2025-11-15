#!/bin/bash

# ==============================================================================
# Variáveis de Configuração
# Define a pasta base (usando o diretório atual em vez de C:\ no Linux)
# A variável BASE_DIR usará o caminho absoluto do seu projeto.
BASE_DIR="$(pwd)/GestorArquivos"
LOG_FILE="$BASE_DIR/Logs/atividade.log"

PASTAS_CRIADAS=0
ARQUIVOS_CRIADOS=0

# ==============================================================================
# Função para Registrar Log
# Argumentos: $1 = Nome da Operação, $2 = Resultado (Sucesso/Falha)
log_operacao() {
    DATA_HORA=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$DATA_HORA] | $1 | $2" >> "$LOG_FILE"
}

# ==============================================================================
# 1. Criação de Diretórios
# No Linux, 'mkdir -p' cria pastas aninhadas e não falha se a pasta já existir.

echo "Iniciando criação de diretórios..."

# Diretórios a serem criados
DIRETORIOS=(
    "$BASE_DIR"
    "$BASE_DIR/Documentos"
    "$BASE_DIR/Logs"
    "$BASE_DIR/Backups"
)

for dir in "${DIRETORIOS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        if [ $? -eq 0 ]; then
            log_operacao "Criação de Pasta: $(basename "$dir")" "Sucesso"
            PASTAS_CRIADAS=$((PASTAS_CRIADAS + 1))
        else
            log_operacao "Criação de Pasta: $(basename "$dir")" "Falha"
        fi
    else
        log_operacao "Verificação de Pasta: $(basename "$dir")" "Já Existe"
    fi
done

echo "Diretórios criados/verificados."

# ==============================================================================
# 2. Criação e Manipulação de Arquivos

DOCUMENTOS_DIR="$BASE_DIR/Documentos"
echo "Iniciando criação de arquivos na pasta Documentos..."

# a) relatorio.txt
echo "Relatório Gerencial do dia." > "$DOCUMENTOS_DIR/relatorio.txt"
echo "Linha 2 de texto." >> "$DOCUMENTOS_DIR/relatorio.txt"
log_operacao "Criação de Arquivo: relatorio.txt" "Sucesso"
ARQUIVOS_CRIADOS=$((ARQUIVOS_CRIADOS + 1))

# b) dados.csv
echo "Nome,Idade,Cidade" > "$DOCUMENTOS_DIR/dados.csv"
echo "João,30,São Paulo" >> "$DOCUMENTOS_DIR/dados.csv"
echo "Maria,25,Rio de Janeiro" >> "$DOCUMENTOS_DIR/dados.csv"
log_operacao "Criação de Arquivo: dados.csv" "Sucesso"
ARQUIVOS_CRIADOS=$((ARQUIVOS_CRIADOS + 1))

# c) config.ini
echo "[Sistema]" > "$DOCUMENTOS_DIR/config.ini"
echo "Versao=1.0" >> "$DOCUMENTOS_DIR/config.ini"
echo "Modo=Producao" >> "$DOCUMENTOS_DIR/config.ini"
log_operacao "Criação de Arquivo: config.ini" "Sucesso"
ARQUIVOS_CRIADOS=$((ARQUIVOS_CRIADOS + 1))

echo "Arquivos de documentos criados."

# ==============================================================================
# 3. Simulação de Backup

BACKUP_DIR="$BASE_DIR/Backups"
DATA_BACKUP=$(date +"%Y-%m-%d %H:%M:%S")

echo "Iniciando backup..."

# Copia os arquivos de Documentos para Backups
cp "$DOCUMENTOS_DIR"/* "$BACKUP_DIR/"
if [ $? -eq 0 ]; then
    log_operacao "Cópia de Arquivos" "Sucesso"
else
    log_operacao "Cópia de Arquivos" "Falha"
fi

# Cria o arquivo backup_completo.bak
echo "BACKUP COMPLETO REALIZADO EM: $DATA_BACKUP" > "$BACKUP_DIR/backup_completo.bak"
log_operacao "Criação de backup_completo.bak" "Sucesso"
ARQUIVOS_CRIADOS=$((ARQUIVOS_CRIADOS + 1))

echo "Backup concluído."

# ==============================================================================
# 4. Relatório Final

RESUMO_FILE="$BASE_DIR/resumo_execucao.txt"

echo "Gerando relatório final em resumo_execucao.txt..."

echo "RELATÓRIO DE EXECUÇÃO" > "$RESUMO_FILE"
echo "----------------------" >> "$RESUMO_FILE"
echo "Total de arquivos criados: $ARQUIVOS_CRIADOS" >> "$RESUMO_FILE"
echo "Total de pastas criadas: $PASTAS_CRIADAS" >> "$RESUMO_FILE"
echo "Data/Hora do backup: $DATA_BACKUP" >> "$RESUMO_FILE"

log_operacao "Geração de Relatório Final" "Sucesso"

echo "Script concluído com sucesso. Verifique a pasta '$BASE_DIR'."
# ==============================================================================