% BSD 3-Clause License
% Copyright (c) 2022-2023, ZUO Zhihua (zuo.zhihua@qq.com)
% Automatic multiscale-based peak detection (AMPD)
% AMPD 峰值查找算法
function location = AMPD(data)
    N = length(data);
    L = N / 2;
    arr_row_sum = zeros(L, 1);

    % 确定最佳窗体宽度
    for k = 1:L

        for i = k + 1:N - k

            if (data(i) > data(i - k) && data(i) > data(i + k))
                arr_row_sum(k) = arr_row_sum(k) + 1;
            end

        end

    end

    max_value = max(max(arr_row_sum));
    for i = 1:L

        if (arr_row_sum(i) == max_value)
            max_index = i;
            break;
        end

    end

    p_data = zeros(N, 1);

    % 峰值查找
    for k = 1:max_index

        for i = k + 1:N - k

            if (data(i) > data(i - k) && data(i) >= data(i + k))
                p_data(i) = p_data(i) + 1;
            end

        end

    end

    location = find(p_data == max_index);
end
