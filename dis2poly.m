function minD = dis2poly(p,poly)


    if inpolygon(p(1),p(2),poly(:,1),poly(:,2))
        k = -1; 
    else
        k = 1;  
    end
    minD = Inf;
    for i = 1:size(poly,1)-1  
        D = dis2edge(p,poly(i,:)',poly(i+1,:)');
        if D < minD
            minD = D;
        end
    end
    minD = k*minD;
    function d = dis2edge(P,A,B)

       AB = B-A;
       AP = P-A;
       BP = P-B;
       t = (AB'*AP)/(AB'*AB);
       if t<0
           d = norm(AP); 
       elseif 0<=t && t<=1
           d = norm(P-t*AB);
       else
           d = norm(BP);
       end
    end
end
