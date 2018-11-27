Return-Path: <owner-linux-mm@kvack.org>
Date: Tue, 27 Nov 2018 07:52:13 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH] mm: warn only once if page table misaccounting is
 detected
Message-ID: <20181127155213.GB27075@linux.intel.com>
References: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, "Kirill A . Shutemov" <kirill@shutemov.name>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Nov 27, 2018 at 09:36:03AM +0100, Heiko Carstens wrote:
> Use pr_alert_once() instead of pr_alert() if page table misaccounting
> has been detected.
> 
> If this happens once it is very likely that there will be numerous
> other occurrence as well, which would flood dmesg and the console with
> hardly any added information. Therefore print the warning only once.
> 
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  kernel/fork.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 07cddff89c7b..c887e9eba89f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -647,8 +647,8 @@ static void check_mm(struct mm_struct *mm)
>  	}
>  
>  	if (mm_pgtables_bytes(mm))
> -		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> -				mm_pgtables_bytes(mm));
> +		pr_alert_once("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> +			      mm_pgtables_bytes(mm));

I found the print-always behavior to be useful when developing a driver
that mucked with PTEs directly via vmf_insert_pfn() and had issues with
racing against exit_mmap().  It was nice to be able to recompile only
the driver and rely on dmesg to let me know when I messed up yet again.

Would pr_alert_ratelimited() suffice?

>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
>  	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
> -- 
> 2.16.4
> 
