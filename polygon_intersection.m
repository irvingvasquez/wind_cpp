clear all
clear all
clc 

% Specify polygon variables
numVert = 8;
radius = 1;
radVar = 1; % variance in the spikiness of vertices
angVar = 1; % variance in spacing of vertices around the unit circle

% preallocate x and y 
x = zeros(numVert,1);
y = zeros(numVert,1);

% angle of the unit circle in radians
circleAng = 2*pi;
% the average angular separation between points in a unit circle
angleSeparation = circleAng/numVert;
% create the matrix of angles for equal separation of points
angleMatrix = 0: angleSeparation: circleAng;
% drop the final angle since 2Pi = 0
angleMatrix(end) = [];

% generate the points x and y
for k = 1:numVert
    x(k) = (radius + radius*rand(1)*radVar) * cos(angleMatrix(k) + angleSeparation*rand(1)*angVar);
    y(k) = (radius + radius*rand(1)*radVar) * sin(angleMatrix(k) + angleSeparation*rand(1)*angVar);
end

% Graph the polygon and connect the final point to the first point
plot([x; x(1)],[y; y(1)],'ro-')
hold on
plot([-2 2],[0 0],'k')
plot([0 0],[-2 2],'k')

%% Generate lines
Polygon_vertex = [x y]
shifted_polygon_vertex = circshift(Polygon_vertex, -1)
gap_y = radius./10;

% left limit
l_limit = min(Polygon_vertex(:,1));
down_limit = min(Polygon_vertex(:,2));
up_limit = max(Polygon_vertex(:,2));

%right limit
r_limit = max(Polygon_vertex(:,1));

y1 = down_limit - gap_y;
y2 = up_limit + gap_y;

% coverage parameters
xd = 0.2;

nl = floor((r_limit - l_limit)/xd) +1;
i = 1;
LinesXY = zeros(nl,4);

x1 = l_limit;
x2 = x1;
while(x1 <= r_limit)
    LinesXY(i,:) = [x1 y1 x2 y2];
    x1 = x1 + xd;
    x2 = x1;
    i = i + 1;
end

PolygonXY = [Polygon_vertex shifted_polygon_vertex];
LinesXY;


%% SPEED TEST METHOD 1.
tic
out = lineSegmentIntersect(PolygonXY,LinesXY);
dt_1 = toc;

fprintf(1,'Method 1 took %.2f seconds for %.0f line segments...\n',dt_1,nl);


%% PREPARE THE FIGURE.
is_show = true;
if is_show

    % Show the intersection points.

    figure('Position',[10 100 500 500],'Renderer','zbuffer');
    
    axes_properties.box             = 'on';
    axes_properties.XLim            = [-2 2];
    axes_properties.YLim            = [-2 2];
    axes_properties.DataAspectRatio = [1 1 1];
    axes_properties.NextPlot        = 'add';
    
    axes(axes_properties,'parent',gcf);
    
    line([PolygonXY(:,1)';PolygonXY(:,3)'],[PolygonXY(:,2)';PolygonXY(:,4)'],'Color','r');
    line([LinesXY(:,1)';LinesXY(:,3)'],[LinesXY(:,2)';LinesXY(:,4)'],'Color','k');
    
    scatter(out.intMatrixX(:),out.intMatrixY(:),[],'r');

    title('Intersection Points');
    
end