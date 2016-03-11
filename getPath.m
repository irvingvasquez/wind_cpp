function [Path, Dist] = getPath(M, dx, curve_radius)

%% Generate lines

gap_y = 1;

% left limit
l_limit = min(M(:,1));
down_limit = min(M(:,2));
up_limit = max(M(:,2));

%right limit
r_limit = max(M(:,1));

y1 = down_limit - gap_y;
y2 = up_limit + gap_y;

%nl = floor((r_limit - l_limit)/dx) +1;
i = 1;
%LinesXY = zeros(nl,4);

x1 = l_limit;
x2 = x1;

df = 0;
db = 0;
dir = 1;% forth abajo arriba, -back

% Show the intersection points.
%     figure('Position',[10 100 500 500],'Renderer','zbuffer'); 
%     axes_properties.box             = 'on';
%     axes_properties.XLim            = [-2 2];
%     axes_properties.YLim            = [-2 2];
%     axes_properties.DataAspectRatio = [1 1 1];
%     axes_properties.NextPlot        = 'add';
%     axes(axes_properties,'parent',gcf);
%     hold on
    
i = 1; %numero de waypoints agregados

while(x1 <= r_limit)
    LineXY = [x1 y1 x2 y2];
    x1 = x1 + dx;
    x2 = x1;
    
    out = lineSegmentIntersect(M,LineXY);
    intersections = [out.intMatrixX(:) out.intMatrixY(:)];
    intersections( ~any(intersections,2), : ) = [];  
    
    intersections
    dir
    
    n = size(intersections,1);
    if (n == 1)
        p1 = intersections(1,:);
        Path(i,:) = p2;
        i = i+1;
    end
    
    if (n == 2)
        p1 = intersections(1,:);
        p2 = intersections(2,:);
        % las ordenamos de acuerdo a la dirección
        if (dir == 1)
            if (p2(1,2)<p1(1,2))
                %intercambiamos
                Path(i,:) = p2;
                i = i+1;
                Path(i,:) = p1;
                i = i+1;
            else
                Path(i,:) = p1;
                i = i+1;
                Path(i,:) = p2;
                i = i+1;
            end
            dist = abs(p2(1,2) - p1(1,2));
            df = df + dist;
        else
           if (p2(1,2)<p1(1,2)) 
               Path(i,:) = p1;
               i = i+1;
               Path(i,:) = p2;
               i = i+1;
           else
               Path(i,:) = p2;
               i = i+1;
               Path(i,:) = p1;
               i = i+1;
           end
           dist = abs(p2(1,2) - p1(1,2));
           db = db + dist;
        end
        dir = dir * -1;
    end       
    Path
    
%     line([M(:,1)';M(:,3)'],[M(:,2)';M(:,4)'],'Color','r');
%     line([LineXY(:,1)';LineXY(:,3)'],[LineXY(:,2)';LineXY(:,4)'],'Color','k');
%     scatter(intersections(:,1), intersections(:,2),[],'b');
    
    %pause
end

% title('Intersection Points');
% hold off;

Dist = [db df];

end

