fm=10;
dt=0.001;
t= 0:dt:1-dt;
signal= 5 * cos(2*pi*fm*t);
ssignal= Sampler(signal, t);
[BIN_Quantized, mx, bitslevels]= Quantizer(ssignal);
[Encoded_sig, no_bit] = Encoder (BIN_Quantized, mx,bitslevels);
[decoded,Q_info]=decoder(Encoded_sig,no_bit);
recon = Rconstruction_filter(decoded,Q_info, t);