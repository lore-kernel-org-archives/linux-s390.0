Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 3/3] s390/mm: Define arch_get_addressable_range()
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
 <1606098529-7907-4-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fc5ebaf9-ce6a-95fd-a2fe-84bfdf73512a@redhat.com>
Date: Wed, 25 Nov 2020 18:27:18 +0100
MIME-Version: 1.0
In-Reply-To: <1606098529-7907-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 23.11.20 03:28, Anshuman Khandual wrote:
> This overrides arch_get_addressable_range() on s390 platform and drops
> now redudant similar check in vmem_add_mapping().
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/s390/include/asm/mmu.h |  2 ++
>  arch/s390/mm/vmem.c         | 16 ++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
> index e12ff0f29d1a..f92d3926b188 100644
> --- a/arch/s390/include/asm/mmu.h
> +++ b/arch/s390/include/asm/mmu.h
> @@ -55,4 +55,6 @@ static inline int tprot(unsigned long addr)
>  	return rc;
>  }
>  
> +#define arch_get_addressable_range arch_get_addressable_range
> +struct range arch_get_addressable_range(bool need_mapping);
>  #endif
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b0..e03ad0ed13a7 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -532,14 +532,22 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>  	mutex_unlock(&vmem_mutex);
>  }
>  
> +struct range arch_get_addressable_range(bool need_mapping)
> +{
> +	struct range memhp_range;
> +
> +	memhp_range.start = 0;
> +	if (need_mapping)
> +		memhp_range.end =  VMEM_MAX_PHYS;
> +	else
> +		memhp_range.end = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
> +	return memhp_range;
> +}
> +
>  int vmem_add_mapping(unsigned long start, unsigned long size)
>  {
>  	int ret;
>  
> -	if (start + size > VMEM_MAX_PHYS ||
> -	    start + size < start)
> -		return -ERANGE;
> -
>  	mutex_lock(&vmem_mutex);
>  	ret = vmem_add_range(start, size);
>  	if (ret)
> 

Note that vmem_add_mapping() is also called from extmem
(arch/s390/mm/extmem.c).

-- 
Thanks,

David / dhildenb
