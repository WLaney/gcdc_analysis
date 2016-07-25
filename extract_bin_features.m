function [ means, stds, rmss ] = extract_bin_features( arr, size, edge )
% Get mean, std. dev, energy, and RMS for each input bin.
% These are used later for machine learning.

bins = binify(arr,size,edge);

means = zeros(length(bins), 1);
stds = means;
rmss = means;

parfor i=1:length(bins)
   bin = bins{i};
   means(i) = sum(mean(bin)); 
   stds(i)  = sum(std(bin)); 
   rmss(i)  = sum(rms(bin)); 
end

scatter3(means,stds,rmss);
xlabel('Mean');
ylabel('Std Dev');
zlabel('RMS');

end
