output_path = "ketqua/";
image_path = "barCodesDetection.png";
I = imread(image_path);
I = rgb2gray(I);

bi_img = I<120;
figure;
imshow(bi_img); title("Anh 1");
print(strcat(output_path,"lab03_bai1_1.png"));

[m,n,n_channels] = size(bi_img);

mat_path = "labelMatrix.txt";
mat = dlmread(mat_path);

red = [128; 0; 0];
green = [0; 128; 0];
# blue = [0; 0; 128]
yellow = [128; 128; 0];

K = zeros(m,n,3);

label_map = [];
for i=1:m
  for j=1:n
    val = mat(i,j);
    if (val > 0)
      color_code = mod(val, 3);
      
      switch (color_code)
        case 0
          K(i,j,:) = red;
        case 1
          K(i,j,:) = green;
        case 2
          K(i,j,:) = yellow;
      endswitch
    endif
  endfor
endfor

K = uint8(K);
#figure;
#imshow(K); title("Anh 2");

info_path = "info.txt";
info_mat = dlmread(info_path);
info_mat = info_mat(2:rows(info_mat), :);

G = K;


for i = 1:rows(info_mat)
  row = info_mat(i,:);
  major_axis_length = row(1);
  orientation = row(2);
  eccentricity = row(3);
  
  if (eccentricity < 0.8 || major_axis_length < 20 || major_axis_length>120 || orientation > -70)
    [row_indices, col_indices] = find(mat == i);
    for j = 1:rows(row_indices)
      G(row_indices(j), col_indices(j), :) = [0; 0; 0];
    endfor  
  endif   
endfor  

G = uint8(G); 
#figure;
#imshow(G); title("Anh 3");

figure;
subplot(1,2,1); imshow(K); title("Anh 2");
subplot(1,2,2); imshow(G); title("Anh 3");
print(strcat(output_path,"lab03_bai1_2.png"));






