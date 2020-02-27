Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200227171704.GK31668@ziepe.ca>
 <e8781f85-3fc7-b9ce-c751-606803cbdc77@deltatee.com> <20200227174311.GL31668@ziepe.ca>
In-Reply-To: <20200227174311.GL31668@ziepe.ca>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 27 Feb 2020 09:55:04 -0800
Message-ID: <CAPcyv4iek=EmNk9JgXq=-HcZjd9Kz4m2+qXMhnDWMshFKFZPXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Logan Gunthorpe <logang@deltatee.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>

On Thu, Feb 27, 2020 at 9:43 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Feb 27, 2020 at 10:21:50AM -0700, Logan Gunthorpe wrote:
> >
> >
> > On 2020-02-27 10:17 a.m., Jason Gunthorpe wrote:
> > >> Instead of this, this series proposes a change to arch_add_memory()
> > >> to take the pgprot required by the mapping which allows us to
> > >> explicitly set pagetable entries for P2PDMA memory to WC.
> > >
> > > Is there a particular reason why WC was selected here? I thought for
> > > the p2pdma cases there was no kernel user that touched the memory?
> >
> > Yes, that's correct. I choose WC here because the existing users are
> > registering memory blocks without side effects which fit the WC
> > semantics well.
>
> Hm, AFAIK WC memory is not compatible with the spinlocks/mutexs/etc in
> Linux, so while it is true the memory has no side effects, there would
> be surprising concurrency risks if anything in the kernel tried to
> write to it.
>
> Not compatible means the locks don't contain stores to WC memory the
> way you would expect. AFAIK on many CPUs extra barriers are required
> to keep WC stores ordered, the same way ARM already has extra barriers
> to keep UC stores ordered with locking..
>
> The spinlocks are defined to contain UC stores though.

How are spinlocks and mutexes getting into p2pdma ranges in the first
instance? Even with UC, the system has bigger problems if it's trying
to send bus locks targeting PCI, see the flurry of activity of trying
to trigger faults on split locks [1].

This does raise a question about separating the cacheability of the
'struct page' memmap from the BAR range. You get this for free if the
memmap is dynamically allocated from "System RAM", but perhaps
memremap_pages() should explicitly prevent altmap configurations that
try to place the map in PCI space?

> If there is no actual need today for WC I would suggest using UC as
> the default.

That's reasonable, but it still seems to be making a broken
configuration marginally less broken. I'd be more interested in
safeguards that prevent p2pdma mappings from being used for any cpu
atomic cycles.

[1]: https://lwn.net/Articles/784864/
