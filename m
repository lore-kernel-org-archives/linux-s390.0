From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RESEND PATCH v3 10/11] powerpc/mm/radix: mark as __tlbie_pid()
 and friends as__always_inline
Date: Fri, 17 May 2019 13:18:31 +0900
Message-ID: <CAK7LNASjc8rmJvv5kgk6Mxo3mcB4EgB4XJG_8JY47ZQbrsSSXg@mail.gmail.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-11-yamada.masahiro@socionext.com> <ca74c830-fe1b-7bff-8dfd-353fca57b647@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ca74c830-fe1b-7bff-8dfd-353fca57b647@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-s390 <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Laura,


On Fri, May 17, 2019 at 7:55 AM Laura Abbott <labbott@redhat.com> wrote:

> What gcc version was this tested with?

I use kernel.org toolchains
https://mirrors.edge.kernel.org/pub/tools/crosstool/

It is GCC 8.1


> We're still seeing errors on
> Fedora rawhide with gcc 9.1.1 on a version (8c05f3b965da14e7790711026b32cc10a4c06213)
> that should have this fix in it:
>
> BUILDSTDERR: arch/powerpc/mm/book3s64/radix_tlb.c: In function '_tlbiel_pid':
> BUILDSTDERR: arch/powerpc/mm/book3s64/radix_tlb.c:104:2: warning: asm operand 3 probably doesn't match constraints
> BUILDSTDERR:   104 |  asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
> BUILDSTDERR:       |  ^~~
> BUILDSTDERR: arch/powerpc/mm/book3s64/radix_tlb.c:104:2: error: impossible constraint in 'asm'
> BUILDSTDERR: make[3]: *** [scripts/Makefile.build:279: arch/powerpc/mm/book3s64/radix_tlb.o] Error 1
> BUILDSTDERR: make[2]: *** [scripts/Makefile.build:489: arch/powerpc/mm/book3s64] Error 2
> BUILDSTDERR: make[1]: *** [scripts/Makefile.build:489: arch/powerpc/mm] Error 2

Thanks for the report.

Does this work for you?


diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c
b/arch/powerpc/mm/book3s64/radix_tlb.c
index 4d841369399f..9a6befdd5e74 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c

@@ -239,7 +239,7 @@ static inline void fixup_tlbie_lpid(unsigned long lpid)
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
-static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
+static __always_inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
 {
        int set;




--
Best Regards
Masahiro Yamada
