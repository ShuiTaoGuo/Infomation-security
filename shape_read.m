function [feature_center,feature_area,shape_datas] = shape_read(name,type)

% 
    shape_datas = shaperead(name);
    shape_counts = length(shape_datas);


    feature_center = [];
    feature_area = [];

    if (type == 0)
        for shape_current = 1:1:shape_counts

            shape_data = shape_datas(shape_current);

            coords_x = shape_data.X(~isnan(shape_data.X));

            coords_y = shape_data.Y(~isnan(shape_data.Y));


            feature_center = [feature_center;coords_x,coords_y];
            feature_area = [feature_area;0];
        end            
    else

        for shape_current = 1:1:shape_counts

            shape_data = shape_datas(shape_current);

            coords_x = shape_data.X(~isnan(shape_data.X));

            coords_y = shape_data.Y(~isnan(shape_data.Y));


            shape_area = polyarea(coords_x,coords_y);


            [rectx,recty,~,~,index,~,~] = minboundrect(coords_x,coords_y,'a');

            count_rect = length(rectx) - 1;
            rectx = rectx(1:count_rect);
            recty = recty(1:count_rect);
            dx = mean(rectx);
            dy = mean(recty);


            feature_center = [feature_center;dx,dy];
            feature_area = [feature_area;shape_area];    
        end
    end    
end
