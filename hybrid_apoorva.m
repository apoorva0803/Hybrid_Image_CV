clc; clear; close all;

image1 = im2single(imread('images\cat.bmp'));
image2 = im2single(imread('images\dog.bmp'));      

image3 = im2single(imread('images\img1.JPG'));
image4 = im2single(imread('images\img2.JPG'));      

%Transform the image to have head coincide
image3 = imrotate(image3, 270);
image4 = imrotate(image4, 270);

shifted = zeros(size(image4));
shifted(:, 25:end,:) = image4(:,1:end-24,:);

image4 = shifted;

image3 = rgb2gray(image3);
image4 = rgb2gray(image4);

image6 = rgb2gray(im2single(imread('images\ld1.JPG'))); % child
image5 = rgb2gray(im2single(imread('images\ld2.jpg'))); % adult     

im_cell = {image6, image5, image4, image3, image2, image1};

% Sigma
im_sigma = {4,9,5,25,5,15};

im_title ={'Change in time','Change of hand direction','Cat and Dog'};
im_input2 ={'Grown up','Both hand upwards', 'Cat'};
im_input1 ={'Childhood picture','Hand over railing', 'Dog'};

t = 0;
for k=1:2:length(im_cell)
   
    cut_off_frequency = cell2mat(im_sigma(k));
    cut_off_frequency2 = cell2mat(im_sigma(k+1));
   
    %size of window
    w1 = floor(2.5 * cut_off_frequency - 0.5);
    w2 = floor(2.5 * cut_off_frequency2 - 0.5);

    filter = fspecial('Gaussian', w1, cut_off_frequency);
    filter2 = fspecial('Gaussian', w2, cut_off_frequency2);
    
    img1 = cell2mat(im_cell(k));
    img2 = cell2mat(im_cell(k+1));
    
    low_frequency = imfilter(img1, filter);
    high_frequency = img2 - imfilter(img2, filter2);
    
    hybrid_image = low_frequency + high_frequency;
    
    figure, imshow(img1), title(im_input1(t+1));
    figure, imshow(img2), title(im_input2(t+1));
    figure, imshow(hybrid_image),title(im_title(t+1));
    t = t + 1;
end
