import 'package:it4billing_pos/main.dart';
import 'package:it4billing_pos/objetos/clienteObj.dart';
import 'package:it4billing_pos/objetos/setupObj.dart';
import 'package:it4billing_pos/objetos/transacoesObj.dart';
import 'package:it4billing_pos/objetos/turnoObj.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../objetos/VendaObj.dart';
import '../objetos/artigoObj.dart';
import '../objetos/categoriaObj.dart';
import '../objetos/impressoraObj.dart';
import '../objetos/localObj.dart';
import '../objetos/metodoPagamentoObj.dart';
import '../objetos/pedidoObj.dart';
import '../objetos/templateOBJ.dart';
import '../objetos/utilizadorObj.dart';
import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ObjectBoxDatabase {
  /// The Store of this app.
  late final Store _store;

  /// A Boxs.
  late final Box<PedidoObj> _pedidosBox;
  late final Box<VendaObj> _vendasBox;
  late final Box<Utilizador> _utilizadoresBox;
  late final Box<ClienteObj> _clientesBox;
  late final Box<LocalObj> _locaisBox;
  late final Box<Categoria> _categoriasBox;
  late final Box<Artigo> _artigosBox;

  late final Box<SetupObj> _setupBox;
  late final Box<TurnoObj> _turnosBox;
  late final Box<MetodoPagamentoObj> _metodoPagamentoBox;
  late final Box<ImpressoraObj> _impressorasBox;
  late final Box<TransactionObj> _transactionsBox;
  late final Box<TemplateOBJ> _templateOBJBox ;

  ObjectBoxDatabase._create(this._store) {
    _pedidosBox = Box<PedidoObj>(_store);
    _vendasBox = Box<VendaObj>(_store);
    _utilizadoresBox = Box<Utilizador>(_store);
    _clientesBox = Box<ClienteObj>(_store);

    _locaisBox = Box<LocalObj>(_store);
    _categoriasBox = Box<Categoria>(_store);
    _artigosBox = Box<Artigo>(_store);

    _setupBox = Box<SetupObj>(_store);
    _turnosBox = Box<TurnoObj>(_store);
    _metodoPagamentoBox = Box<MetodoPagamentoObj>(_store);
    _impressorasBox = Box<ImpressoraObj>(_store);
    _transactionsBox = Box<TransactionObj>(_store);
    _templateOBJBox = Box<TemplateOBJ>(_store);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBoxDatabase> create() async {
    final store = await openStore(
        directory:
            p.join((await getApplicationDocumentsDirectory()).path, "obx-demo"),
        macosApplicationGroup: "objectbox.demo");
    return ObjectBoxDatabase._create(store);
  }

  Future<void> putDemoUsers() async {
    final demoUsers = [
      Utilizador('User 001', 1234),
      Utilizador('User 064', 4321),
    ];
    await _utilizadoresBox.putManyAsync(demoUsers);
  }

  /// perceber quandou houver BDws se criar uma "tabela" ou colocar dentro objeto turno
  /// por agora tabela apenas
  Future<void> putDemoMetodosPagamento() async {
    final List<MetodoPagamentoObj> metodoPagamento = [
      MetodoPagamentoObj('Dinheiro', 0),
      MetodoPagamentoObj('Multibanco', 0),
      MetodoPagamentoObj('MB Way', 0),
    ];
    await _metodoPagamentoBox.putMany(metodoPagamento);
  }

  Future<void> putDemoClientes() async {
    final demoClients = [
      ClienteObj('Consumidor Final', 999999990, 'N/D', 'N/D', '0000-000', 'N/D',
          'N/D', 0, 'N/D'),
      ClienteObj('Beatriz Silva', 240548921, 'Portugal', 'N/D', '0000-000',
          'Lisboa', 'email001@gmail.com', 926545742, 'N/D'),
      ClienteObj('Diogo Figueira', 270785524, 'Portugal', 'Av. de Berna 4 1D',
          '2478-654', 'Porto', 'email002@gmail.com', 926595552, 'N/D'),
      ClienteObj('Filipa Silva', 230784532, 'Espanha', 'N/D', '4562-488',
          'Madrid', 'N/D', 924826542, 'N/D'),
      ClienteObj('João Neves', 191978465, 'Portugal', 'N/D', '0000-000',
          'Lisboa', 'email004@gmail.com', 926952148, 'N/D'),
    ];
    await _clientesBox.putManyAsync(demoClients);
  }

  void putDemoLocais() {
    final List<LocalObj> locais = [
      LocalObj('Mesa 1'),
      LocalObj('Mesa 2'),
      LocalObj('Mesa 3'),
      LocalObj('Balcão 1'),
    ];
    _locaisBox.putManyAsync(locais);
  }

  void putDemoCategorias() {
    final List<Categoria> categorias = [
      Categoria(nome: 'Todos os artigos', description: '', nomeCurto: ''),
      Categoria(nome: "Categoria 1", nomeCurto: "Cat 1", description: ''),
      Categoria(nome: "Categoria 2", nomeCurto: "Cat 2", description: ''),
      Categoria(nome: "Categoria 3", nomeCurto: "Cat 3", description: ''),
    ];
    _categoriasBox.putMany(categorias);
  }

  void putDemoArtigos() {
    List<int> idCategorias = [];

    if (database.getAllCategorias().isNotEmpty) {
      for (var i = 0; i < database.getAllCategorias().length; i++) {
        idCategorias.add(database.getAllCategorias()[i].id);
      }

      List<Artigo> artigos = [
        Artigo(
            referencia: "001",
            nome: "Artigo 1",
            barCod: '',
            description: '',
            productType: '',
            unitPrice: 4.06,
            taxPrecentage: 23,
            idTaxes: 1,
            taxName: '',
            taxDescription: '',
            idRetention: 1,
            retentionPercentage: 1,
            retentionName: '',
            stock: 24,
            idArticlesCategories: idCategorias[1]),
        Artigo(
            referencia: "002",
            nome: "Artigo 2",
            barCod: '',
            description: '',
            productType: '',
            unitPrice: 6.42,
            taxPrecentage: 23,
            idTaxes: 2,
            taxName: '',
            taxDescription: '',
            idRetention: 2,
            retentionPercentage: 2,
            retentionName: '',
            stock: 10,
            idArticlesCategories: idCategorias[2]),
        Artigo(
            referencia: "003",
            nome: "Artigo 3 - com um nome grande PARA TESTES",
            barCod: '',
            description: '',
            productType: '',
            unitPrice: 1,
            taxPrecentage: 23,
            idTaxes: 2,
            taxName: '',
            taxDescription: '',
            idRetention: 2,
            retentionPercentage: 2,
            retentionName: '',
            stock: 12,
            idArticlesCategories: idCategorias[3]),
        Artigo(
            referencia: "004",
            nome: "Artigo 4",
            barCod: '',
            description: '',
            productType: '',
            unitPrice: 4.06,
            taxPrecentage: 23,
            idTaxes: 1,
            taxName: '',
            taxDescription: '',
            idRetention: 1,
            retentionPercentage: 1,
            retentionName: '',
            stock: 6,
            idArticlesCategories: idCategorias[2]),
      ];

      _artigosBox.putMany(artigos);
    }
  }

  Future<void> addPedido(PedidoObj pedido) async {
    await _pedidosBox.put(pedido);
  }

  Future<void> removePedido(int index) async {
    await _pedidosBox.remove(index);
  }

  List<PedidoObj> getAllPedidos() {
    return _pedidosBox.getAll();
  }

  PedidoObj? getPedido(int id) {
    return _pedidosBox.get(id);
  }

  Future<void> removeAllPedidos() async {
    await _pedidosBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para adicionar e manipular funcionários
  Future<void> addFuncionario(Utilizador utilizador) async {
    await _utilizadoresBox.put(utilizador);
  }

  Utilizador? getFuncionario(int id) {
    return _utilizadoresBox.get(id);
  }

  bool containFuncionario(int id) {
    return _utilizadoresBox.contains(id);
  }

  List<Utilizador> getAllFuncionarios() {
    return _utilizadoresBox.getAll();
  }

  Future<void> removeAllFuncionarios() async {
    await _utilizadoresBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para adicionar e manipular locais
  Future<void> addLocal(LocalObj local) async {
    await _locaisBox.put(local);
  }

  LocalObj? getLocal(int id) {
    return _locaisBox.get(id);
  }

  List<LocalObj> getAllLocal() {
    return _locaisBox.getAll();
  }

  Future<void> removeAlllocais() async {
    await _locaisBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para adicionar e manipular Categorias
  Future<void> addCategorias(Categoria categoria) async {
    await _categoriasBox.put(categoria);
  }

  Categoria? getCategorias(int id) {
    return _categoriasBox.get(id);
  }

  List<Categoria> getAllCategorias() {
    return _categoriasBox.getAll();
  }

  Future<void> removeAllCategorias() async {
    await _categoriasBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para adicionar e manipular Artigos
  Future<void> addArtigos(Artigo artigo) async {
    await _artigosBox.put(artigo);
  }

  Artigo? getArtigo(int id) {
    return _artigosBox.get(id);
  }

  List<Artigo> getAllArtigos() {
    return _artigosBox.getAll();
  }

  Future<void> removeAllArtigos() async {
    await _artigosBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para manipular os Turno
  Future<void> addTurno(TurnoObj turno) async {
    await _turnosBox.put(turno);
  }

  TurnoObj? getTurno(int id) {
    return _turnosBox.get(id);
  }

  List<TurnoObj> getAllTurno() {
    return _turnosBox.getAll();
  }

  Future<void> removeAllTurno() async {
    await _turnosBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para manipular as Vendas
  Future<void> addVenda(VendaObj venda) async {
    await _vendasBox.put(venda);
  }

  VendaObj? getVenda(int id) {
    return _vendasBox.get(id);
  }

  List<VendaObj> getAllVendas() {
    return _vendasBox.getAll();
  }

  Future<void> removeAllVendas() async {
    await _vendasBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para manipular o Setup
  Future<void> addSetup(SetupObj setup) async {
    await _setupBox.put(setup);
  }

  SetupObj? getSetup(int id) {
    return _setupBox.get(id);
  }

  List<SetupObj> getAllSetup() {
    return _setupBox.getAll();
  }

  Future<void> removeAllSetup() async {
    await _setupBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para manipular o cliente
  Future<void> addCliente(ClienteObj cliente) async {
    await _clientesBox.put(cliente);
  }

  ClienteObj? getCliente(int id) {
    return _clientesBox.get(id);
  }

  List<ClienteObj> getAllClientes() {
    return _clientesBox.getAll();
  }

  Future<void> removeAllClientes() async {
    await _clientesBox.removeAll();
  }

  Future<void> removeCliente(int index) async {
    await _clientesBox.remove(index);
  }

  ///---------------------------------------------------------
  // Funções para manipular o MetodoPagamento
  Future<void> addMetodoPagamento(MetodoPagamentoObj metodo) async {
    await _metodoPagamentoBox.put(metodo);
  }

  MetodoPagamentoObj? getMetodoPagamento(int id) {
    return _metodoPagamentoBox.get(id);
  }

  List<MetodoPagamentoObj> getAllMetodosPagamento() {
    return _metodoPagamentoBox.getAll();
  }

  Future<void> removeAllMetodosPagamento() async {
    await _metodoPagamentoBox.removeAll();
  }
  List<int> getAllMetodosPagamentoIds() {
    List<int> ids = [];
    List<MetodoPagamentoObj> metodos = _metodoPagamentoBox.getAll();

    for (var metodo in metodos) {
      ids.add(metodo.id);
    }

    return ids;
  }


  ///---------------------------------------------------------
  // Funções para manipular as Impressoras
  Future<void> addImpressora(ImpressoraObj impressora) async {
    await _impressorasBox.put(impressora);
  }

  Future<void> removeImpressora(int index) async {
    await _impressorasBox.remove(index);
  }

  ImpressoraObj? getImpressora(int id) {
    return _impressorasBox.get(id);
  }

  List<ImpressoraObj> getAllImpressoras() {
    return _impressorasBox.getAll();
  }

  Future<void> removeAllImpressoras() async {
    await _impressorasBox.removeAll();
  }

  ///---------------------------------------------------------
  // Funções para manipular as Impressoras
  Future<void> addTransaction(TransactionObj impressora) async {
    await _transactionsBox.put(impressora);
  }

  TransactionObj? getTransaction(int id) {
    return _transactionsBox.get(id);
  }

  List<TransactionObj> getAllTransactions() {
    return _transactionsBox.getAll();
  }

  Future<void> removeAllTransactions() async {
    await _transactionsBox.removeAll();
  }
  ///---------------------------------------------------------
  // Funções para manipular as TemplateOBJ
  Future<void> addTemplate(TemplateOBJ template) async {
    await _templateOBJBox.put(template);
  }

  Future<void> removeAllTemplate() async {
    await _templateOBJBox.removeAll();
  }

  List<TemplateOBJ> getAllTemplates() {
    return _templateOBJBox.getAll();
  }


}
