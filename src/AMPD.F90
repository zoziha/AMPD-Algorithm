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
    !> - 由于移动窗体宽度的存在，序列两端的峰值不被查找，如果需要被查找需要填充最小值，extend = T
    !> - 暂无法实时查找
    !> - 查询谷值，可将信号翻转后再查找
    pure function AMPD(data, extend) result(location)
        real(rk), intent(in) :: data(:)                 !! Input data
                                                        !! 数据
        logical, intent(in), optional :: extend         !! Extend data width to get two end peaks, `.false.` by default
                                                        !! 是否增强数据宽度以获取两端最大峰值, 默认为 `.false.`
        integer, allocatable :: location(:)             !! Peak position
                                                        !! 峰值位置
        integer :: L, N, k, i, row_sum, min_index, extend_size
        integer, allocatable :: arr_row_sum(:)
        integer, allocatable :: p_data(:)
        logical :: extend_
        real(rk), allocatable :: data_(:)

        if (present(extend)) then
            extend_ = extend
        else
            extend_ = .false.
        end if

        ! 确定最佳窗体宽度
        N = size(data)
        L = N/2 + 1
        allocate (arr_row_sum(L))
        do k = 1, L
            row_sum = 0
            do i = k, N - k
                if (i - k == 0 .or. i + k == N + 1) cycle
                if (data(i) > data(i - k) .and. data(i) > data(i + k)) row_sum = row_sum - 1
            end do
            arr_row_sum(k) = row_sum
        end do
        min_index = minloc(arr_row_sum, dim=1) ! 通过最小值确定最佳窗体宽度，显著提升峰值特征，方便查找峰值

        ! 查找峰值
        if (extend_) then
            extend_size = min_index + 1
        else
            extend_size = 0
        end if
        N = N + extend_size*2
        allocate (p_data(N), source=0)
        if (extend_) then
            allocate (data_(N))
            associate (min => minval(data, dim=1))
                data_(:extend_size) = min
                data_(extend_size + 1:N - extend_size) = data(:)
                data_(N - extend_size + 1:) = min
            end associate
        else
            allocate (data_(N), source=data)
        end if
        do k = 1, min_index + 1
            do i = k, N - k
                if (i - k == 0 .or. i + k == N + 1) cycle
                if (data_(i) > data_(i - k) .and. data_(i) > data_(i + k)) p_data(i) = p_data(i) + 1
            end do
        end do

        allocate (location(0))
        do i = 1, N
            if (p_data(i) == min_index) location = [location, i]
        end do
        if (extend_) location = location - extend_size
        location = location - 1

    end function AMPD

end module AMDP_module
