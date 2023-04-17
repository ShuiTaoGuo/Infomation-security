function [] = Get_polygon_topo_para ()
% Extract watermark information based on three topological parameters.
% 
%%%%%%% By comparing the watermark information of the data set, nanjing and Henan only refer %to a certain data set

[nanjing_lin2gon_interdata]=xlsread('../result/nanjing_index_lin.xlsx') ;
[nanjing_lin2gon_offdata]=xlsread('../result/nanjing_offdata_lin.xlsx') ;

[nanjing_gon2lin_interdata]=xlsread('../result/nanjing_index_gon.xlsx') ;
[nanjing_gon2lin_offdata]=xlsread('../result/nanjing_offdata_gon.xlsx') ;

[nanjing_point2lingon_interdata]=xlsread('../result/nanjing_index_point.xlsx') ;
[nanjing_point2lingon_offdata]=xlsread('../result/nanjing_offdata_point.xlsx') ;



nanjing_qus_lin = zeros(1,length(nanjing_lin2gon_interdata));
nanjing_num_lin = find(nanjing_lin2gon_interdata >= nanjing_lin2gon_offdata);
nanjing_qus_lin(nanjing_num_lin) = 1;

nanjing_qus_gon = zeros(1,length(nanjing_gon2lin_interdata));
nanjing_num_gon = find(nanjing_gon2lin_interdata >= nanjing_gon2lin_offdata);
nanjing_qus_gon(nanjing_num_gon) = 1;

nanjing_qus_point = zeros(1,length(nanjing_point2lingon_interdata));
nanjing_num_point = find(nanjing_point2lingon_interdata >= nanjing_point2lingon_offdata);
nanjing_qus_point(nanjing_num_point) = 1;

length_array = [32,64,128,256,512,1024];
ratio_result = [];

for current_length = 1:1:length(length_array)

    length_range = length_array(current_length);
    
    nanjing_watermark = zeros(1,length_range);
    
    for i=1:1: length(nanjing_lin2gon_offdata)
        [hash_index] = Hash_algo(nanjing_lin2gon_offdata(i),length_range);
        if(nanjing_qus_lin(i) == 0)
            nanjing_watermark(hash_index) = nanjing_watermark(hash_index) - 1;
        else
            nanjing_watermark(hash_index) = nanjing_watermark(hash_index) + 1;
        end
    end
    
    for i=1:1: length(nanjing_gon2lin_offdata)

        [hash_index] = Hash_algo(nanjing_gon2lin_offdata(i),length_range);
        if(nanjing_qus_gon(i) == 0)
            nanjing_watermark(hash_index) = nanjing_watermark(hash_index) - 1;
        else
            nanjing_watermark(hash_index) = nanjing_watermark(hash_index) + 1;
        end
    end
    
    for i=1:1: length(nanjing_point2lingon_offdata)
 
        [hash_index] = Hash_algo(nanjing_point2lingon_offdata(i),length_range);
        if(nanjing_qus_point(i) == 0)
            nanjing_watermark(hash_index) = nanjing_watermark(hash_index) - 1;
        else
            nanjing_watermark(hash_index) = nanjing_watermark(hash_index) + 1;
        end
    end
    
    j_watermark = zeros(1,length_range);
    
    j_num = find(nanjing_watermark > 0);
    
    j_watermark(j_num) = 1;
    
    ratio_current = length(find(h_watermark == j_watermark)) / length_range;
    ratio_result = [ratio_result;ratio_current];
    

    if length_range == 64 || length_range == 256 || length_range == 1024 
        width_watermark = sqrt(length_range);
        heigth_watermark = sqrt(length_range);
    elseif length_range == 32
        width_watermark = 4;
        heigth_watermark = 8;   
    elseif length_range == 128
        width_watermark = 8;
        heigth_watermark = 16;
    elseif length_range == 512
        width_watermark = 16;
        heigth_watermark = 32;
    end
    
    j_r_watermark = reshape(j_watermark,width_watermark,heigth_watermark);  
    
    path_img_watermark = '..\result\';
    path_watermark_other = strcat(path_img_watermark,num2str(length_range),'nanjing.bmp');
    imwrite(j_r_watermark,path_watermark_other);
    
end
end
