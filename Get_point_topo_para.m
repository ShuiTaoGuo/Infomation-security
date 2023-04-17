function [] = Get_point_topo_para()
% Obtain the topological parameters of point type data in the dataset, and save them as preparation for extracting watermark information later.
% Read different types of data from the dataset and then perform calculations.
% 
%%%%%%As an example, using the dataset of Nanjing city (Nanjing dataset point topo-parameters)
%clc;
%clear;
%clf;
name_point = '../data/宾馆酒店_point.shp';
[feature_center_points,feature_area_points,shapedata_points] = shape_read(name_point,0);

name_point1 = '../data/大厦_point.shp';
[feature_center_points1,feature_area_points1,shapedata_points1] = shape_read(name_point1,0);

name_point2 = '../data/省会_font_point.shp';
[feature_center_points2,feature_area_points2,shapedata_points2] = shape_read(name_point2,0);

name_point3 = '../data/学校_point.shp';
[feature_center_points3,feature_area_points3,shapedata_points3] = shape_read(name_point3,0);

name_point4 = '../data/药店_point.shp';
[feature_center_points4,feature_area_points4,shapedata_points4] = shape_read(name_point4,0);

name_point5 = '../data/医疗_point.shp';
[feature_center_points5,feature_area_points5,shapedata_points5] = shape_read(name_point5,0);

name_point6 = '../data/银行_point.shp';
[feature_center_points6,feature_area_points6,shapedata_points6] = shape_read(name_point6,0);

name_point7 = '../data/政府机构_point.shp';
[feature_center_points7,feature_area_points7,shapedata_points7] = shape_read(name_point7,0);

name_point8 = '../data/出入口_point.shp';
[feature_center_points8,feature_area_points8,shapedata_points8] = shape_read(name_point8,0);

name_point9 = '../data/公园_point.shp';
[feature_center_points9,feature_area_points9,shapedata_points9] = shape_read(name_point9,0);
% 
name_point10 = '../data/收费站_point.shp';
[feature_center_points10,feature_area_points10,shapedata_points10] = shape_read(name_point10,0);

name_point11 = '../data/县_point.shp';
[feature_center_points11,feature_area_points11,shapedata_points11] = shape_read(name_point11,0);

name_point12 = '../data/镇_point.shp';
[feature_center_points12,feature_area_points12,shapedata_points12] = shape_read(name_point12,0);


feature_center_points = [feature_center_points;feature_center_points1;feature_center_points2;feature_center_points3;feature_center_points4;feature_center_points5;feature_center_points6;feature_center_points7;feature_center_points8];
feature_area_points = [feature_area_points;feature_area_points1;feature_area_points2;feature_area_points3;feature_area_points4;feature_area_points5;feature_area_points6;feature_area_points7;feature_area_points8];
shapedata_points = [shapedata_points;shapedata_points1;shapedata_points2;shapedata_points3;shapedata_points4;shapedata_points5;shapedata_points6;shapedata_points7;shapedata_points8];



name_line = '../data/城市快速路_polyline.shp';
[feature_center_lines,feature_area_lines,shapedata_lines] = shape_read(name_line,1);


name_line1 = '../data/高速_polyline.shp';
[feature_center_lines1,feature_area_lines1,shapedata_lines1] = shape_read(name_line1,1);


name_line2 = '../data/国道_polyline.shp';
[feature_center_lines2,feature_area_lines2,shapedata_lines2] = shape_read(name_line2,1);


feature_center_lines = [feature_center_lines;feature_center_lines1;feature_center_lines2];
feature_area_lines = [feature_area_lines;feature_area_lines1;feature_area_lines2];
shapedata_lines = [shapedata_lines;shapedata_lines1;shapedata_lines2];



name_polygon = '../data/绿地_region.shp';
[feature_center_polygons,feature_area_polygons,shapedata_gons] = shape_read(name_polygon,1);
 
name_polygon1 = '../data/省界_region.shp';
[feature_center_polygons1,feature_area_polygons1,shapedata_gons1] = shape_read(name_polygon1,);

name_polygon2 = '../data/市界_region.shp';
[feature_center_polygons2,feature_area_polygons2,shapedata_gons2] = shape_read(name_polygon2,1);
 
name_polygon3 = '../data/水系_region.shp';
[feature_center_polygons3,feature_area_polygons3,shapedata_gons3] = shape_read(name_polygon3,1);
 
name_polygon4 = '../data/县界_region.shp';
[feature_center_polygons4,feature_area_polygons4,shapedata_gons4] = shape_read(name_polygon4,1);
 

feature_center_polygons = [feature_center_polygons;feature_center_polygons1;feature_center_polygons2;feature_center_polygons3;feature_center_polygons4];
feature_area_polygons = [feature_area_polygons;feature_area_polygons1;feature_area_polygons2;feature_area_polygons3;feature_area_polygons4];
shapedata_gons = [shapedata_gons;shapedata_gons1;shapedata_gons2;shapedata_gons3;shapedata_gons4];


K  =  20;


kdtreeobj = KDTreeSearcher(feature_center_lines,'distance','euclidean');

center_line_gon = [feature_center_lines;feature_center_polygons];

 [index_point2gon,dist_point2gon]=knnsearch(center_line_gon,feature_center_points,'dist','euclidean','k',K);
 

 ratio_inter_point=[];

 ratio_off_point = [];
 
for i_point = 1:1:length(feature_center_points)

    point_current = feature_center_points(i_point,:);
    

    index_near_currenr = index_point2gon(i_point,:);
    
    status_interset_first = 0;
    status_off_first=0;
    

    for k_point = 1:1:K

        current_feature = [];
        current_feature_x = [];
        current_feature_y = [];
        
        index_point_line_gon = index_near_currenr(k_point);
        if (index_point_line_gon <= length(feature_center_lines))

 
            shape_line_current = shapedata_lines(index_point_line_gon);

            current_feature_x = shape_line_current.X(~isnan(shape_line_current.X));

            current_feature_y = shape_line_current.Y(~isnan(shape_line_current.Y));
            
        else

            shape_gon_current = shapedata_gons(index_point_line_gon - length(feature_center_lines));

            current_feature_x = shape_gon_current.X(~isnan(shape_gon_current.X));

            current_feature_y = shape_gon_current.Y(~isnan(shape_gon_current.Y));
                      
        end
        
        if ~((current_feature_x(1) == current_feature_x(end)) && (current_feature_y(1) == current_feature_y(end)))
            current_feature_x(end+1) = current_feature_x(1);
            current_feature_y(end+1) = current_feature_y(1);
        end
        
        current_feature = [current_feature_x',current_feature_y'];
        

        [in_p,on_p] = inpolygon(point_current(1),point_current(2),current_feature_x,current_feature_y);
        
        if((in_p == 1 || on_p == 1) && status_interset_first == 0)

            status_interset_first = 1;

            [index_point2gon_tem,dist_point2gon_tem]=knnsearch(point_current,current_feature,'dist','euclidean','k',2);

            feature_shape_current =  polyshape(current_feature_x,current_feature_y);
            perimeter_shape_current = perimeter(feature_shape_current);
            

            if( dist_point2gon_tem(2) <= perimeter_shape_current)
                ratio_inter_point_tem = dist_point2gon_tem(2)/perimeter_shape_current;
            else
                ratio_inter_point_tem = perimeter_shape_current / dist_point2gon_tem(2);
            end
            
            
        elseif((in_p == 0 && on_p == 0) && status_off_first == 0)

            status_off_first = 1;

            [index_point2gon_tem,dist_point2gon_tem]=knnsearch(point_current,current_feature,'dist','euclidean','k',2);

            feature_shape_current =  polyshape(current_feature_x,current_feature_y);
            perimeter_shape_current = perimeter(feature_shape_current); 
            

            if( dist_point2gon_tem(2) <= perimeter_shape_current)
                ratio_off_point_tem = dist_point2gon_tem(2) / perimeter_shape_current;
            else
                ratio_off_point_tem = perimeter_shape_current / dist_point2gon_tem(2);
            end
            
        end
    end
    
    if (status_interset_first == 0)

         [index_point2gon_current,dist_point2gon_current]=knnsearch(feature_center_polygons,point_current,'dist','euclidean','k',K);
         
        for il=1:1:K
            

            current_feature = [];
            current_feature_x = [];
            current_feature_y = [];
            
            index_point_line_gon = index_point2gon_current(il);

            shape_gon_current = shapedata_gons(index_point_line_gon);

            current_feature_x = shape_gon_current.X(~isnan(shape_gon_current.X));

            current_feature_y = shape_gon_current.Y(~isnan(shape_gon_current.Y));
            
            if ~((current_feature_x(1) == current_feature_x(end)) && (current_feature_y(1) == current_feature_y(end)))
                current_feature_x(end+1) = current_feature_x(1);
                current_feature_y(end+1) = current_feature_y(1);
            end
             
            current_feature = [current_feature_x',current_feature_y'];
        

            [in_p,on_p] = inpolygon(point_current(1),point_current(2),current_feature_x,current_feature_y);
            
            if((in_p == 1 || on_p == 1) && status_interset_first == 0)

                status_interset_first = 1;

                [index_point2gon_tem,dist_point2gon_tem]=knnsearch(point_current,current_feature,'dist','euclidean','k',2);

                feature_shape_current =  polyshape(current_feature_x,current_feature_y);
                perimeter_shape_current = perimeter(feature_shape_current);            
                

                if(dist_point2gon_tem(2) <= perimeter_shape_current)
                    ratio_inter_point_tem = dist_point2gon_tem(2) / perimeter_shape_current;
                else
                    ratio_inter_point_tem = perimeter_shape_current / dist_point2gon_tem(2);
                end
                
            end
        end
    end
    

    if (status_interset_first == 1 && status_off_first == 1)
        ratio_inter_point = [ratio_inter_point,ratio_inter_point_tem];
        ratio_off_point = [ratio_off_point,ratio_off_point_tem];
    end
    
    
end


xlswrite('../result/nanjing_index_point.xlsx',ratio_inter_point);
xlswrite('../result/nanjing_offdata_point.xlsx',ratio_off_point);

end
