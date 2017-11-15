From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH 20/22] s390/mm: Enable gmap huge pmd support
Date: Wed, 15 Nov 2017 11:08:06 +0100
Message-ID: <d4793e16-1eed-3124-0086-5d574ed7822b@redhat.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-21-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-21-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06.11.2017 23:29, Janosch Frank wrote:
> Now that we have everything in place, let's allow huge pmds for gmap
> linking, effectively allowing huge pages guests.

Can you add a comment about transparent huge pages?

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 430dcd9..3cc2765 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -1,8 +1,10 @@
>  /*
>   *  KVM guest address space mapping code
>   *
> - *    Copyright IBM Corp. 2007, 2016
> + *    Copyright IBM Corp. 2007, 2016, 2017
>   *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
> + *		 David Hildenbrand <david@redhat.com>
> + *		 Janosch Frank <frankja@linux.vnet.ibm.com>
>   */
>  
>  #include <linux/kernel.h>
> @@ -596,9 +598,6 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
>  		return -EFAULT;
>  	pmd = pmd_offset(pud, vmaddr);
>  	VM_BUG_ON(pmd_none(*pmd));
> -	/* large pmds cannot yet be handled */
> -	if (pmd_large(*pmd))
> -		return -EFAULT;
>  	/* Link gmap segment table entry location to page table. */
>  	rc = radix_tree_preload(GFP_KERNEL);
>  	if (rc)
> 


-- 

Thanks,

David / dhildenb
