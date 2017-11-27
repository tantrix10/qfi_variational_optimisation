u=figure;
axis tight manual
filename='testanimation.gif';
for n=1:59
    
    y=(real(rhosolutions{1,n}));
    stem3(y);
    drawnow
    frame=getframe(h);
    im=frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if n ==1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else
       imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end
end