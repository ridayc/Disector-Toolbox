function imlist = statExtraction(Synapse)

%count synapses per individual image per type
imlist =  struct('grid',{},'type',{},'layer',{},'image',{},'key',{});
for i=1:length(Synapse)
    imlist(i).grid = Synapse(i).grid;
    [B,I,J] = unique(Synapse(i).image);
    imlist(i).image = B;
    imlist(i).layer = Synapse(i).layer(I);
    type = unique(Synapse(i).type);
    for j=1:length(type)
        imlist(i).key(j) = type(j);
        temp = strcmp(Synapse(i).type,type(j));
        %here comes a sadly less efficient part
        for k=1:length(imlist(i).image)
            imlist(i).type{k,j} = sum((J==k)&temp);
        end
    end
end