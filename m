From: Benjamin Serebrin <serebrin@google.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute - DMA_ATTR_IOMMU_BYPASS
Date: Mon, 16 Nov 2015 10:42:23 -0800
Message-ID: <CAN+hb0XLpQs9UiuWkzU=xBT_Tpfntd+XGCLYQDagwsY+HeN-kw@mail.gmail.com>
References: <20151102144427.GA2876@suse.de>
	<20151102173218.GC12484@shamir-ThinkPad-T430>
	<20151105134206.GD2255@suse.de>
	<20151105.161121.188431695871972310.davem@davemloft.net>
	<20151107150642.GA4405@shamir-ThinkPad-T430>
	<CAN+hb0UvztgwNuAh93XdJEe7vgiZgNMc9mHNziHpEopg8Oi4Mg@mail.gmail.com>
	<1447663353.145626.46.camel@infradead.org>
	<CAN+hb0UWpfcS5DvgMxNjY-5JOztw2mO1r2FJAW17fn974mhxPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAN+hb0UWpfcS5DvgMxNjY-5JOztw2mO1r2FJAW17fn974mhxPA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Miller <davem@davemloft.net>, Joerg Roedel <jroedel@suse.de>, benh@kernel.crashing.org, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, hch@lst.de, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 16, 2015 at 12:42 AM, David Woodhouse <dwmw2@infradead.org>=
 wrote:
>
> On Sun, 2015-11-15 at 22:54 -0800, Benjamin Serebrin wrote:
> > We looked into Intel IOMMU performance a while ago and learned a fe=
w
> > useful things.  We generally did a parallel 200 thread TCP_RR test,
> > as this churns through mappings quickly and uses all available core=
s.
> >
> > First, the main bottleneck was software performance[1].
>
> For the Intel IOMMU, *all* we need to do is put a PTE in place. For
> real hardware (i.e not an IOMMU emulated by qemu for a VM), we don't
> need to do an IOTLB flush. It's a single 64-bit write of the PTE.
>
> All else is software overhead.
>

Agreed!

>
> (I'm deliberately ignoring the stupid chipsets where DMA page tables
> aren't cache coherent and we need a clflush too. They make me too sad=
=2E)



How much does Linux need to care about such chipsets?  Can we argue
that they get very sad performance and so be it?

>
>
>
> >   This study preceded the recent patch to break the locks into pool=
s
> > ("Break up monolithic iommu table/lock into finer graularity pools
> > and lock").  There were several points of lock contention:
> > - the RB tree ...
> > - the RB tree ...
> > - the RB tree ...
> >
> > Omer's paper (https://www.usenix.org/system/files/conference/atc15/=
at
> > c15-paper-peleg.pdf) has some promising approaches.  The magazine
> > avoids the RB tree issue.
>
> I'm thinking of ditching the RB tree altogether and switching to the
> allocator in lib/iommu-common.c (and thus getting the benefit of the
> finer granularity pools).


Sounds promising!  Is 4 parallel arenas enough?  We'll try to play
with that here.
I think lazy_flush leaves dangling references.

>
>
> > I'm interested in seeing if the dynamic 1:1 with a mostly-lock-free
> > page table cleanup algorithm could do well.
>
> When you say 'dynamic 1:1 mapping', is that the same thing that's bee=
n
> suggested elsewhere =E2=80=94 avoiding the IOVA allocator completely =
by using a
> virtual address which *matches* the physical address, if that virtual
> address is available?


Yes.  We munge in 2 upper address bits in the IOVA to encode read and
write permissions as well.

>
> Simply cmpxchg on the PTE itself, and if it was
> already set *then* we fall back to the allocator, obviously configure=
d
> to allocate from a range *higher* than the available physical memory.
>
> J=C3=B6rg has been looking at this too, and was even trying to find s=
pace in
> the PTE for a use count so a given page could be in more than one
> mapping before we call back to the IOVA allocator.


Aren't bits 63:52 available at all levels?

>
>
>
> > There are correctness fixes and optimizations left in the
> > invalidation path: I want strict-ish semantics (a page doesn't go
> > back into the freelist until the last IOTLB/IOMMU TLB entry is
> > invalidated) with good performance, and that seems to imply that an
> > additional page reference should be gotten at dma_map time and put
> > back at the completion of the IOMMU flush routine.  (This is worthy
> > of much discussion.)
>
> We already do something like this for page table pages which are free=
d
> by an unmap, FWIW.


As I understood the code when I last looked, this was true only if a
single unmap operation covered an entire table's worth (2MByte, or
1GByte, etc) of mappings.  The caffeine hasn't hit yet, though, so I
can't even begin to dive into the new calls into mm.c.


>
>
> > Additionally, we can find ways to optimize the flush routine by
> > realizing that if we have frequent maps and unmaps, it may be becau=
se
> > the device creates and destroys buffers a lot; these kind of
> > workloads use an IOVA for one event and then never come back.  Mayb=
e
> > TLBs don't do much good and we could just flush the entire IOMMU TL=
B
> > [and ATS cache] for that BDF.
>
> That would be a very interesting thing to look at. Although it would =
be
> nice if we had a better way to measure the performance impact of IOTL=
B
> misses =E2=80=94 currently we don't have a lot of visibility at all.


All benchmarks are lies.  But we intend to run internal workloads as
well as well-agreed loads and see how things go.

>
>
> > 1: We verified that the IOMMU costs are almost entirely software
> > overheads by forcing software 1:1 mode, where we create page tables
> > for all physical addresses.  We tested using leaf nodes of size 4KB=
,
> > of 2MB, and of 1GB.  In call cases, there is zero runtime maintenan=
ce
> > of the page tables, and no IOMMU invalidations.  We did piles of DM=
A
> > maximizing x16 PCIe bandwidth on multiple lanes, to random DRAM
> > addresses.  At 4KB page size, we could see some bandwidth slowdown,
> > but at 2MB and 1GB, there was < 1% performance loss as compared wit=
h
> > IOMMU off.
>
> Was this with ATS on or off? With ATS, the cost of the page walk can =
be
> amortised in some cases =E2=80=94 you can look up the physical addres=
s *before*
> you are ready to actually start the DMA to it, and don't take that
> latency at the time you're actually moving the data.


This was with ATS intentionally disabled; we wanted to stress the
IOMMU's page walker.
Most devices aren't as smart as you describe, though in any kind of
ring buffer where storage is posted,
the device should be doing that.

On Mon, Nov 16, 2015 at 10:09 AM, Benjamin Serebrin <serebrin@google.co=
m> wrote:
>
>
> On Mon, Nov 16, 2015 at 12:42 AM, David Woodhouse <dwmw2@infradead.or=
g>
> wrote:
>>
>> On Sun, 2015-11-15 at 22:54 -0800, Benjamin Serebrin wrote:
>> > We looked into Intel IOMMU performance a while ago and learned a f=
ew
>> > useful things.  We generally did a parallel 200 thread TCP_RR test=
,
>> > as this churns through mappings quickly and uses all available cor=
es.
>> >
>> > First, the main bottleneck was software performance[1].
>>
>> For the Intel IOMMU, *all* we need to do is put a PTE in place. For
>> real hardware (i.e not an IOMMU emulated by qemu for a VM), we don't
>> need to do an IOTLB flush. It's a single 64-bit write of the PTE.
>>
>> All else is software overhead.
>>
>
> Agreed!
>
>>
>> (I'm deliberately ignoring the stupid chipsets where DMA page tables
>> aren't cache coherent and we need a clflush too. They make me too sa=
d.)
>
>
>
> How much does Linux need to care about such chipsets?  Can we argue t=
hat
> they get very sad performance and so be it?
>
>>
>>
>>
>> >   This study preceded the recent patch to break the locks into poo=
ls
>> > ("Break up monolithic iommu table/lock into finer graularity pools
>> > and lock").  There were several points of lock contention:
>> > - the RB tree ...
>> > - the RB tree ...
>> > - the RB tree ...
>> >
>> > Omer's paper (https://www.usenix.org/system/files/conference/atc15=
/at
>> > c15-paper-peleg.pdf) has some promising approaches.  The magazine
>> > avoids the RB tree issue.
>>
>> I'm thinking of ditching the RB tree altogether and switching to the
>> allocator in lib/iommu-common.c (and thus getting the benefit of the
>> finer granularity pools).
>
>
> Sounds promising!  Is 4 parallel arenas enough?  We'll try to play wi=
th that
> here.
> I think lazy_flush leaves dangling references.
>
>>
>>
>> > I'm interested in seeing if the dynamic 1:1 with a mostly-lock-fre=
e
>> > page table cleanup algorithm could do well.
>>
>> When you say 'dynamic 1:1 mapping', is that the same thing that's be=
en
>> suggested elsewhere =E2=80=94 avoiding the IOVA allocator completely=
 by using a
>> virtual address which *matches* the physical address, if that virtua=
l
>> address is available?
>
>
> Yes.  We munge in 2 upper address bits in the IOVA to encode read and=
 write
> permissions as well.
>
>>
>> Simply cmpxchg on the PTE itself, and if it was
>> already set *then* we fall back to the allocator, obviously configur=
ed
>> to allocate from a range *higher* than the available physical memory=
=2E
>>
>> J=C3=B6rg has been looking at this too, and was even trying to find =
space in
>> the PTE for a use count so a given page could be in more than one
>> mapping before we call back to the IOVA allocator.
>
>
> Aren't bits 63:52 available at all levels?
>
>>
>>
>>
>> > There are correctness fixes and optimizations left in the
>> > invalidation path: I want strict-ish semantics (a page doesn't go
>> > back into the freelist until the last IOTLB/IOMMU TLB entry is
>> > invalidated) with good performance, and that seems to imply that a=
n
>> > additional page reference should be gotten at dma_map time and put
>> > back at the completion of the IOMMU flush routine.  (This is worth=
y
>> > of much discussion.)
>>
>> We already do something like this for page table pages which are fre=
ed
>> by an unmap, FWIW.
>
>
> As I understood the code when I last looked, this was true only if a =
single
> unmap operation covered an entire table's worth (2MByte, or 1GByte, e=
tc) of
> mappings.  The caffeine hasn't hit yet, though, so I can't even begin=
 to
> dive into the new calls into mm.c.
>
>
>>
>>
>> > Additionally, we can find ways to optimize the flush routine by
>> > realizing that if we have frequent maps and unmaps, it may be beca=
use
>> > the device creates and destroys buffers a lot; these kind of
>> > workloads use an IOVA for one event and then never come back.  May=
be
>> > TLBs don't do much good and we could just flush the entire IOMMU T=
LB
>> > [and ATS cache] for that BDF.
>>
>> That would be a very interesting thing to look at. Although it would=
 be
>> nice if we had a better way to measure the performance impact of IOT=
LB
>> misses =E2=80=94 currently we don't have a lot of visibility at all.
>
>
> All benchmarks are lies.  But we intend to run internal workloads as =
well as
> well-agreed loads and see how things go.
>
>>
>>
>> > 1: We verified that the IOMMU costs are almost entirely software
>> > overheads by forcing software 1:1 mode, where we create page table=
s
>> > for all physical addresses.  We tested using leaf nodes of size 4K=
B,
>> > of 2MB, and of 1GB.  In call cases, there is zero runtime maintena=
nce
>> > of the page tables, and no IOMMU invalidations.  We did piles of D=
MA
>> > maximizing x16 PCIe bandwidth on multiple lanes, to random DRAM
>> > addresses.  At 4KB page size, we could see some bandwidth slowdown=
,
>> > but at 2MB and 1GB, there was < 1% performance loss as compared wi=
th
>> > IOMMU off.
>>
>> Was this with ATS on or off? With ATS, the cost of the page walk can=
 be
>> amortised in some cases =E2=80=94 you can look up the physical addre=
ss *before*
>> you are ready to actually start the DMA to it, and don't take that
>> latency at the time you're actually moving the data.
>
>
> This was with ATS intentionally disabled; we wanted to stress the IOM=
MU's
> page walker.
> Most devices aren't as smart as you describe, though in any kind of r=
ing
> buffer where storage is posted,
> the device should be doing that.
>
>>
>>
>> --
>> David Woodhouse                            Open Source Technology Ce=
ntre
>> David.Woodhouse@intel.com                              Intel Corpora=
tion
>>
>
