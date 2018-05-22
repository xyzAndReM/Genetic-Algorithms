function  populacao = Criar(N,T,D); 
%Criar(N,T,D): Esta função cria uma população com "N" indivíduos de tamanho
%"T" e dimensao "D".
%   Uma população neste caso, se trata de uma matrix de "N" linhas e "(T*D) + 1"
%   colunas, composta solenemente de 0s e 1s, cada linha representa um indivíduo da população. O último bit é reservado para
%   armazenar o valor de fitness, em outras palavras, o quão próximo o
%   indivíduo está das condições propostas. Os indivíduos da população são
%   originados de forma aleatória.
populacao =round(rand(N,D*T+1)); 
end

