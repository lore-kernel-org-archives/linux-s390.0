Return-Path: <SRS0=MIKI=TW=vger.kernel.org=kvm-owner@kernel.org>
Date: Thu, 23 May 2019 00:12:46 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 05/10] s390/cio: introduce DMA pools to cio
In-Reply-To: <alpine.LFD.2.21.1905221344180.1782@schleppi>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
        <20190426183245.37939-6-pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905081447280.1773@schleppi>
        <20190508232210.5a555caa.pasic@linux.ibm.com>
        <20190509121106.48aa04db.cohuck@redhat.com>
        <20190510001112.479b2fd7.pasic@linux.ibm.com>
        <20190510161013.7e697337.cohuck@redhat.com>
        <20190512202256.5517592d.pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905161517570.1767@schleppi>
        <20190520141312.4e3a2d36.pasic@linux.ibm.com>
        <alpine.LFD.2.21.1905221344180.1782@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190523001246.449154aa.pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 22 May 2019 14:07:05 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> On Mon, 20 May 2019, Halil Pasic wrote:
> > On Thu, 16 May 2019 15:59:22 +0200 (CEST)
> > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > > We only have a couple of users for airq_iv:
> > > 
> > > virtio_ccw.c: 2K bits
> > 
> > You mean a single allocation is 2k bits (VIRTIO_IV_BITS = 256 * 8)? My
> > understanding is that the upper bound is more like:
> > MAX_AIRQ_AREAS * VIRTIO_IV_BITS = 20 * 256 * 8 = 40960 bits.
> > 
> > In practice it is most likely just 2k.
> > 
> > > 
> > > pci with floating IRQs: <= 2K (for the per-function bit vectors)
> > >                         1..4K (for the summary bit vector)
> > >
> > 
> > As far as I can tell with virtio_pci arch_setup_msi_irqs() gets called
> > once per device and allocates a small number of bits (2 and 3 in my
> > test, it may depend on #virtqueues, but I did not check).
> > 
> > So for an upper bound we would have to multiply with the upper bound of
> > pci devices/functions. What is the upper bound on the number of
> > functions?
> > 
> > > pci with CPU directed IRQs: 2K (for the per-CPU bit vectors)
> > >                             1..nr_cpu (for the summary bit vector)
> > > 
> > 
> > I guess this is the same.
> > 
> > > 
> > > The options are:
> > > * page allocations for everything
> > 
> > Worst case we need 20 + #max_pci_dev pages. At the moment we allocate
> > from ZONE_DMA (!) and waste a lot.
> > 
> > > * dma_pool for AIRQ_IV_CACHELINE ,gen_pool for others
> > 
> > I prefer this. Explanation follows.
> > 
> > > * dma_pool for everything
> > > 
> > 
> > Less waste by factor factor 16.
> > 
> > > I think we should do option 3 and use a dma_pool with cachesize
> > > alignment for everything (as a prerequisite we have to limit
> > > config PCI_NR_FUNCTIONS to 2K - but that is not a real constraint).
> > 
> > I prefer option 3 because it is conceptually the smallest change, and
>                   ^
>                   2
> > provides the behavior which is closest to the current one.
> 
> I can see that this is the smallest change on top of the current
> implementation. I'm good with doing that and looking for further
> simplification/unification later.
> 

Nod. I will go with that for v2.

> 
> > Commit  414cbd1e3d14 "s390/airq: provide cacheline aligned
> > ivs" (Sebastian Ott, 2019-02-27) could have been smaller had you implemented
> > 'kmem_cache for everything' (and I would have had just to replace kmem_cache with
> > dma_cache to achieve option 3). For some reason you decided to keep the
> > iv->vector = kzalloc(size, GFP_KERNEL) code-path and make the client code request
> > iv->vector = kmem_cache_zalloc(airq_iv_cache, GFP_KERNEL) explicitly, using a flag
> > which you only decided to use for directed pci irqs AFAICT.
> > 
> > My understanding of these decisions, and especially of the rationale
> > behind commit 414cbd1e3d14 is limited.
> 
> I introduced per cpu interrupt vectors and wanted to prevent 2 CPUs from
> sharing data from the same cacheline. No other user of the airq stuff had
> this need. If I had been aware of the additional complexity we would add
> on top of that maybe I would have made a different decision.

I understand. Thanks for the explanation!

Regards,
Halil
