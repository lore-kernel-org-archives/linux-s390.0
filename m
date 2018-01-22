From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Mon, 22 Jan 2018 12:46:27 +0100
Message-ID: <edb33737-5f1d-b74e-6dbf-f5174b790fee@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 13.12.2017 13:53, Janosch Frank wrote:
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

I am wondering if we could avoid having invalidation bits on PMDs
completely by always splitting up a PMD huge page into PTEs.

I assume this would make the code easier - as we need split up of PMDs
either way when protecting for the shadow gmap.

This would imply that also our notification handler only has to be
called for 4k pages, which also makes that part easier.

This would mean, that the 1MB segments where the prefixes live would
always be split into 4k pages - but do we care?

I somehow dislike that somebody registers a notifier for some subregion
(e.g. 8k) but gets notified about a huge page (1mb).

Opinions?

> 
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/gmap.h    |  3 ++
>  arch/s390/include/asm/pgtable.h |  7 +++-
>  arch/s390/mm/gmap.c             | 92 ++++++++++++++++++++++++++++++++++++-----
>  arch/s390/mm/pgtable.c          |  4 ++
>  4 files changed, 94 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index c1bc563..21bb658 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -13,6 +13,9 @@
>  #define GMAP_NOTIFY_SHADOW	0x2
>  #define GMAP_NOTIFY_MPROT	0x1
>  
> +/* Status bits in the gmap segment entry. */
> +#define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
> +
>  /**
>   * struct gmap_struct - guest address space
>   * @list: list head for the mm->context gmap list
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 57d7bc9..ba3840c 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -269,8 +269,10 @@ static inline int is_module_addr(void *addr)
>  #define _REGION_ENTRY_BITS_LARGE 0xffffffff8000fe2fUL
>  
>  /* Bits in the segment table entry */
> -#define _SEGMENT_ENTRY_BITS	0xfffffffffffffe33UL
> -#define _SEGMENT_ENTRY_BITS_LARGE 0xfffffffffff0ff33UL
> +#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe33UL
> +#define _SEGMENT_ENTRY_BITS_LARGE 		0xfffffffffff0ff33UL
> +#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe30UL
> +#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE 	0xfffffffffff00730UL
>  #define _SEGMENT_ENTRY_ORIGIN_LARGE ~0xfffffUL /* large page address	    */
>  #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL/* page table origin		    */
>  #define _SEGMENT_ENTRY_PROTECT	0x200	/* segment protection bit	    */
> @@ -1093,6 +1095,7 @@ void ptep_set_pte_at(struct mm_struct *mm, unsigned long addr,
>  void ptep_set_notify(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>  void ptep_notify(struct mm_struct *mm, unsigned long addr,
>  		 pte_t *ptep, unsigned long bits);
> +void pmdp_notify(struct mm_struct *mm, unsigned long addr);
>  int ptep_force_prot(struct mm_struct *mm, unsigned long gaddr,
>  		    pte_t *ptep, int prot, unsigned long bit);
>  void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index e7825d2..ff7fe24 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -596,10 +596,15 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
>  	if (*table == _SEGMENT_ENTRY_EMPTY) {
>  		rc = radix_tree_insert(&gmap->host_to_guest,
>  				       vmaddr >> PMD_SHIFT, table);
> -		if (!rc)
> -			*table = pmd_val(*pmd);
> -	} else
> -		rc = 0;
> +		if (!rc) {
> +			if (pmd_large(*pmd)) {
> +				*table = pmd_val(*pmd) &
> +					_SEGMENT_ENTRY_HARDWARE_BITS_LARGE;
> +			} else
> +				*table = pmd_val(*pmd) &
> +					_SEGMENT_ENTRY_HARDWARE_BITS;
> +		}
> +	}
>  	spin_unlock(&gmap->guest_table_lock);
>  	spin_unlock(ptl);
>  	radix_tree_preload_end();
> @@ -962,6 +967,33 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
>  }
>  
>  /*
> + * gmap_protect_pmd - set pmd notification bits
> + * @pmdp: pointer to the pmd to be protected
> + * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
> + * @bits: notification bits to set
> + *
> + * Returns 0 if successfully protected, -ENOMEM if out of memory and
> + * -EAGAIN if a fixup is needed.
> + *
> + * Expected to be called with sg->mm->mmap_sem in read and
> + * guest_table_lock held.
> + */
> +static int gmap_protect_pmd(struct gmap *gmap, unsigned long gaddr,
> +			    pmd_t *pmdp, int prot, unsigned long bits)
> +{
> +	const int pmd_i = pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
> +	const int pmd_p = pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
> +
> +	/* Fixup needed */
> +	if ((pmd_i && (prot != PROT_NONE)) || (pmd_p && (prot & PROT_WRITE)))
> +		return -EAGAIN;
> +
> +	if (bits & GMAP_NOTIFY_MPROT)
> +		pmd_val(*pmdp) |=  _SEGMENT_ENTRY_GMAP_IN;
> +	return 0;
> +}
> +
> +/*
>   * gmap_protect_range - remove access rights to memory and set pgste bits
>   * @gmap: pointer to guest mapping meta data structure
>   * @gaddr: virtual address in the guest address space
> @@ -979,7 +1011,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
>  static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
>  			      unsigned long len, int prot, unsigned long bits)
>  {
> -	unsigned long vmaddr;
> +	unsigned long vmaddr, dist;
>  	pmd_t *pmdp;
>  	int rc;
>  
> @@ -987,11 +1019,21 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
>  		rc = -EAGAIN;
>  		pmdp = gmap_pmd_op_walk(gmap, gaddr);
>  		if (pmdp) {
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
> +				rc = gmap_protect_pmd(gmap, gaddr, pmdp, prot,
> +						      bits);
> +				if (!rc) {
> +					dist = HPAGE_SIZE - (gaddr & ~HPAGE_MASK);
> +					len = len < dist ? 0 : len - dist;
> +					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
> +				}
>  			}
>  			gmap_pmd_op_end(gmap, pmdp);
>  		}
> @@ -2185,6 +2227,36 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
>  }
>  EXPORT_SYMBOL_GPL(ptep_notify);
>  
> +/**
> + * pmdp_notify - call all invalidation callbacks for a specific pmd
> + * @mm: pointer to the process mm_struct
> + * @vmaddr: virtual address in the process address space
> + *
> + * This function is expected to be called with mmap_sem held in read.
> + */
> +void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
> +{
> +	unsigned long *table, gaddr;
> +	struct gmap *gmap;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
> +		spin_lock(&gmap->guest_table_lock);
> +		table = radix_tree_lookup(&gmap->host_to_guest,
> +					  vmaddr >> PMD_SHIFT);
> +		if (!table || !(*table & _SEGMENT_ENTRY_GMAP_IN)) {
> +			spin_unlock(&gmap->guest_table_lock);
> +			continue;
> +		}
> +		gaddr = __gmap_segment_gaddr(table);
> +		*table &= ~_SEGMENT_ENTRY_GMAP_IN;
> +		spin_unlock(&gmap->guest_table_lock);
> +		gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
> +	}
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(pmdp_notify);
> +
>  static inline void thp_split_mm(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index 4f2b65d..a6cc540 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -405,6 +405,8 @@ pmd_t pmdp_xchg_direct(struct mm_struct *mm, unsigned long addr,
>  	pmd_t old;
>  
>  	preempt_disable();
> +	if (mm_has_pgste(mm))
> +		pmdp_notify(mm, addr);
>  	old = pmdp_flush_direct(mm, addr, pmdp);
>  	*pmdp = new;
>  	preempt_enable();
> @@ -418,6 +420,8 @@ pmd_t pmdp_xchg_lazy(struct mm_struct *mm, unsigned long addr,
>  	pmd_t old;
>  
>  	preempt_disable();
> +	if (mm_has_pgste(mm))
> +		pmdp_notify(mm, addr);
>  	old = pmdp_flush_lazy(mm, addr, pmdp);
>  	*pmdp = new;
>  	preempt_enable();
> 


-- 

Thanks,

David / dhildenb
