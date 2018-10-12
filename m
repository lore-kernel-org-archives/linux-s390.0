From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Date: Fri, 12 Oct 2018 16:19:46 +0300
Message-ID: <20181012131946.zoab2lpfmrycmuju@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181012125046.GA170912@joelaf.mtv.corp.google.com>
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
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>, Geert
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 12, 2018 at 05:50:46AM -0700, Joel Fernandes wrote:
> On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > > Android needs to mremap large regions of memory during memory management
> > > related operations. The mremap system call can be really slow if THP is
> > > not enabled. The bottleneck is move_page_tables, which is copying each
> > > pte at a time, and can be really slow across a large map. Turning on THP
> > > may not be a viable option, and is not for us. This patch speeds up the
> > > performance for non-THP system by copying at the PMD level when possible.
> > > 
> > > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > > 
> > > Before:
> > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > 
> > > After:
> > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > 
> > > Incase THP is enabled, the optimization is skipped. I also flush the
> > > tlb every time we do this optimization since I couldn't find a way to
> > > determine if the low-level PTEs are dirty. It is seen that the cost of
> > > doing so is not much compared the improvement, on both x86-64 and arm64.
> > 
> > I looked into the code more and noticed move_pte() helper called from
> > move_ptes(). It changes PTE entry to suite new address.
> > 
> > It is only defined in non-trivial way on Sparc. I don't know much about
> > Sparc and it's hard for me to say if the optimization will break anything
> > there.
> 
> Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
> not modifying the PTE itself AFAICS:
> 
> #ifdef DCACHE_ALIASING_POSSIBLE
> #define __HAVE_ARCH_MOVE_PTE
> #define move_pte(pte, prot, old_addr, new_addr)                         \
> ({                                                                      \
>         pte_t newpte = (pte);                                           \
>         if (tlb_type != hypervisor && pte_present(pte)) {               \
>                 unsigned long this_pfn = pte_pfn(pte);                  \
>                                                                         \
>                 if (pfn_valid(this_pfn) &&                              \
>                     (((old_addr) ^ (new_addr)) & (1 << 13)))            \
>                         flush_dcache_page_all(current->mm,              \
>                                               pfn_to_page(this_pfn));   \
>         }                                                               \
>         newpte;                                                         \
> })
> #endif
> 
> If its an issue, then how do transparent huge pages work on Sparc?  I don't
> see the huge page code (move_huge_pages) during mremap doing anything special
> for Sparc architecture when moving PMDs..

My *guess* is that it will work fine on Sparc as it apprarently it only
cares about change in bit 13 of virtual address. It will never happen for
huge pages or when PTE page tables move.

But I just realized that the problem is bigger: since we pass new_addr to
the set_pte_at() we would need to audit all implementations that they are
safe with just moving PTE page table.

I would rather go with per-architecture enabling. It's much safer.

> Also, do we not flush the caches from any path when we munmap address space?
> We do call do_munmap on the old mapping from mremap after moving to the new one.

Are you sure about that? It can be hided deeper in architecture-specific
code.

-- 
 Kirill A. Shutemov
