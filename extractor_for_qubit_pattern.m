total=' ';
s1='0';
s2='1';

for i=1:128
    if rhosolutions{371}(1,i) == 0
        total=strcat(total,s1);
    else
        total=strcat(total,s2);
    end
end
