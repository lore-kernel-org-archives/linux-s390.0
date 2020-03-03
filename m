Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm/gup: fixup for 9947ea2c1e608e32 "mm/gup: track
 FOLL_PIN pages"
References: <20200303002506.173957-1-imbrenda@linux.ibm.com>
 <20200303002506.173957-2-imbrenda@linux.ibm.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <dbda1638-4de6-a90f-6000-30651a8d56f0@nvidia.com>
Date: Mon, 2 Mar 2020 21:38:06 -0800
MIME-Version: 1.0
In-Reply-To: <20200303002506.173957-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name
Cc: borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

On 3/2/20 4:25 PM, Claudio Imbrenda wrote:
> In case pin fails, we need to unpin, a simple put_page will not be enough
> 
> fixup for commit 9947ea2c1e608e32 ("mm/gup: track FOLL_PIN pages")
> 
> it can be simply squashed in
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   mm/gup.c | 46 +++++++++++++++++++++++-----------------------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 


Looks good, thanks for fixing this.


thanks,
-- 
John Hubbard
NVIDIA


> diff --git a/mm/gup.c b/mm/gup.c
> index f589299b0d4a..81a95fbe9901 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -116,6 +116,28 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
>   	return NULL;
>   }
>   
> +static void put_compound_head(struct page *page, int refs, unsigned int flags)
> +{
> +	if (flags & FOLL_PIN) {
> +		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
> +				    refs);
> +
> +		if (hpage_pincount_available(page))
> +			hpage_pincount_sub(page, refs);
> +		else
> +			refs *= GUP_PIN_COUNTING_BIAS;
> +	}
> +
> +	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
> +	/*
> +	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> +	 * ref needs a put_page().
> +	 */
> +	if (refs > 1)
> +		page_ref_sub(page, refs - 1);
> +	put_page(page);
> +}
> +
>   /**
>    * try_grab_page() - elevate a page's refcount by a flag-dependent amount
>    *
> @@ -2134,7 +2156,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   			goto pte_unmap;
>   
>   		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> -			put_page(head);
> +			put_compound_head(head, 1, flags);
>   			goto pte_unmap;
>   		}
>   
> @@ -2267,28 +2289,6 @@ static int record_subpages(struct page *page, unsigned long addr,
>   	return nr;
>   }
>   
> -static void put_compound_head(struct page *page, int refs, unsigned int flags)
> -{
> -	if (flags & FOLL_PIN) {
> -		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
> -				    refs);
> -
> -		if (hpage_pincount_available(page))
> -			hpage_pincount_sub(page, refs);
> -		else
> -			refs *= GUP_PIN_COUNTING_BIAS;
> -	}
> -
> -	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
> -	/*
> -	 * Calling put_page() for each ref is unnecessarily slow. Only the last
> -	 * ref needs a put_page().
> -	 */
> -	if (refs > 1)
> -		page_ref_sub(page, refs - 1);
> -	put_page(page);
> -}
> -
>   #ifdef CONFIG_ARCH_HAS_HUGEPD
>   static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
>   				      unsigned long sz)
> 
