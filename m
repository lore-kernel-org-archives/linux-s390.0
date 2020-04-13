Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:21847 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388320AbgDMUW1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Apr 2020 16:22:27 -0400
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <11dc928d-60b4-f04f-1ebf-f4cffb337a6c@intel.com>
Date: Mon, 13 Apr 2020 13:22:24 -0700
MIME-Version: 1.0
In-Reply-To: <20200306132537.783769-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>

On 3/6/20 5:25 AM, Claudio Imbrenda wrote:
> On s390x the function is not supposed to fail, so it is ok to use a
> WARN_ON on failure. If we ever need some more finegrained handling
> we can tackle this when we know the details.

Could you explain a bit why the function can't fail?

If the guest has secret data in the page, then it *can* and does fail.
It won't fail, though, if the host and guest agree on whether the page
is protected.

Right?

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

This seems like a really odd place to do this.  Writeback is specific to
block I/O.  I would have thought there were other kinds of devices that
matter, not just block devices.

Also, this patch seems odd that it only does the
arch_make_page_accessible() half.  Where's the other half where the page
is made inaccessible?

I assume it's OK to "leak" things like this, it's just not clear to me
_why_ it's OK.
