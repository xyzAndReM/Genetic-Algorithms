function P = Mutacao(P,T,D,C)
%Mutacao(P,T,D,C) Sendo P a população de indivíduos de tamanho T e dimensão
%D, esta função será responsável por alterações aleatórias no código de cada
%indivíduo. A probabilidade desta mutação ocorrer é dada pela constante de
%chance C.
%   Cada invidivíduo possui uma chance C de mutar.Se o numéro aleatório
%   gerado pela função rand ultrapassar este número C uma mutação ocorrerá
%   neste indivíduo. A mutação se baseia em alterar um termo do código de
%   cada dimensão do indivíduo, sendo este termo decidido também
%   aleatoriamente. Por exemplo considere um indivíduo de tamanho 8 e
%   dimensão 3, se uma mutação ocorrer, um vetor PM de valores aleatórios entre 1 e 8  de tamanho
%   também 3 é foramado. Digamos que este vetor seja PM = [3;2;6], isto
%   siginifica que os termo 3 da dimensão 1, o termo 2 da dimensão 2 e o
%   termo 6 da dimensão 3 serão invertidos, isto é, se guardam o valor 1
%   serão alterados para 0 e se guardam o valor 0 para 1.

N = size(P,1);
for i=1:N
    if rand < C
        PM =round(rand(1,D)*(T-1))+1;
        for j=1:D
            P(i,(j-1)*T+PM(j))=1-P(i,(j-1)*T+PM(j)); %Aqui ocorre a inversão
        end
    end
end

end

