! BSD 3-Clause License
! Copyright (c) 2022-2023, ZUO Zhihua (zuo.zhihua@qq.com)
module AMDP_module

    implicit none

    private
    public :: AMPD, rk

#ifdef REAL64
    integer, parameter :: rk = kind(1.d0)
#else
    integer, parameter :: rk = kind(1.0)
#endif

contains

    !> Automatic multiscale-based peak detection (AMPD) algorithm
    !> AMPD 峰值查找算法
    !> @note
    !> - 查询谷值，可将信号翻转后再查找
    pure function AMPD(data) result(location)
        real(rk), intent(in) :: data(:)                 !! Input data
                                                        !! 数据
        integer, allocatable :: location(:)             !! 峰值位置
        integer :: L, N, k, i, row_sum, min_index
        integer, allocatable :: arr_row_sum(:)
        integer, allocatable :: p_data(:)

        ! 确定最佳窗体宽度
        N = size(data)
        L = N/2 + 1
        allocate (arr_row_sum(L))
        do k = 1, L
            row_sum = 0
            do i = k + 1, N - k
                if (data(i) > data(i - k) .and. data(i) > data(i + k)) row_sum = row_sum - 1
            end do
            arr_row_sum(k) = row_sum
        end do
        min_index = minloc(arr_row_sum, dim=1) ! 通过最小值确定最佳窗体宽度，显著提升峰值特征，方便查找峰值

        ! 查找峰值
        allocate (p_data(N), source=0)
        do k = 1, min_index
            do i = k + 1, N - k
                if (data(i) > data(i - k) .and. data(i) > data(i + k)) p_data(i) = p_data(i) + 1
            end do
        end do

        allocate (location(0))
        do i = 1, N
            if (p_data(i) == min_index) location = [location, i]
        end do

    end function AMPD

end module AMDP_module
