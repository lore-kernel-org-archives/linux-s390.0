Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 12:54:16 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 03/12] s390/mm: force swiotlb for protected
 virtualization
In-Reply-To: <20190409121647.3e0e1f53.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-4-pasic@linux.ibm.com>
        <20190409121647.3e0e1f53.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190409125416.73713f23@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019 12:16:47 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri,  5 Apr 2019 01:16:13 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On s390 protected virtualization guests also have to use bounce I/O
> > buffers.  That requires some plumbing.
> > 
> > Let us make sure any device using DMA API accordingly is spared from the
                    ^,                                   ^,
Maybe this helps...

> > problems that hypervisor attempting I/O to a non-shared secure page would
> > bring.
> 
> I have problems parsing this sentence :(
> 
> Do you mean that we want to exclude pages for I/O from encryption?

The intended meaning is:
* Devices that do use DMA API (properly) to get get/map the memory
  that is used to talk to hypervisor should be OK with PV (protected
  virtualizaton). I.e. for such devices PV or not PV is basically
  transparent.
* But if a device does not use DMA API for the memory that is used to
  talk to the hypervisor this patch won't help.

And yes the gist of it is: memory accessed by the hypervisor needs to
be on pages excluded from protection (which in case of PV is technically
not encryption).

Does that help?

> 
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  arch/s390/Kconfig                   |  4 ++++
> >  arch/s390/include/asm/Kbuild        |  1 -
> >  arch/s390/include/asm/dma-mapping.h | 13 +++++++++++
> >  arch/s390/include/asm/mem_encrypt.h | 18 +++++++++++++++
> >  arch/s390/mm/init.c                 | 44 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 79 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/s390/include/asm/dma-mapping.h
> >  create mode 100644 arch/s390/include/asm/mem_encrypt.h
> 
> (...)
> 
> > @@ -126,6 +129,45 @@ void mark_rodata_ro(void)
> >  	pr_info("Write protected read-only-after-init data: %luk\n", size >> 10);
> >  }
> >  
> > +int set_memory_encrypted(unsigned long addr, int numpages)
> > +{
> > +	/* also called for the swiotlb bounce buffers, make all pages shared */
> > +	/* TODO: do ultravisor calls */
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(set_memory_encrypted);
> > +
> > +int set_memory_decrypted(unsigned long addr, int numpages)
> > +{
> > +	/* also called for the swiotlb bounce buffers, make all pages shared */
> > +	/* TODO: do ultravisor calls */
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(set_memory_decrypted);
> > +
> > +/* are we a protected virtualization guest? */
> > +bool sev_active(void)
> > +{
> > +	/*
> > +	 * TODO: Do proper detection using ultravisor, for now let us fake we
> > +	 *  have it so the code gets exercised.
> 
> That's the swiotlb stuff, right?
> 

You mean 'That' == code to get exercised == 'swiotlb stuff'?

If yes then the answer is kind of. The swiotlb (i.e. bounce buffers) is
when we map (like we map the buffers pointed to by the descriptors in
case of the virtio ring). The other part of it is the memory allocated
as DMA coherent (i.e. the virtio ring (desc, avail used) itself).

> (The patches will obviously need some reordering before it is actually
> getting merged.)
> 

What do you mean by reordering?

One reason why this is an early RFC is the missing dependency (i.e. the
stuff described by most of the TODO comments). As pointed out in the
cover letter. Another reason is that I wanted to avoid putting a lots of
effort into fine-polishing before clarifying the getting some feedback
on the basics from the community. ;)


> > +	 */
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(sev_active);
> > +
> > +/* protected virtualization */
> > +static void pv_init(void)
> > +{
> > +	if (!sev_active())
> > +		return;
> > +
> > +	/* make sure bounce buffers are shared */
> > +	swiotlb_init(1);
> > +	swiotlb_update_mem_attributes();
> > +	swiotlb_force = SWIOTLB_FORCE;
> > +}
> > +
> >  void __init mem_init(void)
> >  {
> >  	cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
> > @@ -134,6 +176,8 @@ void __init mem_init(void)
> >  	set_max_mapnr(max_low_pfn);
> >          high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
> >  
> > +	pv_init();
> > +
> >  	/* Setup guest page hinting */
> >  	cmma_init();
> >  
> 
