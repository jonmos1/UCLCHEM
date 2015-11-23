! 2015 UCL_CHEM by Serena Viti update by Jon Holdship
! Rewritten for FORTRAN 95 and modulised


PROGRAM uclchem
!everything to do with physics should be stored in a physics module based on physics-template.f90
!UCL_CHEM uses density and temperature in chemical calculations so these MUST be provided, everything else is
!user dependent
USE physics
USE chem
IMPLICIT NONE

!This should be replaced with Antonios style parameter file and reader
include 'parameters.f90'

!Set up with initial values etc, lives in chem.f90
 CALL initialise
!loop over time, tstep limit is arbitrary so that tfin can be reached.
    tout=3.16d7*10.d-8

DO tstep=0,10000
    !End if we hit final density or time
    IF (switch .eq. 1 .and. dens >= dfin) THEN
        exit
    ELSEIF (switch .eq. 0 .and. tage >= tfin) THEN
        exit
    ENDIF
    !update time
    !loop over depth points
    DO dstep=1,points


        !update physics
        CALL phys_update
        !update chemistry
        CALL chem_update
        
        !set time to the final time of integrator rather than target     
        tout=t0
        tage=tout*year
        CALL output      
        CALL timestep

    END DO
END DO 
END PROGRAM uclchem


