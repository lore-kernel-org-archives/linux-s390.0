Return-Path: <owner-linux-mm@kvack.org>
Date: Fri, 3 Nov 2017 12:20:49 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] s390/mm: fix pud table accounting
Message-ID: <20171103092048.ozmskabkq5rrwizz@black.fi.intel.com>
References: <20171103090551.18231-1-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103090551.18231-1-heiko.carstens@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-next@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 03, 2017 at 09:05:51AM +0000, Heiko Carstens wrote:
> With "mm: account pud page tables" and "mm: consolidate page table
> accounting" pud page table accounting was introduced which now results
> in tons of warnings like this one on s390:
> 
> BUG: non-zero pgtables_bytes on freeing mm: -16384
> 
> Reason for this are our run-time folded page tables: by default new
> processes start with three page table levels where the allocated pgd
> is the same as the first pud. In this case there won't ever be a pud
> allocated and therefore mm_inc_nr_puds() will also never be called.
> 
> However when freeing the address space free_pud_range() will call
> exactly once mm_dec_nr_puds() which leads to misaccounting.
> 
> Therefore call mm_inc_nr_puds() within init_new_context() to fix
> this. This is the same like we have it already for processes that run
> with two page table levels (aka compat processes).
> 
> While at it also adjust the comment, since there is no "mm->nr_pmds"
> anymore.

Thanks for tracking it down.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
