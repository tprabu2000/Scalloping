% visualise_loc2cc_nonorm_maxmax_minimin_gain_differences.m
% visualise_loc2cc_nonorm_gian_differences.m  19/Oct/2026 TP
% analyse max detections

clear;
clf;

% load files4_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026c.mat
load files4_maxdet_13102026_rect_hann_hamm_blackmann_chebey30_chebey60_winows_19oct2026d.mat 

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
        

        tvect(startId,:) = tvlist;
        gvect(startId,:) = 1./allmaxgains;

        subplot(4,2,5)
        plot(allmax,'r');
        hold on ; grid on    
        plot(allmin,'k');
        xlabel("template")
        ylabel("max of max and min min");

        
        subplot(4,2,7)
        plot(1./allmaxgains,'r');
        hold on ; grid on
        plot(1./allmingains,'k');
        xlabel("template")
        ylabel("max of max and min min gains");    
        
%end;

pause(2)

end

subplot(4,7,18 ); hist(gvect(:,1),5)
subplot(4,7,19 ); hist(gvect(:,2),5)
subplot(4,7,20 ); hist(gvect(:,3),5)
subplot(4,7,21 ); hist(gvect(:,4),5)
subplot(4,7,25 ); hist(gvect(:,5),5)
subplot(4,7,26 ); hist(gvect(:,6),5)
subplot(4,7,27 ); hist(gvect(:,7),5)


gfact1 = [mean( gvect(:,1))  mean( gvect(:,2)) mean( gvect(:,3)) mean( gvect(:,4)) mean( gvect(:,5)) mean( gvect(:,6)) mean( gvect(:,7)) ]
gfact2 = [median( gvect(:,1))  median( gvect(:,2)) median( gvect(:,3)) median( gvect(:,4)) median( gvect(:,5)) median( gvect(:,6)) median( gvect(:,7)) ]


subplot(4,7,28 );
plot(gfact1,'r-');   %  ylim([ min(gfact1, gfact2)*0.9 max(gfact1, gfact2)*1.1] ); grid on
hold on ; plot(gfact2,'b-'); title ("mean, median g");   grid on
%title('G correction')

save("iter2_gains4_templ_rect_han_ham_bm_cb30_cb60.mat", "gfact1","gfact2")