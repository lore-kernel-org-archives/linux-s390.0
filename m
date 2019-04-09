Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 19:14:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 04/12] s390/cio: introduce cio DMA pool
Message-ID: <20190409191453.01444317.cohuck@redhat.com>
In-Reply-To: <20190409141114.7dcce94a@oc2783563651>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-5-pasic@linux.ibm.com>
        <20190409124458.348d1ff5.cohuck@redhat.com>
        <20190409141114.7dcce94a@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019 14:11:14 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 9 Apr 2019 12:44:58 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri,  5 Apr 2019 01:16:14 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> > > @@ -886,6 +888,8 @@ static const struct attribute_group *cssdev_attr_groups[] = {
> > >  	NULL,
> > >  };
> > >  
> > > +static u64 css_dev_dma_mask = DMA_BIT_MASK(31);
> > > +
> > >  static int __init setup_css(int nr)
> > >  {
> > >  	struct channel_subsystem *css;
> > > @@ -899,6 +903,9 @@ static int __init setup_css(int nr)
> > >  	dev_set_name(&css->device, "css%x", nr);
> > >  	css->device.groups = cssdev_attr_groups;
> > >  	css->device.release = channel_subsystem_release;
> > > +	/* some cio DMA memory needs to be 31 bit addressable */
> > > +	css->device.coherent_dma_mask = DMA_BIT_MASK(31),
> > > +	css->device.dma_mask = &css_dev_dma_mask;  
> > 
> > Question: Does this percolate down to the child devices eventually?
> > E.g., you have a ccw_device getting the mask from its parent
> > subchannel, which gets it from its parent css? If so, does that clash
> > with the the mask you used for the virtio_ccw_device in a previous
> > patch? Or are they two really different things?
> >   
> 
> AFAIK id does not percolate. I could not find anything showing in this
> direction in drivers core at least. AFAIU dma_mask is also about the
> addressing limitations of the device itself (in the good old pci world,
> not really applicable for ccw devices).
> 
> Regarding virtio_ccw, I need to set the DMA stuff on the parent device
> because that is how the stuff in virtio_ring.c works. There I we can
> get away with DMA_BIT_MASK(64) as that stuff is not used in places where
> 31 bit addresses are required. For the actual ccw stuff I used the
> cio DMA pool introduced here.

Ok, so those are two different users then.

> 
> FWIW the allocation mechanisms provided by  DMA API (as documented) is
> not very well suited with what we need for ccw. This is why I choose to
> do this gen_pool thing. The gist of it is as-is at the moment we get
> page granularity allocations from DMA API. Of course we could use
> dma_pool which is kind of perfect for uniformly sized objects. As you
> will see in the rest of the series, we have a comparatively small number
> of smallish objects of varying sizes. And some of these are short lived.
> 
> So the child devices like subchannels and ccw devices do not use DMA API
> directly, except for virtio_ccw.
> 
> Does all that make any sense to you?

I think I need to read more of the series, but that should be enough
info to get me started :)

> 
> 
> > >  
> > >  	mutex_init(&css->mutex);
> > >  	css->cssid = chsc_get_cssid(nr);
> > > @@ -1018,6 +1025,55 @@ static struct notifier_block css_power_notifier = {
> > >  	.notifier_call = css_power_event,
> > >  };
> > >  
> > > +#define POOL_INIT_PAGES 1
> > > +static struct gen_pool *cio_dma_pool;
> > > +/* Currently cio supports only a single css */
> > > +static struct device *cio_dma_css;  
> > 
> > That global variable feels wrong, especially if you plan to support
> > MCSS-E in the future. (Do you? :)   
> 
> Not that I'm aware of any plans to add support MCSS-E.
> 
> > If yes, should the dma pool be global
> > or per-css? As css0 currently is the root device for the channel
> > subsystem stuff, you'd either need a new parent to hang this off from
> > or size this with the number of css images.)
> > 
> > For now, just grab channel_subsystems[0]->device directly?
> >   
> 
> Patch 6 gets rid of this variable and adds an accessor instead:
> 
> +struct device *cio_get_dma_css_dev(void)
> +{
> +	return &channel_subsystems[0]->device;
> +}
> +
> 
> I can move that here if you like (for v1).

An accessor looks more sane than a global variable, yes.

> 
> Yes it is kind of unfortunate that some pieces of this code look
> like there could be more than one css, but actually MCSS-E is not
> supported. I would prefer sorting these problems out when they arise, if
> they ever arise.

As long as it's not too unreasonable, I think we should keep the
infrastructure for multiple css instances in place.

> 
> > > +static gfp_t  cio_dma_flags;
> > > +
> > > +static void __init cio_dma_pool_init(void)
> > > +{
> > > +	void *cpu_addr;
> > > +	dma_addr_t dma_addr;
> > > +	int i;
> > > +
> > > +	cio_dma_css = &channel_subsystems[0]->device;
> > > +	cio_dma_flags = GFP_DMA | GFP_KERNEL | __GFP_ZERO;
> > > +	cio_dma_pool = gen_pool_create(3, -1);
> > > +	/* No need to free up the resources: compiled in */
> > > +	for (i = 0; i < POOL_INIT_PAGES; ++i) {
> > > +		cpu_addr = dma_alloc_coherent(cio_dma_css, PAGE_SIZE, &dma_addr,
> > > +					      cio_dma_flags);
> > > +		if (!cpu_addr)
> > > +			return;
> > > +		gen_pool_add_virt(cio_dma_pool, (unsigned long) cpu_addr,
> > > +				  dma_addr, PAGE_SIZE, -1);
> > > +	}
> > > +
> > > +}
> > > +
> > > +void *cio_dma_zalloc(size_t size)
> > > +{
> > > +	dma_addr_t dma_addr;
> > > +	unsigned long addr = gen_pool_alloc(cio_dma_pool, size);
> > > +
> > > +	if (!addr) {
> > > +		addr = (unsigned long) dma_alloc_coherent(cio_dma_css,
> > > +					PAGE_SIZE, &dma_addr, cio_dma_flags);
> > > +		if (!addr)
> > > +			return NULL;
> > > +		gen_pool_add_virt(cio_dma_pool, addr, dma_addr, PAGE_SIZE, -1);
> > > +		addr = gen_pool_alloc(cio_dma_pool, size);
> > > +	}
> > > +	return (void *) addr;  
> > 
> > At this point, you're always going via the css0 device. I'm wondering
> > whether you should pass in the cssid here and use css_by_id(cssid) to
> > make this future proof. But then, I'm not quite clear from which
> > context this will be called.  
> 
> As said before I don't see MCSS-E coming. Regarding the client code,
> please check out the rest of the series. Especially patch 6. 
> 
> From my perspective it would be at this stage saner to make it more
> obvious that only one css is supported (at the moment), than to implement
> MCSS-E, or to make this (kind of) MCSS-E ready.

I disagree. I think there's value in keeping the interfaces clean
(within reasonable bounds, of course.) Even if there is no
implementation of MCSS-E other than QEMU... it is probably a good idea
to spend some brain cycles to make this conceptually clean.
