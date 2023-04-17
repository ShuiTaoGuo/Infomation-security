function [] = Get_line_topo_para ()
% Obtain the topological parameters of line type data in the dataset, and save them as preparation for extracting watermark information later.
% Read different types of data from the dataset and then perform calculations.
% 
%%%%%%As an example, using the dataset of Nanjing city (Nanjing dataset line topo-parameters)
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

ratio_index = [];

ratio_off = [];


retio_index_contain = [];
ratio_off_contain = [];



kdtreeobj = KDTreeSearcher(feature_center_lines,'distance','euclidean');

[index_line2gon,dist_line2gon]=knnsearch(feature_center_polygons,feature_center_lines,'dist','euclidean','k',K);

for i = 1:1:length(feature_center_lines)

    shape_line_current = shapedata_lines(i);

    coords_x_line = shape_line_current.X(~isnan(shape_line_current.X));

    coords_y_line = shape_line_current.Y(~isnan(shape_line_current.Y));
    
    if ~((coords_x_line(1) == coords_x_line(end)) && (coords_y_line(1) == coords_y_line(end)))
        coords_x_line(end+1) = coords_x_line(1);
        coords_y_line(end+1) = coords_y_line(1);
    end


    p1 = polyshape(coords_x_line,coords_y_line);
    

    status_interset_first = 0;
    status_off_first = 0;
    status_contain_first = 0;
    

    ratios_tem = [];
    ratio_off_tem = [];

    index_near_currenr = index_line2gon(i,:);
    for j=1:1:K
 
        shape_gon_current = shapedata_gons(index_near_currenr(j));

        coords_x_gon = shape_gon_current.X(~isnan(shape_gon_current.X));

        coords_y_gon = shape_gon_current.Y(~isnan(shape_gon_current.Y));

        if(status_interset_first == 1 &&  status_off_first ==1)
            break;
        end        
        
 
        ifconter = isIntersect(coords_x_line,coords_y_line,coords_x_gon,coords_y_gon);

        [in_p,on_p] = inpolygon(coords_x_line,coords_y_line,coords_x_gon,coords_y_gon);
        count_in_1 = length(in_p(in_p>0)) ;
   
        if (ifconter == 1 && status_interset_first == 0)
            

            status_interset_first = 1;
            

            p2= polyshape(coords_x_gon,coords_y_gon);

            [inter_points,~,~] = intersect(p1,p2);
            

            p_inter = polyshape(inter_points.Vertices(:,1),inter_points.Vertices(:,2));
            area_interset = area(p_inter);
            

            if(area_interset<feature_area_lines(i))
                ratios_tem = area_interset/feature_area_lines(i);
            else
                ratios_tem = feature_area_lines(i)/area_interset;
            end
            
        elseif(ifconter == 0 && status_interset_first == 0 && count_in_1 > 0)

            points1 = struct('x',coords_x_line,'y',coords_y_line);
            points2 = struct('x',coords_x_gon,'y',coords_y_gon);
            [min_d,min_total] = min_dist_between_two_polygons(points1,points2,feature_center_lines(i,:),ifconter,0);

            length_count = length(coords_x_line) -1 ;
            x1 = points1.x(1);
            x2 = points1.x(length_count);
            y1 = points1.y(1);
            y2 = points1.y(length_count);            
            line_length_first2end = sqrt(power((x1-x2),2)+power((y1-y2),2));
            

            if(min_d<line_length_first2end)
                ratios_tem = min_d / line_length_first2end;
            else
                ratios_tem = line_length_first2end / min_d;
            end
            
            status_interset_first = 1;
            status_contain_first = 1;
        elseif (ifconter == 0 && status_off_first == 0)

            status_off_first = 1;
            

            points1 = struct('x',coords_x_line,'y',coords_y_line);
            points2 = struct('x',coords_x_gon,'y',coords_y_gon);

            [min_d,min_total] = min_dist_between_two_polygons(points1,points2,feature_center_lines(i,:),ifconter,0);

            area_off = pi*(min_total-min_d)*min_d;
            ratio_off_tem = area_off/feature_area_lines(i);
            
        end   
                
    end
    
%     if(status_off_first == 1 && status_contain_first == 1)
      
%         retio_index_contain = [retio_index_contain,ratios_tem];

%         ratio_off_contain = [ratio_off_contain,ratio_off_tem];
%     elseif(status_off_first == 1 && status_interset_first == 1)
%          ratio_index = [ratio_index,ratios_tem];

%         ratio_off = [ratio_off,ratio_off_tem];
%     end
 if(status_off_first == 1 && status_interset_first == 1)
        ratio_index = [ratio_index,ratios_tem];

        ratio_off = [ratio_off,ratio_off_tem];
    end

    
end

% 

% a = mean(ratio_index);
% c = std(ratio_index);
% num = find(ratio_index>(a+3*c)|ratio_index<(a-3*c));
% 
% ratio_index(num) = [];
% ratio_off(num) = [];


xlswrite('../result/nanjing_index_lin.xlsx',ratio_index);
xlswrite('../result/nanjing_offdata_lin.xlsx',ratio_off);

end
