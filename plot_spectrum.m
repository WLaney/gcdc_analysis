function spectrum_plot( data, sampling_rate)
% Plot the DFT spectrum of a block of data with a given sample rate.
% Some effort has been made to find the 

%% Get DFT
spectrum_freq=fourier_frequencies(sampling_rate, length(data));
ftz=fft(data);
abs_fty=abs(ftz);
% Remove negative results
zero_cross = find(spectrum_freq<0,1)
spectrum_freq(zero_cross:end) = [];
abs_fty(zero_cross:end,:) = [];

%% Peak Extraction
% % We're looking for peaks beyond the DC offset, so we ignore
% % everything below 2Hz. We also want wide peaks.
% peak_width = find(spectrum_freq >= 0.001, 1);
% tail_range = spectrum_freq > 2;
% [peaks,inds] = findpeaks(double(abs_fty), 'MinPeakWidth', peak_width);
% 
% disp(strcat(num2str(length(peaks)), ' peaks found.'));
% table(spectrum_freq(inds), peaks)

%% Plotting
% Make a subplot for each thingamajigger
figure(2);
hold on
plot(spectrum_freq,abs_fty)
set(gca,'yscale','log')
xlabel('Frequency(Hz)')
ylabel('FFT amplitude')
title('Frequency Response');
hold off

end