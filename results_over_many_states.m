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

state_solutions=cell(3,70);

for i=1:70
    state_solutions{1,i} = otimiser_function_state_output( results(i,2), results(i,3) );
    state_solutions{2,i} = results(i,2);
    state_solutions{3,i} = results(i,3);
    save('output_states.mat', 'state_solutions')
end
        