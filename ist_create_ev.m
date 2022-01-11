function ev = ist_create_ev(chos_col,seq_seen)
%Ev is the cumulative evidence for option 1, for each step. 
%E.g.,[0,1,1,2] could mean that a participant first uncovered blue, then yellow and then blue again and finally yellow before choosing yellow.
%This means, the value increases by 1 if the uncovered colour was the same as the chosen one. If the number does not increase the uncovered colour was different to the chosen one.

ev = zeros(1,length(seq_seen));
for i= 1:length(seq_seen)
    if seq_seen(i)==chos_col
        if i>1
            ev(i) = ev(i-1)+1 ;
        else
            ev(i) = 1 ;
        end
    else
        if i>1
            ev(i) = ev(i-1);
        end
    end
end
