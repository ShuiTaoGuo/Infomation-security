function [] = scaleLayer(name,point,ratio)

shape_datas = shaperead(name);

shape_counts = length(shape_datas);

a = theta / 180 * pi;

M = [1, 0, -point(1); 0, 1, -point(2); 0,0,1];

S = [ratio, 0, 0; 0, ratio, 0; 0,0,1];

for i = 1 : 1 :shape_counts
    xyz = [];
    x = shape_datas(i).X;
    y = shape_datas(i).Y;

    xyz(1,:) = x;
    xyz(2,:) = y;
    xyz(3,:) = 1;
    

    xy_M = M * xyz;

    xy_S = S * xy_M;

    xy_MS = M \ xy_S;
    

    shape_datas(i).X = xy_MS(1,:);
    shape_datas(i).Y = xy_MS(2,:);
end

shapewrite(shape_datas,name);
end
