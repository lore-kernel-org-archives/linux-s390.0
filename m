Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgGXOdE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Jul 2020 10:33:04 -0400
Date: Fri, 24 Jul 2020 16:32:50 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] s390: implement and optimize vmemmap_free()
Message-ID: <20200724143250.GB4063@osiris>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

On Wed, Jul 22, 2020 at 11:45:49AM +0200, David Hildenbrand wrote:
> This series is based on the latest s390/features branch [1]. It
> consolidates vmem_add_range(), vmem_remove_range(), and vmemmap_populate()
> into a single, recursive page table walker. It then implements
> vmemmap_free() and optimizes it by
> - Freeing empty page tables (also done for vmem_remove_range()).
> - Handling cases where the vmemmap of a section does not fill huge pages
>   completely (e.g., sizeof(struct page) == 56).
> 
> vmemmap_free() is currently never used, unless adiing standby memory fails
> (unlikely). This is relevant for virtio-mem, which adds/removes memory
> in memory block/section granularity (always removes memory in the same
> granularity it added it).
> 
> I gave this a proper test with my virtio-mem prototype (which I will share
> in the near future), both with 56 byte memmap per page and 64 byte memmap
> per page, with and without huge page support. In both cases, removing
> memory (routed through arch_remove_memory()) will result in
> - all populated vmemmap pages to get removed/freed
> - all applicable page tables for the vmemmap getting removed/freed
> - all applicable page tables for the idendity mapping getting removed/freed
> Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
> environments.
> 
> This is the basis for real memory hotunplug support for s390x and should
> complete my journey to s390x vmem/vmemmap code for now
> 
> What needs double-checking is tlb flushing. AFAIKS, as there are no valid
> accesses, doing a single range flush at the end is sufficient, both when
> removing vmemmap pages and the idendity mapping.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features
> 
> v1 -> v2:
> - Convert to a single page table walker named "modify_pagetable()", with
>   two helper functions "add_pagetable()" and "remove_pagetable().
> 
> David Hildenbrand (9):
>   s390/vmem: rename vmem_add_mem() to vmem_add_range()
>   s390/vmem: consolidate vmem_add_range() and vmem_remove_range()
>   s390/vmemmap: extend modify_pagetable() to handle vmemmap
>   s390/vmemmap: cleanup when vmemmap_populate() fails
>   s390/vmemmap: take the vmem_mutex when populating/freeing
>   s390/vmem: cleanup empty page tables
>   s390/vmemmap: fallback to PTEs if mapping large PMD fails
>   s390/vmemmap: remember unused sub-pmd ranges
>   s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive
>     sections
> 
>  arch/s390/mm/vmem.c | 637 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 442 insertions(+), 195 deletions(-)

Series applied, thank you!
