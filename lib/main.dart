import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RockInRio());
}

class RockInRio extends StatelessWidget {
  // Classe stateless(não muda de estado)
  const RockInRio({Key? key}) : super(key: key); // Construtor do widget

  @override // Indica o que o build vai retornar
  Widget build(BuildContext context) {
    return MaterialApp(
      // Material do aplicativo
      title: 'Rock no rio',
      // Título do app
      debugShowCheckedModeBanner: false,
      // Tira a flag 'debug' da tela do app
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      // Tema da tela
      home: const HomePage(),
      // Chama a classe Homepage
    );
  }
}

class HomePage extends StatefulWidget {
  // Classe stateful(muda de estado)
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  // Função de Criação do estado da HomePage
}

class _HomePageState extends State<HomePage> {
  // Underline(_) Indica que só estará visivel para esta parte do code
  final List<Atracao> listaFavoritos = [];
  //Declaraçao e tipagem Atracao da lista de favoritados.
  //fica Vazia até o user favoritar algum.
  @override
  // Override Indica o que o build vai retornar algo
  Widget build(BuildContext context) {
    return Scaffold(
      // estrututra\'andaime' basica que flutter fornece.
      appBar: AppBar(
        // Barra de ações do app
        title: const Text('Atrações'),
      ),
      body: ListView.builder(
        //body\corpo da página
        // Widget de lista.
        //.builder = Como o objeto vai ser construído
        itemCount: listaAtracoes.length,
        //Conta a quantidade de itens da listaAtrações com .length
        itemBuilder: (context, index) {
          //Builda a lista de atrações
          // context vai indicar o tipo e lista que queremos buildar
          // index = posição que estamos lendo da lista
          //final _favoritos = listaFavoritos.contains(listaAtracoes[index]);
          //Variável booleana que vai verificar se listaFavoritos(.contains) contem
          //as atrações favoritadas pelo user da listaAtracoes.

          //Nome_var_1.contains(nome_var_2[index])

          return ListTile(
            //Mostra uma linha da lista de atrações até acabar a linha
            onTap: () {
              //onTap cria uma interação com cada Objeto da ListTile ao apertarmos

              Navigator.push(
                // Função de navegação entre pages. .Push vai entrar em uma page
                // .pop volta para a page anterior.
                context,
                // Passagem do parâmetro context que indica onde o user está
                MaterialPageRoute(
                  //Criação da page que vamos
                  builder: (context) =>
                      //Builder
                      AtracaoPage(atracao: listaAtracoes[index]),
                  //Criação da page com base no index da atração
                  //que apertamos anteriormente
                ),
              );
            },

            title: Text(listaAtracoes[index].nome),
            // Mostra em um title a lista de atrações do index atual numa variável Text
            subtitle: Wrap(
              spacing: 8, // Espacamento do titulo
              runSpacing: 4,
              children: listaAtracoes[index]
                  .tags
                  //localiza as 'tags' de listaAtracoes para o flutter
                  .map((tag) => Chip(label: Text('#$tag')))
                  //mostra as tags na tela
                  .toList(),
            ),
            leading: CircleAvatar(
              // Ícone de círculo que ter um processo child que
              // Cada widget pode ter um ou vários processos Child\Children.
              child: Text('${listaAtracoes[index].dia}'),
              // vai mostrar o dia do show do artista.
            ),
            trailing: FavoriteButton(
              // Importando 'favorite_button: ^0.0.3' para o arquivo pubspec.yaml
              // Se consegue utilizar do widget FavoriteButton()
              // Podendo definir sua cor e seu estado padrão.
              isFavorite: false,
              //Começa Vazio e cinza.
              iconColor: const Color.fromARGB(255, 236, 7, 217),
              // Cor do icone quando pressionado e true.
              valueChanged: (isFavorite) {},
              // Troca do valor False\true de isFavorite
              // quando o mesmo for selecionado
            ),
          );
        },
      ),
    );
  }
}

class AtracaoPage extends StatelessWidget {
  // Classe da pagima do artista
  final Atracao atracao;
  //Delcaração de var atracao para uso de tag e nome das atrações na classe
  const AtracaoPage({Key? key, required this.atracao}) : super(key: key);
  //Construtor
  @override
  //Indica que vamos buildar algo
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(atracao.nome),
          //App bar que mostra o nome da atração clicada
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          // Padding é o espaçamento da tela em relação ao limite dela. No momento ela está tendo um
          // espaçamento de 24 pixels em todas as direções
          child: Column(
            // Widget de coluna que alinha todos os outros na vertical
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // Alinha os widget colocados na coluna até o limite horizontal da tela.
            children: [
              //Processos ligados a column
              for (var tag in atracao.tags)
                //Loop para printar na tela as tags do artista
                Chip(
                  padding: const EdgeInsets.all(60),
                  backgroundColor: Colors.transparent,
                  label: Text(tag),
                  //FUnção para criar um objeto na tela com: cor, espaçamento e texto
                ),
              ElevatedButton(
                //Botão para voltar a pagina anterior.

                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pop Faz com que volte para a page anterior
                },
                child: const Text('botão de voltar'),
                //Texto que será mostrado no botão.
              ),
            ],
          ),
        ));
  }
}

class Atracao {
//Criação de class\tipo atração. O mesmo pode ser usado depois
  final String nome;
  final int dia;
  final List<String> tags;
  // Declaração das variáveis que mostrarão as atrações

  const Atracao(this.nome, this.dia, this.tags); // Construtor da Variáveis
}

const listaAtracoes = [
  // Lista de Strings atrações
  // criação de tipo 'atração' (Nome  ,   dia   ,   tags)
  Atracao("Iron Maiden", 2, ["Espetaculo", "Fãs", "NovoAlbum"]),
  Atracao("Alok", 3, ["Influente", "Top", "Show"]),
  Atracao("Justin Bieber", 4, ["TopCharts", "Hits", "PríncipeDoPOP"]),
  Atracao("Guns N’ Roses", 4, ["Sucesso", "Espetáculo", "Fãs"]),
  Atracao("Capital Inicial", 4, ["2019", "Novo Álbum"]),
  Atracao("Green Day", 5, ["Sucesso", "Reconhecimento", "Show"]),
  Atracao("Cold Play", 5, ["NovoAlbum", "Overrated", "2011"]),
  Atracao("Ivete Sangalo", 6, ["Unica", "Carreiras", "Veveta"]),
  Atracao("Racionais", 7, ["Hits", "Prêmios", "Mano Brown"]),
  Atracao("Gloria Groove", 7, ["Streams", "Representatividade", "Sucesso"]),
  Atracao("Avril Lavigne", 8,
      ["Clone da Avril de Verdade", "Sucesso", "Lançamento"]),
  Atracao("Ludmilla", 9, ["Representativade", "Sucesso", "Parcerias"]),
];
