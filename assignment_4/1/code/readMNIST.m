function [I,labels,I_test,labels_test] = readMNIST()

%===========
path = 'train-images.idx3-ubyte';
fid = fopen(path,'r','b');  %big-endian
magicNum = fread(fid,1,'int32');   
if(magicNum~=2051) 
    display('Error: cant find magic number');
    return;
end
imgNum = fread(fid,1,'int32');  
rowSz = fread(fid,1,'int32');   
colSz = fread(fid,1,'int32');   

for k=1:imgNum
        I{k} = uint8(fread(fid,[rowSz colSz],'uchar'));
end
fclose(fid);

%============
path = 'train-labels.idx1-ubyte';
fid = fopen(path,'r','b');  % big-endian
magicNum = fread(fid,1,'int32');    
if(magicNum~=2049) 
    display('Error: cant find magic number');
    return;
end
itmNum = fread(fid,1,'int32');  

labels = uint8(fread(fid,itmNum,'uint8'));  

fclose(fid);

%============×
path = 't10k-images.idx3-ubyte';
fid = fopen(path,'r','b');  % big-endian
magicNum = fread(fid,1,'int32');   
if(magicNum~=2051) 
    display('Error: cant find magic number');
    return;
end
imgNum = fread(fid,1,'int32');  
rowSz = fread(fid,1,'int32');   
colSz = fread(fid,1,'int32');   

for k=1:imgNum
        I_test{k} = uint8(fread(fid,[rowSz colSz],'uchar'));
end
fclose(fid);

%============
path = 't10k-labels.idx1-ubyte';
fid = fopen(path,'r','b');  % big-endian
magicNum = fread(fid,1,'int32');   
if(magicNum~=2049) 
    display('Error: cant find magic number');
    return;
end
itmNum = fread(fid,1,'int32');  
labels_test = uint8(fread(fid,itmNum,'uint8'));   

fclose(fid);
