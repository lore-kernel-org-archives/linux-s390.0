From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 02/22] s390/mm: Abstract gmap notify bit setting
Date: Mon, 22 Jan 2018 12:34:47 +0100
Message-ID: <c72a89b2-1451-150e-a0fe-97ac32a237b9@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-3-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-3-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13.12.2017 13:53, Janosch Frank wrote:
> Currently we use the software PGSTE bits PGSTE_IN_BIT and PGSTE_VSIE_BIT
> to notify before an invalidation occurs on a prefix page or a VSIE page
> respectively. Both bits only work for a PGSTE, which only exists for
> page tables.
> 
> For huge page support we also need such bits for segments (pmds) so
> let's introduce abstract GMAP_NOTIFY_* bits that will be realized into
> the respective bits when gmap DAT table entries are protected.
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
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
> index 8de8bf9..e7825d2 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -929,7 +929,7 @@ static inline void gmap_pmd_op_end(struct gmap *gmap, pmd_t *pmdp)
>   * @gaddr: virtual address in the guest address space
>   * @pmdp: pointer to the pmd associated with the pte
>   * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
> - * @bits: pgste notification bits to set
> + * @bits: notification bits to set
>   *
>   * Returns 0 if successfully protected, -ENOMEM if out of memory and
>   * -EAGAIN if a fixup is needed.
> @@ -943,6 +943,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
>  	int rc;
>  	pte_t *ptep;
>  	spinlock_t *ptl = NULL;
> +	unsigned long pbits = 0;
>  
>  	/* We have no upper segment, let's go back and fix this up. */
>  	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
> @@ -952,8 +953,10 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
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
> @@ -1028,7 +1031,7 @@ int gmap_mprotect_notify(struct gmap *gmap, unsigned long gaddr,
>  	if (!MACHINE_HAS_ESOP && prot == PROT_READ)
>  		return -EINVAL;
>  	down_read(&gmap->mm->mmap_sem);
> -	rc = gmap_protect_range(gmap, gaddr, len, prot, PGSTE_IN_BIT);
> +	rc = gmap_protect_range(gmap, gaddr, len, prot, GMAP_NOTIFY_MPROT);
>  	up_read(&gmap->mm->mmap_sem);
>  	return rc;
>  }
> @@ -1150,7 +1153,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
>  		if (ptep) {
>  			spin_lock(&sg->guest_table_lock);
>  			rc = ptep_force_prot(parent->mm, paddr, ptep, prot,
> -					     PGSTE_VSIE_BIT);
> +					     GMAP_NOTIFY_SHADOW);
>  			if (!rc)
>  				gmap_insert_rmap(sg, vmaddr, rmap);
>  			spin_unlock(&sg->guest_table_lock);
> @@ -1616,7 +1619,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
>  	down_read(&parent->mm->mmap_sem);
>  	rc = gmap_protect_range(parent, asce & _ASCE_ORIGIN,
>  				((asce & _ASCE_TABLE_LENGTH) + 1) * PAGE_SIZE,
> -				PROT_READ, PGSTE_VSIE_BIT);
> +				PROT_READ, GMAP_NOTIFY_SHADOW);
>  	up_read(&parent->mm->mmap_sem);
>  	spin_lock(&parent->shadow_lock);
>  	new->initialized = true;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
