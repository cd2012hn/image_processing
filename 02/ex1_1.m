pkg load image;
tic();
I = imread("GreenVietnam.png");

function J = bai1(img)
  filter = [0, -1, 0; -1, 5, -1; 0, -1, 0];
  [n_rows, n_cols, n_channels] = size(img);
  padding_img = zeros(n_rows+2, n_cols+2, 3);
  padding_img(2:n_rows+1, 2:n_cols+1,:) = img(:,:,:);
  
  # org_hist = zeros(255, 3);
  # result_hist = zeros(255, 3);
  # padding_img = uint8(padding_img);
  
  J = zeros(n_rows, n_cols, 3);
  
  for b = 1:n_channels
    for i = 1:n_rows
      for j = 1:n_cols
        #sum = 0;
        #for u = i:i+2
        #  for v = j:j+2
        #    sum += padding_img(u,v,b) * filter(u-i+1, v-j+1);
        #  endfor
        #endfor
        #J(i,j,b) = sum + img(i,j,b); 
        
        mat = padding_img(i:i+2, j:j+2, b) .* filter;
        #org_val = img(i,j,b);
        #result_val = sum(mat(:,:)(:)) + org_val;
        #J(i,j,b) = result_val;
        
        #org_hist(org_val+1, b) = org_hist(org_val+1, b) + 1;
        #result_hist(result_val+1, b) = result_hist(result_val+1,b) + 1;
        
        J(i,j,b) = sum(mat(:,:)(:));
      endfor
    endfor
    
  endfor
  
  J = uint8(J) + img;
endfunction

 
S = bai1(I);

figure;
subplot(4,2,1); imshow(I); title("Org Img");
subplot(4,2,2); imshow(S); title("Result Img");
#subplot(4,2,3); set(bar(org_hist(:,1), 'hist'), 'facecolor', 'r', 'edgecolor', 'r'); title("Org R"); 
#subplot(4,2,5); set(bar(org_hist(:,2), 'hist'), 'facecolor', 'g', 'edgecolor', 'g'); title("Org G");
#subplot(4,2,7); set(bar(org_hist(:,3), 'hist'), 'facecolor', 'b', 'edgecolor', 'b'); title("Org B");
#subplot(4,2,4); set(bar(result_hist(:,1), 'hist'), 'facecolor', 'r', 'edgecolor', 'r'); title("Result R"); 
#subplot(4,2,6); set(bar(result_hist(:,2), 'hist'), 'facecolor', 'g', 'edgecolor', 'g'); title("Result G");
#subplot(4,2,8); set(bar(result_hist(:,3), 'hist'), 'facecolor', 'b', 'edgecolor', 'b'); title("Result B");

# Histogram anh I
Red = I(:,:,1);
Green = I(:,:,2);
Blue = I(:,:,3);
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
subplot(4,2,3); set(bar(yRed, 'hist'), 'facecolor', 'r', 'edgecolor', 'r'); title("Org R"); 
subplot(4,2,5); set(bar(yGreen, 'hist'), 'facecolor', 'g', 'edgecolor', 'g'); title("Org G");
subplot(4,2,7); set(bar(yBlue, 'hist'), 'facecolor', 'b', 'edgecolor', 'b'); title("Org B");

#subplot(2,2,3); plot(x, yRed, 'r', x, yGreen, 'g', x, yBlue, 'b'); title("Histogram anh I");


Red = S(:,:,1);
Green = S(:,:,2);
Blue = S(:,:,3);
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);
subplot(4,2,4); set(bar(yRed, 'hist'), 'facecolor', 'r', 'edgecolor', 'r'); title("Result R"); 
subplot(4,2,6); set(bar(yGreen, 'hist'), 'facecolor', 'g', 'edgecolor', 'g'); title("Result G");
subplot(4,2,8); set(bar(yBlue, 'hist'), 'facecolor', 'b', 'edgecolor', 'b'); title("Result B");

# Histogram anh S

#subplot(2,2,4); plot(x, yRed, 'r', x, yGreen, 'g', x, yBlue, 'b'); title("Histogram anh S");


toc();