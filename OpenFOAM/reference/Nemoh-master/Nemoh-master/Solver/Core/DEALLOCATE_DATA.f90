!--------------------------------------------------------------------------------------
!
!   Copyright 2014 Ecole Centrale de Nantes, 1 rue de la No�, 44300 Nantes, France
!
!   Licensed under the Apache License, Version 2.0 (the "License");
!   you may not use this file except in compliance with the License.
!   You may obtain a copy of the License at
!
!       http://www.apache.org/licenses/LICENSE-2.0
!
!   Unless required by applicable law or agreed to in writing, software
!   distributed under the License is distributed on an "AS IS" BASIS,
!   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!   See the License for the specific language governing permissions and
!   limitations under the License. 
!
!   Contributors list:
!   - G. Delhommeau
!   - J. Singh  
!
!--------------------------------------------------------------------------------------
    SUBROUTINE DEALLOCATE_DATA

      USE COM_VAR

      DEALLOCATE(X,Y,Z,XG,YG,ZG)
      DEALLOCATE(AIRE,M1,M2,M3,M4)
      DEALLOCATE(XN,YN,ZN,DIST,TDIS)
      if(Indiq_solver .eq. 0)DEALLOCATE(ZIJ)
      DEALLOCATE(ZPB,ZPS)
      DEALLOCATE(ZIGB,ZIGS)
      
    END SUBROUTINE