From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Tue, 13 Feb 2018 15:36:45 +0100
Message-ID: <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 09.02.2018 10:34, Janosch Frank wrote:
> For later migration of huge pages we want to write-protect guest
> PMDs. While doing this, we have to make absolutely sure, that the
> guest's lowcore is always accessible when the VCPU is running. With
> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
> the invalidation notification bit and kicking the guest out of the SIE
> via a notifier function if we need to invalidate such a page.
> 
> With PMDs we do not have PGSTEs or some other bits we could use in the
> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
> time a host pmd will be invalidated, we will check if the respective
> gmap PMD has the bit set and in that case fire up the notifier.
> 
> In the first step we only support setting the invalidation bit, but we
> do not support restricting access of guest pmds. It will follow
> shortly.
> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>

[...]

> +
> +/**
> + * gmap_pmd_split - Split a huge gmap pmd and use a page table instead
> + * @gmap: pointer to guest mapping meta data structure
> + * @gaddr: virtual address in the guest address space
> + * @pmdp: pointer to the pmd that will be split
> + *
> + * When splitting gmap pmds, we have to make the resulting page table
> + * look like it's a normal one to be able to use the common pte
> + * handling functions. Also we need to track these new tables as they
> + * aren't tracked anywhere else.
> + */
> +static int gmap_pmd_split(struct gmap *gmap, unsigned long gaddr, pmd_t *pmdp)
> +{
> +	unsigned long *table;
> +	struct page *page;
> +	pmd_t new;
> +	int i;
> +

That's interesting, because the SIE can now suddenly work on these
PGSTEs, e.g. not leading to intercepts on certain events (like setting
storage keys).

How is that intended to be handled? I assume we would somehow have to
forbid the SIE from making use of the PGSTE. But that involves clearing
certain interception controls, which might be problematic.

> +	page = page_table_alloc_pgste(gmap->mm);
> +	if (!page)
> +		return -ENOMEM;
> +	table = (unsigned long *) page_to_phys(page);
> +	for (i = 0; i < 256; i++) {
> +		table[i] = (pmd_val(*pmdp) & HPAGE_MASK) + i * PAGE_SIZE;
> +		/* pmd_large() implies pmd/pte_present() */
> +		table[i] |=  _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE;
> +		/* ptes are directly marked as dirty */
> +		table[i + PTRS_PER_PTE] |= PGSTE_UC_BIT;
> +	}
> +
> +	pmd_val(new) = ((unsigned long)table | _SEGMENT_ENTRY |
> +			(_SEGMENT_ENTRY_GMAP_SPLIT));
> +	list_add(&page->lru, &gmap->split_list);
> +	gmap_pmdp_xchg(gmap, pmdp, new, gaddr);
> +	return 0;
> +}
> +
>  /*
>   * gmap_protect_pte - remove access rights to memory and set pgste bits
>   * @gmap: pointer to guest mapping meta data structure
> @@ -941,7 +1021,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
>  	spinlock_t *ptl = NULL;
>  	unsigned long pbits = 0;
>  
> -	ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
> +	ptep = gmap_pte_from_pmd(gmap, pmdp, gaddr, &ptl);
>  	if (!ptep)
>  		return -ENOMEM;
>  
> @@ -979,15 +1059,21 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
>  		rc = -EAGAIN;
>  		pmdp = gmap_pmd_op_walk(gmap, gaddr);
>  		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
> -			rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
> -					      bits);
> -			if (!rc) {
> -				len -= PAGE_SIZE;
> -				gaddr += PAGE_SIZE;
> +			if (!pmd_large(*pmdp)) {
> +				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
> +						      bits);
> +				if (!rc) {
> +					len -= PAGE_SIZE;
> +					gaddr += PAGE_SIZE;
> +				}
> +			} else {
> +				rc = gmap_pmd_split(gmap, gaddr, pmdp);
> +				if (!rc)
> +					rc = -EFAULT;

Not sure if -EFAULT is the right thing to do here. Actually this would
be a much better use case for -EAGAIN.

(or simply avoid this by doing an gmap_pmd_op_end() + continue;)

>  			}
>  			gmap_pmd_op_end(gmap, pmdp);
>  		}
> -		if (rc) {
> +		if (rc && rc != -EFAULT) {
>  			vmaddr = __gmap_translate(gmap, gaddr);
>  			if (IS_ERR_VALUE(vmaddr))
>  				return vmaddr;
> @@ -2133,6 +2219,39 @@ static void gmap_shadow_notify(struct gmap *sg, unsigned long vmaddr,
>  	spin_unlock(&sg->guest_table_lock);
>  }
>  
> +/*
> + * ptep_notify_gmap - call all invalidation callbacks for a specific pte of a gmap
> + * @mm: pointer to the process mm_struct
> + * @addr: virtual address in the process address space
> + * @pte: pointer to the page table entry
> + * @bits: bits from the pgste that caused the notify call
> + *
> + * This function is assumed to be called with the guest_table_lock held.
> + */
> +void ptep_notify_gmap(struct mm_struct *mm, unsigned long vmaddr,
> +		      pte_t *pte, unsigned long bits)
> +{
> +	unsigned long offset, gaddr = 0;
> +	unsigned long *table;
> +	struct gmap *gmap;
> +
> +	offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
> +	offset = offset * (4096 / sizeof(pte_t));
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
> +		table = radix_tree_lookup(&gmap->host_to_guest,
> +					  vmaddr >> PMD_SHIFT);
> +		if (table)
> +			gaddr = __gmap_segment_gaddr(table) + offset;
> +		else
> +			continue;
> +
> +		if (bits & PGSTE_IN_BIT)
> +			gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
> +	}
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * ptep_notify - call all invalidation callbacks for a specific pte.
>   * @mm: pointer to the process mm_struct
> @@ -2177,6 +2296,23 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
>  }
>  EXPORT_SYMBOL_GPL(ptep_notify);
>  
> +static void pmdp_notify_split(struct mm_struct *mm, unsigned long vmaddr,
> +			      unsigned long *table)
> +{
> +	int i = 0;
> +	unsigned long bits;
> +	unsigned long *ptep = (unsigned long *)(*table & PAGE_MASK);
> +	unsigned long *pgste = ptep + PTRS_PER_PTE;
> +
> +	for (; i < 256; i++, vmaddr += PAGE_SIZE, ptep++, pgste++) {
> +		bits = *pgste & (PGSTE_IN_BIT | PGSTE_VSIE_BIT);
> +		if (bits) {
> +			*pgste ^= bits;
> +			ptep_notify_gmap(mm, vmaddr, (pte_t *)ptep, bits);

All existing callers of ptep_notify_gmap() are called with the pgste
lock being held. I guess we don't need that here as we always take the
guest_table_lock when working with split PMDs.

Complicated stuff :)

> +		}
> +	}
> +}


-- 

Thanks,

David / dhildenb
