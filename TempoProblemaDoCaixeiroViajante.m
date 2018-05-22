
function TempoProblemaDoCaixeiroViajante(NumeroDeCidades)
% Resolve o Problema do Caixeiro Viajante

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

%funcaoFitness = 'FuncaoFitness'; % Fun��o auxiliar
Ncidades = NumeroDeCidades; % N�meros de cidades do problemas

x = rand(1,Ncidades); % Coordenada x de cada cidade
y = rand(1,Ncidades); % Coordenada y de cada cidade

% N�mero m�ximo de itera��es
MaxIteracoes = NumeroDeCidades*500;

% Par�metros do Algoritmo Gen�tico
tamanhoPopulacao = Ncidades; % Tamanho inicial da popula��o
taxaMutacao = 0.05; % Probabilidade de acontecer muta��o
taxaDeSelecaoNatural = 0.5; % Fra��o da popula��o que sobrevive a cada itera��o

populacaoSobrevivente = floor(taxaDeSelecaoNatural*tamanhoPopulacao); % N�mero de sobreviventes
populacaoExterminada = tamanhoPopulacao - populacaoSobrevivente; % N�mero de exterminados a cada itera��o

Ncrossings = ceil( populacaoExterminada / 2); % N�mero de crossing overs
parentes = 1;

for iPar = 2:populacaoSobrevivente
    parentes = [parentes iPar*ones(1,iPar)];
end

Nparentes = length(parentes);
parentes = populacaoSobrevivente - parentes + 1;

% Popula��o inicial
geracao = 0;

populacao = zeros(tamanhoPopulacao,Ncidades);
% Gera uma popula��o inicial aleat�ria
for iPop = 1:tamanhoPopulacao
    populacao(iPop,:) = randperm(Ncidades); % Popula��o aleat�ria
end

fitness = funcaoFitness(populacao,x,y); % Calcula o custo da popula��o utilizando FuncaoFitness

[fitness,ind] = sort(fitness);
populacao = populacao(ind,:);
menorCusto(1,1) = min(fitness);
mediaCusto(1,1) = mean(fitness);

while geracao < MaxIteracoes
    geracao = geracao + 1; % Nova gera��o
    
    pai = ceil(Nparentes * rand(1,Ncrossings) );
    mae = ceil(Nparentes * rand(1,Ncrossings) );
    
    iPai = parentes(pai); % Indice do pai
    iMae = parentes(mae); % Indice da mae
    
    % Realizando crossing-over
    for iCross = 1:Ncrossings
        conjuge1 = populacao(iPai(iCross),:); % Primeiro cromossomo
        conjuge2 = populacao(iMae(iCross),:); % Segundo cromossomo
        
        iCasal = 2 * (iCross-1) + 1;
        
        xAcasalamento = ceil(rand * Ncidades); % Posi��o onde come�a a permuta��o.
        
        aux = conjuge1;
        xInicial = xAcasalamento;
        
        while conjuge1(xAcasalamento) ~= aux(xInicial) % Crossover c�clico
            % Realiza a troca c�clica. Impede que hajam cidades repetidas.
            conjuge1(xAcasalamento) = conjuge2(xAcasalamento);
            conjuge2(xAcasalamento) = aux(xAcasalamento);
            
            auxTroca = find(aux == conjuge1(xAcasalamento));
            xAcasalamento = auxTroca;
        end
        
        populacao( populacaoSobrevivente + iCasal,:) = conjuge1;
        populacao( populacaoSobrevivente + iCasal + 1,:) = conjuge2;
        
    end
    
    % Realizando muta��es para garantir a vaariabilidade da popula��o
    
    Nmutacoes = ceil(tamanhoPopulacao * taxaMutacao * Ncidades); % C�lculo do n�mero de muta��es.
    for iMut = 1:Nmutacoes
        linha1 = ceil(rand * (tamanhoPopulacao-1)) +1;
        
        coluna1 = ceil(rand * Ncidades);
        coluna2 = ceil(rand * Ncidades);
        
        auxTroca = populacao(linha1, coluna1);
        populacao(linha1, coluna1) = populacao(linha1, coluna2);
        populacao(linha1, coluna2) = auxTroca;
    end
    
    fitness = funcaoFitness(populacao,x,y); % Calcula a fun��o fitness dessa gera��o.
    
    % Ordena��o da popula��o de acordo com cada fitness.
    [fitness,ind] = sort(fitness);
    populacao = populacao(ind,:);
    
    % C�lculo dos valores m�dios e m�nimos dessa gera��o.
    menorCusto(1,geracao) = min(fitness);
    mediaCusto(1,geracao) = mean(fitness);
end % Fim do loop das gera��es

end


        
        
    
    