Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635123AbgDPMQG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 08:16:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GC4l8N058432
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 08:16:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30eh6eb4ws-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Apr 2020 08:16:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 16 Apr 2020 13:15:16 +0100
Date: Thu, 16 Apr 2020 14:15:47 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
In-Reply-To: <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
        <20200306132537.783769-3-imbrenda@linux.ibm.com>
        <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
        <20200415221754.GM2483@worktop.programming.kicks-ass.net>
        <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200416141547.29be5ea0@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On Wed, 15 Apr 2020 16:34:14 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/15/20 3:17 PM, Peter Zijlstra wrote:
> > On Wed, Apr 15, 2020 at 02:52:31PM -0700, Dave Hansen wrote:  
> >> Yes, the docs do say that FOLL_PIN is for accessing the pages.
> >> But, there's a crucial thing that it leaves out: *WHO* will be
> >> accessing the pages.  For Direct IO, for instance, the CPU isn't
> >> touching the page at all.  It's always a device.  Also, crucially,
> >> the page contents are *not* accessible from the CPU's perspective
> >> after a gup.  They're not accessible until a kmap().  They're also
> >> not even accessible for *devices* after a gup.  There's a
> >> _separate_ mapping process that's requires to make them accessible
> >> to the CPU.  
> > 
> > I think the crucial detail is that we can fail gup(), while we
> > cannot ever fail kmap() or whatever else a device needs to do.  
> 
> Yep, good point.
> 
> The patch in question puts says that you now need to do something to
> the page before it can be accessed by the kernel.  Because this is

actually, before it can be accessed by anything. In fact, if the kernel
touches a protected page on s390 it gets a recoverable fault, and our
fault handler basically calls arch_make_page_accessible. the problem is
that I/O devices can touch the memory without the CPU touching it
first. so they would try to read or write on protected memory, causing
all kinds of issues.

> presumably anonymous-only, and the only main way to get to anonymous
> pages is the page tables, and the gup code is our de facto user page
> table walker, this works OK-ish.

actually this also works for mmapped memory, you can always write to
memory and then call sync, the effect is similar to swapping (both use
writeback IIRC)

> But, the gup code isn't out only walker.  Grepping for pte_page()
> finds a bunch of sites that this approach misses.  They'll
> theoretically each have to be patched if we want to extend this
> gup-time approach for anything other than anonymous, small pages.

well, no. walking the page tables gives you a physical address, but you
have no guarantees that the page will still be there later. that's the
whole point of gup - you make sure the page stays pinned in memory

e.g. stuff like follow_page without FOLL_PIN or FOLL_GET offers no
guarantee that the page will still be there one nanosecond later 

> (Most of the additional pte_page() sites are for huge pages, which
> can't be protected on s390.)
> 
> >>> +	access_ret = arch_make_page_accessible(page);
> >>> +	/*
> >>> +	 * If writeback has been triggered on a page that cannot
> >>> be made
> >>> +	 * accessible, it is too late to recover here.
> >>> +	 */
> >>> +	VM_BUG_ON_PAGE(access_ret != 0, page);
> >>> +
> >>>  	return ret;
> >>>  
> >>>  }  
> >>
> >> I think this one really shows the cracks in the approach.  Pages
> >> being swapped *don't* have get_user_pages() done on them since
> >> we've already got the physical page at the time writeback and
> >> aren't looking at PTEs.  
> > 
> > I suspect this happens because FOLL_TOUCH or something later does
> > set_page_dirty() on the page, which then eventually gets it in
> > writeback.  
> 
> I assumed that this was all anonymous-only so it's always dirty before
> writeback starts.

it could also be mmapped

> >> Why do I care?
> >>
> >> I was looking at AMD's SEV (Secure Encrypted Virtualization) code
> >> which is in the kernel which shares some implementation details
> >> with the not-in-the-tree Intel MKTME.  SEV currently has a concept
> >> of guest pages being encrypted and being gibberish to the host,
> >> plus a handshake to share guest-selected pages.  Some of the
> >> side-effects of exposing the gibberish to the host aren't great (I
> >> think it can break cache coherency if a stray write occurs) and it
> >> would be nice to get better behavior.
> >>
> >> But, to get better behavior, the host kernel might need to remove
> >> pages from its direct map, making them inaccessible.   
> > 
> > But for SEV we would actually need to fail this
> > arch_make_page_acesssible() thing, right?   
> 
> Yeah, we would ideally fail it, but not at the current
> arch_make_page_acesssible() site.  If the PTE isn't usable, we
> shouldn't be creating it in the first place, or shouldn't leave it
> Present=1 and GUP'able in the page tables once the underlying memory
> is no longer accessible.

the problem is that the page needs to be present, otherwise it cannot
be used in the VM. the protected VM can access the content of otherwise
inaccessible pages -- that's the whole point. we have userspace pages
that need to be mapped, but whose content should not be touched by I/O
without being "made accessible" first. and the I/O devices don't
necessarily use the DMA API

> I _think_ vm_normal_page() is the right place to do it, when we're
> dealing with a PTE but don't yet have a 'struct page'.
> 
> > The encrypted guest pages cannot be sanely accessed by the host
> > IIRC, ever. Isn't their encryption key linked to the phys addr of
> > the page?  
> Yes, and the keys can't even be used unless you are inside the VM.
> 
> But this begs the question: why did we create PTEs which can't be
> used? Just to have something to gup?

the userspace PTEs (which are used for the protected guest) are needed
by the protected guest to access its memory. memory that is
"inaccessible" for the kernel is accessible by the hardware/firmware
and by the protected guest it belongs to. if the PTE is not valid, the
guest cannot run.

> >> I was hoping to reuse
> >> arch_make_page_accessible() for obvious reasons.  But,
> >> get_user_pages() is not the right spot to map pages because they
> >> might not *ever* be accessed by the CPU, only devices.  
> > 
> > I'm confused, why does it matter who accesses it? The point is that
> > they want to access it through this vaddr/mapping.  
> 
> To me, that's the entire *point* of get_user_pages().  It's someone
> saying: "I want to find out what this mapping does, but I actually
> can't use *that* mapping."  I'm either:
> 
> 1. A device that does I/O to the paddr space or through an IOMMU, or

this is exactly the thing we want to protect ourselves from

> 2. The kernel but I want access to that page via *another* mapping (if
>    we could use the gup'd mapping, we would, but we know we can't)

on s390 this is also true sometimes, because the kernel has a 1-to-1
mapping of all physical memory, and that's the mapping used to access
all pages when we have only the physical address.

copy to user actually uses the userspace mapping

s390 has separate address spaces for kernel and userspace

also, notice that in this case which mapping is used is irrelevant: you
could work with paging disabled, you still need to make the physical
pages accessible before the kernel or anyone else (except
hardware/firmware and the protected VM it belongs to) can touch them.

> and I need the physical address space to stay consistent for a bit so
> I can do those things via other address spaces.
