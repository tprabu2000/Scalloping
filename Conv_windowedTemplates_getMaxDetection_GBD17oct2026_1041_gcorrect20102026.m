% Conv_windowedTemplates_getMaxDetection_GBD17oct2026_1041.m
%% float_plotSPEC_conv_with_windowedTemplate.m 07-10-2026
%% 
% cxft_with_chi_sq_normalisation.m
% Script reads in a .tim file which is the output of DDTR
% and performs the CXFT Fourier Transform with a Chi-Sq normalisation. 
% The resulant .dat file is the real and imaginary 32-bit IEEE 754 values
% that are the input observation to the FDAS FPGA
% The binary file is in little endian format as that is what is required
% for it to be read by the PC into memory. But when it is written to 
% the FDAS FPGA the 32-bit real and 32-bit imaginary values will be 
% big endian.
%
% Jon Taylor/Martin Droog Covnetics 09 Feb 2024

  clear; clf;
  readMetadata;
  %templates = templateGenerator(metadata);
  
  load our_new_templates.mat;

  filenames=readlines("./filelist.txt");
  nlines = length(filenames);
  
% for idx=1:nlines-1
%     idx
%     filenames{idx}
% end
   
% Step 1  
% Find all .tim files in the current directory
% timFiles = dir('*.tim');

% loc1 = zeros(nlines-1,85,2);
% loc2 = zeros(nlines-1,85,2);
% loc3 = zeros(nlines-1,85,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop through the .tim files to create the .dat files
for filek = 1:1:nlines-1 %length(timFiles)  
   
  % Input filename
      filename_in = filenames{filek} 
 
  %% tim-file data to be used for input
  % 
    %  
      fileID = fopen(filename_in);
      %timeSeries = single( fread(fileID, 2^23, 'float'));   % read 8 million samples
      timeSeries = single( fread(fileID, 2^23, 'uint8'));   % read 8 million samples
      fclose(fileID);
 
  %% Chi-sq normalization on time series
      timeSeries=timeSeries-mean(timeSeries);  %%Mean subtracted
      timeSeries=timeSeries/std(timeSeries);
      meantimeSeries = mean(timeSeries);
      stdtimeSeries = std(timeSeries);
      
      % timeSeries2 = zeros(length(timeSeries)*2,1); % zero pad one half
      % timeSeries2(1:length(timeSeries)) = timeSeries; 

      temp = sqrt(2)*fft(timeSeries)/sqrt(length(timeSeries)); % cxft  
      %temp = sqrt(2)*fft(timeSeries2)/sqrt(length(timeSeries)); % cxft  
  
    % Take only the first half of the FFT output
      halfSpectrum = temp(1:(length(temp)/2 + 1)); % input data
      
      ip1 = halfSpectrum;
      
      Nip = length(ip1)
  
  %}

  
  
  for idx=1:85
      FILE_TEMPL=[filek idx]
      temp_templ = templates{idx};
      ln = length(temp_templ);

      windows = [rectwin(ln), hamming(ln,"periodic"), hanning(ln,"periodic"), blackman(ln,"periodic"), chebwin(ln,30), chebwin(ln,60)];
      labels = ["Rectangle", "Hamming", "Hanning", "Blackman", "Chebyshev"];

      %%
      % equalise Hann kernel gains with first kernel
      % gain4w1 = sqrt(sum(abs(WKER_HANN(1,:)))./sum(abs(WKER_HANN(tdx,:))) );
      % Wker(2,:)  = Wker(2,:).*gain4hannk;


      % hw1 = hamming(ln);
      % hnw1 = hanning(ln);
      % 
      % templ2 = 1.15* (hw1.*templ1')';
      % templ3 = 1.15* (hnw1.*templ1')';
      
      templ0 = temp_templ;   
      templ1 = temp_templ.*windows(:,1)'; 
      templ2 = temp_templ.*windows(:,2)' ; 
      templ3 = temp_templ.*windows(:,3)' ; 
      templ4 = temp_templ.*windows(:,4)' ;  
      templ5 = temp_templ.*windows(:,5)' ;  
      templ6 = temp_templ.*windows(:,6)' ;  

       
      g1 = sqrt(sum((abs(fft(templ0))).^2))/sqrt(sum((abs(fft(templ1))).^2));
      g2 = sqrt(sum((abs(fft(templ0))).^2))/sqrt(sum((abs(fft(templ2))).^2));
      g3 = sqrt(sum((abs(fft(templ0))).^2))/sqrt(sum((abs(fft(templ3))).^2));
      g4 = sqrt(sum((abs(fft(templ0))).^2))/sqrt(sum((abs(fft(templ4))).^2));
      g5 = sqrt(sum((abs(fft(templ0))).^2))/sqrt(sum((abs(fft(templ5))).^2));
      g6 = sqrt(sum((abs(fft(templ0))).^2))/sqrt(sum((abs(fft(templ6))).^2));

      [ g1 g2 g3 g4 g5 g6 ]
     load iter1_gains4_templ_rect_han_ham_bm_cb30_cb60.mat; % gain correction factors - iteration-1
      g1 = g1*gfact2(2);
      g2 = g2*gfact2(3);
      g3 = g3*gfact2(4);
      g4 = g4*gfact2(5);
      g5 = g5*gfact2(6);
      g6 = g6*gfact2(7);
      [ g1 g2 g3 g4 g5 g6 ]

    load iter2_gains4_templ_rect_han_ham_bm_cb30_cb60.mat; % gain correction factors -iteration-2
      g1 = g1*gfact2(2);
      g2 = g2*gfact2(3);
      g3 = g3*gfact2(4);
      g4 = g4*gfact2(5);
      g5 = g5*gfact2(6);
      g6 = g6*gfact2(7);
      [ g1 g2 g3 g4 g5 g6 ]


      templ1 = templ1*g1 ; 
      templ2 = templ2*g2 ; 
      templ3 = templ3*g3 ; 
      templ4 = templ4*g4 ;  
      templ5 = templ5*g5 ;  
      templ6 = templ6*g6 ;  


      % convolve 
      cout0 = abs(conv(ip1, templ0, 'same')).^2;
      cout1 = abs(conv(ip1, templ1, 'same')).^2;
      cout2 = abs(conv(ip1, templ2, 'same')).^2;
      cout3 = abs(conv(ip1, templ3, 'same')).^2;
      cout4 = abs(conv(ip1, templ4, 'same')).^2;
      cout5 = abs(conv(ip1, templ5, 'same')).^2;
      cout6 = abs(conv(ip1, templ6, 'same')).^2;

      % find max detections 
      maxo0 = max(cout0);
      maxo1 = max(cout1);
      maxo2 = max(cout2);
      maxo3 = max(cout3);
      maxo4 = max(cout4);
      maxo5 = max(cout5);
      maxo6 = max(cout6);

      % find max detection locations 
      [a0,b0] = find( ismember(cout0, maxo0 ) );
      [a1,b1] = find( ismember(cout1, maxo1 ) );
      [a2,b2] = find( ismember(cout2, maxo2 ) );
      [a3,b3] = find( ismember(cout3, maxo3 ) );
      [a4,b4] = find( ismember(cout4, maxo4 ) );
      [a5,b5] = find( ismember(cout5, maxo5 ) );
      [a6,b6] = find( ismember(cout6, maxo6 ) );
      
      loc0(filek,idx,:) = [ a0, maxo0];
      loc1(filek,idx,:) = [ a1, maxo1];
      loc2(filek,idx,:) = [ a2, maxo2];
      loc3(filek,idx,:) = [ a3, maxo3];
      loc4(filek,idx,:) = [ a4, maxo4];
      loc5(filek,idx,:) = [ a5, maxo5];
      loc6(filek,idx,:) = [ a6, maxo6];
       
      
  end

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end



save ('files40_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026e.mat',"loc0","loc1","loc2", "loc3","loc4","loc5","loc6");

figure (1); clf
subplot(1,7,1); plot(10*log10((loc0(:,:,2)'./( max(max(loc0(:,:,2)') ))))); xlim([1 45]); grid on; ylabel('Detected MAx Power (dB)'); xlabel('Template');title('Weight-0 - Rectangle');
subplot(1,7,2); plot(10*log10((loc1(:,:,2)'./( max(max(loc1(:,:,2)') ))))); xlim([1 45]); grid on; ylabel('Detected MAx Power (dB)'); xlabel('Template');title('Weight-1 - Rectangle');
subplot(1,7,3); plot(10*log10((loc2(:,:,2)'./( max(max(loc2(:,:,2)') ))))); xlim([1 45]); grid on; ylabel('Detected MAx Power (dB)'); xlabel('Template');title('Weight-2 - hann');
subplot(1,7,4); plot(10*log10((loc3(:,:,2)'./( max(max(loc3(:,:,2)') ))))); xlim([1 45]); grid on; ylabel('Detected MAx Power (dB)'); xlabel('Template');title('Weight-3 - hamm');
subplot(1,7,5); plot(10*log10((loc4(:,:,2)'./( max(max(loc4(:,:,2)') ))))); xlim([1 45]); grid on; ylabel('Detected MAx Power (dB)'); xlabel('Template');title('Weight-4 - Blackman');
subplot(1,7,6); plot(10*log10((loc5(:,:,2)'./( max(max(loc5(:,:,2)') ))))); xlim([1 45]); grid on; ylabel('Detected MAx Power (dB)'); xlabel('Template');title('Weight-5 - Chebyshev30dB');
subplot(1,7,7); plot(10*log10((loc6(:,:,2)'./( max(max(loc6(:,:,2)') ))))); xlim([1 45]); grid on; ylabel('Detected MAx Power (dB)'); xlabel('Template');title('Weight-6 - Chebyshev60dB');
