function M2 = rotatePolygon(M , theta)
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    M2 = R * M';
end