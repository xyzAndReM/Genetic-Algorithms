tempoAG = zeros(1,3);
tempoBruteForce = zeros(1,3);

for i = 4:6
    tic
    TempoProblemaDoCaixeiroViajante(i+5);
    tempoAG(1,i) = toc;
    
    tic
    BruteForceCaixeiroViajante(i+5);
    tempoBruteForce(1,i) = toc;
end

t = 9:11;

plot(t, tempoAG,'g');

hold on;

plot(t, tempoBruteForce,'r');

xlabel('N�mero de Cidades')
ylabel('Tempo(s)')
legend('Algoritmo Gen�tico','Brute Force')
title('Compara��o Algoritmo Gen�tico x Brute Force')

grid on 

print -dpng -r400 Comparacao9ate11.png
    