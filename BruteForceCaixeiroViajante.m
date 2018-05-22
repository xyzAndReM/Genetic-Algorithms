function BruteForceCaixeiroViajante(NumeroDeCidades)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function fitness = funcaoFitness(populacao,x,y)
    % fitness = FuncaoFitness(populacao,x,y) calcula o custo de cada  resolver o 
    % de uma popula��o.

    % O custo de um cromossomo � somat�rio das dist�ncias percorridas de 
    % acordo com a trajet�ria.

    % popula�a� � uma matriz de dimens�o Ncromossomos x Ncidades.

    % Cada linha representa um cromossomo. Cada cromossomo representa uma  
    % trajet�ria (percurso). 

    % x e y s�o vetores de dimens�o Ncidades. Eles guardam, respectivamente,
    % as coordenadas x e y das cidades.

    % O retorno � o vetor coluna fitness = [ fit1 fit2 ... fitN]^T
    % Cada linha equivale ao custo do cromossomo correspondente da popula��o.

    [Ncromossomos,Ncidades] = size(populacao);
    percurso = [ populacao populacao(:,1)]; % Duplica a primeira coluna para fechar o percurso.

    %Calcular dist�ncia entre as cidades
    distEntreCidades = zeros(Ncidades,Ncidades);

    for i1 = 1:Ncidades
        for j1 = 1:Ncidades
            % Dist�ncia euclidiana entre cada par de cidades
            distEntreCidades(i1,j1) = sqrt( (x(i1) - x(j1))^2 + (y(i1) - y(j1))^2 ); 
        end
    end
    %Calcular o custo de cada cromossomo
    fitness = zeros(Ncromossomos,1);

    for i2 = 1:Ncromossomos
        for j2 = 1:Ncidades
         % Soma a dist�ncia entre duas cidades vizinhas de acordo com o
         % percurso.
            fitness(i2,1) = fitness(i2,1) + distEntreCidades(percurso(i2,j2),percurso(i2,j2+1));
        end
    end
    
    end % Fun��o Fitness
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

v = zeros(1,NumeroDeCidades);

for i = 1:NumeroDeCidades
    v(1,i) = i;
end

permutacoes = perms(v); % Calcula todas as permuta��es.

x = rand(1,NumeroDeCidades); % Coordenada x de cada cidade
y = rand(1,NumeroDeCidades); % Coordenada y de cada cidade

fitness = funcaoFitness(permutacoes,x,y);
menorCusto =  min(fitness);

solution = find(fitness == menorCusto);
end