% visualise_loc2cc_nonorm_gian_differences.m  19/Oct/2026 TP
% analyse max detections

clear;
clf;

load files4_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026c.mat


for startId=1:10
    
step=10;

tvlist = [startId,startId+step, startId+2*step, startId+3*step]
   
       set0max = max(loc0(tvlist,:,2));
       set1max = max(loc1(tvlist,:,2));
       set2max = max(loc2(tvlist,:,2));
       set3max = max(loc3(tvlist,:,2));
       set4max = max(loc4(tvlist,:,2));
       set5max = max(loc5(tvlist,:,2));
       set6max = max(loc6(tvlist,:,2));

       set0min = min(loc0(tvlist,:,2));
       set1min = min(loc1(tvlist,:,2));
       set2min = min(loc2(tvlist,:,2));
       set3min = min(loc3(tvlist,:,2));
       set4min = min(loc4(tvlist,:,2));
       set5min = min(loc5(tvlist,:,2));
       set6min = min(loc6(tvlist,:,2));

 		subplot(2,7,1);plot(set0max); title(num2str(tvlist)) ; grid on; grid on; axis([0 85 0 375]); ; ylabel("max detection"); xlabel("Template"); 
 		subplot(2,7,2);plot(set1max); grid on; axis([0 85 0 375]);
 		subplot(2,7,3);plot(set2max); grid on; axis([0 85 0 375]);
 		subplot(2,7,4);plot(set3max); grid on; axis([0 85 0 375]);
		subplot(2,7,5);plot(set4max); grid on; axis([0 85 0 375]);
		subplot(2,7,6);plot(set5max); grid on; axis([0 85 0 375]);
 		subplot(2,7,7);plot(set6max); grid on; axis([0 85 0 375]);     

        allmax = [max(set0max) max(set1max) max(set2max) max(set3max) max(set4max) max(set5max) max(set6max)  ]
        allmin = [min(set0min) min(set1min) min(set2min) min(set3min) min(set4min) min(set5min) min(set6min)  ]
        allmaxgains = [max(set0max)/max(set0max)  max(set1max)/max(set0max) max(set2max)/max(set0max) max(set3max)/max(set0max) max(set4max)/max(set0max) max(set5max)/max(set0max) max(set6max)/max(set0max)  ]
        allmingains = [min(set0min)/min(set0min)  min(set1min)/min(set0min) min(set2min)/min(set0min) min(set3min)/min(set0min) min(set4min)/min(set0min) min(set5min)/min(set0min) min(set6min)/min(set0min)  ]
        

        subplot(4,1,3)
        plot(allmax);
        hold on ; grid on
        xlabel("template")
        ylabel("max of max");

        subplot(4,1,4)
        plot(allmin);
        hold on ; grid on
        xlabel("template")
        ylabel("min of min");

%end;

pause(2)

end
