.global __start
__start:
    /* 设置处理器进入svc模式 */
    mrs r0, cpsr
    bic r0, r0, #0x1F   /* 清楚cpsr的bit 4 ~ bit 0 */
    orr r0, r0, #0x13    /* 使用svc模式 */
    msr cpsr, r0        /* 将r写入到cpsr */

    /* 设置sp指针 */
    ldr sp, = 0x80200000
    b main               /* 跳转到C语言的main函数 */