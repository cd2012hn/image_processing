pkg load video;

video = "sky.avi";
info = aviinfo (video)
n_frames = info.NumFrames

%{
for i = 1:info.NumFrames-1
  string = int2str(i)
  concated = strcat("img",string,".jpeg")
  img = aviread(video,i);
  imwrite(img, concated)                  
end
%}
function J = median_filter_1(I)
  mean_filter = [0,1,1,1,0;
                1,2,2,2,1;
                1,1,5,1,1;
                1,2,2,2,1;
                0,1,1,1,0];
 
  I = rgb2gray(I);
  I = double(I);
  [m,n,n_channels] = size(I);
  J = zeros(m,n);
  
  for i = 1:m
    for j = 1:n
      s_u = max(i-2,1);
      s_v = max(j-2,1);
      e_u = min(i+2,m);
      e_v = min(j+2,n);
      
      sub_filter = mean_filter(s_u-i+3:e_u-i+3, s_v-j+3:e_v-j+3);
      n_elements = sum(sub_filter(:));
      mat = I(s_u:e_u,s_v:e_v) .* sub_filter;
      J(i,j) = sum(mat(:)) / n_elements;
    endfor
  endfor   
 
  J = uint8(j); 
endfunction

function J = median_filter_2(I)
  mean_filter = [0,1,1,1,0;
                1,2,2,2,1;
                1,1,5,1,1;
                1,2,2,2,1;
                0,1,1,1,0];
  n_elements = sum(mean_filter(:));
 
  #I = rgb2gray(I);
  #I = double(I);
  [m,n,n_channels] = size(I);
  J = zeros(m,n);
  
  padding = zeros(m+4, n+4);
  padding(3:m+2, 3:n+2) = double(rgb2gray(I));
  #padding(3:m+2, 3:n+2) = I;
  
  for i = 1:m
    for j = 1:n
      result_mat = padding(i:i+4,j:j+4) .* mean_filter;
      sum_elements = sum(result_mat(:));
      
      J(i,j) = sum_elements/n_elements;
    endfor
  endfor    
  
endfunction

video_output = avifile("test.avi", "codec", "msmpeg4v2", "fps", 15)

for i = 1:n_frames
  tic();
  img = aviread(video,i);  
  output = median_filter_2(img);
  addframe(video_output, output);
  toc();
end