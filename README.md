
## Requisitos do Projeto
- [x] 1. O projeto precisa ser feito em OCaml.
- [x] 2. Para calcular a saída, é necessário utilizar map , reduce e filter .
- [x] 3. O código deve conter funções para leitura e escrita de arquivos CSV. Isso gerará funções
impuras.
- [x] 4. Separar as funções impuras das funções puras nos arquivos do projeto.
- [x] 5. A entrada precisa ser carregada em uma estrutura de lista de Records .
- [x] 6. É obrigatório o uso de Helper Functions para carregar os campos em um Record .
- [x] 7. É necessário escrever um relatório do projeto, indicando como as etapas foram construídas. Isso
é semelhante a um roteiro para alguém que iria refazer o projeto no futuro. Você deve declarar o
uso ou não de IA Generativa nesse relatório.


## Requisitos Opcionais
- [x] 1. Ler os dados de entrada em um arquivo estático na internet (exposto via http).
- [x] 2. Salvar os dados de saída em um Banco de Dados SQLite.
- [ ] 3. É possível fazer fazer o tratamento das tabelas de entrada em separado. Mas é desejável realizar
o tratamento dos dados conjuntamente via operação de inner join . Ou seja, juntar as tabelas
antes de iniciar a etapa de
Transform.
- [x] 4. Organizar o projeto ETL utilizando dune .
- [x] 5. Documentar todas as funções geradas via formato docstring .
- [ ] 6. Realizar uma saída adicional que contém a média de receita e impostos pagos agrupados por
mês e ano.
- [x] 7. Gerar arquivos de testes completos para as funções puras.


## Step by step

A seguir, vou relatar o processo de desenvolvimento desse projeto.

### Inicio

No início, quando eu ainda não estava muito familiarizado com a sintaxe, eu optei por iniciar de cara um projeto usando o dune uma vez que meus amigos me disseram que seria mais fácil iniciar o projeto usadno a ferramenta. Primeiramente, eu criei algumas funções simples para me acostumar com o jeito que as coisas funcionavam em OCaml, mas tive bastante dificultade para importar funcoes de um arquivo para outro, mas eventualmente, consegui fazer tudo funcionar da maneira que eu planejava.

### Leitura de dados em csv

O segundo passo foi descobrir como trabalhar com arquivos CSV. Eu optei por baixar a biblioteca "csv" para lidar com os aquivos de dados do projeto.

### Processar dados

Em seguida, passei a escrever as funções que convertiam as listas de strings nos tipos que eu havia criado: "order" e "order_item". Nesse momento eu passei a realmente entender como o pattern matching e os tipos funcionavam na linguagem.

### Fazer o C

Tendo os dados em mãos e já convertidos em tipos, foi simples concluir os requisitos "C" do projeto. Ao criar a

### Requisitos avançados

### Uso de IA

