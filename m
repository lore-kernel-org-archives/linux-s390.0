From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
Date: Mon, 2 Nov 2015 19:32:19 +0200
Message-ID: <20151102173218.GC12484@shamir-ThinkPad-T430>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
 <1446013801.3405.183.camel@infradead.org>
 <20151028111049.GA30785@shamir-ThinkPad-T430>
 <1446039110.3405.212.camel@infradead.org>
 <1446078721.1856.49.camel@kernel.crashing.org>
 <1446079332.3405.273.camel@infradead.org>
 <20151029073231.GE30785@shamir-ThinkPad-T430>
 <20151102144427.GA2876@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151102144427.GA2876@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 02, 2015 at 03:44:27PM +0100, Joerg Roedel wrote:
> 
> How do you envision this per-mapping by-pass to work? For the DMA-API
> mappings you have only one device address space. For by-pass to work,
> you need to map all physical memory of the machine into this space,
> which leaves the question where you want to put the window for
> remapping.
> 
> You surely have to put it after the physical mappings, but any
> protection will be gone, as the device can access all physical memory.

Correct. This issue is one of the concerns here in the previous replies.
I will take different approach which will not require the IOMMU bypass
per mapping. Will try to shift to the x86 'iommu=pt' approach.

> 
> So instead of working around the shortcomings of DMA-API
> implementations, can you present us some numbers and analysis of how bad
> the performance impact with an IOMMU is and what causes it?

We had a bunch of issues around SPARC IOMMU. Not all of them relate to
performance. The first issue was that on SPARC, currently, we only have 
limited address space to IOMMU so we had issue to do large DMA mappings
for Infiniband. Second issue was that we identified high contention on 
the IOMMU locks even in ETH driver. 

> 
> I know that we have lock-contention issues in our IOMMU drivers, which
> can be fixed. Maybe the performance problems you are seeing can be fixed
> too, when you give us more details about them.
> 

I do not want to put too much information here but you can see some results:

rds-stress test from sparc t5-2 -> x86:

with iommu bypass:
---------------------
sparc->x86 cmdline = -r XXX -s XXX -q 256 -a 8192 -T 10 -d 10 -t 3 -o XXX
tsks   tx/s   rx/s  tx+rx K/s    mbi K/s    mbo K/s tx us/c   rtt us cpu %
   3 141278      0 1165565.81       0.00       0.00    8.93   376.60 -1.00  (average)

without iommu bypass:
---------------------
sparc->x86 cmdline = -r XXX -s XXX -q 256 -a 8192 -T 10 -d 10 -t 3 -o XXX
tsks   tx/s   rx/s  tx+rx K/s    mbi K/s    mbo K/s tx us/c   rtt us cpu %
   3  78558      0  648101.41       0.00       0.00   15.05   876.72 -1.00  (average)

+ RDMA tests are totally not working (might be due to failure to DMA map all the memory).

So IOMMU bypass give ~80% performance boost.

> 
> 	Joerg
