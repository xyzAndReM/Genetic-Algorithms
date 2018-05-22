function  populacao = Criar(N,T,D); 
%Criar(N,T,D): Esta fun��o cria uma popula��o com "N" indiv�duos de tamanho
%"T" e dimensao "D".
%   Uma popula��o neste caso, se trata de uma matrix de "N" linhas e "(T*D) + 1"
%   colunas, composta solenemente de 0s e 1s, cada linha representa um indiv�duo da popula��o. O �ltimo bit � reservado para
%   armazenar o valor de fitness, em outras palavras, o qu�o pr�ximo o
%   indiv�duo est� das condi��es propostas. Os indiv�duos da popula��o s�o
%   originados de forma aleat�ria.
populacao =round(rand(N,D*T+1)); 
end

