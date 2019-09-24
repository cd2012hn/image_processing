% load thu vien
pkg load image

% khai bao ham

function display_image (image, image_title)
	figure
	imshow(image)
	title(image_title)
endfunction

function gray_histogram = caculate_gray_image_histogram (gray_image, range)
	if (ndims(gray_image) != 2)
		error ('not 2d matrix');
	endif
	
	gray_hist = zeros(range, 1);
	for i = 1:rows(gray_image)
		for j = 1:columns(gray_image)
			pixel_val = gray_image(i,j);
			gray_hist(pixel_val+1)++;
		endfor
	endfor
	
	gray_histogram = gray_hist;
endfunction

function color_histogram = caculate_color_image_histogram (color_image, range)
	if (ndims(color_image) != 3)
		error ('Not 3d matrix');
	endif
	
	color_hist = zeros(range, 3);
	for i = 1:rows(color_image)
		for j = 1:columns(color_image)
			for channel = 1:3
				pixel_val = color_image(i, j, channel);
				color_hist(pixel_val+1, channel) ++;
			endfor
		endfor
	endfor
	
	color_histogram = color_hist;
endfunction

function display_color_histogram(matrix, hist_title, color)
	colors = {'r', 'g', 'b'};
	contain_color = any(strcmp(colors, color));
  
	if (! contain_color)
		error ('Wrong color argument');
	endif

	figure
	h = bar(matrix, 'hist');
	set(h, 'facecolor', color, 'edgecolor', color);
	title(hist_title);
  
endfunction

function display_gray_histogram(matrix, hist_title)
	figure
    h = bar(matrix, 'hist');
    set(h, 'ydata');
    title(hist_title);
endfunction

function result_img = increase_brightness(color_img, range, g)
	if (g<0 || g>255)
		error ('Illegal Argument Exception: g must be large then 0 and less than 255');
	endif
	
	lut = zeros(range);
	for u = 1:range
		new_val = u + g - 1;
		if (new_val > 255)
			new_val = 255;
		endif
		lut(u) = new_val;
	endfor
	
	n_rows = rows(color_img);
	n_cols = columns(color_img);
	temp_img = zeros(n_rows, n_cols, 3);
	
	for i = 1:n_rows
		for j = 1:n_cols
			for channel = 1:3
				pixel_val = color_img(i, j, channel);
				temp_img(i, j, channel) = lut(pixel_val+1);
			endfor
		endfor
	endfor
	
	if (range == 16)
		temp_img = uint4(temp_img);
	elseif (range == 256)
		temp_img = uint8(temp_img);
	else 
		temp_img = uint16(temp_img);
	endif
	
	result_img = temp_img;
endfunction

function result_img = decrease_brightness(color_img, range, g)
	if (g<0 || g>255)
		error ('Illegal Argument Exception: g must be large then 0 and less than 255');
	endif
	
	lut = zeros(range);
	for u = 1:range
		new_val = u - g - 1;
		if (new_val < 0)
			new_val = 0;
		endif
		lut(u) = new_val;
	endfor
	
	n_rows = rows(color_img);
	n_cols = columns(color_img);
	temp_img = zeros(n_rows, n_cols, 3);
	
	for i = 1:n_rows
		for j = 1:n_cols
			for channel = 1:3
				pixel_val = color_img(i, j, channel);
				temp_img(i, j, channel) = lut(pixel_val+1);
			endfor
		endfor
	endfor
	
	if (range == 16)
		temp_img = uint4(temp_img);
	elseif (range == 256)
		temp_img = uint8(temp_img);
	else 
		temp_img = uint16(temp_img);
	endif
	
	result_img = temp_img;
endfunction

function result_img = increase_constrast(color_img, range, a, s)
	if (s<0 || s>255)
		error ('Illegal Argument Exception: s must be large then 0 and less than 255');
	endif
	
	if (a < 1.0)
		error ('Illegal Argument Exception: a must be large than 1.0');
	endif
	
	lut = zeros(range);
	for u = 1:range
		new_val = new_val = a * ( u - 1  - s ) + s;
		if (new_val > 255)
			new_val = 255;
		elseif (new_val < 0) 
			new_val = 0;
		endif
		lut(u) = new_val;
	endfor
	
	n_rows = rows(color_img);
	n_cols = columns(color_img);
	temp_img = zeros(n_rows, n_cols, 3);
	
	for i = 1:n_rows
		for j = 1:n_cols
			for channel = 1:3
				pixel_val = color_img(i, j, channel);
				temp_img(i, j, channel) = lut(pixel_val+1);
			endfor
		endfor
	endfor
	
	if (range == 16)
		temp_img = uint4(temp_img);
	elseif (range == 256)
		temp_img = uint8(temp_img);
	else 
		temp_img = uint16(temp_img);
	endif
	
	result_img = temp_img;
endfunction

function result_img = decrease_constrast(color_img, range, a, s)
	if (s<0 || s>255)
		error ('Illegal Argument Exception: s must be large then 0 and less than 255');
	endif
	
	if (a<=0 || a>=1)
		error ('Illegal Argument Exception: a must be large than 0 and less than 1');
	endif
	
	lut = zeros(range);
	for u = 1:range
		new_val = a * ( u - 1 - s ) + s;
		lut(u) = new_val;
	endfor
	
  
	n_rows = rows(color_img);
	n_cols = columns(color_img);
	temp_img = zeros(n_rows, n_cols, 3);
	
	for i = 1:n_rows
		for j = 1:n_cols
			for channel = 1:3
				pixel_val = color_img(i, j, channel);
				temp_img(i, j, channel) = lut(pixel_val+1);
			endfor
		endfor
	endfor
	
	if (range == 16)
		temp_img = uint4(temp_img);
	elseif (range == 256)
		temp_img = uint8(temp_img);
	else 
		temp_img = uint16(temp_img);
	endif
	
	result_img = temp_img;
endfunction

function result_img = adjust_gamma(color_img, range, gamma)
	
	lut = zeros(range);
	for u = 1:range
		new_val = 255 * (((u - 1)/255) ** (1 / gamma) );
		lut(u) = new_val;
	endfor
	
	n_rows = rows(color_img);
	n_cols = columns(color_img);
	temp_img = zeros(n_rows, n_cols, 3);
	
	for i = 1:n_rows
		for j = 1:n_cols
			for channel = 1:3
				pixel_val = color_img(i, j, channel);
				temp_img(i, j, channel) = lut(pixel_val+1);
			endfor
		endfor
	endfor
	
	if (range == 16)
		temp_img = uint4(temp_img);
	elseif (range == 256)
		temp_img = uint8(temp_img);
	else 
		temp_img = uint16(temp_img);
	endif
	
	result_img = temp_img;
endfunction


% =======================================

% doc anh
file_name = 'anhmau4.png';

info = imfinfo(file_name);
depth = info.BitDepth;
range = 2 ** depth;

org_img = imread(file_name);

% display anh
display_image(org_img, 'Original Image')

% chuyen anh mau thanh anh den trang
%gray_img = rgb2gray(org_img);

% tinh hist cua anh den trang
%gray_hist = caculate_gray_image_histogram(gray_img, range);

%display_gray_histogram(gray_hist, 'Histogram of gray image');

% tinh hist cua anh mau
%color_hist = caculate_color_image_histogram(org_img, range);

%display_color_histogram(color_hist(:,1), 'Histogram of Red', 'r');
%display_color_histogram(color_hist(:,2), 'Histogram of Green', 'g');
%display_color_histogram(color_hist(:,3), 'Histogram of Blue', 'b');

% tinh anh value
%value_image = org_img(:,:,1)/3 + org_img(:,:,2)/3 + org_img(:,:,3)/3;
%display_image(value_image, 'Value image');

% tinh anh luminance
%luminance = org_img(:,:,1)*0.299 + org_img(:,:,2)*0.587 + org_img(:,:,3)*0.114;
%display_image(luminance, 'luminance image');

% tang do sang
%new_img = increase_brightness(org_img, range, 250);
%display_image(new_img, 'Increase Brightness');

% tang do tuong phan
%new_img = increase_constrast(org_img, range, 2.5, 128);
%display_image(new_img, 'Increase Contrast');

% tang do gamma
new_img = adjust_gamma(org_img, range, 2);
display_image(new_img, 'Increase Gamma');
