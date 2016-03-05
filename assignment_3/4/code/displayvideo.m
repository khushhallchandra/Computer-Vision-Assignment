function displayvideo (vid,pausetime)

T = size(vid,3);

for i=1:T
   imshow(vid(:,:,i)/255);
   pause(pausetime);
end

