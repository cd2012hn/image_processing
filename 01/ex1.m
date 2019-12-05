rgb_path = 'lion.jpg';
hsv_path = 'lionHSV.jpg';

rgb_image = imread(rgb_path);
hsv_image = imread(hsv_path);

function bai1(rgb_image, hsv_image)
  figure;
  subplot(2,1,1);
  imshow(rgb_image);
  title('Anh 1');
  subplot(2,1,2);
  imshow(hsv_image);
  title('Anh 2');
endfunction  

function bai2(hsv_img)
  [n_rows, n_cols, n_channels] = size(hsv_img);
  jh = hsv_img(:,:,1);

  result = zeros(n_rows, n_cols);
  for i = 1:n_rows
    for j = 1:n_cols
      pixel_val = double(jh(i,j)) / 255;
      if (pixel_val > 0.22 && pixel_val < 0.45)
         result(i,j) = 255;
      endif
    endfor
  endfor 
  
  figure;
  imshow(result);
  title('Bai 2');
endfunction  



function K = ChromaKeying(m, n, vector_t, vector_b)
	id = find(vector_b);
	result = zeros(m,n,3);
	for b = 1:3
		for index = 1:size(id)
			vector_t(id(index), b) = 0;
		endfor
		for j = 1:n
			count = 1;
			for i = ((j-1)*m + 1) : (j * m)
				result(count, j, b) = vector_t(i, b);
			  count += 1;
      endfor
		endfor
	endfor
	
	result = uint8(result);
	K = result;
endfunction


function bai3(image)
  [m n channel] = size(image);
  file_data = dlmread("data.txt");
  vector_t = file_data(:, 1:3);
  vector_b = file_data(:, 4);

  new_img = ChromaKeying(m, n, vector_t, vector_b);
  figure;
  imshow(new_img);
  title('Bai 3');
endfunction  

bai1(rgb_image, hsv_image);
%bai2(hsv_image);
%bai3(rgb_image);




