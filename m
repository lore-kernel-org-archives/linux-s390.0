From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Date: Sun, 31 Mar 2013 23:52:26 +0000
Subject: Re: drivers/usb/gadget/pch_udc.c:1405:3: error: implicit declaration of function 'irq_set_irq_type'
Message-Id: <CANKRQnjzAZ+FymhRc5Re6i7QbpjQsLsXwXXPqhUmBbHPS7X7LQ@mail.gmail.com>
In-Reply-To: <20130329025523.GB10831@localhost>
References: <20130329025523.GB10831@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi

This driver works only for X86, especially, Intel Atom E6XX series.
I should have written X86 definition to Kconfig.

thanks.
-- 
ROHM Co., Ltd.
tomoya

On Fri, Mar 29, 2013 at 11:55 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> Greetings,
>
> FYI, kernel build failed on s390 since
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
> head:   9064171268d838b8f283fe111ef086b9479d059a
> commit: 637b78eb31e0b167ed913f1750bb645dfeda38f0 usb: gadget: pch_udc: Detecting VBUS through GPIO with interrupt
> date:   1 year, 2 months ago
> config: make ARCH=s390 allmodconfig
>
> All error/warnings:
>
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_readl':
>    drivers/usb/gadget/pch_udc.c:422:2: error: implicit declaration of function 'ioread32' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_writel':
>    drivers/usb/gadget/pch_udc.c:428:2: error: implicit declaration of function 'iowrite32' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c: In function 'pch_vbus_gpio_init':
>>> drivers/usb/gadget/pch_udc.c:1405:3: error: implicit declaration of function 'irq_set_irq_type' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c:1405:29: error: 'IRQ_TYPE_EDGE_BOTH' undeclared (first use in this function)
>    drivers/usb/gadget/pch_udc.c:1405:29: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/usb/gadget/pch_udc.c: In function 'complete_req':
>    drivers/usb/gadget/pch_udc.c:1459:5: error: implicit declaration of function 'dma_unmap_single' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c:1461:8: error: 'DMA_TO_DEVICE' undeclared (first use in this function)
>    drivers/usb/gadget/pch_udc.c:1465:8: error: 'DMA_FROM_DEVICE' undeclared (first use in this function)
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_free_dma_chain':
>    drivers/usb/gadget/pch_udc.c:1529:3: error: implicit declaration of function 'pci_pool_free' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_create_dma_chain':
>    drivers/usb/gadget/pch_udc.c:1572:3: error: implicit declaration of function 'pci_pool_alloc' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c:1572:6: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_alloc_request':
>    drivers/usb/gadget/pch_udc.c:1781:11: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_pcd_queue':
>    drivers/usb/gadget/pch_udc.c:1863:5: error: implicit declaration of function 'dma_map_single' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c:1866:13: error: 'DMA_TO_DEVICE' undeclared (first use in this function)
>    drivers/usb/gadget/pch_udc.c:1871:13: error: 'DMA_FROM_DEVICE' undeclared (first use in this function)
>    drivers/usb/gadget/pch_udc.c: In function 'init_dma_pools':
>    drivers/usb/gadget/pch_udc.c:2935:2: error: implicit declaration of function 'pci_pool_create' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c:2935:21: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/usb/gadget/pch_udc.c:2944:20: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/usb/gadget/pch_udc.c:2952:9: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/usb/gadget/pch_udc.c:2962:10: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/usb/gadget/pch_udc.c:2980:12: error: 'DMA_FROM_DEVICE' undeclared (first use in this function)
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_remove':
>    drivers/usb/gadget/pch_udc.c:3079:3: error: implicit declaration of function 'pci_pool_destroy' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c:3098:32: error: 'DMA_FROM_DEVICE' undeclared (first use in this function)
>    drivers/usb/gadget/pch_udc.c:3108:3: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c: In function 'pch_udc_probe':
>    drivers/usb/gadget/pch_udc.c:3199:2: error: implicit declaration of function 'ioremap_nocache' [-Werror=implicit-function-declaration]
>    drivers/usb/gadget/pch_udc.c:3199:17: warning: assignment makes pointer from integer without a cast [enabled by default]
>    drivers/usb/gadget/pch_udc.c:3227:2: error: implicit declaration of function 'pci_try_set_mwi' [-Werror=implicit-function-declaration]
>    cc1: some warnings being treated as errors
>
> vim +/irq_set_irq_type +1405 drivers/usb/gadget/pch_udc.c
>
> dd63180b Tomoya MORINAGA 2012-02-03  1399       dev->vbus_gpio.port = vbus_gpio_port;
> dd63180b Tomoya MORINAGA 2012-02-03  1400       gpio_direction_input(vbus_gpio_port);
> dd63180b Tomoya MORINAGA 2012-02-03  1401       INIT_WORK(&dev->vbus_gpio.irq_work_fall, pch_vbus_gpio_work_fall);
> dd63180b Tomoya MORINAGA 2012-02-03  1402
> 637b78eb Tomoya MORINAGA 2012-02-03  1403       irq_num = gpio_to_irq(vbus_gpio_port);
> 637b78eb Tomoya MORINAGA 2012-02-03  1404       if (irq_num > 0) {
> 637b78eb Tomoya MORINAGA 2012-02-03 @1405               irq_set_irq_type(irq_num, IRQ_TYPE_EDGE_BOTH);
> 637b78eb Tomoya MORINAGA 2012-02-03  1406               err = request_irq(irq_num, pch_vbus_gpio_irq, 0,
> 637b78eb Tomoya MORINAGA 2012-02-03  1407                       "vbus_detect", dev);
> 637b78eb Tomoya MORINAGA 2012-02-03  1408               if (!err) {
>
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
