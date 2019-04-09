Return-Path: <SRS0=pOBU=SL=vger.kernel.org=kvm-owner@kernel.org>
Date: Tue, 9 Apr 2019 14:39:06 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 03/12] s390/mm: force swiotlb for protected
 virtualization
In-Reply-To: <20190409122241.GA9312@infradead.org>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
        <20190404231622.52531-4-pasic@linux.ibm.com>
        <20190409122241.GA9312@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190409143906.716e82c0@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 9 Apr 2019 05:22:41 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> > +++ b/arch/s390/include/asm/dma-mapping.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_S390_DMA_MAPPING_H
> > +#define _ASM_S390_DMA_MAPPING_H
> > +
> > +#include <linux/dma-contiguous.h>
> > +
> > +static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> > +{
> > +	return NULL;
> > +}
> > +
> > +#endif /* _ASM_S390_DMA_MAPPING_H */
> > +
> 
> Congratulations!  You ust create an entirely pointless duplicate of
> include/asm-generic/dma-mapping.h.
> 

Right! Thanks for spotting. There was a stage in development when my
arch/s390/include/asm/dma-mapping.h looked quite different, but I did
end up with an entirely pointless duplicate indeed.

I will fix it for v1.

Regards,
Halil
