function [BIN_Quantized, mx, bitslevels]= Quantizer(signal)
prompt = 'Enter 0 for midrise unifrom quantizer, and 1 for non uniform quantizer ';
x = input(prompt);
prompt_1 = 'Quantizer no of bits? ';
bitslevels = input(prompt_1);
figure(2)
subplot(2,1,1)
stem(signal);
title('Sampled Signal', 'LineWidth', 7);
xlabel('samples');
ylabel('signal');
switch x
    
    case 0
        levels=[];
        nolevels= 2^bitslevels;
        m_max=max(abs(signal)); 
        delta=(2*m_max)/nolevels ;  
        k_max=nolevels/2; 
        pos_levels=[];
        i=1;
        for k=0:2:2*(k_max-1)
            pos_levels(i)=(1+k)*(0.5*delta);
            i=i+1;
        end
        neg_levels=[];
        j=1;
        for kk=0:2:2*(k_max-1)
            neg_levels(j)= -(1+kk)*(0.5*delta);
            j=j+1;
        end
        levels=[fliplr(neg_levels)  pos_levels];
        Quantized=[];
        Quantized_plt=[];
        for i=1:length(signal) 
            [~ ,I] =min(abs(pos_levels-abs(signal(i))));
            if signal(i)>0
            Quantized(i)= I+length(neg_levels)-1;
            Quantized_plt(i)= pos_levels(I);
            else
            Quantized(i)= length(neg_levels)-(I-1)-1;
            Quantized_plt(i)= neg_levels(I);
            end
        end
        
%         t1=linspace(0,2, length(Quantized_plt));
        subplot(2,1,2)
        stem(Quantized_plt);
        title('Quantized Signal', 'LineWidth', 7);
        xlabel('samples');
        ylabel('signal');


    case 1
         prompt = 'Enter the value of mu ';
         mu = input(prompt);
%          signal= [3,9,-28,10,-34,-22,-4,24,18,30,-16];
        %Performing mu-law compression of the input signal
        signal_comp= sign(signal).*log(1+mu*abs(signal))/log(1+mu);
        
        % uniform Quantization using n-bit quantizer
          Quantized_sign=Quantizeer(signal_comp,bitslevels);
   
         %Expanding the output of the mu law quantizer
         Quantized= sign(Quantized_sign)*(1/mu).*((1+mu).^(abs(Quantized_sign))-1);
         
         %plotting the Quantized signal
         stem(Quantized);
         
       

end
mx= m_max;
BIN_Quantized= reshape((fliplr(de2bi(Quantized, bitslevels)))', 1,[]);

 end
        