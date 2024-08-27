.global  _start

/* 
 * description: _start function,  程序从此函数开始执行此函数完成始终使能
 *                                GPIO初始化、最终控制GPIO输出低电平来点亮LED灯
 */

_start:
    /* 使能时钟 */
    ldr r0, =0x020C4068 /* 寄存器CCGR0 */
    ldr r1, =0xFFFFFFFF
    str r1, [r0]

    ldr r0, =0x020C406C /* 寄存器CCGR1 */
    str r1, [r0]

    ldr r0, =0x020C4070 /* 寄存器CCGR2 */
    str r1, [r0]

    ldr r0, =0x020C4074 /* 寄存器CCGR3 */
    str r1, [r0]

    ldr r0, =0x020C4078 /* 寄存器CCGR4 */
    str r1, [r0]

    ldr r0, =0x020C407C /* 寄存器CCGR5 */
    str r1, [r0]    

    ldr r0, =0x020C4080 /* 寄存器CCGR6 */
    str r1, [r0]    


/* 设置GPIO01_IO03复用为GPIO */
    ldr r0, =0x020E0068
    ldr r1, =5
    str r1, [r0]




/* 配置GPIO01_IO03的IO属性 
 * bit 16:0 HYS 关闭
 * bit [15:14]: 00 默认下拉
 * bit [13]: 0 kepper 功能
 * bit [12]: 1 pull/keeper 使能
 * bit [11]: 0 关闭开路输出
 * bit [7:6]: 01 速度 100Mhz,  or 10 速度 100Mhz
 * bit [0]: 0 低转换率
 */
    ldr r0, =0x020E02F4
    ldr r1, =0x1070
    str r1, [r0]

/* 设置GPIO01_IO03为输出 */
    ldr r0, =0x0209C004
    ldr r1, =0x8
    str r1, [r0]

/* 设置GPIO01_IO03输出低电平 */
    ldr r0, =0x0209C000
    ldr r1, =0x0
    str r1, [r0]

loop:
    b loop

