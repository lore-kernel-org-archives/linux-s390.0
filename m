Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 12:44:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
Message-ID: <20190409124458.348d1ff5.cohuck@redhat.com>
In-Reply-To: <20190404231622.52531-5-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-5-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri,  5 Apr 2019 01:16:14 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> To support protected virtualization cio will need to make sure the
> memory used for communication with the hypervisor is DMA memory.
> 
> Let us introduce a DMA pool to cio that will help us in allocating

missing 'and'

> deallocating those chunks of memory.
> 
> We use a gen_pool backed with DMA pages to avoid each allocation
> effectively wasting a page, as we typically allocate much less
> than PAGE_SIZE.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |  1 +
>  arch/s390/include/asm/cio.h |  3 +++
>  drivers/s390/cio/css.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 46c69283a67b..e8099ab47368 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -194,6 +194,7 @@ config S390
>  	select VIRT_TO_BUS
>  	select HAVE_NMI
>  	select SWIOTLB
> +	select GENERIC_ALLOCATOR
>  
>  
>  config SCHED_OMIT_FRAME_POINTER
> diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
> index 1727180e8ca1..4510e418614a 100644
> --- a/arch/s390/include/asm/cio.h
> +++ b/arch/s390/include/asm/cio.h
> @@ -328,6 +328,9 @@ static inline u8 pathmask_to_pos(u8 mask)
>  void channel_subsystem_reinit(void);
>  extern void css_schedule_reprobe(void);
>  
> +extern void *cio_dma_zalloc(size_t size);
> +extern void cio_dma_free(void *cpu_addr, size_t size);
> +
>  /* Function from drivers/s390/cio/chsc.c */
>  int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
>  int chsc_sstpi(void *page, void *result, size_t size);
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index aea502922646..72629d99d8e4 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -20,6 +20,8 @@
>  #include <linux/reboot.h>
>  #include <linux/suspend.h>
>  #include <linux/proc_fs.h>
> +#include <linux/genalloc.h>
> +#include <linux/dma-mapping.h>
>  #include <asm/isc.h>
>  #include <asm/crw.h>
>  
> @@ -886,6 +888,8 @@ static const struct attribute_group *cssdev_attr_groups[] = {
>  	NULL,
>  };
>  
> +static u64 css_dev_dma_mask = DMA_BIT_MASK(31);
> +
>  static int __init setup_css(int nr)
>  {
>  	struct channel_subsystem *css;
> @@ -899,6 +903,9 @@ static int __init setup_css(int nr)
>  	dev_set_name(&css->device, "css%x", nr);
>  	css->device.groups = cssdev_attr_groups;
>  	css->device.release = channel_subsystem_release;
> +	/* some cio DMA memory needs to be 31 bit addressable */
> +	css->device.coherent_dma_mask = DMA_BIT_MASK(31),
> +	css->device.dma_mask = &css_dev_dma_mask;

Question: Does this percolate down to the child devices eventually?
E.g., you have a ccw_device getting the mask from its parent
subchannel, which gets it from its parent css? If so, does that clash
with the the mask you used for the virtio_ccw_device in a previous
patch? Or are they two really different things?

>  
>  	mutex_init(&css->mutex);
>  	css->cssid = chsc_get_cssid(nr);
> @@ -1018,6 +1025,55 @@ static struct notifier_block css_power_notifier = {
>  	.notifier_call = css_power_event,
>  };
>  
> +#define POOL_INIT_PAGES 1
> +static struct gen_pool *cio_dma_pool;
> +/* Currently cio supports only a single css */
> +static struct device *cio_dma_css;

That global variable feels wrong, especially if you plan to support
MCSS-E in the future. (Do you? :) If yes, should the dma pool be global
or per-css? As css0 currently is the root device for the channel
subsystem stuff, you'd either need a new parent to hang this off from
or size this with the number of css images.)

For now, just grab channel_subsystems[0]->device directly?

> +static gfp_t  cio_dma_flags;
> +
> +static void __init cio_dma_pool_init(void)
> +{
> +	void *cpu_addr;
> +	dma_addr_t dma_addr;
> +	int i;
> +
> +	cio_dma_css = &channel_subsystems[0]->device;
> +	cio_dma_flags = GFP_DMA | GFP_KERNEL | __GFP_ZERO;
> +	cio_dma_pool = gen_pool_create(3, -1);
> +	/* No need to free up the resources: compiled in */
> +	for (i = 0; i < POOL_INIT_PAGES; ++i) {
> +		cpu_addr = dma_alloc_coherent(cio_dma_css, PAGE_SIZE, &dma_addr,
> +					      cio_dma_flags);
> +		if (!cpu_addr)
> +			return;
> +		gen_pool_add_virt(cio_dma_pool, (unsigned long) cpu_addr,
> +				  dma_addr, PAGE_SIZE, -1);
> +	}
> +
> +}
> +
> +void *cio_dma_zalloc(size_t size)
> +{
> +	dma_addr_t dma_addr;
> +	unsigned long addr = gen_pool_alloc(cio_dma_pool, size);
> +
> +	if (!addr) {
> +		addr = (unsigned long) dma_alloc_coherent(cio_dma_css,
> +					PAGE_SIZE, &dma_addr, cio_dma_flags);
> +		if (!addr)
> +			return NULL;
> +		gen_pool_add_virt(cio_dma_pool, addr, dma_addr, PAGE_SIZE, -1);
> +		addr = gen_pool_alloc(cio_dma_pool, size);
> +	}
> +	return (void *) addr;

At this point, you're always going via the css0 device. I'm wondering
whether you should pass in the cssid here and use css_by_id(cssid) to
make this future proof. But then, I'm not quite clear from which
context this will be called.

> +}
> +
> +void cio_dma_free(void *cpu_addr, size_t size)
> +{
> +	memset(cpu_addr, 0, size);
> +	gen_pool_free(cio_dma_pool, (unsigned long) cpu_addr, size);
> +}
> +
>  /*
>   * Now that the driver core is running, we can setup our channel subsystem.
>   * The struct subchannel's are created during probing.
> @@ -1063,6 +1119,7 @@ static int __init css_bus_init(void)
>  		unregister_reboot_notifier(&css_reboot_notifier);
>  		goto out_unregister;
>  	}
> +	cio_dma_pool_init();
>  	css_init_done = 1;
>  
>  	/* Enable default isc for I/O subchannels. */
