From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Sep 2018 13:15:32 +0000
Subject: Re: [RFC 01/14] s390/mm: Code cleanups
Message-Id: <e21596e1-7737-8a5a-72ca-f1dd85e6c4c5@de.ibm.com>
In-Reply-To: <31445605-897a-0b07-b1e6-5b239b52d990@linux.ibm.com>
References: <31445605-897a-0b07-b1e6-5b239b52d990@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 09/19/2018 10:47 AM, Janosch Frank wrote:
> Let's clean up leftovers before introducing new code.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  arch/s390/mm/gmap.c    | 8 ++++----
>  arch/s390/mm/pgtable.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 1e668b95e0c6..9ccd62cc7f37 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -5,7 +5,7 @@
>   *    Copyright IBM Corp. 2007, 2016, 2018
>   *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
>   *		 David Hildenbrand <david@redhat.com>
> - *		 Janosch Frank <frankja@linux.vnet.ibm.com>
> + *		 Janosch Frank <frankja@linux.ibm.com>
>   */
>  
>  #include <linux/kernel.h>
> @@ -2285,10 +2285,10 @@ static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
>  	pmdp_notify_gmap(gmap, pmdp, gaddr);
>  	pmd_val(new) &= ~_SEGMENT_ENTRY_GMAP_IN;
>  	if (MACHINE_HAS_TLB_GUEST)
> -		__pmdp_idte(gaddr, (pmd_t *)pmdp, IDTE_GUEST_ASCE, gmap->asce,
> +		__pmdp_idte(gaddr, pmdp, IDTE_GUEST_ASCE, gmap->asce,
>  			    IDTE_GLOBAL);
>  	else if (MACHINE_HAS_IDTE)
> -		__pmdp_idte(gaddr, (pmd_t *)pmdp, 0, 0, IDTE_GLOBAL);
> +		__pmdp_idte(gaddr, pmdp, 0, 0, IDTE_GLOBAL);
>  	else
>  		__pmdp_csp(pmdp);
>  	*pmdp = new;
> @@ -2505,7 +2505,7 @@ static inline void thp_split_mm(struct mm_struct *mm)
>   * - This must be called after THP was enabled
>   */
>  static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
> -			   unsigned long end, struct mm_walk *walk)
> +			    unsigned long end, struct mm_walk *walk)
>  {
>  	unsigned long addr;
>  
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index f2cc7da473e4..16d35b881a11 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -723,7 +723,7 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>   * Test and reset if a guest page is dirty
>   */
>  bool ptep_test_and_clear_uc(struct mm_struct *mm, unsigned long addr,
> -		       pte_t *ptep)
> +			    pte_t *ptep)
>  {
>  	pgste_t pgste;
>  	pte_t pte;
> 
