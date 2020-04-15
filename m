Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47466 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgDOXeT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Apr 2020 19:34:19 -0400
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
 <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
 <20200415221754.GM2483@worktop.programming.kicks-ass.net>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
Date: Wed, 15 Apr 2020 16:34:14 -0700
MIME-Version: 1.0
In-Reply-To: <20200415221754.GM2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On 4/15/20 3:17 PM, Peter Zijlstra wrote:
> On Wed, Apr 15, 2020 at 02:52:31PM -0700, Dave Hansen wrote:
>> Yes, the docs do say that FOLL_PIN is for accessing the pages.  But,
>> there's a crucial thing that it leaves out: *WHO* will be accessing the
>> pages.  For Direct IO, for instance, the CPU isn't touching the page at
>> all.  It's always a device.  Also, crucially, the page contents are
>> *not* accessible from the CPU's perspective after a gup.  They're not
>> accessible until a kmap().  They're also not even accessible for
>> *devices* after a gup.  There's a _separate_ mapping process that's
>> requires to make them accessible to the CPU.
> 
> I think the crucial detail is that we can fail gup(), while we cannot
> ever fail kmap() or whatever else a device needs to do.

Yep, good point.

The patch in question puts says that you now need to do something to the
page before it can be accessed by the kernel.  Because this is
presumably anonymous-only, and the only main way to get to anonymous
pages is the page tables, and the gup code is our de facto user page
table walker, this works OK-ish.

But, the gup code isn't out only walker.  Grepping for pte_page() finds
a bunch of sites that this approach misses.  They'll theoretically each
have to be patched if we want to extend this gup-time approach for
anything other than anonymous, small pages.

(Most of the additional pte_page() sites are for huge pages, which can't
be protected on s390.)

>>> +	access_ret = arch_make_page_accessible(page);
>>> +	/*
>>> +	 * If writeback has been triggered on a page that cannot be made
>>> +	 * accessible, it is too late to recover here.
>>> +	 */
>>> +	VM_BUG_ON_PAGE(access_ret != 0, page);
>>> +
>>>  	return ret;
>>>  
>>>  }
>>
>> I think this one really shows the cracks in the approach.  Pages being
>> swapped *don't* have get_user_pages() done on them since we've already
>> got the physical page at the time writeback and aren't looking at PTEs.
> 
> I suspect this happens because FOLL_TOUCH or something later does
> set_page_dirty() on the page, which then eventually gets it in
> writeback.

I assumed that this was all anonymous-only so it's always dirty before
writeback starts.

>> Why do I care?
>>
>> I was looking at AMD's SEV (Secure Encrypted Virtualization) code which
>> is in the kernel which shares some implementation details with the
>> not-in-the-tree Intel MKTME.  SEV currently has a concept of guest pages
>> being encrypted and being gibberish to the host, plus a handshake to
>> share guest-selected pages.  Some of the side-effects of exposing the
>> gibberish to the host aren't great (I think it can break cache coherency
>> if a stray write occurs) and it would be nice to get better behavior.
>>
>> But, to get better behavior, the host kernel might need to remove pages
>> from its direct map, making them inaccessible. 
> 
> But for SEV we would actually need to fail this
> arch_make_page_acesssible() thing, right? 

Yeah, we would ideally fail it, but not at the current
arch_make_page_acesssible() site.  If the PTE isn't usable, we shouldn't
be creating it in the first place, or shouldn't leave it Present=1 and
GUP'able in the page tables once the underlying memory is no longer
accessible.

I _think_ vm_normal_page() is the right place to do it, when we're
dealing with a PTE but don't yet have a 'struct page'.

> The encrypted guest pages cannot be sanely accessed by the host IIRC,
> ever. Isn't their encryption key linked to the phys addr of the
> page?
Yes, and the keys can't even be used unless you are inside the VM.

But this begs the question: why did we create PTEs which can't be used?
 Just to have something to gup?

>> I was hoping to reuse
>> arch_make_page_accessible() for obvious reasons.  But, get_user_pages()
>> is not the right spot to map pages because they might not *ever* be
>> accessed by the CPU, only devices.
> 
> I'm confused, why does it matter who accesses it? The point is that they
> want to access it through this vaddr/mapping.

To me, that's the entire *point* of get_user_pages().  It's someone
saying: "I want to find out what this mapping does, but I actually can't
use *that* mapping."  I'm either:

1. A device that does I/O to the paddr space or through an IOMMU, or
2. The kernel but I want access to that page via *another* mapping (if
   we could use the gup'd mapping, we would, but we know we can't)

and I need the physical address space to stay consistent for a bit so I
can do those things via other address spaces.
