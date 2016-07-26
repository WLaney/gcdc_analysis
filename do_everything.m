%% Get features for the Machine Analysis app
% Constants
DATA_MAT = 'big_data/AccelC'; % accel, inds, times
BIN_SIZE = 512;
BIN_EDGE = 128;

load(DATA_MAT);
inds = binify_monolithic(accel, BIN_SIZE, BIN_EDGE);
[means,stds,rmss,daytime] = extract_bin_features(accel, times, inds);

final_array = [means,stds,rmss,daytime];