function Quantized=Quantizeer(y,n)
nolevels=2^n;
mx=max(y);
mn=min(y);
step_size= (mx-mn)/nolevels;
minlevel=step_size*ceil(mn/step_size);
for k=0:1:nolevels-1
    levels(k+1)=minlevel+k*step_size;
end
Quantized=[];
for i=1:length(y)  
    [~ ,I] =min(abs(levels-y(i)));
    Quantized(i)=levels(I); 
end

end
