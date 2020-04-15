Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
Date: Wed, 15 Apr 2020 14:52:31 -0700
MIME-Version: 1.0
In-Reply-To: <20200306132537.783769-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On 3/6/20 5:25 AM, Claudio Imbrenda wrote:
> +	/*
> +	 * We need to make the page accessible if and only if we are going
> +	 * to access its content (the FOLL_PIN case).  Please see
> +	 * Documentation/core-api/pin_user_pages.rst for details.
> +	 */
> +	if (flags & FOLL_PIN) {
> +		ret = arch_make_page_accessible(page);
> +		if (ret) {
> +			unpin_user_page(page);
> +			page = ERR_PTR(ret);
> +			goto out;
> +		}
> +	}

Thanks, Claudio, for a really thorough refresher on this in private mail.

But, I think this mechanism probably hooks into the wrong place.  I
don't doubt that it *functions* on s390, but I think these calls are
misplaced.  I think the end result is that no other architecture will
have a chance to use the same hooks.  They're far too s390-specific even
for a concept that's not limited to s390.

get_user_pages(FOLL_PIN) does *not* mean "the kernel will access this
page's contents".  The kmap() family is really what we use for that.
kmap()s are often *preceded* by get_user_pages(), which is probably why
this works for you, though.

Yes, the docs do say that FOLL_PIN is for accessing the pages.  But,
there's a crucial thing that it leaves out: *WHO* will be accessing the
pages.  For Direct IO, for instance, the CPU isn't touching the page at
all.  It's always a device.  Also, crucially, the page contents are
*not* accessible from the CPU's perspective after a gup.  They're not
accessible until a kmap().  They're also not even accessible for
*devices* after a gup.  There's a _separate_ mapping process that's
requires to make them accessible to the CPU.

> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2764,7 +2764,7 @@ int test_clear_page_writeback(struct page *page)
>  int __test_set_page_writeback(struct page *page, bool keep_write)
>  {
>  	struct address_space *mapping = page_mapping(page);
> -	int ret;
> +	int ret, access_ret;
>  
>  	lock_page_memcg(page);
>  	if (mapping && mapping_use_writeback_tags(mapping)) {
> @@ -2807,6 +2807,13 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
>  		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
>  	}
>  	unlock_page_memcg(page);
> +	access_ret = arch_make_page_accessible(page);
> +	/*
> +	 * If writeback has been triggered on a page that cannot be made
> +	 * accessible, it is too late to recover here.
> +	 */
> +	VM_BUG_ON_PAGE(access_ret != 0, page);
> +
>  	return ret;
>  
>  }

I think this one really shows the cracks in the approach.  Pages being
swapped *don't* have get_user_pages() done on them since we've already
got the physical page at the time writeback and aren't looking at PTEs.

They're read by I/O devices sending them out to storage, but also by the
CPU if you're doing something like zswap.  But, again, critically,
accessing page contents won't be done until kmap().

I suspect you saw crashes underneath __swap_writepage()->submit_bio()
and looked a few lines up to the set_page_writeback() and decided to
hook in there.  I think a better spot, again, is to hook into kmap()
which is called in the block layer.

Why do I care?

I was looking at AMD's SEV (Secure Encrypted Virtualization) code which
is in the kernel which shares some implementation details with the
not-in-the-tree Intel MKTME.  SEV currently has a concept of guest pages
being encrypted and being gibberish to the host, plus a handshake to
share guest-selected pages.  Some of the side-effects of exposing the
gibberish to the host aren't great (I think it can break cache coherency
if a stray write occurs) and it would be nice to get better behavior.

But, to get better behavior, the host kernel might need to remove pages
from its direct map, making them inaccessible.  I was hoping to reuse
arch_make_page_accessible() for obvious reasons.  But, get_user_pages()
is not the right spot to map pages because they might not *ever* be
accessed by the CPU, only devices.

Anyway, I know it's late feedback, but I'd hate to have core code like
this that has no hope of ever getting reused.
