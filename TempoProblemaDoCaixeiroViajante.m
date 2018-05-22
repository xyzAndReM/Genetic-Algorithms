
function TempoProblemaDoCaixeiroViajante(NumeroDeCidades)
% Resolve o Problema do Caixeiro Viajante

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function fitness = funcaoFitness(populacao,x,y)
    % fitness = FuncaoFitness(populacao,x,y) calcula o custo de cada  resolver o 
    % de uma população.

    % O custo de um cromossomo é somatório das distâncias percorridas de 
    % acordo com a trajetória.

    % populaçaõ é uma matriz de dimensão Ncromossomos x Ncidades.

    % Cada linha representa um cromossomo. Cada cromossomo representa uma  
    % trajetória (percurso). 

    % x e y são vetores de dimensão Ncidades. Eles guardam, respectivamente,
    % as coordenadas x e y das cidades.

    % O retorno é o vetor coluna fitness = [ fit1 fit2 ... fitN]^T
    % Cada linha equivale ao custo do cromossomo correspondente da população.

    [Ncromossomos,Ncidades] = size(populacao);
    percurso = [ populacao populacao(:,1)]; % Duplica a primeira coluna para fechar o percurso.

    %Calcular distância entre as cidades
    distEntreCidades = zeros(Ncidades,Ncidades);

    for i1 = 1:Ncidades
        for j1 = 1:Ncidades
            % Distância euclidiana entre cada par de cidades
            distEntreCidades(i1,j1) = sqrt( (x(i1) - x(j1))^2 + (y(i1) - y(j1))^2 ); 
        end
    end
    %Calcular o custo de cada cromossomo
    fitness = zeros(Ncromossomos,1);

    for i2 = 1:Ncromossomos
        for j2 = 1:Ncidades
         % Soma a distância entre duas cidades vizinhas de acordo com o
         % percurso.
            fitness(i2,1) = fitness(i2,1) + distEntreCidades(percurso(i2,j2),percurso(i2,j2+1));
        end
    end
    
    end % Função Fitness
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%funcaoFitness = 'FuncaoFitness'; % Função auxiliar
Ncidades = NumeroDeCidades; % Números de cidades do problemas

x = rand(1,Ncidades); % Coordenada x de cada cidade
y = rand(1,Ncidades); % Coordenada y de cada cidade

% Número máximo de iterações
MaxIteracoes = NumeroDeCidades*500;

% Parâmetros do Algoritmo Genético
tamanhoPopulacao = Ncidades; % Tamanho inicial da população
taxaMutacao = 0.05; % Probabilidade de acontecer mutação
taxaDeSelecaoNatural = 0.5; % Fração da população que sobrevive a cada iteração

populacaoSobrevivente = floor(taxaDeSelecaoNatural*tamanhoPopulacao); % Número de sobreviventes
populacaoExterminada = tamanhoPopulacao - populacaoSobrevivente; % Número de exterminados a cada iteração

Ncrossings = ceil( populacaoExterminada / 2); % Número de crossing overs
parentes = 1;

for iPar = 2:populacaoSobrevivente
    parentes = [parentes iPar*ones(1,iPar)];
end

Nparentes = length(parentes);
parentes = populacaoSobrevivente - parentes + 1;

% População inicial
geracao = 0;

populacao = zeros(tamanhoPopulacao,Ncidades);
% Gera uma população inicial aleatória
for iPop = 1:tamanhoPopulacao
    populacao(iPop,:) = randperm(Ncidades); % População aleatória
end

fitness = funcaoFitness(populacao,x,y); % Calcula o custo da população utilizando FuncaoFitness

[fitness,ind] = sort(fitness);
populacao = populacao(ind,:);
menorCusto(1,1) = min(fitness);
mediaCusto(1,1) = mean(fitness);

while geracao < MaxIteracoes
    geracao = geracao + 1; % Nova geração
    
    pai = ceil(Nparentes * rand(1,Ncrossings) );
    mae = ceil(Nparentes * rand(1,Ncrossings) );
    
    iPai = parentes(pai); % Indice do pai
    iMae = parentes(mae); % Indice da mae
    
    % Realizando crossing-over
    for iCross = 1:Ncrossings
        conjuge1 = populacao(iPai(iCross),:); % Primeiro cromossomo
        conjuge2 = populacao(iMae(iCross),:); % Segundo cromossomo
        
        iCasal = 2 * (iCross-1) + 1;
        
        xAcasalamento = ceil(rand * Ncidades); % Posição onde começa a permutação.
        
        aux = conjuge1;
        xInicial = xAcasalamento;
        
        while conjuge1(xAcasalamento) ~= aux(xInicial) % Crossover cíclico
            % Realiza a troca cíclica. Impede que hajam cidades repetidas.
            conjuge1(xAcasalamento) = conjuge2(xAcasalamento);
            conjuge2(xAcasalamento) = aux(xAcasalamento);
            
            auxTroca = find(aux == conjuge1(xAcasalamento));
            xAcasalamento = auxTroca;
        end
        
        populacao( populacaoSobrevivente + iCasal,:) = conjuge1;
        populacao( populacaoSobrevivente + iCasal + 1,:) = conjuge2;
        
    end
    
    % Realizando mutações para garantir a vaariabilidade da população
    
    Nmutacoes = ceil(tamanhoPopulacao * taxaMutacao * Ncidades); % Cálculo do número de mutações.
    for iMut = 1:Nmutacoes
        linha1 = ceil(rand * (tamanhoPopulacao-1)) +1;
        
        coluna1 = ceil(rand * Ncidades);
        coluna2 = ceil(rand * Ncidades);
        
        auxTroca = populacao(linha1, coluna1);
        populacao(linha1, coluna1) = populacao(linha1, coluna2);
        populacao(linha1, coluna2) = auxTroca;
    end
    
    fitness = funcaoFitness(populacao,x,y); % Calcula a função fitness dessa geração.
    
    % Ordenação da população de acordo com cada fitness.
    [fitness,ind] = sort(fitness);
    populacao = populacao(ind,:);
    
    % Cálculo dos valores médios e mínimos dessa geração.
    menorCusto(1,geracao) = min(fitness);
    mediaCusto(1,geracao) = mean(fitness);
end % Fim do loop das gerações

end


        
        
    
    