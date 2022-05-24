function [y,no_bit] = Encoder (Input,mx, bits_levels)
 
prompt = 'Enter 0 for Unipolar NRZ , 1 for Polar NRZ, 2  for Manchester Encoding ';
x = input(prompt);
prompt = 'Enter the amplitude of the coding ';
Amp = input(prompt);

bitrate= 5;
len = length(Input);  
T= 1 / bitrate;
Tb= linspace(0,T,100);
no_bit= ceil(log2(mx));
if mod(no_bit,2) ~=0
    no_bit=no_bit+1;
end

mx_bin= reshape((fliplr(de2bi(mx,no_bit )))', 1,[]);
nobits_bin= reshape((fliplr(de2bi(no_bit ,no_bit)))', 1,[]);
type_bin=reshape((fliplr(de2bi(x,no_bit)))', 1,[]);
bits_level_1= reshape((fliplr(de2bi(bits_levels,no_bit)))', 1,[]);
y = [type_bin, mx_bin, nobits_bin,  bits_level_1];

% y_plot=[];
out=[];
switch x
    case 0
        for j = 1: len
           % enn(j)= Input(j);
            y = [y  Amp*Input(j)*ones(1,no_bit)];
           % y_plot= [y_plot  Amp*Input(j)*ones(1,length(Tb))];
            %type=0;
        end
        
    case 1
        for j = 1:len
           % out(j)=str2double(Input(j));
            y= [y   Amp/2*((-1)^(Input(j) + 1))*ones(1,no_bit)];
           % y_plot= [y_plot  ((-1)^(Input(j) + 1))*Amp/2*ones(1,length(Tb))];
           % type=1;
            
        end
        case 2
        for j = 1:len
            c = ones(1,no_bit/2);
           % c_1= ones(1,length(Tb)/2);
            b = -1*ones(1,no_bit/2);
            %b_1= -1*ones(1,length(Tb)/2);
            p = [c b];
            %p_1=[c_1 b_1];
            y = [y  ((-1)^(Input(j)+1))*(Amp/2)*p];
            %y_plot= [y_plot ((-1)^(Input(j)+1))*Amp/2*p_1];
            %type=2;
        end
end

%Plotting the Input stream of bits
Tm=linspace(0,1/bitrate);
Input_new=[];
for i =1: length(Input)
    Input_new = [Input_new  Input(i)*ones(1,length(Tm))];
end
Total_t= length(Input)/bitrate;
Total=linspace(0,Total_t, length(Input));
figure(3)
subplot(2,1,1)

stairs( Total, Input);
ylim([-2 2]);
title('Input signal', 'LineWidth', 6);
xlabel('time in sec');
ylabel('signal');

%plotting the encoded signal
t = linspace(0,len*T,length(y(4*no_bit+1:end)));
subplot(2,1,2)
stairs(t,y(4*no_bit+1:end));
ylim([-2 2]);
title('Encoded signal', 'LineWidth', 5);
xlabel('time in sec');
ylabel('signal');
 end