output_path = "ketqua/";
image_path = "barCodesDetection.png";
I = imread(image_path);
I = rgb2gray(I);

bi_img = I<120;
figure;
imshow(bi_img); title("Anh nhi phan");

[m,n,n_channels] = size(bi_img);

function [K, region_count] = loang(padding_mat, trace, u, v, cur_region)
  current_pad = padding_mat(u-1:u+1,v-1:v+1);
  count = sum( current_pad(:) );
  
  if (padding_mat(u,v) == 1 & trace(u,v) == 0 && count > 1)
    cur_region = cur_region + 1;
    trace(u,v) = cur_region;
    
    stack_size = 1;
    ptr = 1;
    stack = [u,v];
    # [m,n,n_channels] = size(padding_mat);
    while (ptr <= stack_size)
      line = stack(ptr, :);
      row = line(1);
      col = line(2);
      [row, col];
      if (stack_size>1)
        stack = stack(2:stack_size,:);
      else
        stack = [];
      endif
      stack_size = stack_size - 1;
      
      #stack = stack(2:size(stack)(2),:);
      current_pad = padding_mat(row-1:row+1,col-1:col+1);
      current_trace = trace(row-1:row+1,col-1:col+1);
      count = sum( current_pad(:) );
      
      if (count > 1)
        [pad_row_indices, pad_col_indices, pad_values] = find(current_pad);
        [trace_row_indices, trace_col_indices, trace_values] = find(current_trace==0);
        
        [row_indices, col_indices] = intersect([pad_row_indices, pad_col_indices], [trace_row_indices, trace_col_indices], "rows");
        for i = 1:size(row_indices)
          stack = [stack; row-2+row_indices(i), col-2+col_indices(i)];
          trace(row-2+row_indices(i),col-2+col_indices(i)) = cur_region;
          stack_size = stack_size+1;
        endfor
      endif
      
      ptr = ptr+1;
      [ptr, stack_size]
  
    endwhile
    
    K = trace;
    region_count = cur_region
  else
    K = [];
    region_count = cur_region;
  endif
  

endfunction

function K = region_color(bi_img)
  [m,n,n_channels] = size(bi_img);
  padding_mat = zeros(m+2, n+2);
  padding_mat(2:m+1, 2:n+1) = bi_img;
  trace_mat = zeros(m+2, n+2);
  
  cur_region = 0;
  
  for i = 2:m+1
    for j = 2:n+1
      [mat, next_region] = loang(padding_mat, trace_mat, i, j, cur_region);
      if cur_region < next_region
        trace_mat = mat;
        cur_region = next_region;
      endif
    endfor
  endfor
  
  K = trace_mat(2:m+1, 2:n+1);
endfunction

K = region_color(bi_img);

