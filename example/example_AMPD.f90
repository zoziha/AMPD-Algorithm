program example_AMPD

    use AMDP_module, only: rk, AMPD
    implicit none

    real(rk) :: x(30)
    integer :: i

    do i = 1, 30
        x(i) = sin(0.314*i)
    end do

    associate (y => AMPD(x))
        print 101, "Peaks indexes        : ", y
        print 100, "Peaks values         : ", x(y)
        print 100, "Left values of peaks : ", x(y - 1)
        print 100, "Right values of peaks: ", x(y + 1)
    end associate

100 format(A, T24, *(f7.4, :, ", "))
101 format(A, T24, *(i007, :, ", "))

end program example_AMPD
! Peaks indexes        :      5,      25
! Peaks values         :  1.0000,  1.0000
! Left values of peaks :  0.9509,  0.9499
! Right values of peaks:  0.9514,  0.9523
