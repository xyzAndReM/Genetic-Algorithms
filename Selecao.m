function E = Selecao(P,N,T,D)
% Selecao(P,N,T,D): Executa a seleção numa população P de N indivíduos de
% tamanho T e dimensão D. A seleção se consiste em selecionar os indivíduos
% mais adequados, isto é , com os maiores valores de fitness e descartar
% aqueles com os menores.
%
%  Esta função basicamente seleciona metade da atual População P para
%  sobreviver à próxima rodada dado que o número de indivíduos atual não é maior que dez vezes a população original. 
%  Se o número de indivíduos de P assumir um valor maior que dez vezes o
%  seu valor inicial, então uma seleção apocalíptica ocorre e apenas um
%  quinto da população atual é selecionada.
fitness = P(:,D*T+1);
sfitness = sort(fitness);
novoN = size(P,1);
if novoN > 10*N
n = round(8*novoN/10)-1;
else
n = round(novoN/2)-1;
end
E = zeros(novoN - n,D*T+1);
S = sfitness(n);
i = 1;
        for j=1:novoN
            if P(j,D*T+1) > S
                E(i,:)=P(j,:); %Seleção que busca o máximo
                i = i+1;
            end
        end
end

