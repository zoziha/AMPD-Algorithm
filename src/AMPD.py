# BSD 3-Clause License
# Copyright (c) 2022-2023, ZUO Zhihua (zuo.zhihua@qq.com)
import numpy as np


def AMPD(data):
    """
    Automatic multiscale-based peak detection (AMPD) algorithm

    AMPD 峰值算法

    Parameters
    ---
    data : array_like
        输入的一维数据

    Returns
    ---
    p_data : ndarray
        波峰所在索引值的列表
    """
    p_data = np.zeros_like(data, dtype=np.int32)
    count = data.shape[0]

    # 计算每个窗口的行和，并存储到arr_rowsum数组中
    arr_rowsum = -np.ones(count // 2, dtype=np.int32)
    for k in range(1, count // 2 + 1):
        arr_rowsum[k - 1] = np.sum(
            (data[k:-k] > data[k * 2 :]) & (data[k:-k] > data[: -k * 2])
        ) * (-1)

    # 找到最小的行和对应的窗口长度
    min_index = np.argmin(arr_rowsum)

    # 根据窗口长度计算波峰
    for k in range(1, min_index + 1):
        p_data[k:-k][(data[k:-k] > data[k * 2 :]) & (data[k:-k] > data[: -k * 2])] += 1  # 花式索引

    return np.where(p_data == min_index)[0]
