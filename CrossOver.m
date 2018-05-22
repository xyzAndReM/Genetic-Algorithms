function P = CrossOver(P,N,T,D)
%CrossOver(P,N,T,D) Esta função executa o crossing-over entre os N indivíduos
%de uma população P de indivíduos de tamanho T e dimensão D.
%   Esta função cria novos indivíduos para a população com base nos
%   indivíduos já existentes. Vale salientar que a população cresce
%   esporadicamente devido à esta função, mas seu crescimento é limitado
%   pela seleção apocalíptica(Ver função seleção)
%
%   Selecionamento de pais:
%
%   O processo ocorre da seguinte forma: são
%   escolhidos aleatoriamente N indivíduos dos N existentes com a
%   possibilidade de repetição formando uma lista M de indivíduos, então
%   o primeiro indivíduo da população irá formar duas crianças com o
%   primeiro indivíduo da lista M e assim por diante até o ultímo indivíduo
%   da população e da lista M.
%
%
%   Crossing-Over:
%
% Cada dimensão das crianças é construída por uma parte de cada um dos
% pais com um ponto de cruzamento determinado aleatoriamente. Então por
% exemplo, se um indivíduo possui 8 termos em sua dimensão e o ponto de
% cruzamento foi aleatoriamente escolhido como 3, os seus primeiros termos
% desta dimensão serão do primeiro pai enquanto os cinco ultímos do segundo
% pai. O mesmo se repete para as outras dimensões, notando que o ponto de
% cruzamento é diferente para diferentes dimensões.
%
N=size(P,1);
M=round(rand(1,N)*(N-1))+1;
F = zeros(2*N,D*T+1);

for i=1:N
  pai1 = P(i,:); %Primeiro pai é selecionado percorrendo a População.
  pai2 = P(M(i),:);  %Segundo pai advém da lista M formada aleatoriamente.
    
 [filho1,filho2]=Cruzamento(pai1,pai2,T,D); %função Cruzamento abaixo
 
 F(2*i-1:2*i,1:T*D)=[filho1;filho2];
 
%Note que M se trata apenas de um vetor de inteiros que se designam aos
%indivíduos da população P.

end
 P = [P;F];
end

function [filho1,filho2]=Cruzamento(pai1,pai2,T,D)
%Esta função executará a contruçãos dos novos filhos com base na identidade
%dos pais.
PC =round((T-1)*rand(1,D))+1; %Pontos de Cruzamento para cada dimensão, PC é um vetor de inteiros.

for j=1:D
    
filho1((j-1)*T+1:j*T)=[  pai1((j-1)*T+1:(j-1)*T+PC(j)) , pai2((j-1)*T+PC(j)+1:j*T)]; %Formação do primeiro filho

filho2((j-1)*T+1:j*T)=[  pai2((j-1)*T+1:(j-1)*T+PC(j)) , pai1((j-1)*T+PC(j)+1:j*T)]; %Formação do segundo filho

end
end