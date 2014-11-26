#define __SEL(var,nr) 				var select nr
#define __SSEL(var,nr,np) 			((var select nr) select np)
#define __ARRAY_SET(array,idx,var)	array set [idx,var]
#define __ARRAY_ADD(array,var)		array + var
#define __MAX(array)				((count array) -1)
#define __CNT(array)				count array

#define __ALLOC_WEP		0
#define __ALLOC_MAG		1
#define __ALLOC_IT		2
#define __ALLOC_Wear	3
#define __ALLOC_BP		4


