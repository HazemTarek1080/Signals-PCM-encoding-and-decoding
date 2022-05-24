function [decoded,Q_info]=decoder(Encoded, no_bit)

len = length(Encoded); 
% prompt = 'Enter the type ';
% type = input(prompt);
type=bi2de(Encoded(1:no_bit), 'left-msb');
%jj=1;
% p=[];
Q_info=[];
Q_info=Encoded(1:4*no_bit);
% for h=1:no_bit:(3*no_bit)+1
% decoded(jj) = bi2de(Q_info(h:h+no_bit-1), 'left-msb') ;
% p(jj)= decoded(jj);;
% end

decoded=[];
k=1;

if type== 0 
      for j=(4*no_bit)+1:no_bit:len
      if Encoded(j)>0
      decoded(k)= 1;
      else
      decoded(k)=0;    
      end
      k=k+1;
      end
    
 elseif type== 1 
        for j=(4*no_bit)+1:no_bit:len
          if Encoded(j)>0
          decoded(k)= 1;
          else
          decoded(k)=0;
          end
         k=k+1;
        end
      
    
 else
        for j=(4*no_bit)+1:no_bit:len
          if Encoded(j)>0
          decoded(k)= 1;
          else
          decoded(k)=0;
          end
         k=k+1;
        end


end

end

