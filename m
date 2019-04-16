Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Tue, 16 Apr 2019 14:06:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <20190416110906.6c773aff@mschwideX1>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190416140658.2cb73a3f@mschwideX1>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Apr 2019 11:09:06 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Mon, 15 Apr 2019 09:17:10 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:  
> > >
> > > Can we please have the page refcount overflow fixes out on the list
> > > for review, even if it is after the fact?    
> > 
> > They were actually on a list for review long before the fact, but it
> > was the security mailing list. The issue actually got discussed back
> > in January along with early versions of the patches, but then we
> > dropped the ball because it just wasn't on anybody's radar and it got
> > resurrected late March. Willy wrote a rather bigger patch-series, and
> > review of that is what then resulted in those commits. So they may
> > look recent, but that's just because the original patches got
> > seriously edited down and rewritten.  
> 
> First time I hear about this, thanks for the heads up.
>  
> > That said, powerpc and s390 should at least look at maybe adding a
> > check for the page ref in their gup paths too. Powerpc has the special
> > gup_hugepte() case, and s390 has its own version of gup entirely. I
> > was actually hoping the s390 guys would look at using the generic gup
> > code.  
> 
> We did look at converting the s390 gup code to CONFIG_HAVE_GENERIC_GUP,
> there are some details that need careful consideration. The top one
> is access_ok(), for s390 we always return true. The generic gup code
> relies on the fact that a page table walk with a specific address is
> doable if access_ok() returned true, the s390 specific check is slightly
> different:
> 
>         if ((end <= start) || (end > mm->context.asce_limit))
>                 return 0;
> 
> The obvious approach would be to modify access_ok() to check against
> the asce_limit. I will try and see if anything breaks, e.g. the automatic
> page table upgrade.

I tested the waters in regard to access_ok() and the generic gup code.
The good news is that mm/gup.c with CONFIG_HAVE_GENERIC_GUP=y seems to
work just fine if the access_ok() issue is taken care of. But..

Bloat-o-meter with a non-empty uaccess_ok() that checks against
current->mm->context.asce_limit:

add/remove: 8/2 grow/shrink: 611/11 up/down: 61352/-1914 (59438)

with CONFIG_HAVE_GENERIC_GUP on top of that

add/remove: 10/2 grow/shrink: 612/12 up/down: 63568/-3280 (60288)

This is not nice, would a patch like the following be acceptable?
--
Subject: [PATCH] mm: introduce mm_pgd_walk_ok

Add the architecture overrideable function mm_pgd_walk_ok() to check
if a block of memory is inside the limits of the page table hierarchy
of a given mm struct.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/asm-generic/pgtable.h | 4 ++++
 mm/gup.c                      | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index fa782fba51ee..7d2a8a58f1c1 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1186,4 +1186,8 @@ static inline bool arch_has_pfn_modify_check(void)
 #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
 #endif
 
+#ifndef mm_pgd_walk_ok
+#define mm_pgd_walk_ok(mm, addr, size)	access_ok(addr, size)
+#endif
+
 #endif /* _ASM_GENERIC_PGTABLE_H */
diff --git a/mm/gup.c b/mm/gup.c
index 91819b8ad9cc..b3eb3f45d237 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1990,7 +1990,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	len = (unsigned long) nr_pages << PAGE_SHIFT;
 	end = start + len;
 
-	if (unlikely(!access_ok((void __user *)start, len)))
+	if (unlikely(!mm_pgd_walk_ok(current->mm, (void __user *)start, len)))
 		return 0;
 
 	/*
@@ -2044,7 +2044,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (nr_pages <= 0)
 		return 0;
 
-	if (unlikely(!access_ok((void __user *)start, len)))
+	if (unlikely(!mm_pgd_walk_ok(current->mm, (void __user *)start, len)))
 		return -EFAULT;
 
 	if (gup_fast_permitted(start, nr_pages)) {
-- 
2.16.4

With an empty access_ok() but a "real" mm_pgd_walk_ok() the results are
much more reasonable:

add/remove: 2/0 grow/shrink: 2/1 up/down: 2186/-1382 (804)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
