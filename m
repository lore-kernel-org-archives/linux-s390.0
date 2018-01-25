From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/2] mm: s390: Only notify on 4k pages
Date: Thu, 25 Jan 2018 17:04:17 +0100
Message-ID: <26ef13f7-dfd4-de7d-b448-0084df956d27@redhat.com>
References: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
 <1516894398-12694-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1516894398-12694-2-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1516894398-12694-2-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 25.01.2018 16:33, Janosch Frank wrote:
> Let's try this
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/gmap.h |  5 ++-
>  arch/s390/mm/gmap.c          | 72 ++++++++------------------------------------
>  2 files changed, 14 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index 6287aca..4120360 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -13,9 +13,8 @@
>  #define GMAP_NOTIFY_SHADOW	0x2
>  #define GMAP_NOTIFY_MPROT	0x1
>  
> -/* Status bits in huge and non-huge gmap segment entries. */
> -#define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
> -#define _SEGMENT_ENTRY_GMAP_SPLIT	0x0002  /* split huge pmd */
> +/* Status bit in huge and non-huge gmap segment entries. */
> +#define _SEGMENT_ENTRY_GMAP_SPLIT	0x0001  /* split huge pmd */
>  /* Status bits only for huge segment entries */
>  #define _SEGMENT_ENTRY_GMAP_UC		0x4000	/* user dirty (migration) */
>  #define _SEGMENT_ENTRY_GMAP_VSIE	0x8000	/* vsie bit */
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 10e0690..c47964f 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -998,7 +998,7 @@ static void gmap_pte_transfer_prot(struct mm_struct *mm, unsigned long addr,
>   * and requested access rights are incompatible.
>   */
>  static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
> -				pmd_t *pmdp, int prot, unsigned long bits)
> +				pmd_t *pmdp, int prot)
>  {
>  	int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
>  	int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
> @@ -1018,7 +1018,6 @@ static int gmap_pmdp_force_prot(struct gmap *gmap, unsigned long addr,
>  		pmd_val(new) |= _SEGMENT_ENTRY_PROTECT;
>  		gmap_pmdp_xchg(gmap, pmdp, new, addr);
>  	}
> -	pmd_val(*pmdp) |=  bits;
>  	return 0;
>  }
>  
> @@ -1136,21 +1135,18 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
>  			    unsigned long vmaddr, pmd_t *pmdp, pmd_t *hpmdp,
>  			    int prot, unsigned long bits)
>  {
> -	unsigned long sbits = 0;
>  	int ret = 0;
>  
> -	sbits |= (bits & GMAP_NOTIFY_MPROT) ? _SEGMENT_ENTRY_GMAP_IN : 0;
> -	sbits |= (bits & GMAP_NOTIFY_SHADOW) ? _SEGMENT_ENTRY_GMAP_VSIE : 0;
> -
> -	if (((prot != PROT_WRITE) && (bits & GMAP_NOTIFY_SHADOW))) {
> +	/* We notify only on the smallest possible frame size, a 4k page. */
> +	if (bits) {
>  		ret = gmap_pmd_split(gmap, gaddr, pmdp);
>  		if (ret)
>  			return ret;
>  		return -EFAULT;
>  	}

See below, I think we should move that to the caller.

Especially, gmap_protect_rmap_pmd() should no longer be needed then. (if
I am not messing things up)

>  
> -	/* Protect gmap pmd */
> -	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot, sbits);
> +	/* Protect gmap pmd for dirty tracking. */
> +	ret = gmap_pmdp_force_prot(gmap, gaddr, pmdp, prot);
>  	/*
>  	 * Transfer protection back to the host pmd, so userspace has
>  	 * never more access rights than the VM.
> @@ -1167,7 +1163,7 @@ static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
>   * @gaddr: virtual address in the guest address space
>   * @len: size of area
>   * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
> - * @bits: pgste notification bits to set
> + * @bits: notification bits to set
>   *
>   * Returns 0 if successfully protected, -ENOMEM if out of memory and
>   * -EFAULT if gaddr is invalid (or mapping for shadows is missing).
> @@ -1196,11 +1192,6 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
>  		pmdp = gmap_pmd_op_walk(gmap, gaddr);
>  		if (pmdp) {
>  			if (!pmd_large(*pmdp)) {
> -				if (gmap_pmd_is_split(pmdp) &&
> -				    (bits & GMAP_NOTIFY_MPROT)) {
> -					pmd_val(*pmdp) |= _SEGMENT_ENTRY_GMAP_IN;
> -				}
> -

Actually we can reduce this code here quite a lot by simply checking for

if (pmd_large(*pmdp)) {
	// splitup
	rc = EAGAIN;
}

No need to call gmap_protect_pmd().

I think it makes sense to move the split handling completely out of
gmap_protect_pmd() and only call it at places where we need it.

So only gmap_test_and_clear_dirty_segment() should end up calling it.

We can then also get rid of the "bits" parameter here, which is nice.

>  				rc = gmap_protect_pte(gmap, gaddr, vmaddr,
>  						      pmdp, hpmdp, prot, bits);
>  				if (!rc) {
> @@ -2562,53 +2553,20 @@ static void gmap_shadow_notify_pmd(struct gmap *sg, unsigned long vmaddr,
>  				   unsigned long gaddr)
>  {
>  	struct gmap_rmap *rmap, *rnext, *head;
> -	unsigned long start, end, bits, raddr;
> +	unsigned long bits, raddr;
>  
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  
>  	spin_lock_nested(&sg->guest_table_lock, GMAP_LOCK_SHADOW);
> -	if (sg->removed) {
> -		spin_unlock(&sg->guest_table_lock);
> -		return;
> -	}
> -	/* Check for top level table */
> -	start = sg->orig_asce & _ASCE_ORIGIN;
> -	end = start + ((sg->orig_asce & _ASCE_TABLE_LENGTH) + 1) * 4096;
> -	if (!(sg->orig_asce & _ASCE_REAL_SPACE) && gaddr >= start &&
> -	    gaddr < ((end & HPAGE_MASK) + HPAGE_SIZE - 1)) {
> -		/* The complete shadow table has to go */
> -		gmap_unshadow(sg);
> -		spin_unlock(&sg->guest_table_lock);
> -		list_del(&sg->list);
> -		gmap_put(sg);
> -		return;
> -	}
> -	/* Remove the page table tree from on specific entry */
>  	head = radix_tree_delete(&sg->host_to_rmap, (vmaddr & HPAGE_MASK) >> PAGE_SHIFT);
>  	gmap_for_each_rmap_safe(rmap, rnext, head) {
>  		bits = rmap->raddr & _SHADOW_RMAP_MASK;
>  		raddr = rmap->raddr ^ bits;
> -		switch (bits) {
> -		case _SHADOW_RMAP_REGION1:
> -			gmap_unshadow_r2t(sg, raddr);
> -			break;
> -		case _SHADOW_RMAP_REGION2:
> -			gmap_unshadow_r3t(sg, raddr);
> -			break;
> -		case _SHADOW_RMAP_REGION3:
> -			gmap_unshadow_sgt(sg, raddr);
> -			break;
> -		case _SHADOW_RMAP_SEGMENT_LP:
> +		if (bits ==  _SHADOW_RMAP_SEGMENT_LP)
>  			gmap_unshadow_segment(sg, raddr);
> -			break;
> -		case _SHADOW_RMAP_SEGMENT:
> -			gmap_unshadow_pgt(sg, raddr);
> -			break;
> -		case _SHADOW_RMAP_PGTABLE:
> -			gmap_unshadow_page(sg, raddr);
> -			break;
> -		}

Now this looks much better. Do we still need the _SHADOW_RMAP_SEGMENT_LP
check in gmap_shadow_notify() ? don't think so

> +		else
> +			BUG_ON(1);
>  		kfree(rmap);
>  	}
>  	spin_unlock(&sg->guest_table_lock);
> @@ -2777,9 +2735,8 @@ static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
>  	table = gmap_table_walk(gmap, gaddr, 1);
>  	if (!table)
>  		return;
> -	bits = *table & _SEGMENT_ENTRY_GMAP_IN;
>  	if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
> -		bits |= _SEGMENT_ENTRY_GMAP_VSIE;
> +		bits = _SEGMENT_ENTRY_GMAP_VSIE;
>  	if (!bits)
>  		return;
>  	*table &= ~bits;
> @@ -2792,8 +2749,6 @@ static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
>  			gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
>  		spin_unlock(&gmap->shadow_lock);
>  	}
> -	if (bits & _SEGMENT_ENTRY_GMAP_IN)
> -		gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
>  }
>  
>  static void pmdp_notify_split(struct mm_struct *mm, unsigned long vmaddr,
> @@ -2841,9 +2796,8 @@ void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
>  			continue;
>  		}
>  
> -		bits = *table & (_SEGMENT_ENTRY_GMAP_IN);
>  		if (pmd_large(__pmd(*table)) && (*table & _SEGMENT_ENTRY_GMAP_VSIE))
> -			bits |= _SEGMENT_ENTRY_GMAP_VSIE;
> +			bits = _SEGMENT_ENTRY_GMAP_VSIE;
>  		*table &= ~bits;
>  		gaddr = __gmap_segment_gaddr(table);
>  		spin_unlock(&gmap->guest_table_lock);
> @@ -2854,8 +2808,6 @@ void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
>  				gmap_shadow_notify_pmd(sg, vmaddr, gaddr);
>  			spin_unlock(&gmap->shadow_lock);
>  		}
> -		if (bits & _SEGMENT_ENTRY_GMAP_IN)
> -			gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
>  	}
>  	rcu_read_unlock();
>  }
> 


-- 

Thanks,

David / dhildenb
