Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:62798 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEMev (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 May 2020 08:34:51 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
Date: Tue, 5 May 2020 05:34:45 -0700
MIME-Version: 1.0
In-Reply-To: <20200504134154.GA21001@oc3748833570.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ulrich Weigand <uweigand@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On 5/4/20 6:41 AM, Ulrich Weigand wrote:
> On Fri, May 01, 2020 at 09:32:45AM -0700, Dave Hansen wrote:
>> The larger point, though, is that the s390 code ensures no extra
>> references exist upon entering make_secure_pte(), but it still has no
>> mechanism to prevent future, new references to page cache pages from
>> being created.
> 
> Hi Dave, I worked with Claudio and Christian on the initial design
> of our approach, so let me chime in here as well.

Hi Ulrich!

> You're right that there is no mechanism to prevent new references,
> but that's really never been the goal either.  We're simply trying
> to ensure that no I/O is ever done on a page that is in the "secure"
> (or inaccessible) state.  To do so, we rely on the assumption that
> all code that starts I/O on a page cache page will *first*:
> - mark the page as pending I/O by either taking an extra page
>   count, or by setting the Writeback flag; then:
> - call arch_make_page_accessible(); then:
> - start I/O; and only after I/O has finished:
> - remove the "pending I/O" marker (Writeback and/or extra ref)

Let's ignore writeback for a moment because get_page() is the more
general case.  The locking sequence is:

1. get_page() (or equivalent) "locks out" a page from converting to
   inaccessbile,
2. followed by a make_page_accessible() guarantees that the page
   *stays* accessible until
3. I/O is safe in this region
4. put_page(), removes the "lock out", I/O now unsafe

They key is, though, the get_page() must happen before
make_page_accessible() and *every* place that acquires a new reference
needs a make_page_accessible().

try_get_page() is obviously one of those "new reference sites" and it
only has one call site outisde of the gup code: generic_pipe_buf_get(),
which is effectively patched by the patch that started this thread.  The
fact that this one oddball site _and_ gup are patched now is a good sign.

*But*, I still don't know how that could work nicely:

> static inline __must_check bool try_get_page(struct page *page)
> {
>         page = compound_head(page);
>         if (WARN_ON_ONCE(page_ref_count(page) <= 0))
>                 return false;
>         page_ref_inc(page);
>         return true;
> }

If try_get_page() collides with a freeze_page_refs(), it'll hit the
WARN_ON_ONCE(), which is surely there for a good reason.  I'm not sure
that warning is _actually_ valid since freeze_page_refs() isn't truly a
0 refcount.  But, the fact that this hasn't been encountered means that
the testing here is potentially lacking.

> We thought we had identified all places where we needed to place
> arch_make_page_accessible so that the above assumption is satisfied.
> You've found at least two instances where this wasn't true (thanks!);
> but I still think that this can be fixed by just adding those calls.

Why do you think that's the extent of the problem?  Because the crashes
stopped?

I'd feel a lot more comfortable if you explained the audits that you've
performed or _why_ you think that.  What I've heard thus far is
basically that you've been able to boot a guest and you're ready to ship
this code.

>> The one existing user of expected_page_refs() freezes the refs then
>> *removes* the page from the page cache (that's what the xas_lock_irq()
>> is for).  That stops *new* refs from being acquired.
>>
>> The s390 code is missing an equivalent mechanism.
>>
>> One example:
>>
>> 	page_freeze_refs();
>> 	// page->_count==0 now
>> 					find_get_page();
>> 					// ^ sees a "freed" page
>> 	page_unfreeze_refs();
>>
>> find_get_page() will either fail to *find* the page because it will see
>> page->_refcount==0 think it is freed (not great), or it will
>> VM_BUG_ON_PAGE() in __page_cache_add_speculative().
> 
> I don't really see how that could happen; my understanding is that
> page_freeze_refs simply causes potential users to spin and wait
> until it is no longer frozen.  For example, find_get_page will
> in the end call down to find_get_entry, which does:
> 
>         if (!page_cache_get_speculative(page))
>                 goto repeat;
> 
> Am I misunderstanding anything here?

Dang, I think I was looking at the TINY_RCU code, which is unfortunately
first in page_cache_get_speculative().  It doesn't support PREEMPT or
SMP, so it can take some shortcuts.

But, with regular RCU, you're right, it _does_ appear that it would hit
that retry loop, but then it would *succeed* in getting a reference.  In
the end, this just supports the sequence I wrote above:
arch_make_page_accessible() is only valid when called with an elevated
refcount and the refcount must be held to lock out make_secure_pte().

>> My bigger point is that this patches doesn't systematically stop finding
>> page cache pages that are arch-inaccessible.  This patch hits *one* of
>> those sites.
> 
> As I said above, that wasn't really the goal for our approach.
> 
> In particular, note that we *must* have secure pages present in the
> page table of the secure guest (that is a requirement of the architecture;
> note that the "secure" status doesn't just apply to the phyiscal page,
> but a triple of "*this* host physical page is the secure backing store
> of *this* guest physical page in *this* secure guest", which the HW/FW
> tracks based on the specific page table entry).
> 
> As a consequence, the page really also has to remain present in the
> page cache (I don't think Linux mm code would be able to handle the
> case where a file-backed page is in the page table but not page cache).

It actually happens transiently, at least.  I believe inode truncation
removes from the page cache before it zaps the PTEs.

> I'm not sure what exactly the requirements for your use case are; if those
> are significantly differently, maybe we can work together to find an
> approach that works for both?

I'm actually trying to figure out what to do with AMD's SEV.  The
current state isn't great and, for instance, allows userspace to read
guest ciphertext.  But, the pages come and go out of the encrypted state
at the behest of the guest, and the kernel needs *some* mapping for the
pages to do things like instruction emulation.

I started looking at s390 because someone said there was a similar
problem there and suggested the hooks might work.  I couldn't figure out
how they worked comprehensively on s390, and that's how we got here.
