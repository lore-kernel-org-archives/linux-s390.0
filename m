From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Date: Fri, 12 Oct 2018 09:37:25 -0700
Message-ID: <20181012163725.GB223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012110906.fpfttp4nhvsr2ps7@kshutemo-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181012110906.fpfttp4nhvsr2ps7@kshutemo-mobl1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/kvmarm/>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 12, 2018 at 02:09:06PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 06:37:55PM -0700, Joel Fernandes (Google) wrote:
> > diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> > index 12fe700632f4..4399d712f6db 100644
> > --- a/arch/m68k/include/asm/mcf_pgalloc.h
> > +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> > @@ -12,8 +12,7 @@ extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> >  
> >  extern const char bad_pmd_string[];
> >  
> > -extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> > -	unsigned long address)
> > +extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >  {
> >  	unsigned long page = __get_free_page(GFP_DMA);
> >  
> > @@ -32,8 +31,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
> >  #define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
> >  #define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
> >  
> > -#define pte_alloc_one_fast(mm, addr) pte_alloc_one(mm, addr)
> > -
> 
> I believe this was one done manually, right?
> Please explicitely state everthing you did on not of sematic patch

Ok, I can update the changelog with that information next time I send it.
This is the only thing I didn't mention in the changelog since it was a
trivial unused function deletion.. but I mentioned everything else..

And sir, you are one thorough reviewer! ;-)

 - Joel

[..]
