function [ bins ] = binify_2( arr, size, edge )
% Split arr into a cell array of overlapping bins.
% This should be inlined into extract_bin_features once we've got it
% working.
ind_length = floor(length(arr)/size);
bins = cell(ind_length,1);
bins{1} = arr(1:(size+edge));
for i=2:(length(bins)-1)
    bins{i} = arr((size * (i-1) - edge + 1) : ...
                  (size * (i) + edge));
end

bins{end} = [bins{end-1}+1, length(arr)];

end