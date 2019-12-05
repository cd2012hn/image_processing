output_path = "ketqua/";

I = imread("fence.png");
G = imread("noiseSP.png");

figure;
subplot(1,2,1); imshow(I); title("Anh I");
subplot(1,2,2); imshow(G); title("Anh nhieu G");
print(strcat(output_path,"lab03_bai2_1.png"));

[m,n,n_channels] = size(I);

N = zeros(m,n,n_channels);

G2 = uint8(G);
G2(G2 == 1) = 255;

for b=1:n_channels
  N(:,:,b) = I(:,:,b) + G2;
  # N(:,:,b) = bitor(I(:,:,b), G2);
endfor
N = uint8(N);

figure;
imshow(N);title("Anh nhieu");
print(strcat(output_path,"lab03_bai2_2.png"));
