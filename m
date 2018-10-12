From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Date: Fri, 12 Oct 2018 14:09:06 +0300
Message-ID: <20181012110906.fpfttp4nhvsr2ps7@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181012013756.11285-1-joel@joelfernandes.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/kvmarm/>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 11, 2018 at 06:37:55PM -0700, Joel Fernandes (Google) wrote:
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 12fe700632f4..4399d712f6db 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -12,8 +12,7 @@ extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  
>  extern const char bad_pmd_string[];
>  
> -extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -	unsigned long address)
> +extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
>  	unsigned long page = __get_free_page(GFP_DMA);
>  
> @@ -32,8 +31,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>  #define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
>  #define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
>  
> -#define pte_alloc_one_fast(mm, addr) pte_alloc_one(mm, addr)
> -

I believe this was one done manually, right?
Please explicitely state everthing you did on not of sematic patch

...

> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
> index 7c89390c0c13..f4cc9ffc449e 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -108,10 +108,9 @@ static inline void free_pgd_slow(pgd_t *pgd)
>  #define pmd_alloc_one_fast(mm, address)	({ BUG(); ((pmd_t *)1); })
>  #define pmd_alloc_one(mm, address)	({ BUG(); ((pmd_t *)2); })
>  
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>  
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -		unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *ptepage;
>  
> @@ -132,20 +131,6 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
>  	return ptepage;
>  }
>  
> -static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm,
> -		unsigned long address)
> -{
> -	unsigned long *ret;
> -
> -	ret = pte_quicklist;
> -	if (ret != NULL) {
> -		pte_quicklist = (unsigned long *)(*ret);
> -		ret[0] = 0;
> -		pgtable_cache_size--;
> -	}
> -	return (pte_t *)ret;
> -}
> -

Ditto.

-- 
 Kirill A. Shutemov
