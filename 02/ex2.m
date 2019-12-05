pkg load image;

output_path = "ketqua/";

foreground_path = "foreground.png";
background_path = "background.png";

I = imread(foreground_path);
J = imread(background_path);

[m, n, n_channels] = size(I);

J = imresize(J, [m, n]);

figure;
subplot(1, 2, 1); imshow(I); title("Anh I");
subplot(1, 2, 2); imshow(J); title("Anh J");
print(strcat(output_path, "lab02_bai2_1.png"));

histogram = zeros(256, 3);


# tinh histogram
tic();
for i = 1:m
   for j = 1:n
      pixel_val = I(i, j, :);
      histogram(pixel_val(1)+1, 1) += 1;   
      histogram(pixel_val(2)+1, 2) += 1;  
      histogram(pixel_val(3)+1, 3) += 1;  
   endfor
endfor
toc();


figure;
subplot(1,3,1); set(bar(histogram(:,1), 'hist'), 'facecolor', 'r', 'edgecolor', 'r'); title("R"); 
subplot(1,3,2); set(bar(histogram(:,2), 'hist'), 'facecolor', 'g', 'edgecolor', 'g'); title("G");
subplot(1,3,3); set(bar(histogram(:,3), 'hist'), 'facecolor', 'b', 'edgecolor', 'b'); title("B");
print(strcat(output_path, "lab02_bai2_2.png"));

function result = combineImage(I,J)
  k  = 120;
  [m,n,n_channels] = size(I);
  T = zeros(m,n,3);
  #for b = 1:n_channels
  #  T(:,:,b) = (I(:,:,b)>k);
  #endfor
  T(:,:,:) = (I(:,:,:)>k);
  M = zeros(m,n);
  M = T(:,:,1) .* T(:,:,2) .* T(:,:,3);
  N = ~M;
  M = uint8(M);
  N = uint8(N);
  K = zeros(m,n,n_channels);
  for b = 1:n_channels
    K(:,:,b) = M .* J(:,:,b) + N .* I(:,:,b);
  endfor
  result = uint8(K);
endfunction

K = combineImage(I,J);
figure;
imshow(K); title("Anh K");
print(strcat(output_path, "lab02_bai2_3.png"));
