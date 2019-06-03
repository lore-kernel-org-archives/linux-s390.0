Return-Path: <SRS0=iFEE=UC=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 3 Jun 2019 14:47:06 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] s390/cio: introduce DMA pools to cio
In-Reply-To: <20190603133745.240c00a7.cohuck@redhat.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
        <20190529122657.166148-3-mimu@linux.ibm.com>
        <20190603133745.240c00a7.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190603144706.2d458ccc.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Mueller <mimu@linux.ibm.com>, KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 3 Jun 2019 13:37:45 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 29 May 2019 14:26:51 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
> > From: Halil Pasic <pasic@linux.ibm.com>
> > 
> > To support protected virtualization cio will need to make sure the
> > memory used for communication with the hypervisor is DMA memory.
> > 
> > Let us introduce one global pool for cio.
> > 
> > Our DMA pools are implemented as a gen_pool backed with DMA pages. The
> > idea is to avoid each allocation effectively wasting a page, as we
> > typically allocate much less than PAGE_SIZE.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> > ---
> >  arch/s390/Kconfig           |   1 +
> >  arch/s390/include/asm/cio.h |  11 ++++
> >  drivers/s390/cio/css.c      | 120 ++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 128 insertions(+), 4 deletions(-)
> 
> (...)
> 
> > diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
> > index 1727180e8ca1..43c007d2775a 100644
> > --- a/arch/s390/include/asm/cio.h
> > +++ b/arch/s390/include/asm/cio.h
> > @@ -328,6 +328,17 @@ static inline u8 pathmask_to_pos(u8 mask)
> >  void channel_subsystem_reinit(void);
> >  extern void css_schedule_reprobe(void);
> >  
> > +extern void *cio_dma_zalloc(size_t size);
> > +extern void cio_dma_free(void *cpu_addr, size_t size);
> > +extern struct device *cio_get_dma_css_dev(void);
> > +
> > +struct gen_pool;
> 
> That forward declaration is a bit ugly... 

Can you explain to me what is ugly about it so I can avoid similar
mistakes in the future?

>I guess the alternative was
> include hell?
> 

What do you mean by include hell?

I decided to use a forward declaration because the guys that include
"cio.h" are not expected to require the interfaces defined in
linux/genalloc.h. My motivation to do it like this was the principle of
encapsulation.

Regards,
Halil
