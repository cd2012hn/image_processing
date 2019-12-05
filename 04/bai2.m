I = imread("fence.png");

T = rgb2gray(I);

W = zeros(101, 101);
W(:,51) = ones(101,1);
W(51,:) = ones(1,101);

[m,n,n_channels] = size(T);
temp = ones(m+100,n+100) * 255;
temp(51:50+m, 51:50+n) = T;
K = zeros(m, n);

for i = 1:m
  for j = 1:n
    mat = temp(i:i+100, j:j+100) .* W;
    min1 = min(mat(:,51));
    min2 = min(mat(51,:));
    value = min(min1, min2);
    K(i,j) = value;
  endfor
endfor
K=uint8(K);

B = K>200;

figure;
subplot(3,1,1);imshow(I);title("Anh goc");
subplot(3,1,2);imshow(K);title("Anh co");
subplot(3,1,3);imshow(B);title("Anh nhi phan");


