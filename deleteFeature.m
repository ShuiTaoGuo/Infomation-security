function [] = DeleteF(name,ratio_delete)

shape_datas = shaperead(name);
shape_counts = length(shape_datas);


delete_counts = round( shape_counts * ratio_delete);

rand_index = randperm(shape_counts,delete_counts);


shape_datas(rand_index) = [];

shapewrite(shape_datas,name);
end
