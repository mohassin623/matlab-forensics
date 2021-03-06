%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%% Calcolo ROC per Dataset separati con predittore median e Algoritmo EM ZM
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

datasets=dir('/users/ferrara/Desktop/Simulazioni Median'); %%% INSERIRE IL PATH ESATTO
cartelle={datasets.name};
dimensione_statistica = dir('/users/ferrara/Desktop/Simulazioni Median/Canon EOS');
statistica = {dimensione_statistica.name};

% dimensione del tampering per dataset. l'ordinamento dipende da come sono
% ordinate le cartelle nel path

tamper_size=128;


% Inizializzazione di parametri che sono funzione della dimensione dei
% blocchi

TOL = 1e-3;
MAX_ITER = 500;

% Generazione dei dati sui quali effettuare le misure

    for i=4:length(cartelle)
        for j = 3:length(statistica)
            verosimiglianza(['/users/ferrara/Desktop/Simulazioni Median/',char(cartelle(i)),'/',char(statistica(j)),'/TIFF_128']);
            if (j==3)
            ROC_verosimiglianza2x2(['/users/ferrara/Desktop/Simulazioni Median/',char(cartelle(i)),'/',char(statistica(j)),'/TIFF_128'],tamper_size);
            elseif(j==4)
            ROC_verosimiglianza4x4(['/users/ferrara/Desktop/Simulazioni Median/',char(cartelle(i)),'/',char(statistica(j)),'/TIFF_128'],tamper_size);   
            else
            ROC_verosimiglianza8x8(['/users/ferrara/Desktop/Simulazioni Median/',char(cartelle(i)),'/',char(statistica(j)),'/TIFF_128'],tamper_size);       
            end
        end
    end
    
    

