From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 11/22] s390/mm: Remove superfluous parameter
Date: Tue, 16 Jan 2018 14:11:53 +0100
Message-ID: <f8b38dc2-fcf5-ff5b-5e4c-2c807204394f@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-12-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13.12.2017 13:53, Janosch Frank wrote:
> It seems it hasn't even been used before the last cleanup and was
> overlooked.
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index ffc11d8..d396da8 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2237,7 +2237,7 @@ EXPORT_SYMBOL_GPL(gmap_shadow_page);
>   * Called with sg->parent->shadow_lock.
>   */
>  static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
> -			       unsigned long gaddr, pte_t *pte)
> +			       unsigned long gaddr)
>  {
>  	struct gmap_rmap *rmap, *rnext, *head;
>  	unsigned long start, end, bits, raddr;
> @@ -2322,7 +2322,7 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
>  			spin_lock(&gmap->shadow_lock);
>  			list_for_each_entry_safe(sg, next,
>  						 &gmap->children, list)
> -				gmap_shadow_notify(sg, vmaddr, gaddr, pte);
> +				gmap_shadow_notify(sg, vmaddr, gaddr);
>  			spin_unlock(&gmap->shadow_lock);
>  		}
>  		if (bits & PGSTE_IN_BIT)
> 

Could be from an earlier prototype, can be removed.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
