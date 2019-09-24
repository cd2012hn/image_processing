% load thu vien
pkg load image

% doc anh
file_name = 'anhmau4.png';

info = imfinfo(file_name);
depth = info.BitDepth;
range = 2 ** depth;

dim = ndims(ones(2,2))

org_img = imread(file_name);

% display anh
figure
imshow(org_img)
title('Anh goc')

% chuyen anh mau thanh anh den trang
gray_img = rgb2gray(org_img);

% tinh hist cua anh den trang
gray_hist = zeros(range, 1)
for i = 1:rows(gray_img)
   for j = 1:columns(gray_img)
     gray_hist( gray_img(i, j) + 1) += 1;
   endfor
endfor
    
gray_hist;

figure
h = bar(gray_hist, 'hist');
set(h, 'ydata')
title('Histogram of gray image')

% tinh hist cua anh mau
color_hist = zeros(range, 3)
for i = 1:rows(org_img)
  for j = 1:columns(org_img)
    for channel = 1:3
      pixel_value = org_img(i, j, channel);
      color_hist(pixel_value + 1 , channel) += 1;
    endfor
  endfor
endfor

figure
h = bar(color_hist(:,1), 'hist', 'facecolor', 'r', 'edgecolor', 'r');
set(h, 'ydata')
title('Histogram of red')

figure
h = bar(color_hist(:,2), 'hist', 'facecolor', 'g', 'edgecolor', 'g');
set(h, 'ydata')
title('Histogram of green')

figure
h = bar(color_hist(:,3), 'hist', 'facecolor', 'b', 'edgecolor', 'b');
set(h, 'ydata')
title('Histogram of blue') 

% tinh anh value
value_image = org_img(:,:,1)/3 + org_img(:,:,2)/3 + org_img(:,:,3)/3;

figure
imshow(value_image)
title('Value image')

