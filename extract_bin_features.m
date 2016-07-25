function [ means, stds, rmss, daytime] = extract_bin_features( arr, dates, inds )
% Get mean, std. dev, energy, and RMS for each input bin.
% These are used later for machine learning.

bins = binify(arr,size,edge);

means = zeros(length(bins), 1);
stds = means;
rmss = means;
daytime = logical(means);

parfor i=1:length(bins)
   bin = bins{i}{1};
   means(i) = sum(mean(bin)); 
   stds(i)  = sum(std(bin)); 
   rmss(i)  = sum(rms(bin));
   
   hr = hour(bins{i}{2});
   daytime(i) = (hr > 8) & (hr < 16);
end

nighttime = ~daytime;

hold on
scatter3(means(daytime), stds(daytime), rmss(daytime), 3, 'r');
scatter3(means(nighttime), stds(nighttime), rmss(nighttime), 3, 'b');
xlabel('Mean');
ylabel('Std. Dev');
zlabel('RMS');
title('Statistical Measures of Each Bin');
hold off

end
