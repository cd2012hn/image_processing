imagePath = 'GreenVietnam.png';

I = imread(imagePath);

function P = pixelization(img)
  s=8;
  [n_rows, n_cols, n_channels] = size(img);
  J = zeros(round(n_rows / s), round(n_cols / s), 3);

  for b = 1:3
    for r = 1:(n_rows/s - 1)
      for c = 1:(n_cols/s - 1)
        #mean = 0;
        #
        #for p = (r*s) : ((r+1) * s - 1)
        #  for x = (c*s) : ((c+1) *s - 1)
        #    #printf("I(%d,%d,%d) = %d\n", p, x, b, img(p,x,b));
        #    num = double(img(p,x,b));   
        #    mean = mean + num;
        #  endfor
        #endfor
        start_row = r*s;
        end_row = (r+1)*s - 1;
        start_col = c*s;
        end_col = (c+1)*s - 1;
        n_element = (end_row - start_row + 1) * (end_col - start_col + 1);
        sum_m = sum(img(start_row:end_row, start_col:end_col, b)(:));
        J(r,c,b) = sum_m / n_element;
      endfor
    endfor
  endfor
  
  J = uint8(J);
  P = J;  
endfunction

P = pixelization(I);
figure;
imshow(P);
title('Pixel');
