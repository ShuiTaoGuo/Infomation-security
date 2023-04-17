function [hash_index] = Hash_algo(ratio,length_range)

seed_rng = 1;
hash_index = 1;
therehold = pow2(32);
if(~isnan(ratio))
    seed_rng = typecast(ratio,'uint64');
    seed_rng = rem(seed_rng,therehold);
    s = rng(seed_rng);

    randD = rand(1,5);

    ratio = randD(1);

    hash_index = round(ratio * (length_range - 1)) + 1;
    
end
% 
% % value_4 = eval(vpa(ratio,4));

% % str_4 = erase(num2str(value_4),'.');
% % len = 4 - strlength(str_4);
% % if len > 0
% %     str_extend = char(zeros(1,len)+'0');
% %     str_4 =strcat (str_4,str_extend);
% % end
% % len = 1;

% % str_3 = str_4(len:end - 1);

% % % index = str2num(str_3);
% % if length(str_3) == 2
% %     L = 1;
% % end

% % % max = 1000;
% % [hash_index] = hashFunc(str_3, length_range);
% 
% 
%     therehold = pow2(32);

%     ratio = abs(ratio);

%     ratio_enlarge = [];
%     if(ratio<therehold && ratio * 10000 < therehold)
%         ratio_enlarge = ratio * 10000;   
%     elseif(ratio * 10000 < therehold)
%         ratio_enlarge = ratio;
%     else
%         ratio_enlarge = rem(ratio,therehold);
%     end
% 
% 

%     value_4 = eval(vpa(ratio_enlarge,3));
%     hash_index = 1;
%     % value_4

%     % value_3 = eval(vpa(value_4,3));

%     if (~isnan(value_4))
%         s = rng(value_4);

%         randD = rand(1,5);

%         ratio = randD(1);

%         % length_range = 4999;
%         hash_index = round(ratio * (length_range - 1)) + 1;
% 

%         % hash_index = rem(hash_index,length_range) + 1;
%     end
end


function  [hashValue] = hashFunc(str, max)

    hashValue = 0;

    for i = 1:1:length(str)-1
        hashValue = 37 * hashValue + str(i);
    end
    
    if (str(3) >= '0') && (str(3) <= '3')
         hashValue = 37 * hashValue + '2';
    else if (str(3) > '3') && (str(3) <= '6')
             hashValue = 37 * hashValue + '5';
        
    else
        hashValue = 37 * hashValue + '8';
        end
    end

    hashValue = rem( hashValue, max) + 1;
end
