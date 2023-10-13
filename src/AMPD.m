% BSD 3-Clause License
% Copyright (c) 2022-2023, ZUO Zhihua (zuo.zhihua@qq.com)
% Automatic multiscale-based peak detection (AMPD)
% AMPD 峰值查找算法
function location = AMPD(data)
    N = length(data);
    L = N / 2 + 1;
    arr_row_sum = zeros(L, 1);

    % 确定最佳窗体宽度
    for k = 1:L
        row_sum = 0;

        for i = k:N - k

            if (i - k == 0 || i + k == N + 1)
                continue;
            end

            if (data(i) > data(i - k) && data(i) > data(i + k))
                row_sum = row_sum - 1;
            end

        end

        arr_row_sum(k) = row_sum;
    end

    for i = 1:L

        if (arr_row_sum(i) == min(min(arr_row_sum)))
            min_index = i;
            break;
        end

    end

    extend_width = min_index + 1;
    N = N + 2 * extend_width;
    p_data = zeros(N, 1);
    data_ = zeros(N, 1); data_(extend_width + 1:N - extend_width) = data;

    % 峰值查找
    for k = 1:min_index + 1

        for i = k:N - k

            if (i - k == 0 || i + k == N + 1)
                continue;
            end

            if (data_(i) > data_(i - k) && data_(i) >= data_(i + k))
                p_data(i) = p_data(i) + 1;
            end

        end

    end

    location = find(p_data == max(max(p_data))) - extend_width;
end
