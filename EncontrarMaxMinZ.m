function [y,x] = EncontrarMaxMinZ(N,T,D,L,C,n_i,f,Comando)
%AlgoritmoGenetico(P,T,D,L,f,Comando): N, T e D são três inteiros, parâmetros de uma
%População, N representa o número de indivíduos, T o tamanho  de cada uma
%de suas dimensões os quais numeram D. L é uma matriz  de duas colunas e D
%linhas, cada linha armazena os valores limites das variáveis. . C é um número variando de 0 à 1, este indica
%a chance de ocorrer uma mutação.n_i é o número de iterações máximo. f é a função a qual queremos encontrar um
%máximo global, um mínimo global ou as raízes. Comando é a string que
%determina qual das 3 operações se quer realizar. O output y representa o
%mínimo ou máximo global,  e x o vetor para qual f(x) = y.
%
%    Uma população neste caso é uma matriz composta apenas de 0s e 1s. cada
%    linha representa um indivíduo, no caso cada linha representa um vetor
%    x de números. Cada cadeia binária de uma dimensão representa um valor
%    decimal associado à uma variável.
%
%    N é o número de indivíduos e portanto o número de linhas desta matriz.
%
%    D é a dimensão do problema, ou seja, quantas variáveis a
%    função f está submetida, por exemplo a função f(x1,x2) = x1+x2 está em
%    função de duas variáveis e portanto  caso esta fosse o objeto de
%    estudo a dimensão D seria 2.
%
%    T é o tamanho de cada dimensão, se refere à precisão do problema,
%    maiores valores de T criam cadeias binárias maiores e portanto
%    possibilitam uma gama maior de valores fracionários sob o custo de
%    maior uso de memória e tempo de execução.
%
%    Um indivíduo é então composto de uma cadeia binária de T*D +1 termos
%    Este termo adicional armazena o valor decimal que a cadeia binária
%    traduz.
%
%    L armazena os limites impostos às variáveis, por exemplo se a<x1<b e
%    c<x2<d então L será: [a,b ;c,d].
%
%    C é uma double variando de 0 a 1 indicando a probabilidade de uma
%    mutação ocorrer numa rodada para cada indivíduo. Valores baixosde C
%    podem fazer a busca paralizar num máximo ou mínimo local, porém
%    valores muito altos de C deixam a populção instável e o tempo
%    necessário para encontrar uma solução ótima mais elevado.
%    
%    n_i é o número de iterações máximo, valores muito altos podem custar
%    muito tempo mas valores muito baixos podem não fornecer valores tão
%    acurados.
%
%    f é uma função a ser analisada de n variáveis. O detalhe é que esta
%    handle deve ser sempre expressa na forma vetorial ainda que contenha
%    apenas uma variável.
%   
%    Comando é uma string que designa o que o usuário quer do algoritmo, se
%    é um máximo global, mínimo local ou solução f(x) = 0. As strings,
%    respectivamente, são: 'EncontrarMaximo' 'EncontrarMinimo' e
%    'EncontrarSolucao'
minus = false;
if(strcmp(Comando,'max'))
    h = f;
elseif(strcmp(Comando,'min'))
    h = @(x) -f(x);
    minus = true; %Isto é uma flag, para encontrar o mínimo a função foi espelhada e então procura-se o máximo da função espelhada. A resposta final, todavia, é o negativo do máximo encontrado
elseif(strcmp(Comando,'zero'))
    h = @(x) -abs(f(x));
else
    display('Comando não válido, as três opções são: EncontrarMaximo, EncontrarMinimo e EncontrarSolucao no formato de string');
end
P = Criar(N,T,D); 
P = Decodificar(P,T,D,L,h); 
[maximo,n_maximo]=max(P(:,T*D+1)); %Encontrando o primeiro indivíduo mais adaptado.
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
    if ( c == 3) %Isto é uma condição de parada, se os valores do mais adaptado não mudam por 3 gerações seguidas a iteração termina
        break
    end

    [k,m_k]=min(P(:,T*D+1));
    P(m_k,:)=IMA; %Indivíduo mais adaptado
end

[y,x]=Resultado(P,T,D,L);
if(minus) y = -y; end %como a função foi espelhada em relação ao eixo x para encontrar o seu mínimo, o valor dado como mínimo é menos o máximo encontrado

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
