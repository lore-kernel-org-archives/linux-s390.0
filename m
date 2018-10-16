From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Date: Mon, 15 Oct 2018 19:08:53 -0700
Message-ID: <20181016020853.GA56701@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <6580a62b-69c6-f2e3-767c-bd36b977bea2@de.ibm.com>
 <20181015101814.306d257c@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181015101814.306d257c@mschwideX1>
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
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Christian Borntraeger <borntraeger@de.ibm.co>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 15, 2018 at 10:18:14AM +0200, Martin Schwidefsky wrote:
> On Mon, 15 Oct 2018 09:10:53 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 10/12/2018 03:37 AM, Joel Fernandes (Google) wrote:
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
> > > 
> > > Cc: minchan@kernel.org
> > > Cc: pantin@google.com
> > > Cc: hughd@google.com
> > > Cc: lokeshgidra@google.com
> > > Cc: dancol@google.com
> > > Cc: mhocko@kernel.org
> > > Cc: kirill@shutemov.name
> > > Cc: akpm@linux-foundation.org
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > > 
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index 9e68a02a52b1..d82c485822ef 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> > >  		drop_rmap_locks(vma);
> > >  }
> > >  
> > > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > > +		  unsigned long new_addr, unsigned long old_end,
> > > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > > +{
> > > +	spinlock_t *old_ptl, *new_ptl;
> > > +	struct mm_struct *mm = vma->vm_mm;
> > > +
> > > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > +	    || old_end - old_addr < PMD_SIZE)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * The destination pmd shouldn't be established, free_pgtables()
> > > +	 * should have release it.
> > > +	 */
> > > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * We don't have to worry about the ordering of src and dst
> > > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > > +	 */
> > > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > > +	if (old_ptl) {
> > > +		pmd_t pmd;
> > > +
> > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > > +		if (new_ptl != old_ptl)
> > > +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> > > +
> > > +		/* Clear the pmd */
> > > +		pmd = *old_pmd;
> > > +		pmd_clear(old_pmd);  
> > 
> > Adding Martin Schwidefsky.
> > Is this mapping maybe still in use on other CPUs? If yes, I think for
> > s390 we need to flush here as well (in other word we might need to introduce
> > pmd_clear_flush). On s390 you have to use instructions like CRDTE,IPTE or IDTE
> > to modify page table entries that are still in use. Otherwise you can get a 
> > delayed access exception which is - in contrast to page faults - not recoverable.
> 
> Just clearing an active pmd would be broken for s390. We need the equivalent
> of the ptep_get_and_clear() function for pmds. For s390 this function would
> look like this:
> 
> static inline pte_t pmdp_get_and_clear(struct mm_struct *mm,
>                                        unsigned long addr, pmd_t *pmdp)
> {
>         return pmdp_xchg_lazy(mm, addr, pmdp, __pmd(_SEGMENT_ENTRY_INVALID));
> }
> 
> Just like pmdp_huge_get_and_clear() in fact.

I agree architecture like s390 may need additional explicit instructions to
avoid any unrecoverable failure. So the good news is in my last patch I sent, I
have put this behind an architecture flag (HAVE_MOVE_PMD), so we don't have
to enable it with architectures that cannot handle it:
https://www.spinics.net/lists/linux-mm/msg163621.html

Also we are triggering this optimization only if the page is not a transparent
huge page by calling pmd_trans_huge(). For regular pages, it should be safe to
not do the atomic get_and_clear AIUI because Linux doesn't use any bits from
the PMD like the dirty bit if THP is not in use (and the processors that I
saw (not s390) should not storing anything in the bits anyway when the page
is not a huge page. I have gone through various scenarios and read both arm
32-bit and 64-bit and x86 64-bit manuals, and I believe it to be safe.

For s390, lets not set the HAVE_MOVE_PMD flag. Does that work for you?

> > > +
> > > +		VM_BUG_ON(!pmd_none(*new_pmd));
> > > +
> > > +		/* Set the new pmd */
> > > +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> > > +		if (new_ptl != old_ptl)
> > > +			spin_unlock(new_ptl);
> > > +		spin_unlock(old_ptl);
> > > +
> > > +		*need_flush = true;
> > > +		return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> 
> So the idea is to move the pmd entry to the new location, dragging
> the whole pte table to a new location with a different address.
> I wonder if that is safe in regard to get_user_pages_fast().

Could you elaborate why you feel it may not be?

Are you concerned that the PMD moving interferes with the page walk? Incase
the tree changes during page-walking, the number of pages pinned by
get_user_pages_fast may be less than the number requested. In this case,
get_user_pages_fast would fall back to the slow path which should be
synchronized with the mremap by courtesy of the mm->mmap_sem. But please let
me know the scenario you have in mind and if I missed something.

thanks,

 - Joel
