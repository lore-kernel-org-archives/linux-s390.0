Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
 <CAK8P3a0-7LRE4ByO2Uf4tb5mR49SbZzBu0AgHpS=03FAMWFLgQ@mail.gmail.com> <CAK7LNATjXoNrbt2SSgR4omiQEBppOkF6mdcVJjpw2B+ihGQvGw@mail.gmail.com>
In-Reply-To: <CAK7LNATjXoNrbt2SSgR4omiQEBppOkF6mdcVJjpw2B+ihGQvGw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Mar 2019 14:04:34 +0100
Message-ID: <CAK8P3a3Y+r95FNpHjPznD5g1PSS=OuYdzT8VH9XNY2DTUhB-Tw@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190320130434.N0mpi5ZkH8bkaBRXfrauWxLljlYsIPnsV06u5_60-JQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 20, 2019 at 11:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Wed, Mar 20, 2019 at 6:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Mar 20, 2019 at 7:41 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >
> > > It is unclear to me how to fix it.
> > > That's why I ended up with "depends on !MIPS".
> > >
> > >
> > >   MODPOST vmlinux.o
> > > arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> > > sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> > > sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> > > arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined
> > > references to `mips_gcr_base'
> > >
> > >
> > > Perhaps, MIPS folks may know how to fix it.
> >
> > I would guess like this:
> >
> > diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> > index 8bc5df49b0e1..a27483fedb7d 100644
> > --- a/arch/mips/include/asm/mips-cm.h
> > +++ b/arch/mips/include/asm/mips-cm.h
> > @@ -79,7 +79,7 @@ static inline int mips_cm_probe(void)
> >   *
> >   * Returns true if a CM is present in the system, else false.
> >   */
> > -static inline bool mips_cm_present(void)
> > +static __always_inline bool mips_cm_present(void)
> >  {
> >  #ifdef CONFIG_MIPS_CM
> >         return mips_gcr_base != NULL;
> > @@ -93,7 +93,7 @@ static inline bool mips_cm_present(void)
> >   *
> >   * Returns true if the system implements an L2-only sync region, else false.
> >   */
> > -static inline bool mips_cm_has_l2sync(void)
> > +static __always_inline bool mips_cm_has_l2sync(void)
> >  {
> >  #ifdef CONFIG_MIPS_CM
> >         return mips_cm_l2sync_base != NULL;
> >
>
>
> Thanks, I applied the above, but I still see
>  undefined reference to `mips_gcr_base'
>
>
> I attached .config to produce this error.
>
> I use prebuilt mips-linux-gcc from
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/

I got to this patch experimentally, it fixes the problem for me:

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 394673991bab..d70d02da038b 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -181,7 +181,7 @@ static int __init mips_sc_probe_cm3(void)
        return 0;
 }

-static inline int __init mips_sc_probe(void)
+static __always_inline int __init mips_sc_probe(void)
 {
        struct cpuinfo_mips *c = &current_cpu_data;
        unsigned int config1, config2;
diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 830c93a010c3..186c28463bf3 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -548,7 +548,7 @@ static inline unsigned long __fls(unsigned long word)
  * Returns 0..SZLONG-1
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static inline unsigned long __ffs(unsigned long word)
+static __always_inline unsigned long __ffs(unsigned long word)
 {
        return __fls(word & -word);
 }


It does look like a gcc bug though, as at least some of the references
are from a function that got split out from an inlined function but that
has no remaining call sites.

       Arnd
