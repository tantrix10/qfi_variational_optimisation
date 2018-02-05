clear
gamma=linspace(0.001,1,10);
n=[2, 3, 4, 5, 6, 7, 8];
counter=0;


results=zeros(70 ,3);

for p = 1:length(gamma)
    for en = 1:length(n)
        counter=counter+1;
        results(counter,2)=gamma(p);
        results(counter,3)=n(en);
    end
end


for i=1:70
    results(i, 1)= otimiser_function( results(i,2), results(i,3) );
    save('output.mat', 'results')
end
        