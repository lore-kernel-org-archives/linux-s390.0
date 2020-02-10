Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728100AbgBJR1R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 12:27:17 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AHJ8eQ003817
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 12:27:15 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tpbs1n7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 12:27:15 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 17:27:13 -0000
Subject: Re: [PATCH 01/35] mm:gup/writeback: add callbacks for inaccessible
 pages
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-2-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 18:27:04 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <28792269-e053-ac70-a344-45612ee5c729@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, kvm-ppc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>

CC Marc Zyngier for KVM on ARM.  Marc, see below. Will there be any
use for this on KVM/ARM in the future?

CC Sean Christopherson/Tom Lendacky. Any obvious use case for Intel/AMD
to have a callback before a page is used for I/O?

Andrew (or other mm people) any chance to get an ACK for this change?
I could then carry that via s390 or KVM tree. Or if you want to carry
that yourself I can send an updated version (we need to kind of 
synchronize that Linus will pull the KVM changes after the mm changes).

Andrea asked if others would benefit from this, so here are some more
information about this (and I can also put this into the patch
description).  So we have talked to the POWER folks. They do not use
the standard normal memory management, instead they have a hard split
between secure and normal memory. The secure memory  is the handled by
the hypervisor as device memory and the ultravisor and the hypervisor
move this forth and back when needed.

On s390 there is no *separate* pool of physical pages that are secure.
Instead, *any* physical page can be marked as secure or not, by
setting a bit in a per-page data structure that hardware uses to stop
unauthorized access.  (That bit is under control of the ultravisor.)

Note that one side effect of this strategy is that the decision
*which* secure pages to encrypt and then swap out is actually done by
the hypervisor, not the ultravisor.  In our case, the hypervisor is
Linux/KVM, so we're using the regular Linux memory management scheme
(active/inactive LRU lists etc.) to make this decision.  The advantage
is that the Ultravisor code does not need to itself implement any
memory management code, making it a lot simpler.

However, in the end this is why we need the hook into Linux memory
management: once Linux has decided to swap a page out, we need to get
a chance to tell the Ultravisor to "export" the page (i.e., encrypt
its contents and mark it no longer secure).

As outlined below this should be a no-op for anybody not opting in.

Christian                                   

On 07.02.20 12:39, Christian Borntraeger wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> With the introduction of protected KVM guests on s390 there is now a
> concept of inaccessible pages. These pages need to be made accessible
> before the host can access them.
> 
> While cpu accesses will trigger a fault that can be resolved, I/O
> accesses will just fail.  We need to add a callback into architecture
> code for places that will do I/O, namely when writeback is started or
> when a page reference is taken.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  include/linux/gfp.h | 6 ++++++
>  mm/gup.c            | 2 ++
>  mm/page-writeback.c | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index e5b817cb86e7..be2754841369 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -485,6 +485,12 @@ static inline void arch_free_page(struct page *page, int order) { }
>  #ifndef HAVE_ARCH_ALLOC_PAGE
>  static inline void arch_alloc_page(struct page *page, int order) { }
>  #endif
> +#ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
> +static inline int arch_make_page_accessible(struct page *page)
> +{
> +	return 0;
> +}
> +#endif
>  
>  struct page *
>  __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> diff --git a/mm/gup.c b/mm/gup.c
> index 7646bf993b25..a01262cd2821 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -257,6 +257,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  			page = ERR_PTR(-ENOMEM);
>  			goto out;
>  		}
> +		arch_make_page_accessible(page);
>  	}
>  	if (flags & FOLL_TOUCH) {
>  		if ((flags & FOLL_WRITE) &&
> @@ -1870,6 +1871,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  
>  		VM_BUG_ON_PAGE(compound_head(page) != head, page);
>  
> +		arch_make_page_accessible(page);
>  		SetPageReferenced(page);
>  		pages[*nr] = page;
>  		(*nr)++;
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 2caf780a42e7..0f0bd14571b1 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2806,6 +2806,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
>  		inc_lruvec_page_state(page, NR_WRITEBACK);
>  		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
>  	}
> +	arch_make_page_accessible(page);
>  	unlock_page_memcg(page);

As outlined by Ulrich, we can move the callback after the unlock.

>  	return ret;
>  
> 
