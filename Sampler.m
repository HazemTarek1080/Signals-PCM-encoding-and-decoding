function ssignal= Sampler(signal, t)
prompt = 'What is the Sampling frequnecy? ';
fs = input(prompt);
figure(1)
set(gcf, 'Position',  [100, 100, 500, 400]);
subplot (2,1,1);
plot(t,signal);
title('continuous Input signal', 'LineWidth', 7);
xlabel('time in sec');
ylabel('signal');

%sampling the signal at Fs
fm=10;
T=0:1/fs:1-(1/fs);
ssignal= 5 * cos(2*pi*fm*T);
subplot (2,1,2);
stem(T, ssignal);
title('Discrete time signal', 'LineWidth', 7);
xlabel('Samples');
ylabel('Sampled signal');

 end