% Profile testing scrap

%limo_display_results_tf(LIMO, one_sample(:,:,:,4),1,['ITC 1samp profiling'])

% limo_random_robust(model.test_select{1},Y1,Y2,parameters,nboot,tfce);
% disp([model.test_select{2} ' done'])

%limo_display_results_tf(LIMO, H0_two_samples(:,:,:,4),1,['ITC F ', model.test_select{2}])

%limo_display_results(1,'R2.mat','/media/ADATA_SSD/sets/2nd_level/cgs2',0.05,2,LIMO,0);


tag = 'andrews_clus14_cov4_optim';
[M, mask, mytitle] = limo_stat_values(1,'Covariate_effect_1.mat',0.05,2,LIMO,'use theoretical p values',[]); 





profs = 0;
if profs == 1
    % Parse data from profiler
   
    clear func_ttime
    
    pinfo = profile('info');
    
    nfun = size(pinfo.FunctionTable,1);
    
    for i=1:nfun     % Stip a simple vector of TotalTimes
        func_ttime(i) = pinfo.FunctionTable(i).TotalTime;
    end
    
    func_ttime2 = func_ttime;
    
    for i = 1:12
        % Record max index, pop it, save it
        [a1 func_idx] = find(func_ttime2 == max(func_ttime2));
        func_ttime2(func_idx(1)) = 0;
        
        func_ltime_idx(i) = func_idx(1);
        func_ltimes(i) = pinfo.FunctionTable(func_idx(1)).TotalTime;
        func_ltimes_names{i,1} = pinfo.FunctionTable(func_idx(1)).FunctionName;
        func_ltimes_names{i,2} = pinfo.FunctionTable(func_idx(1)).TotalTime;
        
    end
    
    func_ltimes_names
    
    
    % Save all in compendium of benchmark results
    load /media/ADATA_SSD/Dropbox/limo_stuff/profiling/bmark.mat
    bmark_idx = length(bmark.names) + 1;
    bmark.names{bmark_idx} = tag;
    bmark.times{bmark_idx} = func_ltimes_names;
    bmark.masks{bmark_idx} = mask;
    
    tmpt = bmark.times{bmark_idx}(1,2)
    bmark.total_time(bmark_idx) = tmpt{1};
    
    
    
    mask_comp = bmark.masks{14}(:)== bmark.masks{bmark_idx}(:);
    
    
    if any(mask_comp==0)   % if there is anywhere that the masks are not equal
        bmark.mask_good(bmark_idx) = 0;
        error('Bad mask here')
        
    else        
        bmark.mask_good(bmark_idx) = 1;
    end
 
    
    save('/media/ADATA_SSD/Dropbox/limo_stuff/profiling/bmark.mat','bmark')
end

% for i=3:5
%     tmpt = bmark.times{i}(1,2)
%     bmark.total_time(i) = tmpt{1};
% end

