From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 02/16] s390/mm: Abstract gmap notify bit setting
Date: Tue, 13 Feb 2018 15:10:26 +0100
Message-ID: <316974c5-2cdd-3cac-f424-cc2f728f2175@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-3-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-3-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09.02.2018 10:34, Janosch Frank wrote:
> Currently we use the software PGSTE bits PGSTE_IN_BIT and PGSTE_VSIE_BIT
> to notify before an invalidation occurs on a prefix page or a VSIE page
> respectively. Both bits only work for a PGSTE, which only exists for
> page tables.
> 
> For huge page support we also need such bits for segments (pmds) so
> let's introduce abstract GMAP_NOTIFY_* bits that will be realized into
> the respective bits when gmap DAT table entries are protected.

This comment is stale.

This patch is no longer needed but also doesn't hurt.

> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/gmap.h |  4 ++++
>  arch/s390/mm/gmap.c          | 13 ++++++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index e07cce8..c1bc563 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -9,6 +9,10 @@
>  #ifndef _ASM_S390_GMAP_H
>  #define _ASM_S390_GMAP_H
>  
> +/* Generic bits for GMAP notification on DAT table entry changes. */
> +#define GMAP_NOTIFY_SHADOW	0x2
> +#define GMAP_NOTIFY_MPROT	0x1
> +
>  /**
>   * struct gmap_struct - guest address space
>   * @list: list head for the mm->context gmap list
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 549a55f..4471cb9 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -922,7 +922,7 @@ static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
>   * @gaddr: virtual address in the guest address space
>   * @pmdp: pointer to the pmd associated with the pte
>   * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
> - * @bits: pgste notification bits to set
> + * @bits: notification bits to set
>   *
>   * Returns 0 if successfully protected, -ENOMEM if out of memory and
>   * -EAGAIN if a fixup is needed.
> @@ -936,13 +936,16 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
>  	int rc;
>  	pte_t *ptep;
>  	spinlock_t *ptl = NULL;
> +	unsigned long pbits = 0;
>  
>  	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
>  	if (!ptep)
>  		return -ENOMEM;
>  
> +	pbits |= (bits & GMAP_NOTIFY_MPROT) ? PGSTE_IN_BIT : 0;
> +	pbits |= (bits & GMAP_NOTIFY_SHADOW) ? PGSTE_VSIE_BIT : 0;
>  	/* Protect and unlock. */
> -	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
> +	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, pbits);
>  	gmap_pte_op_end(ptl);
>  	return rc;
>  }
> @@ -1017,7 +1020,7 @@ int gmap_mprotect_notify(struct gmap *gmap, unsigned long gaddr,
>  	if (!MACHINE_HAS_ESOP && prot == PROT_READ)
>  		return -EINVAL;
>  	down_read(&gmap->mm->mmap_sem);
> -	rc = gmap_protect_range(gmap, gaddr, len, prot, PGSTE_IN_BIT);
> +	rc = gmap_protect_range(gmap, gaddr, len, prot, GMAP_NOTIFY_MPROT);
>  	up_read(&gmap->mm->mmap_sem);
>  	return rc;
>  }
> @@ -1139,7 +1142,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
>  		if (ptep) {
>  			spin_lock(&sg->guest_table_lock);
>  			rc = ptep_force_prot(parent->mm, paddr, ptep, prot,
> -					     PGSTE_VSIE_BIT);
> +					     GMAP_NOTIFY_SHADOW);
>  			if (!rc)
>  				gmap_insert_rmap(sg, vmaddr, rmap);
>  			spin_unlock(&sg->guest_table_lock);
> @@ -1605,7 +1608,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
>  	down_read(&parent->mm->mmap_sem);
>  	rc = gmap_protect_range(parent, asce & _ASCE_ORIGIN,
>  				((asce & _ASCE_TABLE_LENGTH) + 1) * PAGE_SIZE,
> -				PROT_READ, PGSTE_VSIE_BIT);
> +				PROT_READ, GMAP_NOTIFY_SHADOW);
>  	up_read(&parent->mm->mmap_sem);
>  	spin_lock(&parent->shadow_lock);
>  	new->initialized = true;
>

-- 

Thanks,

David / dhildenb
