From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Date: Sat, 13 Oct 2018 00:40:08 +0300
Message-ID: <20181012214008.jj7vhh76vte7xj7i@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <9ed82f9e-88c4-8e4f-8c45-3ef153469603@kot-begemot.co.uk>
 <20181012143728.t42uvr6etg7gp7fh@kshutemo-mobl1>
 <4dd52e22-5b51-9b30-7178-fde603a08f88@kot-begemot.co.uk>
 <97cb3fe1-7bc1-12ff-d602-56c72a5496c5@kot-begemot.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <97cb3fe1-7bc1-12ff-d602-56c72a5496c5@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 12, 2018 at 05:42:24PM +0100, Anton Ivanov wrote:
> =

> On 10/12/18 3:48 PM, Anton Ivanov wrote:
> > On 12/10/2018 15:37, Kirill A. Shutemov wrote:
> > > On Fri, Oct 12, 2018 at 03:09:49PM +0100, Anton Ivanov wrote:
> > > > On 10/12/18 2:37 AM, Joel Fernandes (Google) wrote:
> > > > > Android needs to mremap large regions of memory during
> > > > > memory management
> > > > > related operations. The mremap system call can be really
> > > > > slow if THP is
> > > > > not enabled. The bottleneck is move_page_tables, which is copying=
 each
> > > > > pte at a time, and can be really slow across a large map.
> > > > > Turning on THP
> > > > > may not be a viable option, and is not for us. This patch
> > > > > speeds up the
> > > > > performance for non-THP system by copying at the PMD level
> > > > > when possible.
> > > > > =

> > > > > The speed up is three orders of magnitude. On a 1GB mremap, the m=
remap
> > > > > completion times drops from 160-250 millesconds to 380-400
> > > > > microseconds.
> > > > > =

> > > > > Before:
> > > > > Total mremap time for 1GB data: 242321014 nanoseconds.
> > > > > Total mremap time for 1GB data: 196842467 nanoseconds.
> > > > > Total mremap time for 1GB data: 167051162 nanoseconds.
> > > > > =

> > > > > After:
> > > > > Total mremap time for 1GB data: 385781 nanoseconds.
> > > > > Total mremap time for 1GB data: 388959 nanoseconds.
> > > > > Total mremap time for 1GB data: 402813 nanoseconds.
> > > > > =

> > > > > Incase THP is enabled, the optimization is skipped. I also flush =
the
> > > > > tlb every time we do this optimization since I couldn't find a wa=
y to
> > > > > determine if the low-level PTEs are dirty. It is seen that the co=
st of
> > > > > doing so is not much compared the improvement, on both
> > > > > x86-64 and arm64.
> > > > > =

> > > > > Cc: minchan@kernel.org
> > > > > Cc: pantin@google.com
> > > > > Cc: hughd@google.com
> > > > > Cc: lokeshgidra@google.com
> > > > > Cc: dancol@google.com
> > > > > Cc: mhocko@kernel.org
> > > > > Cc: kirill@shutemov.name
> > > > > Cc: akpm@linux-foundation.org
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > > =A0=A0 mm/mremap.c | 62
> > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > =A0=A0 1 file changed, 62 insertions(+)
> > > > > =

> > > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > > index 9e68a02a52b1..d82c485822ef 100644
> > > > > --- a/mm/mremap.c
> > > > > +++ b/mm/mremap.c
> > > > > @@ -191,6 +191,54 @@ static void move_ptes(struct
> > > > > vm_area_struct *vma, pmd_t *old_pmd,
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 drop_rmap_locks(vma);
> > > > > =A0=A0 }
> > > > > +static bool move_normal_pmd(struct vm_area_struct *vma,
> > > > > unsigned long old_addr,
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long new_addr, unsigned lon=
g old_end,
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 pmd_t *old_pmd, pmd_t *new_pmd, bool=
 *need_flush)
> > > > > +{
> > > > > +=A0=A0=A0 spinlock_t *old_ptl, *new_ptl;
> > > > > +=A0=A0=A0 struct mm_struct *mm =3D vma->vm_mm;
> > > > > +
> > > > > +=A0=A0=A0 if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > > > +=A0=A0=A0=A0=A0=A0=A0 || old_end - old_addr < PMD_SIZE)
> > > > > +=A0=A0=A0=A0=A0=A0=A0 return false;
> > > > > +
> > > > > +=A0=A0=A0 /*
> > > > > +=A0=A0=A0=A0 * The destination pmd shouldn't be established, fre=
e_pgtables()
> > > > > +=A0=A0=A0=A0 * should have release it.
> > > > > +=A0=A0=A0=A0 */
> > > > > +=A0=A0=A0 if (WARN_ON(!pmd_none(*new_pmd)))
> > > > > +=A0=A0=A0=A0=A0=A0=A0 return false;
> > > > > +
> > > > > +=A0=A0=A0 /*
> > > > > +=A0=A0=A0=A0 * We don't have to worry about the ordering of src =
and dst
> > > > > +=A0=A0=A0=A0 * ptlocks because exclusive mmap_sem prevents deadl=
ock.
> > > > > +=A0=A0=A0=A0 */
> > > > > +=A0=A0=A0 old_ptl =3D pmd_lock(vma->vm_mm, old_pmd);
> > > > > +=A0=A0=A0 if (old_ptl) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 pmd_t pmd;
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0 new_ptl =3D pmd_lockptr(mm, new_pmd);
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (new_ptl !=3D old_ptl)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_lock_nested(new_ptl, SING=
LE_DEPTH_NESTING);
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0 /* Clear the pmd */
> > > > > +=A0=A0=A0=A0=A0=A0=A0 pmd =3D *old_pmd;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 pmd_clear(old_pmd);
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0 VM_BUG_ON(!pmd_none(*new_pmd));
> > > > > +
> > > > > +=A0=A0=A0=A0=A0=A0=A0 /* Set the new pmd */
> > > > > +=A0=A0=A0=A0=A0=A0=A0 set_pmd_at(mm, new_addr, new_pmd, pmd);
> > > > UML does not have set_pmd_at at all
> > > Every architecture does. :)
> > =

> > I tried to build it patching vs 4.19-rc before I made this statement and
> > ran into that.
> > =

> > Presently it does not.
> > =

> > https://elixir.bootlin.com/linux/v4.19-rc7/ident/set_pmd_at - UML is not
> > on the list.
> =

> Once this problem as well as the omissions in the include changes for UML=
 in
> patch one have been fixed it appears to be working.
> =

> What it needs is attached.

Well, the optization is only suitable for arch that has 3 or more levels
of page tables. Otherwise it will not have [non-folded] pmd.

And in this case arch/um already should have set_pmd_at(), see
3_LEVEL_PGTABLES.

To port on 2-level paging, it has to be handled on pgd level. It
complicates the code and will not bring much value.

-- =

 Kirill A. Shutemov
