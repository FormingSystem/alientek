.global __start
.global __bss_start
_bss_start:
    .word __bss_start

.global __bss_end
_bss_end:
    .word __bss_end


__start:
    /* 设置处理器进入svc模式 */
    mrs r0, cpsr
    bic r0, r0, #0x1F   /* 清楚cpsr的bit 4 ~ bit 0 */
    orr r0, r0, #0x13    /* 使用svc模式 */
    msr cpsr, r0        /* 将r写入到cpsr */

    /* 清楚BSS段 */
    ldr r0, _bss_start
    ldr r1, _bss_end
    mov r2, #0

bss_loop:
    stmia r0!, {r2}
    cmp r0, r1          /* 比较r0和r1里面的值 */
    ble bss_loop        /* 如果r0地址小于等于r1，继续清楚bss段 */

    /* 设置sp指针 */
    ldr sp, = 0x80200000
    b main               /* 跳转到C语言的main函数 */