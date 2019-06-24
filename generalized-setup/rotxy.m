% takes in original vector, x and y angles, and multiplication order
function r = rotxy(vec, xang, yang, dir)
% assigns x-rotation matrix
rx=[1, 0, 0;
    0, cos(xang), -sin(xang);
    0, sin(xang), cos(xang)];
% assigns y-rotation matrix
ry=[cos(yang), 0, sin(yang);
    0, 1, 0;
    -sin(yang), 0, cos(yang)];
% if dir is zero the rotation about x happens before that about y
if dir==0
    r=ry*rx*vec;
% if dir is not zero the rotation about y happens before that about x
else
    r=rx*ry*vec;
end   