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


x = np.sin(np.arange(1, 30, 1) * 0.314)
y = AMPD(x)
print("Peaks indexes        : ", y)
print("Peaks values         : ", x[y])
print("Left values of peaks : ", x[y - 1])
print("Right values of peaks: ", x[y + 1])

# Peaks indexes        :  [ 4 24]
# Peaks values         :  [0.99999968 0.99999207]
# Left values of peaks :  [0.95085946 0.94986839]
# Right values of peaks:  [0.95135138 0.95232797]
