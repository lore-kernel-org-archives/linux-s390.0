Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23209 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgD3WGt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 18:06:49 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
Date: Thu, 30 Apr 2020 15:06:46 -0700
MIME-Version: 1.0
In-Reply-To: <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk
Cc: david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

I was also wondering if Claudio was right about the debug patch having
races.  I went to go look how the s390 code avoids races when pages go
from accessible->inaccessible.

Because, if if all of the traps are in place to transform pages from
inaccessible->accessible, the code *after* those traps is still
vulnerable.  What *keeps* pages accessible?

The race avoidance is this, basically:

	down_read(&gmap->mm->mmap_sem);
	lock_page(page);
        ptep = get_locked_pte(gmap->mm, uaddr, &ptelock);
...
>         expected = expected_page_refs(page);
>         if (!page_ref_freeze(page, expected))
>                 return -EBUSY;
>         set_bit(PG_arch_1, &page->flags);
>         rc = uv_call(0, (u64)uvcb);
>         page_ref_unfreeze(page, expected);

... up_read(mmap_sem) / unlock_page() / unlock pte

I'm assuming that after the uv_call(), the page is inaccessible and I/O
devices will go boom if they touch the page.

The page_ref_freeze() ensures that references come between the
freeze/unfreeze are noticed, but it doesn't actually *stop* new ones for
users that hold references already.  For the page cache, especially,
someone could do:

	page = find_get_page();
	arch_make_page_accessible();
					lock_page();
	...				make_secure_pte();
					unlock_page();
	get_page();
	// ^ OK because I have a ref
	// do DMA on inaccessible page

Because the make_secure_pte() code isn't looking for a *specific*
'expected' value, it has no way of noticing that the extra ref snuck in
there.

I _think_ expected actually needs to be checked for having a specific
(low) value so that if there's a *possibility* of a reference holder
acquiring additional references, the page is known to be off-limits.
mm/migrate.c has a few examples of this, but I'm not quite sure how
bulletproof they are.  Some of it appears to just be optimizations.
