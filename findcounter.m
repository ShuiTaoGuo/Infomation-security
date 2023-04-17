function ifconter = findcounter(P1X,P1Y,P2X,P2Y)

    ifconter=0;
    for i=1:length(P1X)-1
        for j=1:length(P2X)-1
            p1x=P1X(i:i+1)  ;
            p1y= P1Y(i:i+1)  ;
            p2x=P2X(j:j+1);
            p2y=  P2Y(j:j+1);
%             figure(2);
%             clf
%             plot(P1X(i:i+1),P1Y(i:i+1));hold on
%             plot(P2X(j:j+1),P2Y(j:j+1))
            AllX=linspace(min([p1x p2x]),max([p1x p2x]),100);    

             Int1 = interp1(p1x,p1y,AllX);
             Int2 = interp1(p2x,p2y,AllX);
             intersec=Int1-Int2;
            if(max(intersec)*min(intersec)<0)
                ifconter=1;
            end
        end
    end
end
