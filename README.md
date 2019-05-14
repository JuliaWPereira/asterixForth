<h1> AsterixForth</h1>
<h2>Arquitetura Stack desenvolvida por Júlia Wotzasek Pereira </h2>

Para informações relativas a ideia da arquitetura, por enquanto leia o pdf do repositório

<h2> Arquivos vigentes </h2>
<div>
<u1>
  <li> ula.v - arquivo atual da ULA. Operações estritamente combinacionais</li>
  <li> shifter.v - arquivo acoplado com a ula.v para dar shift nos resultados da ula. Operaçes estritamente combinacionais</li>
  <li> muxY.v - arquivo do multiplexador de seleção de quem deve ser colocado no barramento do Y no qual a ULA tem acesso. Operações estritamente combinacionais.</li>
  <li> pilhaDeDados.v - arquivo da pilha de dados. Ele utiliza a memória do FPGA. Possui os sinais FLAG para underflow, overflow e empty para exceções. </li>
  <li> pilhaDeRetorno.v - arquivo da pilha de retorno. A priori, tá igual a pilha de Dados. Pensar em talvez alterar o tamanho.</li>
  <li> memoriaDePrograma.v - arquivo da memória de programa. Implementei dual-port para me resguardar de já ser possível escrever na memória de programas, apesar de não usar isso nesse projeto. Implementei dual-clock para ter a leitura automática.</li>
  <li> contadorDoPrograma.v - arquivo do contador do programa, ou PC. Já que estamos trabalhando com dual clock, fiz com que o PC dê a saída do endereço sempre no tempo do clock do FPGA (read_clk) e atualizar o clock no tempo da máquina. Deixei encapsulado o controle de <i>branch</i> dentro desse módulo, tratando com if.</li>
  <li> binarioParaBCD.v - arquivo para converter os dados de 16 bits para BCD para posterior saída no <i>display</i> de 7 segmentos. O dado é considerado <i>unsigned</i>. Daí, se resolver que vou tratar números negativos, devo desenvolver um módulo que antecede a conversão e que inverte todos os bits e soma 1 caso seja negativo, obtendo o valor correto.</li>
  <li> BCDpara7segmentos.v - converte individualmente o número BCD para 7 segmentos. </li>
  <li> debounce.v - debounce para o push button de enter. </li>
  <li> entradaSwitches.v - recebe as entradas dos 16 switches, esperando a confirmação do dado com um "enter" de push button. Fiz com que fosse síncrona, para garantir que lê a entrada a tempo. </li>
  <li> muxG.v - multiplexador para definir se o dado que está no barramento de E/S é o next (para saída de dados) ou se é o dado que está nos switches (para entrada de dados). </li>
  <li> muxNEXT.v - multiplexador para definir a origem do dado que ficará no registrador NEXT. Pode decidir entre os resultados de muxTorNEXT, da memória de dados e da memória de programa. </li>
  <li> memoriaDeDados.v - memória para armazenamentos dos dados da arquitetura. Destaque para o fato de a arquitetura é do tipo HARVARD, pois tem memória de Dados separada da Memória de Programa. </li>
</u1>
</div> 

<br>
<br>

<h2> Arquivos antigos </h2>
<div>
  <u1>
    <li> ULA.v - descontinuado </li>
  </u1>
</div>
