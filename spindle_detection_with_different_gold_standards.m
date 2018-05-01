% loop over all records and all parameters
% hp selection is performed in a second phase
% // function Mass_parallelSpindleDetection()

addpath('playing_with_different_gold_standards/')

format long g
warning('off','all')

p = parpool('local', 12); 

% param grid
lam3_grid = [45];
Threshold_grid = [0.5];

% loop over record
PATH = '/home/infres/schambon/Papers/mcsleep/data/mat_gold_standard/';
fil=fullfile(PATH,'*.mat')
d=dir(fil)
% scores = {};
for k=1:numel(d)	
	file_name=fullfile(PATH,d(k).name);

	%if k >= 14

	disp(file_name)
	% % Grid search
	[metrics_E1, metrics_E2, metrics_union, metrics_intersection] = hp_selection_gold_standard(file_name, lam3_grid, Threshold_grid)

	a = strsplit(file_name, '/');
	b = a{1, end};
	c = strsplit(b, '.');

	save(['scores/parekh_2017/metrics_E1_' c{1, 1} '.mat'], 'metrics_E1')
	save(['scores/parekh_2017/metrics_E2_' c{1, 1} '.mat'], 'metrics_E2')
	save(['scores/parekh_2017/metrics_union_' c{1, 1} '.mat'], 'metrics_union')
	save(['scores/parekh_2017/metrics_intersection_' c{1, 1} '.mat'], 'metrics_intersection')
	%else
	%	disp(file_name)
	%end

end

delete(gcp('nocreate'))

// end