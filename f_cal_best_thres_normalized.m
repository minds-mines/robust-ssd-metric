function [thres_using, thres_idx, stat_table] = f_cal_best_thres_normalized(ref_y, input_y, idx_remained)
	ref_y_remained = ref_y(idx_remained);
	input_y_remained = input_y(idx_remained);
	
	n_pos = nnz(ref_y_remained > 0);
	n_neg = nnz(ref_y_remained < 0);

	stat_table = zeros(length(input_y_remained) - 1, 5);
	[input_y_sorted, idx_sorted] = sort(input_y_remained);

	for k = 1 : length(input_y_sorted) - 1
		%tp
		stat_table(k, 1) = nnz((input_y_remained < input_y_sorted(k + 1)) .* (ref_y_remained > 0)) / n_pos;
		%tn
		stat_table(k, 2) = nnz((input_y_remained > input_y_sorted(k + 1)) .* (ref_y_remained < 0)) / n_neg;
		%fp
		stat_table(k, 3) = nnz((input_y_remained < input_y_sorted(k + 1)) .* (ref_y_remained < 0)) / n_pos;
		%fn
		stat_table(k, 4) = nnz((input_y_remained > input_y_sorted(k + 1)) .* (ref_y_remained > 0)) / n_neg;
	end

	stat_table(:, 5) = stat_table(:, 1) + stat_table(:, 2);
	[m, thres_idx] = max(stat_table(:, 5));
	%disp(['The thres_idx is ', num2str(thres_idx)]);
	if thres_idx > 1
		thres_using = input_y_sorted(thres_idx) - (input_y_sorted(thres_idx) - input_y_sorted(thres_idx - 1)) / 2;
	else
		thres_using = input_y_sorted(thres_idx);
	end
end
