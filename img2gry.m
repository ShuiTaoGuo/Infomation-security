function [] = imgcolor2gry(path_read,path_write)


    subplot(1, 2, 1);
    a = imread(path_read);
    imshow(a);
    title('原图');


    subplot(1, 2, 2);
    thresh = graythresh(a);
    b = im2bw(a, thresh);
    imshow(b);
    title('二值化');


    imwrite(b, path_write);	

end
