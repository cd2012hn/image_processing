I = imread("coneDetection.jpg");

G = rgb2gray(I);
K = G>120;

figure;
imshow(K); title("Anh nhi phan");

S1 = ones(5,5);
S2 = ones(3,3);

[m, n, n_channels] = size(K);

temp1 = zeros(m+4, n+4);
temp1(3:m+2,3:n+2) = K;
re1 = zeros(m, n);

temp2 = zeros(m+2, n+2);
temp2(2:m+1, 2:n+1) = K;
re2 = zeros(m, n);

for i = 1:m
  for j = 1:n
    mat = temp1(i:i+4, j:j+4) .* S1;
    count = size(find(mat==1));
    if count>0
       re1(i, j) = 1;     
    endif
    
    mat = temp2(i:i+2, j:j+2) .* S2;
    count = size(find(mat==1));
    if count>0
       re2(i, j) = 1;     
    endif
  endfor
endfor

re = logical(re1) - logical(re2);

figure;
imshow(re); title("Result");

