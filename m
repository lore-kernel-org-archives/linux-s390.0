Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <87sguhti6e.fsf@concordia.ellerman.id.au>
In-Reply-To: <87sguhti6e.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Apr 2019 21:13:17 -0700
Message-ID: <CAHk-=wi2HxyJoH3xhr_ytM3gf1mkvq8Dq9Do+EdNZrm8KjV_6w@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
Content-Type: text/plain; charset="UTF-8"
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Christoph Hellwig <hch@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 16, 2019 at 8:38 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> > That said, powerpc and s390 should at least look at maybe adding a
> > check for the page ref in their gup paths too. Powerpc has the special
> > gup_hugepte() case
>
> Which uses page_cache_add_speculative(), which handles the case of the
> refcount being zero but not overflow. So that looks like it needs
> fixing.

Note that unlike the zero check, the "too many refs" check does _not_
need to be atomic.

Because it's not a correctness issue right at some magical exact
point, it's a much more ambiguous a "the refcount is now so large that
I'm not going to do GUP on this page any more". Being off by a number
of pages in case there's a race is just fine.

So you could do something like this (TOTALLY UNTESTED, and
whitespace-damaged on purpose - I don't want you to apply it blindly)
appended patch.

> And we have a few uses of bare get_page() in KVM code which might be
> subject to the same attack.

Note that you really have to have not just a get_page(), but some way
of lining up *billions* of them. Which really tends to be pretty hard.

            Linus

----

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9e732bb2c84a..52db7ff7c756 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -523,7 +523,8 @@ struct page *follow_huge_pd(struct vm_area_struct *vma,
                page = pte_page(*ptep);
                page += ((address & mask) >> PAGE_SHIFT);
                if (flags & FOLL_GET)
-                       get_page(page);
+                       if (!try_get_page(page))
+                               page = NULL;
        } else {
                if (is_hugetlb_entry_migration(*ptep)) {
                        spin_unlock(ptl);
@@ -883,6 +884,8 @@ int gup_hugepte(pte_t *ptep, unsigned long sz,
unsigned long addr,

        refs = 0;
        head = pte_page(pte);
+       if (page_ref_count(head) < 0)
+               return 0;

        page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
        do {
