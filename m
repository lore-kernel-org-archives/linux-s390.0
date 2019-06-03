Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 3 Jun 2019 13:37:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 2/8] s390/cio: introduce DMA pools to cio
Message-ID: <20190603133745.240c00a7.cohuck@redhat.com>
In-Reply-To: <20190529122657.166148-3-mimu@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-3-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 29 May 2019 14:26:51 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> To support protected virtualization cio will need to make sure the
> memory used for communication with the hypervisor is DMA memory.
> 
> Let us introduce one global pool for cio.
> 
> Our DMA pools are implemented as a gen_pool backed with DMA pages. The
> idea is to avoid each allocation effectively wasting a page, as we
> typically allocate much less than PAGE_SIZE.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/cio.h |  11 ++++
>  drivers/s390/cio/css.c      | 120 ++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 128 insertions(+), 4 deletions(-)

(...)

> diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
> index 1727180e8ca1..43c007d2775a 100644
> --- a/arch/s390/include/asm/cio.h
> +++ b/arch/s390/include/asm/cio.h
> @@ -328,6 +328,17 @@ static inline u8 pathmask_to_pos(u8 mask)
>  void channel_subsystem_reinit(void);
>  extern void css_schedule_reprobe(void);
>  
> +extern void *cio_dma_zalloc(size_t size);
> +extern void cio_dma_free(void *cpu_addr, size_t size);
> +extern struct device *cio_get_dma_css_dev(void);
> +
> +struct gen_pool;

That forward declaration is a bit ugly... I guess the alternative was
include hell?

> +void *cio_gp_dma_zalloc(struct gen_pool *gp_dma, struct device *dma_dev,
> +			size_t size);
> +void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size);
> +void cio_gp_dma_destroy(struct gen_pool *gp_dma, struct device *dma_dev);
> +struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages);
> +
>  /* Function from drivers/s390/cio/chsc.c */
>  int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
>  int chsc_sstpi(void *page, void *result, size_t size);
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index aea502922646..b97618497848 100644
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
> @@ -224,6 +226,8 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
>  	INIT_WORK(&sch->todo_work, css_sch_todo);
>  	sch->dev.release = &css_subchannel_release;
>  	device_initialize(&sch->dev);

It might be helpful to add a comment why you use 31 bit here...

> +	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
> +	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
>  	return sch;
>  
>  err:
> @@ -899,6 +903,8 @@ static int __init setup_css(int nr)
>  	dev_set_name(&css->device, "css%x", nr);
>  	css->device.groups = cssdev_attr_groups;
>  	css->device.release = channel_subsystem_release;

...and 64 bit here.

> +	css->device.coherent_dma_mask = DMA_BIT_MASK(64);
> +	css->device.dma_mask = &css->device.coherent_dma_mask;
>  
>  	mutex_init(&css->mutex);
>  	css->cssid = chsc_get_cssid(nr);

(...)

> @@ -1059,16 +1168,19 @@ static int __init css_bus_init(void)
>  	if (ret)
>  		goto out_unregister;
>  	ret = register_pm_notifier(&css_power_notifier);
> -	if (ret) {
> -		unregister_reboot_notifier(&css_reboot_notifier);
> -		goto out_unregister;
> -	}
> +	if (ret)
> +		goto out_unregister_rn;
> +	ret = cio_dma_pool_init();
> +	if (ret)
> +		goto out_unregister_rn;

Don't you also need to unregister the pm notifier on failure here?

Other than that, I noticed only cosmetic issues; seems reasonable to me.

>  	css_init_done = 1;
>  
>  	/* Enable default isc for I/O subchannels. */
>  	isc_register(IO_SCH_ISC);
>  
>  	return 0;
> +out_unregister_rn:
> +	unregister_reboot_notifier(&css_reboot_notifier);
>  out_unregister:
>  	while (i-- > 0) {
>  		struct channel_subsystem *css = channel_subsystems[i];
