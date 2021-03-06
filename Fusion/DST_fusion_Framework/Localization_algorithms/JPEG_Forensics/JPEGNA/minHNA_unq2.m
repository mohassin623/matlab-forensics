function [minH1, k1, k2] = minHNA_unq2(I)
%
% Computation of features able to detect the presence of non-aligned 
% double JPEG compression (NA-JPEG) as described in T. Bianchi and A. Piva,
% "Detection of Non-Aligned Double JPEG Compression Based on Integer 
% Periodicity Maps", IEEE Trans. Forensics Security.
%
% Matlab JPEG Toolbox is required, available at: 
% http://www.philsallee.com/jpegtbx/index.html
% 
% im:       jpeg object from jpeg_read of Matlab JPEG Toolbox
% ncomp:    index of color component to be used (1 = Y, 2 = Cb, 3 = Cr)
%
% minH1:    smaller min-entropy of IPM such that maximum of IPM is not at
%           (0,0)
% minH2:    min-entropy of DIPM


% coeffArray = im.coef_arrays{ncomp};
% qtable = im.quant_tables{im.comp_info(ncomp).quant_tbl_no};
% minQ = max(2, floor(qtable/sqrt(3)));
% maxQ = max(16, qtable);
minQ = 2;
maxQ = 16;
% simulate decompression
% I = ibdct(dequantize(coeffArray, qtable));
% compute DC coefficients for all shifts
A = zeros(16);
A(1:2:end,1:2:end) = 1/8;
DC = conv2(imresize(I, 2, 'bilinear'), A);
DC = DC(16:end,16:end);
Qmap = zeros(16,16,maxQ(1,1)-minQ(1,1)+1);

binHist = (-2^11:1:2^11-1);
periods = minQ(1,1):maxQ(1,1);
% define DFT matrix for frequencies corresponding to integer periods
harmfreq = 1./periods;
IPDFT = exp(-2*pi*i* binHist' * harmfreq);

for k1 = 1:16
    for k2 = 1:16
        % get DC coefficients for shift k1, k2
        DCpoly = DC(k1:16:end,k2:16:end);
        num4Bin = hist(DCpoly(:),binHist);
        % compute DFT of histogram of DC coeffs
        hspec = abs(num4Bin * IPDFT);
        Qmap(k1,k2,:) = hspec;
    end
end

minH1 = 8;
for k = 1:length(periods)
    Qmaptmp = Qmap(:,:,k);
    % compute IPM
    minH = min(-log2(Qmaptmp(:)/sum(Qmaptmp(:))));
    if minH < minH1
        % record minimum value of minH 
        [m1,i1] = max(Qmaptmp);
        [m2,i2] = max(m1);

        minH1 = minH;
    end
end

minH1 = minH1/8;
k1 = i1(i2);
k2 = i2;

return