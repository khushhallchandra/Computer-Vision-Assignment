function smooth_motion = mySmoothMotion(motion)
smooth_motion=motion;
smooth_motion(:)=0;
width=10;   % actual width is width+1;
window=gausswin(width+1);
for i=1:length(motion)
    p=max(1,i-width/2);
    q=min(length(motion),i+width/2);
    smooth_motion(i)=sum(motion(p:q)*window(p-i+width/2 +1 : q-i+width/2 +1))/sum(window(p-i+width/2+1 : q-i+width/2+1));
end
% for i=2:25
%     txfinal(i)=txfinal(i)+txfinal(i-1);
% end