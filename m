From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 05/22] s390/mm: hugetlb pages within a gmap can not
 be freed
Date: Wed, 24 Jan 2018 14:45:04 +0100
Message-ID: <07d8227f-ec52-f282-6ecf-d0880f3b74d8@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-6-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-6-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13.12.2017 13:53, Janosch Frank wrote:
> From: Dominik Dingel <dingel@linux.vnet.ibm.com>
> 
> Guests backed by huge pages could theoretically free unused pages via
> the diagnose 10 instruction. We currently don't allow that, so we
> don't have to refault it once it's needed again.
> 
> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index aceaeb5..056acfc 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -695,6 +695,9 @@ void gmap_discard(struct gmap *gmap, unsigned long from, unsigned long to)
>  		vmaddr |= gaddr & ~PMD_MASK;
>  		/* Find vma in the parent mm */
>  		vma = find_vma(gmap->mm, vmaddr);
> +		/* We do not discard pages that are backed by hugetlbfs */
> +		if (vma && is_vm_hugetlb_page(vma))
> +			continue;
>  		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
>  		zap_page_range(vma, vmaddr, size);
>  	}
> 

This check does not care about split huge pages, correct? (because we're
checking the VMA?)

-- 

Thanks,

David / dhildenb
