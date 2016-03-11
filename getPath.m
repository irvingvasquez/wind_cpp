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
dr = 0;
dl = 0;
dir = 1;% forth abajo arriba, -back

%%
%Calcular distancia de la curva

% Show the intersection points.
%     figure('Position',[10 100 500 500],'Renderer','zbuffer'); 
%     axes_properties.box             = 'on';
%     axes_properties.XLim            = [-2 2];
%     axes_properties.YLim            = [-2 2];
%     axes_properties.DataAspectRatio = [1 1 1];
%     axes_properties.NextPlot        = 'add';
%     axes(axes_properties,'parent',gcf);
%     hold on
  
%%
i = 1; %numero de waypoints agregados
lines = 0;
enterWP = [0 0];
exitWP = [0 0];
lastWP = [0 0];

while(x1 <= r_limit)
    LineXY = [x1 y1 x2 y2];
    x1 = x1 + dx;
    x2 = x1;
    lines = lines +1;
    
    out = lineSegmentIntersect(M,LineXY);
    intersections = [out.intMatrixX(:) out.intMatrixY(:)];
    intersections( ~any(intersections,2), : ) = [];  
    
    intersections
    dir
    
    n = size(intersections,1);
    if (n == 1)
        p1 = intersections(1,:);
        Path(i,:) = p1;
        enterWP = p1;
        i = i+1;
    end
    
    if (n == 2)
        p1 = intersections(1,:);
        p2 = intersections(2,:);
        % las ordenamos de acuerdo a la dirección
        if (dir == 1) % direcciń hacia arriba
            if (p2(1,2)<p1(1,2))
                enterWP = p2;
                exitWP = p1;
            else
                enterWP = p1;
                exitWP = p2;
            end
            
            if(lines > 1)
                % agregar un punto para compensar
                dif = enterWP(1,2) - lastWP(1,2);
                if(dif < 0) % agregar un punto a la izquierda
                    intermediateWP = [lastWP(1,1) enterWP(1,2)];
                    Path(i,:) = intermediateWP;
                    i = i+1;
                    
                    [dubinsWP, dist] = getDubinsWaypoints(intermediateWP, enterWP, curve_radius, dx, -1);
                    Path = [Path ;dubinsWP];
                    i = i + size(dubinsWP,1);
                    
                    dl = dl + dist;
                else % agregar un punto a la derecha
                    intermediateWP = [enterWP(1,1) lastWP(1,2)];
                    
                    [dubinsWP, dist] = getDubinsWaypoints(lastWP, intermediateWP, curve_radius, dx, -1);
                    Path = [Path ;dubinsWP];
                    i = i + size(dubinsWP,1);
                    
                    Path(i,:) = intermediateWP;
                    i = i+1;
                    
                    dl = dl + dist;
                end
            end
            
            Path(i,:) = enterWP;
            i = i+1;
            Path(i,:) = exitWP;
            i = i+1;
            
            dist = abs(p2(1,2) - p1(1,2));
            df = df + dist;
        else % dirección hacia abajo
           if (p2(1,2)<p1(1,2)) 
               enterWP = p1;
               exitWP = p2;
           else
               enterWP = p2;
               exitWP = p1;
           end
           
           if(lines > 1)
                % agregar un punto para compensar
                dif = enterWP(1,2) - lastWP(1,2);
                if(dif > 0) % agregar un punto a la izquierda
                    intermediateWP = [lastWP(1,1) enterWP(1,2)];
                    
                    Path(i,:) = intermediateWP;
                    i = i+1;

                    [dubinsWP, dist] = getDubinsWaypoints(intermediateWP, enterWP, curve_radius, dx, 1);
                    Path = [Path ;dubinsWP];
                    i = i + size(dubinsWP,1);
                    
                    dr = dr + dist;
                else % agregar un punto a la derecha
                    intermediateWP = [enterWP(1,1) lastWP(1,2)];
                                                            
                    [dubinsWP, dist] = getDubinsWaypoints(lastWP, intermediateWP, curve_radius, dx, 1);
                    Path = [Path ;dubinsWP];
                    i = i + size(dubinsWP,1);
                    
                    Path(i,:) = intermediateWP;
                    i = i+1;
                    
                    dr = dr + dist;
                end
            end
           
            Path(i,:) = enterWP;
            i = i+1;
            Path(i,:) = exitWP;
            i = i+1
            
           dist = abs(p2(1,2) - p1(1,2));
           db = db + dist;
        end
        
        dir = dir * -1;
        lastWP = exitWP;
    end       
    
    
    %pause
end

% title('Intersection Points');
% hold off;

Dist = [db df dl dr];

end

