function P = Mutacao(P,T,D,C)
%Mutacao(P,T,D,C) Sendo P a popula��o de indiv�duos de tamanho T e dimens�o
%D, esta fun��o ser� respons�vel por altera��es aleat�rias no c�digo de cada
%indiv�duo. A probabilidade desta muta��o ocorrer � dada pela constante de
%chance C.
%   Cada invidiv�duo possui uma chance C de mutar.Se o num�ro aleat�rio
%   gerado pela fun��o rand ultrapassar este n�mero C uma muta��o ocorrer�
%   neste indiv�duo. A muta��o se baseia em alterar um termo do c�digo de
%   cada dimens�o do indiv�duo, sendo este termo decidido tamb�m
%   aleatoriamente. Por exemplo considere um indiv�duo de tamanho 8 e
%   dimens�o 3, se uma muta��o ocorrer, um vetor PM de valores aleat�rios entre 1 e 8  de tamanho
%   tamb�m 3 � foramado. Digamos que este vetor seja PM = [3;2;6], isto
%   siginifica que os termo 3 da dimens�o 1, o termo 2 da dimens�o 2 e o
%   termo 6 da dimens�o 3 ser�o invertidos, isto �, se guardam o valor 1
%   ser�o alterados para 0 e se guardam o valor 0 para 1.

N = size(P,1);
for i=1:N
    if rand < C
        PM =round(rand(1,D)*(T-1))+1;
        for j=1:D
            P(i,(j-1)*T+PM(j))=1-P(i,(j-1)*T+PM(j)); %Aqui ocorre a invers�o
        end
    end
end

end

