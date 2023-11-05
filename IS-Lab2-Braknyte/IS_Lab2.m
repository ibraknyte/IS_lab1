clear all
clc
% Užduotis:

% Sukurkite daugiasluoksnio perceptrono koeficientams apskaičiuoti skirtą 
% programą. Daugiasluoksnis perceptronas turi atlikti aproksimatoriaus 
% funkciją. Daugiasluoksnio perceptrono struktūra:
% VIENAS ĮĖJIMAS (įėjime paduodamas 20 skaičių vektorius X, su reikšmėmis 
% intervale nuo 0 iki 1, pvz., x = 0.1:1/22:1; ).
% VIENAS IŠĖJIMAS (pvz., išėjime tikimasi tokio norimo atsako, kurį galima 
% būtų apskaičiuoti pagal formulę: y = (1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2; 
% - kuriamas neuronų tinklas turėtų "modeliuoti/imituoti šios formulės 
% elgesį" naudodamas visiškai kitokią matematinę išraišką nei ši);
% VIENAS PASLĖPTASIS SLUOKSNIS su hiperbolinio tangento arba sigmoidinėmis 
% aktyvavimo funkcijomis neuronuose (neuronų skaičius: 4-8);
% TIESINE AKTYVAVIMO FUNKCIJA išėjimo neurone;
% MOKYMO ALGORITMAS - Backpropagation (atgalinio sklidimo).

% Pasirenkame struktūrą: 1 įėjimas; 1 išėjimas(y); 1 paslėptas sluoksnis (su 5 neuronais).

% 1. Surinkti/paruošti mokymo duomenų rinkinį
 x = 0.1:1/22:1;
 y = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;

 %plot(x,y,'bx')
 
% 2. Sugeneruoti pradines ryšių svorių reikšmes
    % 1-ojo sluoksnio parametrai:
w11_1 = randn(1); b1_1 = randn(1);
w21_1 = randn(1); b2_1 = randn(1);
w31_1 = randn(1); b3_1 = randn(1);
w41_1 = randn(1); b4_1 = randn(1);
w51_1 = randn(1); b5_1 = randn(1);
    % 2-ojo sluoksnio parametrai:
w11_2 = randn(1); b1_2 = randn(1);
w12_2 = randn(1);
w13_2 = randn(1);
w14_2 = randn(1);
w15_2 = randn(1);

mok_zing = 0.15;

% 3. Apskaičiuoti tinklo atsaką (momentinį)
    % Pasverta suma kiekviename sluoksnyje
for indx = 1 :10000
for n = 1 : 20 
    v1_1 = x(n)*w11_1 + b1_1;
    v2_1 = x(n)*w21_1 + b2_1;
    v3_1 = x(n)*w31_1 + b3_1;
    v4_1 = x(n)*w41_1 + b4_1;
    v5_1 = x(n)*w51_1 + b5_1;
    % Aktyvavimo f-ja 1-jame sluoksnyje
    y1_1=tanh(v1_1); % y1_1 = 1/(1+exp(-v1_1));
    y2_1=tanh(v2_1); % y2_1 = 1/(1+exp(-v2_1));
    y3_1=tanh(v3_1); % y3_1 = 1/(1+exp(-v3_1));
    y4_1=tanh(v4_1); % y4_1 = 1/(1+exp(-v4_1));
    y5_1=tanh(v5_1); % y5_1 = 1/(1+exp(-v5_1));
    % Paverta suma išėjimo sluoksnyje
    v1_2 = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + y5_1 + w15_2;
    % Skaičiuojame išėjimą/tinklo atsaką pritaikydami aktyvavimo f-jas
    y_aktyvumo = v1_2;

% 4. Palyginti su norimu atsaku ir apskaičiuoti klaidą
    e = y(n) - y_aktyvumo;

% 5. Atnaujinti ryšių svorius taip, kad klaida mažėtų (apmokyti)
    % Formulė: Nauja_reikšmė = Sena_reikėmė + mokymo_žingsnis*delta*input
    delta_out = e; % kadangi tiesinė aktyvumo f-ja

    delta1_1=(1-(tanh(y1_1))^2)*delta_out*w11_2; % delta1_1 = y1_1*(1-y1_1)*(delta_out*w11_1);
    delta2_1=(1-(tanh(y2_1))^2)*delta_out*w12_2; % delta2_1 = y2_1*(1-y2_1)*(delta_out*w21_1);
    delta3_1=(1-(tanh(y3_1))^2)*delta_out*w13_2; % delta3_1 = y3_1*(1-y3_1)*(delta_out*w31_1);
    delta4_1=(1-(tanh(y4_1))^2)*delta_out*w14_2; % delta4_1 = y4_1*(1-y4_1)*(delta_out*w41_1);
    delta5_1=(1-(tanh(y5_1))^2)*delta_out*w15_2; % delta5_1 = y5_1*(1-y5_1)*(delta_out*w51_1);
    % Atnaujiname svorius išėjimo sluoksnyje
    w11_2 = w11_2+ mok_zing*delta_out*y1_1;
    w12_2 = w12_2+ mok_zing*delta_out*y2_1;
    w13_2 = w13_2+ mok_zing*delta_out*y3_1;
    w14_2 = w14_2+ mok_zing*delta_out*y4_1;
    w15_2 = w15_2+ mok_zing*delta_out*y5_1;
    b1_2 = b1_2 + mok_zing*delta_out*1;
    % Atnaujimane svorius paslėptajame sluoksnyje
    w11_1 = w11_1 + mok_zing*delta1_1*x(n);
    w21_1 = w21_1 + mok_zing*delta2_1*x(n);
    w31_1 = w31_1 + mok_zing*delta3_1*x(n);
    w41_1 = w41_1 + mok_zing*delta4_1*x(n);
    w51_1 = w51_1 + mok_zing*delta5_1*x(n);
    b1_1 = b1_1 + mok_zing*delta1_1;
    b2_1 = b2_1 + mok_zing*delta2_1;
    b3_1 = b3_1 + mok_zing*delta3_1;
    b4_1 = b4_1 + mok_zing*delta4_1;
    b5_1 = b5_1 + mok_zing*delta5_1;
end
end
z = linspace(0.1,1,100);
for m = 1 : 100 
    v1_1 = z(m)*w11_1 + b1_1;
    v2_1 = z(m)*w21_1 + b2_1;
    v3_1 = z(m)*w31_1 + b3_1;
    v4_1 = z(m)*w41_1 + b4_1;
    v5_1 = z(m)*w51_1 + b5_1;
    % Aktyvavimo f-ja 1-jame sluoksnyje
    y1_1 = tanh(v1_1); % y1_1 = 1/(1+exp(-v1_1));
    y2_1 = tanh(v2_1); % y2_1 = 1/(1+exp(-v2_1));
    y3_1 = tanh(v3_1); % y3_1 = 1/(1+exp(-v3_1));
    y4_1 = tanh(v4_1); % y4_1 = 1/(1+exp(-v4_1));
    y5_1 = tanh(v5_1); % y5_1 = 1/(1+exp(-v5_1));
    % Paverta suma išėjimo sluoksnyje
    v1_2 = y1_1 * w11_2 + y2_1 * w12_2 + y3_1 * w13_2 + y4_1 * w14_2 + y5_1 + w15_2;
    % Skaičiuojame išėjimą/tinklo atsaką pritaikydami aktyvavimo f-jas
    y_aktyvumo(m) = v1_2;
end
figure(1), plot(x,y,'bx',z, y_aktyvumo, 'rx')
