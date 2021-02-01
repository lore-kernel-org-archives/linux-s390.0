Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V5 3/4] s390/mm: Define arch_get_mappable_range()
References: <1612149902-7867-1-git-send-email-anshuman.khandual@arm.com>
 <1612149902-7867-4-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6e84c7a9-730d-64ee-ab8a-ae966a0e007e@redhat.com>
Date: Mon, 1 Feb 2021 10:06:30 +0100
MIME-Version: 1.0
In-Reply-To: <1612149902-7867-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com, osalvador@suse.de
Cc: Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 01.02.21 04:25, Anshuman Khandual wrote:
> This overrides arch_get_mappabble_range() on s390 platform which will be
> used with recently added generic framework. It modifies the existing range
> check in vmem_add_mapping() using arch_get_mappable_range(). It also adds a
> VM_BUG_ON() check that would ensure that mhp_range_allowed() has already
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
>   arch/s390/mm/init.c |  1 +
>   arch/s390/mm/vmem.c | 14 +++++++++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 73a163065b95..0e76b2127dc6 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -297,6 +297,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>   		return -EINVAL;
>   
> +	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>   	rc = vmem_add_mapping(start, size);
>   	if (rc)
>   		return rc;
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 01f3a5f58e64..82dbf9450105 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,6 +4,7 @@
>    *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>    */
>   
> +#include <linux/memory_hotplug.h>
>   #include <linux/memblock.h>
>   #include <linux/pfn.h>
>   #include <linux/mm.h>
> @@ -532,11 +533,22 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>   	mutex_unlock(&vmem_mutex);
>   }
>   
> +struct range arch_get_mappable_range(void)
> +{
> +	struct range mhp_range;
> +
> +	mhp_range.start = 0;
> +	mhp_range.end =  VMEM_MAX_PHYS - 1;
> +	return mhp_range;
> +}
> +
>   int vmem_add_mapping(unsigned long start, unsigned long size)
>   {
> +	struct range range = arch_get_mappable_range();
>   	int ret;
>   
> -	if (start + size > VMEM_MAX_PHYS ||
> +	if (start < range.start ||
> +	    start + size > range.end + 1 ||
>   	    start + size < start)
>   		return -ERANGE;
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
