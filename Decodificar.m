function P = Decodificar(P,T,D,L,f)
%Decodificar(P,T,D,L): Quando a população P foi criada, esta é descrita por
%uma lista de de linhas em que cada linha contém um indivíduo de tamanho T
%e dimensão D, cada termo individual desta linha é representado por zeros
%ou uns, o objetivo desta função é extrair o valor decimal encriptado em cada indivíduo. L representa o vetor de tamanho 2*D que contém os limites para os
%valores de x impostos ao problema, carregando estes limites em pares na
%ordem do vetor. Por exemplo se há 3 variáveis x (x1,x2 e x3) e a<x1<b ; c<x2<d e e<x3<f o vetor L
%seria L = [a;b;c;d;e;f]. A função retorna uma nova população P com os
%valores de fitness atualizados bem como a matriz V similar a da popução P
%porém no sistema decimal.
%Decodificar extrai da sequência binária o valor em sistema decimal
%representado em ordem para verificar o valor de fitness, e isto depende
%dos limites impostos.
%   O valor de decodificação deve estar entre os limites propostos, sua
%   fórmula é então dada por:
% x = ( (Valor decimal da sequencia binaria)/2^T - 1 )* (limite_superior -
%limite_inferior) + limite_inferior.
% No final, o valor f(x) é guardado no ultímo termo de cada indivíduo.


N=size(P,1);
temp=2.^(T-1:-1:0)/(2^T-1);
for i=1:D
    limite(i)=L(i,2)-L(i,1);
end
for i=1:N
    for j=1:D
        m(:,j)=P(i,T*(j-1)+1:T*j);
    end
    x=temp*m;
    x=x.*limite+L(:,1)';
    P(i,D*T+1)=f(x);
end
end



