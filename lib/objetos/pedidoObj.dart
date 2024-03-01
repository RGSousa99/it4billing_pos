import '../main.dart';
import 'artigoObj.dart';
import 'package:objectbox/objectbox.dart';
import '../database/objectbox.g.dart';

@Entity()
class PedidoObj {
  int id = 0;
  String nome;
  DateTime hora;


  // late ToMany<Artigo> artigosPedido = ToMany<Artigo>();
  late List<int> artigosPedidoIds = [];

  int utilizadorId;
  int localId ;

  double total = 0;
  int nrArtigos = 0;

  PedidoObj({
    required this.nome,
    required this.hora,
    required this.utilizadorId,
    required this.localId,
    required this.total,
  });


  double calcularValorTotal() {
    total=0;
    for (var artigoId in artigosPedidoIds) {
      total += database.getArtigo(artigoId)!.price;
    }
    return total;
  }
}
