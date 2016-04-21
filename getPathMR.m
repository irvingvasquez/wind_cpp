% BUG que pasa si hay mas de una intersección con la linea vertical
% BUG Todavia no calcula la energia

% Returns a path for a given polygon 
% Multirotor
% Dist = [lb lf ll lr];
function [Path, Dist, Energy] = getPathMR(M, dx, curve_radius)
%% Generate lines

gap_y = 1;

% polygon limits
l_limit = min(M(:,1));
r_limit = max(M(:,1));
down_limit = min(M(:,2));
up_limit = max(M(:,2));

%extend the lines beyond the polygon
y1 = down_limit - gap_y;
y2 = up_limit + gap_y;

x1 = l_limit;
x2 = x1;

df = 0;
db = 0;
dr = 0;
dl = 0;
dir = 1;% forth abajo arriba, -back

%% Show the intersection points.
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
nLinesF = 0;
nLinesB = 0;
enterWP = [0 0];
exitWP = [0 0];
lastWP = [0 0];

while(x1 <= r_limit)
    % linea de intersección
    LineXY = [x1 y1 x2 y2];
    x1 = x1 + dx;
    x2 = x1;
    lines = lines +1;
    
    %intersecciones
    out = lineSegmentIntersect(M,LineXY);
    intersections = [out.intMatrixX(:) out.intMatrixY(:)];
    intersections( ~any(intersections,2), : ) = [];  
    n = size(intersections,1);
    
    % Si solo hay una intersección agegamos el punto directamente
    if (n == 1)
        p1 = intersections(1,:);
        Path(i,:) = p1;
        enterWP = p1;
        i = i+1;
    end
    
    % si hay dos intersecciones entonces tomamos las intersecciones como wp
    if (n > 1)
        
        if(n>2)
           [B, kkk] = sort(intersections(:,2)); % TODO: Revisar que esto este bien
           ordered = [intersections(kkk) B];
           p1 = ordered(1,:);
           p2 = ordered(n,:);
        else
            p1 = intersections(1,:);
            p2 = intersections(2,:);
        end
            
            
        % las ordenamos de acuerdo a la dirección
        if (dir == 1) % direcciń hacia arriba
            
            % ordenar los puntos para que corresponda con la dirección
            % hacia arriba
            if (p2(1,2)<p1(1,2))
                enterWP = p2; % punto de entrada a la linea
                exitWP = p1; % punto de salida de la linea
            else
                enterWP = p1;
                exitWP = p2;
            end
            
            % si hay lineas previas entonces conectamos la linea previa con
            % la nueva a través de curvas de dubins
            if(lines > 1)
                % agregar un punto para compensar la inclinación de la
                % arista del poligono
                dif = enterWP(1,2) - lastWP(1,2);
                if(dif < 0) % agregar un punto a la izquierda
                    intermediateWP = [lastWP(1,1) enterWP(1,2)];
                    Path(i,:) = intermediateWP;
                    i = i+1;
                    
                    % TODO: integrar la energia gastada entre esos dos
                    % puntos
                    %[dubinsWP, dist] = getDubinsWaypoints(intermediateWP, enterWP, curve_radius, dx, -1);
                    Path = [Path ;intermediateWP; enterWP];
                    %i = i + size(dubinsWP,1);
                    i = i + 2;
                    dist = norm(intermediateWP-enterWP);
                    dl = dl + dist;
                else % agregar un punto a la derecha
                    intermediateWP = [enterWP(1,1) lastWP(1,2)];
                    
                    %[dubinsWP, dist] = getDubinsWaypoints(lastWP, intermediateWP, curve_radius, dx, -1);
                    %Path = [Path ;dubinsWP];
                    Path = [Path; lastWP; intermediateWP];
                    %i = i + size(dubinsWP,1);
                    i = i + 2;
                    
                    %Path(i,:) = intermediateWP;
                    %i = i+1;
                    
                    dist = norm(lastWP-intermediateWP);
                    dl = dl + dist;
                end
            end
            
            Path(i,:) = enterWP;
            i = i+1;
            Path(i,:) = exitWP;
            i = i+1;
            
            dist = norm(exitWP-enterWP);
            df = df + dist;
            nLinesF = nLinesF +1;
        else % dirección hacia abajo
            
           %ordenar los waypoints
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
                    
                    %Path(i,:) = intermediateWP;
                    %i = i+1;

                    %[dubinsWP, dist] = getDubinsWaypoints(intermediateWP, enterWP, curve_radius, dx, 1);
                    %Path = [Path ;dubinsWP];
                    Path = [Path; intermediateWP; enterWP];
                    %i = i + size(dubinsWP,1);
                    i = i+2;
                    
                    dist = norm(intermediateWP-enterWP);
                    dr = dr + dist;
                else % agregar un punto a la derecha
                    intermediateWP = [enterWP(1,1) lastWP(1,2)];
                                                            
                    
                    %[dubinsWP, dist] = getDubinsWaypoints(lastWP, intermediateWP, curve_radius, dx, 1);
                    %Path = [Path ;dubinsWP];
                    Path = [Path; lastWP; intermediateWP];
                    %i = i + size(dubinsWP,1);
                    i = i+2;
                    
                    %Path(i,:) = intermediateWP;
                    %i = i+1;
                    dist = norm(lastWP-intermediateWP);
                    dr = dr + dist;
                end
            end
           
            Path(i,:) = enterWP;
            i = i+1;
            Path(i,:) = exitWP;
            i = i+1;
            
            dist = norm(exitWP-enterWP);
            db = db + dist;
            nLinesB = nLinesB +1 ;
        end
        
        dir = dir * -1;
        lastWP = exitWP;
    end       
    
    nLines = [nLinesB nLinesF];
    %pause
end

% title('Intersection Points');
% hold off;

Dist = [db df dl dr];

end