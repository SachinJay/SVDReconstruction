%deconstructs filename and then reconstructs a rank n approximation for it
function reconstruct(filename,n)

%Read in the given image
A = double(imread(filename));

%Since this is a black and white image, the other layers are unimportant
B = A(:,:,1);

%Performs singular value deconstruction
[U,S,V] = svd(B);

%Stores the dimensions of B
a = size(B);

r= a(1);
c = a(2);

%construct a matrix of zeroes with the same size as B
approx = zeros(r,c);

%This constructs a rank n approximation for the matrix B
for i = 1:n
    approx =approx + (S(i,i) * U(:,i) * V(:,i)');
end

%Calculates what percent of the frobenius norm is captured by the
%approximation
disp(norm(approx,'fro')/norm(B,'fro'))

%Used for naming and storing the reconstructed image on my machine
p = num2str(n);
name = strcat('reconstruction',p);
name = strcat(name,'.jpg');
imwrite(uint8(approx),name);

end