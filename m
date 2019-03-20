Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
In-Reply-To: <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Mar 2019 10:38:38 +0100
Message-ID: <CAK8P3a0-7LRE4ByO2Uf4tb5mR49SbZzBu0AgHpS=03FAMWFLgQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190320093838.getVFSePzsAzy6z6kIYCwtIvIfwZHmT4YZtrJLGRbRg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 20, 2019 at 7:41 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> It is unclear to me how to fix it.
> That's why I ended up with "depends on !MIPS".
>
>
>   MODPOST vmlinux.o
> arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined
> references to `mips_gcr_base'
>
>
> Perhaps, MIPS folks may know how to fix it.

I would guess like this:

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 8bc5df49b0e1..a27483fedb7d 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -79,7 +79,7 @@ static inline int mips_cm_probe(void)
  *
  * Returns true if a CM is present in the system, else false.
  */
-static inline bool mips_cm_present(void)
+static __always_inline bool mips_cm_present(void)
 {
 #ifdef CONFIG_MIPS_CM
        return mips_gcr_base != NULL;
@@ -93,7 +93,7 @@ static inline bool mips_cm_present(void)
  *
  * Returns true if the system implements an L2-only sync region, else false.
  */
-static inline bool mips_cm_has_l2sync(void)
+static __always_inline bool mips_cm_has_l2sync(void)
 {
 #ifdef CONFIG_MIPS_CM
        return mips_cm_l2sync_base != NULL;
