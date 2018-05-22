function P = CrossOver(P,N,T,D)
%CrossOver(P,N,T,D) Esta fun��o executa o crossing-over entre os N indiv�duos
%de uma popula��o P de indiv�duos de tamanho T e dimens�o D.
%   Esta fun��o cria novos indiv�duos para a popula��o com base nos
%   indiv�duos j� existentes. Vale salientar que a popula��o cresce
%   esporadicamente devido � esta fun��o, mas seu crescimento � limitado
%   pela sele��o apocal�ptica(Ver fun��o sele��o)
%
%   Selecionamento de pais:
%
%   O processo ocorre da seguinte forma: s�o
%   escolhidos aleatoriamente N indiv�duos dos N existentes com a
%   possibilidade de repeti��o formando uma lista M de indiv�duos, ent�o
%   o primeiro indiv�duo da popula��o ir� formar duas crian�as com o
%   primeiro indiv�duo da lista M e assim por diante at� o ult�mo indiv�duo
%   da popula��o e da lista M.
%
%
%   Crossing-Over:
%
% Cada dimens�o das crian�as � constru�da por uma parte de cada um dos
% pais com um ponto de cruzamento determinado aleatoriamente. Ent�o por
% exemplo, se um indiv�duo possui 8 termos em sua dimens�o e o ponto de
% cruzamento foi aleatoriamente escolhido como 3, os seus primeiros termos
% desta dimens�o ser�o do primeiro pai enquanto os cinco ult�mos do segundo
% pai. O mesmo se repete para as outras dimens�es, notando que o ponto de
% cruzamento � diferente para diferentes dimens�es.
%
N=size(P,1);
M=round(rand(1,N)*(N-1))+1;
F = zeros(2*N,D*T+1);

for i=1:N
  pai1 = P(i,:); %Primeiro pai � selecionado percorrendo a Popula��o.
  pai2 = P(M(i),:);  %Segundo pai adv�m da lista M formada aleatoriamente.
    
 [filho1,filho2]=Cruzamento(pai1,pai2,T,D); %fun��o Cruzamento abaixo
 
 F(2*i-1:2*i,1:T*D)=[filho1;filho2];
 
%Note que M se trata apenas de um vetor de inteiros que se designam aos
%indiv�duos da popula��o P.

end
 P = [P;F];
end

function [filho1,filho2]=Cruzamento(pai1,pai2,T,D)
%Esta fun��o executar� a contru��os dos novos filhos com base na identidade
%dos pais.
PC =round((T-1)*rand(1,D))+1; %Pontos de Cruzamento para cada dimens�o, PC � um vetor de inteiros.

for j=1:D
    
filho1((j-1)*T+1:j*T)=[  pai1((j-1)*T+1:(j-1)*T+PC(j)) , pai2((j-1)*T+PC(j)+1:j*T)]; %Forma��o do primeiro filho

filho2((j-1)*T+1:j*T)=[  pai2((j-1)*T+1:(j-1)*T+PC(j)) , pai1((j-1)*T+PC(j)+1:j*T)]; %Forma��o do segundo filho

end
end