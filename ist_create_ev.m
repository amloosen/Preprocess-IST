function ev = ist_create_ev(chos_col,seq_seen)
%Ev ist di kumulative evidence fuer option 1, fuer jeden step.
%also [0,1,1,2] bedeutet dass wenn die person yellow (y) gewaehlt hat, dann hat sie zuerst blau (b) gesehen (i.e. 0 y), dann y, dann blau, dann y.
%D.h. wenn immer sich der zaehler um 1 erhoeht, dann ist das ein neues in favour of the chosen. Wenn es sich nicht erhoeht, dann ist es eine karte der anderen farbe.

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