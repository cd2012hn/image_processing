output_folder = "ketqua/";
if !exist(output_folder, 'dir')
   mkdir(output_folder);
end


I = imread("Image25.jpg");
Im = rgb2gray(I);
#figure;
#subplot(1,2,1); imshow(Im);

function J = median_filter(I)
  filter = [0,1,1,1,0;
                1,2,2,2,1;
                1,1,5,1,1;
                1,2,2,2,1;
                0,1,1,1,0];
 
  n_elements = sum(filter(:));
  #arr = ones(1,n_elements);
  
  I = rgb2gray(I);
  I = double(I);
  [m,n,n_channels] = size(I);
  padding = zeros(m+4,n+4);
  padding(3:m+2,3:n+2) = I;
  J = zeros(m,n);

  for i = 1:m
    for j = 1:n
      %{
      s_u = max(i-2,1);
      s_v = max(j-2,1);
      e_u = min(i+2,m);
      e_v = min(j+2,n);
      
      sub_filter = mean_filter(s_u-i+3:e_u-i+3, s_v-j+3:e_v-j+3);
      
      arr = [];
      for u = s_u : e_u
        for v = s_v : e_v
          arr = [arr, ones(1, sub_filter(u-s_u+1, v-s_v+1)) * I(u, v)];
        endfor
      endfor
      %}
      
      mat = padding(i:i+4, j:j+4);
      ptr = 1;
      arr = ones(1,n_elements);
      
      for idx = 1:25
        n_times = filter(idx);
        if n_times
          arr(ptr:ptr+n_times-1) *= mat(idx);
          #arr(ptr:ptr+n_times-1) = mat(idx)(ones(1, n_times));
          ptr += n_times;
        endif 
      endfor

      
      J(i,j) = median(arr);
    endfor
  endfor   
  
  J = uint8(J); 
endfunction


%{
tic();
J = median_filter_1(I);
toc();
%}
tic();
K = median_filter(I);
toc();
figure;
imshow(K);
print(strcat(output_folder,"/lab05_bai1.png"));
