## Como rodar o projeto



```
git clone https://github.com/marchettomarcelo/ETL-Ocaml.git

dune build
```

Para filtrar por tipos de status e orgigem, deve ser passado como argumento de linha de comando os seguintes valores

Status: "Pending", "Complete" ou "all"

Origin: "P", "O" ou "all"


```
dune exec etl all all
```


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


## Passo a passo  

A seguir, são descritas as etapas de desenvolvimento do projeto, com recomendações para facilitar sua reprodução no futuro.  

### Configuração inicial  

Para iniciar o projeto, recomenda-se utilizar o Dune, uma ferramenta que simplifica a configuração e o gerenciamento de dependências em OCaml. Criar um projeto estruturado desde o início ajuda na organização e facilita a manutenção do código. Antes de avançar para a implementação principal, é útil escrever algumas funções simples para se familiarizar com a sintaxe da linguagem. Uma dificuldade comum nesse estágio é a importação de funções entre arquivos diferentes, o que pode ser resolvido ajustando a estrutura do projeto e configurando corretamente os arquivos `dune`.  

### Leitura de dados em CSV  

Para lidar com arquivos CSV, recomenda-se utilizar a biblioteca `csv`, que fornece funcionalidades para carregar e manipular dados tabulares. Essa abordagem simplifica a leitura e conversão dos dados para os tipos específicos do projeto.  

### Processamento de dados  

Com os dados carregados, o próximo passo é convertê-los em tipos estruturados, como `order` e `order_item`. Nesse processo, o uso de pattern matching facilita a extração e manipulação das informações, permitindo compreender melhor como os tipos e variantes funcionam em OCaml.  

### Implementação da agregação de dados  

Uma vez que os dados foram corretamente tipados, torna-se mais simples implementar as funções de agregação exigidas pelo requisito "C" do projeto. O objetivo aqui é agrupar valores de `order_item` com base nos identificadores das ordens (`order`).  

### Requisitos avançados  

Para funcionalidades mais complexas, como testes automatizados, manipulação de banco de dados SQLite e leitura de arquivos via internet, recomenda-se utilizar as bibliotecas `ounit2`, `sqlite3`, `cohttp-lwt-unix` e `lwt`. Essas ferramentas fornecem suporte eficiente para testes, persistência de dados e requisições HTTP assíncronas, facilitando a implementação e a escalabilidade do projeto.  


## Uso de IA

Para a realização do projeto, foi utilizada a IA generativa principalmente para que eu pudesse me familizarizar com a sintaxe e features da linguagem. Por exemplo, a sequência de uso de "pipes" no arquivo main foi sugerida pela IA, algo que eu não teria pensado em fazer por mim mesmo. No entanto, a maior parte da lógica de como a aplicação funciona e foi estruturada foi feita por mim.
