function P = Decodificar(P,T,D,L,f)
%Decodificar(P,T,D,L): Quando a popula��o P foi criada, esta � descrita por
%uma lista de de linhas em que cada linha cont�m um indiv�duo de tamanho T
%e dimens�o D, cada termo individual desta linha � representado por zeros
%ou uns, o objetivo desta fun��o � extrair o valor decimal encriptado em cada indiv�duo. L representa o vetor de tamanho 2*D que cont�m os limites para os
%valores de x impostos ao problema, carregando estes limites em pares na
%ordem do vetor. Por exemplo se h� 3 vari�veis x (x1,x2 e x3) e a<x1<b ; c<x2<d e e<x3<f o vetor L
%seria L = [a;b;c;d;e;f]. A fun��o retorna uma nova popula��o P com os
%valores de fitness atualizados bem como a matriz V similar a da popu��o P
%por�m no sistema decimal.
%Decodificar extrai da sequ�ncia bin�ria o valor em sistema decimal
%representado em ordem para verificar o valor de fitness, e isto depende
%dos limites impostos.
%   O valor de decodifica��o deve estar entre os limites propostos, sua
%   f�rmula � ent�o dada por:
% x = ( (Valor decimal da sequencia binaria)/2^T - 1 )* (limite_superior -
%limite_inferior) + limite_inferior.
% No final, o valor f(x) � guardado no ult�mo termo de cada indiv�duo.


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



