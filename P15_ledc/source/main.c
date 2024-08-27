#include "main.h"

/* 使能外设时钟 */
void
clk_enable(void)
{
    CCM_CCGR0 = 0xFFFFFFFF;
    CCM_CCGR1 = 0xFFFFFFFF;
    CCM_CCGR2 = 0xFFFFFFFF;
    CCM_CCGR3 = 0xFFFFFFFF;
    CCM_CCGR4 = 0xFFFFFFFF;
    CCM_CCGR5 = 0xFFFFFFFF;
    CCM_CCGR6 = 0xFFFFFFFF;
}

/* 初始化LED */
void
led_init(void)
{
    SW_MUX_GPIO1_IO03 = 0x5;    /* 使用GPIO1-IO03模式 */
    SW_PAD_GPIO1_IO03 = 0x10B0; /* 设置GPIO1-IO03电器属性 */

    /* GPIO初始化 */
    GPIO1_GDIR = 0x8; /* 设置为输出 */
    GPIO1_DR   = 0x0; /* 打开LED灯 */
}

/*
 * @description	: 打开LED灯
 * @param 		: 无
 * @return 		: 无
 */
void
led_on(void)
{
    /*
     * 将GPIO1_DR的bit3清零
     */
    GPIO1_DR &= ~(1 << 3);
}

/*
 * @description	: 关闭LED灯
 * @param 		: 无
 * @return 		: 无
 */
void
led_off(void)
{
    /*
     * 将GPIO1_DR的bit3置1
     */
    GPIO1_DR |= (1 << 3);
}

/*
 * @description	: 短时间延时函数
 * @param - n	: 要延时循环次数(空操作循环次数，模式延时)
 * @return 		: 无
 */
void
delay_short(volatile unsigned int n)
{
    while (n--) { }
}

/*
 * @description	: 延时函数,在396Mhz的主频下
 * 			  	  延时时间大约为1ms
 * @param - n	: 要延时的ms数
 * @return 		: 无
 */
void
delay(volatile unsigned int n)
{
    while (n--) {
        delay_short(0x7ff);
    }
}

int
main()
{
	clk_enable();		/* 使能所有的时钟		 	*/
	led_init();			/* 初始化led 			*/

	while(1) {			/* 死循环 				*/
		led_off();		/* 关闭LED   			*/
		delay(500);		/* 延时大约500ms 		*/

		led_on();		/* 打开LED		 	*/
		delay(500);		/* 延时大约500ms 		*/
	}
    return 0;
}