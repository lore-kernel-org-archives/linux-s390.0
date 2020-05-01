Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:56120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgEAQcr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 1 May 2020 12:32:47 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
Date: Fri, 1 May 2020 09:32:45 -0700
MIME-Version: 1.0
In-Reply-To: <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk
Cc: david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On 5/1/20 12:18 AM, Christian Borntraeger wrote:
>> 					unlock_page();
>> 	get_page();
>> 	// ^ OK because I have a ref
>> 	// do DMA on inaccessible page
>>
>> Because the make_secure_pte() code isn't looking for a *specific*
>> 'expected' value, it has no way of noticing that the extra ref snuck in
>> there.
> I think the expected calcution is actually doing that,giving back the minimum
> value when no one else has any references that are valid for I/O.
> 
> But I might not have understood what you are trying to tell me?

I was wrong.  I was looking at migrate_page_move_mapping():

>         int expected_count = expected_page_refs(mapping, page) + extra_count;
...
>         xas_lock_irq(&xas);
>         if (page_count(page) != expected_count || xas_load(&xas) != page) {
>                 xas_unlock_irq(&xas);
>                 return -EAGAIN;
>         }
> 
>         if (!page_ref_freeze(page, expected_count)) {
>                 xas_unlock_irq(&xas);
>                 return -EAGAIN;
>         }

I saw the check for page_count(page) *and* the page_ref_freeze() call.
My assumption was that both were needed.  My assumption was wrong.  (I
think the migrate_page_move_mapping() code may actually be doing a
superfluous check.)

The larger point, though, is that the s390 code ensures no extra
references exist upon entering make_secure_pte(), but it still has no
mechanism to prevent future, new references to page cache pages from
being created.

The one existing user of expected_page_refs() freezes the refs then
*removes* the page from the page cache (that's what the xas_lock_irq()
is for).  That stops *new* refs from being acquired.

The s390 code is missing an equivalent mechanism.

One example:

	page_freeze_refs();
	// page->_count==0 now
					find_get_page();
					// ^ sees a "freed" page
	page_unfreeze_refs();

find_get_page() will either fail to *find* the page because it will see
page->_refcount==0 think it is freed (not great), or it will
VM_BUG_ON_PAGE() in __page_cache_add_speculative().

My bigger point is that this patches doesn't systematically stop finding
page cache pages that are arch-inaccessible.  This patch hits *one* of
those sites.
