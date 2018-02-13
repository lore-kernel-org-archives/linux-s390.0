From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 03/16] s390/mm: Introduce gmap_pmdp_xchg
Date: Tue, 13 Feb 2018 15:16:41 +0100
Message-ID: <74d88194-4fc6-92ec-2fb1-e2c6940c5fe6@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-4-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-4-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09.02.2018 10:34, Janosch Frank wrote:
> When changing guest pmds, we don't need to take care of the
> corresponding host pmd. This means, we don't need to flush the host
> TLB entries and we don't need to notify on all gmaps.
> 
> Let's introduce a function, that exchanges a pmd and takes care of the
> necessary flushing and notification.

stale comment, notification is handled in a different patch.

> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  arch/s390/mm/gmap.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 4471cb9..16c877a9 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -23,6 +23,9 @@
>  
>  #define GMAP_SHADOW_FAKE_TABLE 1ULL
>  
> +static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *old, pmd_t new,
> +			   unsigned long gaddr);
> +
>  /**
>   * gmap_alloc - allocate and initialize a guest address space
>   * @mm: pointer to the parent mm_struct
> @@ -2174,6 +2177,31 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
>  }
>  EXPORT_SYMBOL_GPL(ptep_notify);
>  
> +/**
> + * gmap_pmdp_xchg - exchange a gmap pmd with another and notify

dito, no notification yet

> + * @gmap: pointer to the guest address space structure
> + * @pmdp: pointer to the pmd entry
> + * @new: replacement entry
> + * @gaddr: the affected guest address
> + *
> + * This function is assumed to be called with the guest_table_lock
> + * held.
> + */
> +static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
> +			   unsigned long gaddr)
> +{
> +	if (MACHINE_HAS_TLB_GUEST)
> +		__pmdp_idte(gaddr, (pmd_t *)pmdp,
> +			    IDTE_GUEST_ASCE, gmap->asce,
> +			    IDTE_GLOBAL);

This fits into two lines

> +	if (MACHINE_HAS_IDTE)
> +		__pmdp_idte(gaddr, (pmd_t *)pmdp,
> +			    0, 0, IDTE_GLOBAL);

This fits into one line

> +	else
> +		__pmdp_csp(pmdp);
> +	*pmdp = new;
> +}
> +
>  static inline void thp_split_mm(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 

Apart from that, looks good to me. (although very similar to
gmap_pmdp_idte_global -  can we reuse gmap_pmdp_xchg() in
gmap_pmdp_idte_global?)

-- 

Thanks,

David / dhildenb
