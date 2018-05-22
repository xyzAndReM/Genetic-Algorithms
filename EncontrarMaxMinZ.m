function [y,x] = EncontrarMaxMinZ(N,T,D,L,C,n_i,f,Comando)
%AlgoritmoGenetico(P,T,D,L,f,Comando): N, T e D s�o tr�s inteiros, par�metros de uma
%Popula��o, N representa o n�mero de indiv�duos, T o tamanho  de cada uma
%de suas dimens�es os quais numeram D. L � uma matriz  de duas colunas e D
%linhas, cada linha armazena os valores limites das vari�veis. . C � um n�mero variando de 0 � 1, este indica
%a chance de ocorrer uma muta��o.n_i � o n�mero de itera��es m�ximo. f � a fun��o a qual queremos encontrar um
%m�ximo global, um m�nimo global ou as ra�zes. Comando � a string que
%determina qual das 3 opera��es se quer realizar. O output y representa o
%m�nimo ou m�ximo global,  e x o vetor para qual f(x) = y.
%
%    Uma popula��o neste caso � uma matriz composta apenas de 0s e 1s. cada
%    linha representa um indiv�duo, no caso cada linha representa um vetor
%    x de n�meros. Cada cadeia bin�ria de uma dimens�o representa um valor
%    decimal associado � uma vari�vel.
%
%    N � o n�mero de indiv�duos e portanto o n�mero de linhas desta matriz.
%
%    D � a dimens�o do problema, ou seja, quantas vari�veis a
%    fun��o f est� submetida, por exemplo a fun��o f(x1,x2) = x1+x2 est� em
%    fun��o de duas vari�veis e portanto  caso esta fosse o objeto de
%    estudo a dimens�o D seria 2.
%
%    T � o tamanho de cada dimens�o, se refere � precis�o do problema,
%    maiores valores de T criam cadeias bin�rias maiores e portanto
%    possibilitam uma gama maior de valores fracion�rios sob o custo de
%    maior uso de mem�ria e tempo de execu��o.
%
%    Um indiv�duo � ent�o composto de uma cadeia bin�ria de T*D +1 termos
%    Este termo adicional armazena o valor decimal que a cadeia bin�ria
%    traduz.
%
%    L armazena os limites impostos �s vari�veis, por exemplo se a<x1<b e
%    c<x2<d ent�o L ser�: [a,b ;c,d].
%
%    C � uma double variando de 0 a 1 indicando a probabilidade de uma
%    muta��o ocorrer numa rodada para cada indiv�duo. Valores baixosde C
%    podem fazer a busca paralizar num m�ximo ou m�nimo local, por�m
%    valores muito altos de C deixam a popul��o inst�vel e o tempo
%    necess�rio para encontrar uma solu��o �tima mais elevado.
%    
%    n_i � o n�mero de itera��es m�ximo, valores muito altos podem custar
%    muito tempo mas valores muito baixos podem n�o fornecer valores t�o
%    acurados.
%
%    f � uma fun��o a ser analisada de n vari�veis. O detalhe � que esta
%    handle deve ser sempre expressa na forma vetorial ainda que contenha
%    apenas uma vari�vel.
%   
%    Comando � uma string que designa o que o usu�rio quer do algoritmo, se
%    � um m�ximo global, m�nimo local ou solu��o f(x) = 0. As strings,
%    respectivamente, s�o: 'EncontrarMaximo' 'EncontrarMinimo' e
%    'EncontrarSolucao'
minus = false;
if(strcmp(Comando,'max'))
    h = f;
elseif(strcmp(Comando,'min'))
    h = @(x) -f(x);
    minus = true; %Isto � uma flag, para encontrar o m�nimo a fun��o foi espelhada e ent�o procura-se o m�ximo da fun��o espelhada. A resposta final, todavia, � o negativo do m�ximo encontrado
elseif(strcmp(Comando,'zero'))
    h = @(x) -abs(f(x));
else
    display('Comando n�o v�lido, as tr�s op��es s�o: EncontrarMaximo, EncontrarMinimo e EncontrarSolucao no formato de string');
end
P = Criar(N,T,D); 
P = Decodificar(P,T,D,L,h); 
[maximo,n_maximo]=max(P(:,T*D+1)); %Encontrando o primeiro indiv�duo mais adaptado.
IMA=P(n_maximo,:); %%Individuo Mais Adaptado
c = 0;
for i=1:n_i
    P = CrossOver(P,N,T,D);
    P = Mutacao(P,T,D,C); 
    P = Decodificar(P,T,D,L,h);
    P = Selecao(P,N,T,D);
    [k,n_k] = max(P(:,T*D + 1));
    if(k - maximo > 10^-6)
        maximo = k;
        n_maximo = n_k;
        c = 0;
    else c = c+1;
    end
    if ( c == 3) %Isto � uma condi��o de parada, se os valores do mais adaptado n�o mudam por 3 gera��es seguidas a itera��o termina
        break
    end

    [k,m_k]=min(P(:,T*D+1));
    P(m_k,:)=IMA; %Indiv�duo mais adaptado
end

[y,x]=Resultado(P,T,D,L);
if(minus) y = -y; end %como a fun��o foi espelhada em rela��o ao eixo x para encontrar o seu m�nimo, o valor dado como m�nimo � menos o m�ximo encontrado

end

function [valor,x]= Resultado(P,T,D,L)
[valor,k]=max(P(:,T*D+1));
temp=2.^(T-1:-1:0)/(2^T-1);
for i=1:D
    bound(i)=L(i,2)-L(i,1);
end
for j=1:D
    m(:,j)=P(k,T*(j-1)+1:T*j);
end
x=temp*m;
x=x.*bound+L(:,1)';
end
