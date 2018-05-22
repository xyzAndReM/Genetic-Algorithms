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

xlabel('Número de Cidades')
ylabel('Tempo(s)')
legend('Algoritmo Genético','Brute Force')
title('Comparação Algoritmo Genético x Brute Force')

grid on 

print -dpng -r400 Comparacao9ate11.png
    