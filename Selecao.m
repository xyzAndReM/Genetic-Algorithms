function E = Selecao(P,N,T,D)
% Selecao(P,N,T,D): Executa a sele��o numa popula��o P de N indiv�duos de
% tamanho T e dimens�o D. A sele��o se consiste em selecionar os indiv�duos
% mais adequados, isto � , com os maiores valores de fitness e descartar
% aqueles com os menores.
%
%  Esta fun��o basicamente seleciona metade da atual Popula��o P para
%  sobreviver � pr�xima rodada dado que o n�mero de indiv�duos atual n�o � maior que dez vezes a popula��o original. 
%  Se o n�mero de indiv�duos de P assumir um valor maior que dez vezes o
%  seu valor inicial, ent�o uma sele��o apocal�ptica ocorre e apenas um
%  quinto da popula��o atual � selecionada.
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
                E(i,:)=P(j,:); %Sele��o que busca o m�ximo
                i = i+1;
            end
        end
end

