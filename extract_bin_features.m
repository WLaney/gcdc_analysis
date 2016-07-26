function [ means, stds, rmss, daytime] = extract_bin_features( accel, times, inds )
% Get mean, std. dev, energy, and RMS for each input bin.
% These are used later for machine learning.

means = zeros(length(inds), 3);
stds = means;
rmss = means;
daytime = false(length(inds),1);

disp('Binify:');
tic
bins = cell(length(inds),1);
for i=1:length(inds)
    bins{i} = {single(accel(inds(i,1):inds(i,2),:)), times(inds(i,1))};
end
toc

disp('Stat analysis:');
tic
for i=1:length(bins)
   bin = bins{i}{1};
   means(i,:) = mean(bin); 
   stds(i,:)  = std(bin); 
   rmss(i,:)  = rms(bin);
   
   hr = hour(bins{i}{2});
   daytime(i) = (hr > 8) & (hr < 16);
end
toc

end