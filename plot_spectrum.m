function spectrum_plot( data, sampling_rate)
%input data and sampling rate in Hz, returns data filtered with a high pass
%brick wall filter

%preform and plot DFT
ftz=fft(data); %preform foward DFT
abs_fty=abs(ftz); %find absolute value
spectrum_freq=fourier_frequencies(sampling_rate, length(data)); %find freq
% remove negative frequencies
neg = spectrum_freq < 0;
abs_fty(neg) = [];
spectrum_freq(neg) = [];

% % We're looking for peaks beyond the DC offset, so we ignore
% % everything below 2Hz. We also want wide peaks.
% peak_width = find(spectrum_freq >= 0.001, 1);
% tail_range = spectrum_freq > 2;
% [peaks,inds] = findpeaks(double(abs_fty), 'MinPeakWidth', peak_width);
% 
% disp(strcat(num2str(length(peaks)), ' peaks found.'));
% table(spectrum_freq(inds), peaks)

figure(2);
hold on
plot(spectrum_freq,abs_fty) %dft
set(gca,'yscale','log')
xlabel('Frequency(Hz)')
ylabel('FFT amplitude')
title('Logarithmic Frequency Response');
hold off

end