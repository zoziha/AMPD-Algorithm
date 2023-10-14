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
    N = data.shape[0]
    L = N // 2

    # 计算每个窗口的行和，并存储到arr_rowsum数组中
    arr_rowsum = np.zeros(L, dtype=np.int32)
    for k in range(1, L):
        arr_rowsum[k] = np.sum(
            (data[k:-k] > data[k * 2 :]) & (data[k:-k] > data[: -k * 2])
        )

    # 找到最大的行和对应的窗口长度
    max_index = np.argmax(arr_rowsum)

    # 根据窗口长度计算波峰
    for k in range(1, max_index + 1):
        p_data[k:-k][
            (data[k:-k] > data[k * 2 :]) & (data[k:-k] > data[: -k * 2])
        ] += 1  # 花式索引

    return np.where(p_data == max_index)[0]
