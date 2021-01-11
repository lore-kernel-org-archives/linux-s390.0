Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbhAKKll (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Jan 2021 05:41:41 -0500
Subject: Re: [PATCH V2 3/3] s390/mm: Define arch_get_mappable_range()
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <1608218912-28932-4-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <87ae0b7c-0e95-6068-900e-d813a53f2732@redhat.com>
Date: Mon, 11 Jan 2021 11:40:06 +0100
MIME-Version: 1.0
In-Reply-To: <1608218912-28932-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On 17.12.20 16:28, Anshuman Khandual wrote:
> This overrides arch_get_mappabble_range() on s390 platform which will be
> used with recently added generic framework. It modifies the existing range
> check in vmem_add_mapping() using arch_get_mappable_range(). It also adds a
> VM_BUG_ON() check that would ensure that memhp_range_allowed() has already
> been called on the hotplug path.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/s390/mm/init.c |  1 +
>  arch/s390/mm/vmem.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 77767850d0d0..e0e78234ae57 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>  		return -EINVAL;
>  
> +	VM_BUG_ON(!memhp_range_allowed(start, size, 1));

s/1/true/

>  	rc = vmem_add_mapping(start, size);
>  	if (rc)
>  		return rc;
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b0..e10e563ad2b4 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,6 +4,7 @@
>   *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>   */
>  
> +#include <linux/memory_hotplug.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
>  #include <linux/mm.h>
> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>  	mutex_unlock(&vmem_mutex);
>  }
>  
> +struct range arch_get_mappable_range(void)
> +{
> +	struct range memhp_range;
> +
> +	memhp_range.start = 0;
> +	memhp_range.end =  VMEM_MAX_PHYS;

s/  / /

IIRC, the range is inclusive? "VMEM_MAX_PHYS - 1" then, and adjust the
check below.

> +	return memhp_range;
> +}
> +


-- 
Thanks,

David / dhildenb
