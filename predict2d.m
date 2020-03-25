% predict2d.m programmed by Tomo Furukawa
function pxykGz1tkm = predict2d(dx, dy, pxykGxkm, pxykmGz1tkm)

pxykGz1tkm = dx*dy*conv2(pxykmGz1tkm, pxykGxkm, 'same');
