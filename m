Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33637 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfIMIvg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 13 Sep 2019 04:51:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id o9so26411180edq.0
        for <linux-s390@vger.kernel.org>; Fri, 13 Sep 2019 01:51:35 -0700 (PDT)
Date: Fri, 13 Sep 2019 11:51:35 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm/pgtable/debug: Fix test validating architecture page
 table helpers
Message-ID: <20190913085135.rfr3zrabghi2qo2t@box>
References: <1892b37d1fd9a4ed39e76c4b999b6556077201c0.1568355752.git.christophe.leroy@c-s.fr>
 <527dd29d-45fa-4d83-1899-6cbf268dd749@arm.com>
 <e2b42446-7f91-83f1-ac12-08dff75c4d35@c-s.fr>
 <cb226b56-ff20-3136-7ffb-890657e56870@c-s.fr>
 <bdf7f152-d093-1691-4e96-77da7eb9e20a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bdf7f152-d093-1691-4e96-77da7eb9e20a@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Vlastimil Babka <vbabka@suse.cz>, linux-snps-arc@lists.infradead.org, Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-arm-kernel@lists.infradead.org, Sri Krishna chowdary <schowdary@nvidia.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Fri, Sep 13, 2019 at 02:12:45PM +0530, Anshuman Khandual wrote:
>=20
>=20
> On 09/13/2019 12:41 PM, Christophe Leroy wrote:
> >=20
> >=20
> > Le 13/09/2019 =EF=BF=BD 09:03, Christophe Leroy a =EF=BF=BDcrit=EF=BF=
=BD:
> >>
> >>
> >> Le 13/09/2019 =EF=BF=BD 08:58, Anshuman Khandual a =EF=BF=BDcrit=EF=BF=
=BD:
> >>> On 09/13/2019 11:53 AM, Christophe Leroy wrote:
> >>>> Fix build failure on powerpc.
> >>>>
> >>>> Fix preemption imbalance.
> >>>>
> >>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>>> ---
> >>>> =EF=BF=BD mm/arch_pgtable_test.c | 3 +++
> >>>> =EF=BF=BD 1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/mm/arch_pgtable_test.c b/mm/arch_pgtable_test.c
> >>>> index 8b4a92756ad8..f2b3c9ec35fa 100644
> >>>> --- a/mm/arch_pgtable_test.c
> >>>> +++ b/mm/arch_pgtable_test.c
> >>>> @@ -24,6 +24,7 @@
> >>>> =EF=BF=BD #include <linux/swap.h>
> >>>> =EF=BF=BD #include <linux/swapops.h>
> >>>> =EF=BF=BD #include <linux/sched/mm.h>
> >>>> +#include <linux/highmem.h>
> >>>
> >>> This is okay.
> >>>
> >>>> =EF=BF=BD #include <asm/pgalloc.h>
> >>>> =EF=BF=BD #include <asm/pgtable.h>
> >>>> @@ -400,6 +401,8 @@ static int __init arch_pgtable_tests_init(void)
> >>>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD p4d_clear_tests(p4dp);
> >>>> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD pgd_clear_tests(mm, pg=
dp);
> >>>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD pte_unmap(ptep);
> >>>> +
> >>>
> >>> Now the preemption imbalance via pte_alloc_map() path i.e
> >>>
> >>> pte_alloc_map() -> pte_offset_map() -> kmap_atomic()
> >>>
> >>> Is not this very much powerpc 32 specific or this will be applicable
> >>> for all platform which uses kmap_XXX() to map high memory ?
> >>>
> >>
> >> See https://elixir.bootlin.com/linux/v5.3-rc8/source/include/linux/hig=
hmem.h#L91
> >>
> >> I think it applies at least to all arches using the generic implementa=
tion.
> >>
> >> Applies also to arm:
> >> https://elixir.bootlin.com/linux/v5.3-rc8/source/arch/arm/mm/highmem.c=
#L52
> >>
> >> Applies also to mips:
> >> https://elixir.bootlin.com/linux/v5.3-rc8/source/arch/mips/mm/highmem.=
c#L47
> >>
> >> Same on sparc:
> >> https://elixir.bootlin.com/linux/v5.3-rc8/source/arch/sparc/mm/highmem=
.c#L52
> >>
> >> Same on x86:
> >> https://elixir.bootlin.com/linux/v5.3-rc8/source/arch/x86/mm/highmem_3=
2.c#L34
> >>
> >> I have not checked others, but I guess it is like that for all.
> >>
> >=20
> >=20
> > Seems like I answered too quickly. All kmap_atomic() do preempt_disable=
(), but not all pte_alloc_map() call kmap_atomic().
> >=20
> > However, for instance ARM does:
> >=20
> > https://elixir.bootlin.com/linux/v5.3-rc8/source/arch/arm/include/asm/p=
gtable.h#L200
> >=20
> > And X86 as well:
> >=20
> > https://elixir.bootlin.com/linux/v5.3-rc8/source/arch/x86/include/asm/p=
gtable_32.h#L51
> >=20
> > Microblaze also:
> >=20
> > https://elixir.bootlin.com/linux/v5.3-rc8/source/arch/microblaze/includ=
e/asm/pgtable.h#L495
>=20
> All the above platforms checks out to be using k[un]map_atomic(). I am wo=
ndering whether
> any of the intermediate levels will have similar problems on any these 32=
 bit platforms
> or any other platforms which might be using generic k[un]map_atomic().

No. Kernel only allocates pte page table from highmem. All other page
tables are always visible in kernel address space.

--=20
 Kirill A. Shutemov
