% create_patch.m programmed by Tomo Furukawa
function E = create_patch(xyq,xyoff)

E.xyq = xyq;
E.xy(1,:) = [E.xyq(1)-xyoff(1), E.xyq(2)-xyoff(2)];
E.xy(2,:) = [E.xyq(1)+xyoff(1), E.xyq(2)-xyoff(2)];
E.xy(3,:) = [E.xyq(1)+xyoff(1), E.xyq(2)+xyoff(2)];
E.xy(4,:) = [E.xyq(1)-xyoff(1), E.xyq(2)+xyoff(2)];
