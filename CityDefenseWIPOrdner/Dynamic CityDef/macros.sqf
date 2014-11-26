#define __cnt count VAR_PH
#define __cntArray(array) count array
#define __maxArray(array) __cntArray(array)-1
#define __sel(var,nr) var select nr
#define __ssel(var,nr1,nr2) __sel(var,nr1) select nr2

#define __SVAR(obj,var,value) obj setvariable [#var,value]
#define __GVAR(obj,var) obj getvariable #var
