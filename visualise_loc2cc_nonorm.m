
% analyse max detections

clear;
clf;

% files40_maxdet_13102026_rect_blackmann_chebey_winows_14oct2026v1.mat
% load  files40_maxdet_13102026_rect_blackmann_chebey_winows_14oct2026v1.mat
% load files40_maxdet_13102026_rect_hann_hamm_blackmann_chebey_winows_17oct2026.mat

% load files4_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey13_winows_19oct2026.mat
% load files4_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026b.mat
% load files4_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026c.mat

%load files4_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026d.mat
load files40_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026e.mat

% ./max(loc0(idx,:,2))
% ./max(loc1(idx,:,2))
% ./max(loc2(idx,:,2))
% ./max(loc3(idx,:,2))
% ./max(loc4(idx,:,2))
% ./max(loc5(idx,:,2))
% ./max(loc6(idx,:,2))

for startId=1:9
    clf;
step=10;

for  idx=startId:step:40
    [idx]
    
      
    if idx == startId
        [idx]
  		  subplot(4, 7,1); plot(loc0(idx,:,2) ,'r'); hold on; grid;  legend(num2str(idx)) ; axis tight; title('templ'); ylabel("TV1 - max detection")
		 % title( strcat("File: ",num2str(idx)) );  %ylim([0 370])
		 subplot(4, 7,2);   plot(loc1(idx,:,2)  ,'r');   hold on; grid;   axis tight; title('Rectangle')
		 subplot(4, 7,3); plot(loc2(idx,:,2)  ,'b');   hold on; grid;   axis tight; title('HAMM')
		 subplot(4, 7,4); plot(loc3(idx,:,2) ,'b'); hold on; grid;    axis tight; title('HANN')
		 subplot(4, 7,5); plot(loc4(idx,:,2) ,'k');   hold on; grid;   axis tight; title('BlackMan')
		 subplot(4, 7,6); plot(loc5(idx,:,2) ,'k');  hold on; grid;    axis tight; title('Cheb30')
		 subplot(4, 7,7); plot(loc6(idx,:,2) ,'k'); hold on; grid;    axis tight; title('Cheb60')
         
    elseif idx == startId+step
         [idx]
        
    subplot(4, 7,8);     plot(loc0(idx,:,2) ,'r'); hold on; grid;  legend(num2str(idx)) ; axis tight ; ylabel("TV2 - max detection")
    % title( strcat("File: ",num2str(idx)) );  %ylim([0 370]) l
    subplot(4, 7, 9); plot(loc1(idx,:,2)  ,'r'); hold on; grid; axis tight
    subplot(4, 7,10); plot(loc2(idx,:,2)  ,'b'); hold on; grid;   axis tight
    subplot(4, 7,11); plot(loc3(idx,:,2) ,'b'); hold on; grid;    axis tight
    subplot(4, 7,12); plot(loc4(idx,:,2) ,'k'); hold on; grid;    axis tight
    subplot(4, 7,13); plot(loc5(idx,:,2) ,'k'); hold on; grid;   axis tight
    subplot(4, 7,14); plot(loc6(idx,:,2) ,'k'); hold on ; grid;   axis tight

    
    %legend("loc0", "loc1","loc2", "loc3", "loc4","loc5","loc6")
    %legend( "Chebey13dB" )
    
       elseif idx == startId+2*step
        [idx] 
        
    subplot(4, 7,15); plot(loc0(idx,:,2) ,'r'); hold on; grid;  legend(num2str(idx)) ; axis tight; ylabel("TV3 - max detection")
    % title( strcat("File: ",num2str(idx)) );  %ylim([0 370])
    subplot(4, 7,16); plot(loc1(idx,:,2)  ,'r'); hold on; grid;   axis tight
    subplot(4, 7,17); plot(loc2(idx,:,2)  ,'b'); hold on; grid; axis tight
    subplot(4, 7,18); plot(loc3(idx,:,2) ,'b'); hold on; grid;    axis tight
    subplot(4, 7,19); plot(loc4(idx,:,2) ,'k'); hold on; grid;   axis tight
    subplot(4, 7,20); plot(loc5(idx,:,2) ,'k'); hold on; grid;    axis tight
    subplot(4, 7,21); plot(loc6(idx,:,2) ,'k'); hold on ; grid;    axis tight

    elseif idx == startId+3*step
       [idx]

     subplot(4, 7,22); plot(loc0(idx,:,2) ,'r'); hold on; grid;  legend(num2str(idx)) ; axis tight; xlabel("Template number "); ylabel("TV4 - max detection")
    % title( strcat("File: ",num2str(idx)) );  %ylim([0 370])
    subplot(4, 7,23); plot(loc1(idx,:,2)  ,'r'); hold on; grid;    axis tight; 
    subplot(4, 7,24); plot(loc2(idx,:,2)  ,'b'); hold on; grid;   axis tight
    subplot(4, 7,25); plot(loc3(idx,:,2) ,'b'); hold on; grid;    axis tight
    subplot(4, 7,26); plot(loc4(idx,:,2) ,'k'); hold on; grid;   axis tight
    subplot(4, 7,27); plot(loc5(idx,:,2) ,'k'); hold on; grid;    axis tight
    subplot(4, 7,28); plot(loc6(idx,:,2) ,'k'); hold on ; grid;   axis tight
    
    
    end
        



    % pause(1)
end;

pause(3)

end