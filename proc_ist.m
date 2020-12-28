function [ist_proc,beh_ist] = proc_ist(sl,i,ist_data)
blocklist = {1,2,3};
for j = 1:length(blocklist)
    l = blocklist{j};
    r_idx = find(ismember(ist_data.prolific_id,sl{i}) & ismember(ist_data.block_number,l));
    
    if isempty(r_idx)
        warning([sl{j} ' not found.'])
    else
        sequence_tmp = regexp(ist_data.sequence(r_idx),'],', 'split');
        opened_positions_tmp = regexp(ist_data.opened_positions(r_idx),'],', 'split');
        click_rt_tmp = regexp(ist_data.click_rt(r_idx),'],', 'split');
        outcomes_tmp = regexp(ist_data.outcomes(r_idx),',', 'split');
        confidence_tmp = regexp(ist_data.confidence(r_idx),',', 'split');
        confidence_rt_tmp = regexp(ist_data.rt_confidence(r_idx),',', 'split');
        confidence_init_tmp = regexp(ist_data.confidence_init(r_idx),',', 'split');
        accuracy_tmp = regexp(ist_data.correct(r_idx),',', 'split');
        opened_tmp = regexp(ist_data.opened(r_idx),',', 'split');
        chosen_tmp = regexp(ist_data.chosen(r_idx),',', 'split');
        
        for k = 1:size(sequence_tmp{1, 1},2)%sort into struct
            ist_tmp(k).id = sl(i);
            ist_tmp(k).context = cell2mat(blocklist(j))-1;
            ist_tmp(k).game  = k;
            ist_tmp(k).sequence  = str2double(regexp(sequence_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).opened_positions  = str2double(regexp(opened_positions_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).click_rt  = str2double(regexp(click_rt_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).confidence = str2double(regexp(confidence_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).confidence_rt = str2double(regexp(confidence_rt_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).confidence_init = str2double(regexp(confidence_init_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).accuracy = str2double(regexp(accuracy_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).opened = str2double(regexp(opened_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).chosen = str2double(regexp(chosen_tmp{1, 1}{1, k},'\d+(\.)?(\d+)?', 'match'));
            ist_tmp(k).outcome = str2double(regexp(outcomes_tmp{1, 1}{1, k},'[+-]?\d+\.?\d*', 'match'));
            ist_tmp(k).cor_col = mode(ist_tmp(k).sequence);
            %create chosen & ev
            ist_tmp(k).ev = ist_create_ev(ist_tmp(k).chosen,ist_tmp(k).sequence);
        end 
        
        ist_proc{j} = ist_tmp;
        beh_ist_tmp.mean_nr_opened= mean([ist_tmp.opened]);
        beh_ist_tmp.acc= (sum([ist_tmp.accuracy])*(100/length([ist_tmp.accuracy])));
        beh_ist_tmp.mean_conf= mean([ist_tmp.confidence]);
        beh_ist_tmp.id= sl(i);
        beh_ist{j} = beh_ist_tmp;
    end
end

