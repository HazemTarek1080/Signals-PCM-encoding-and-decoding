function recon= Rconstruction_filter(decoded,Q_info,t)
levels=[];
no_bit= length(Q_info)/4;
bitslevels= bi2de(Q_info(3*no_bit+1:end), 'left-msb');
m_max= bi2de(Q_info(no_bit+1:2*no_bit), 'left-msb');
        nolevels= 2^bitslevels;
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
        n=1;
        Signal=[];
for i=0:bitslevels:length(decoded)-bitslevels
    Signal(n)=bi2de(decoded(i+1:n*bitslevels), 'left-msb');
    n=n+1;
end

Quantized_1=[];
for h=1:length(Signal)
Quantized_1(h)= levels(Signal(h)+1); 
end


% reconstruction of the signal
fs=length(Quantized_1);
recon = zeros(1,length(t));
for i=1:length(t)
    for j=1:length(Quantized_1)
        re=recon(i);
        recon(i)= re + Quantized_1(j)*sinc(2*fs*t(i)-j);
    end 
end
figure(4)
plot(t,recon(1,:));
xlabel('Time');
ylabel('Amplitude');
end