Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44261 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387716AbfIMJNG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 13 Sep 2019 05:13:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id p2so25201407edx.11
        for <linux-s390@vger.kernel.org>; Fri, 13 Sep 2019 02:13:04 -0700 (PDT)
Date: Fri, 13 Sep 2019 12:13:05 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH V2 2/2] mm/pgtable/debug: Add test validating
 architecture page table helpers
Message-ID: <20190913091305.rkds4f3fqv3yjhjy@box>
References: <1568268173-31302-1-git-send-email-anshuman.khandual@arm.com>
 <1568268173-31302-3-git-send-email-anshuman.khandual@arm.com>
 <ab0ca38b-1e4f-b636-f8b4-007a15903984@c-s.fr>
 <502c497a-9bf1-7d2e-95f2-cfebcd9cf1d9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <502c497a-9bf1-7d2e-95f2-cfebcd9cf1d9@arm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Steven Price <Steven.Price@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Matthew Wilcox <willy@infradead.org>, Sri Krishna chowdary <schowdary@nvidia.com>, Dave Hansen <dave.hansen@intel.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vineet Gupta <vgupta@synopsys.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 02:32:04PM +0530, Anshuman Khandual wrote:
>=20
> On 09/12/2019 10:44 PM, Christophe Leroy wrote:
> >=20
> >=20
> > Le 12/09/2019 =EF=BF=BD 08:02, Anshuman Khandual a =EF=BF=BDcrit=EF=BF=
=BD:
> >> This adds a test module which will validate architecture page table he=
lpers
> >> and accessors regarding compliance with generic MM semantics expectati=
ons.
> >> This will help various architectures in validating changes to the exis=
ting
> >> page table helpers or addition of new ones.
> >>
> >> Test page table and memory pages creating it's entries at various leve=
l are
> >> all allocated from system memory with required alignments. If memory p=
ages
> >> with required size and alignment could not be allocated, then all depe=
nding
> >> individual tests are skipped.
> >>
> >=20
> > [...]
> >=20
> >>
> >> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> =EF=BF=BD arch/x86/include/asm/pgtable_64_types.h |=EF=BF=BD=EF=BF=BD =
2 +
> >> =EF=BF=BD mm/Kconfig.debug=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD |=EF=BF=BD 14 +
> >> =EF=BF=BD mm/Makefile=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD |=EF=BF=BD=EF=BF=BD =
1 +
> >> =EF=BF=BD mm/arch_pgtable_test.c=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD | 429 ++++++++++++++++++++++++
> >> =EF=BF=BD 4 files changed, 446 insertions(+)
> >> =EF=BF=BD create mode 100644 mm/arch_pgtable_test.c
> >>
> >> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/includ=
e/asm/pgtable_64_types.h
> >> index 52e5f5f2240d..b882792a3999 100644
> >> --- a/arch/x86/include/asm/pgtable_64_types.h
> >> +++ b/arch/x86/include/asm/pgtable_64_types.h
> >> @@ -40,6 +40,8 @@ static inline bool pgtable_l5_enabled(void)
> >> =EF=BF=BD #define pgtable_l5_enabled() 0
> >> =EF=BF=BD #endif /* CONFIG_X86_5LEVEL */
> >> =EF=BF=BD +#define mm_p4d_folded(mm) (!pgtable_l5_enabled())
> >> +
> >=20
> > This is specific to x86, should go in a separate patch.
>=20
> Thought about it but its just a single line. Kirill suggested this in the
> previous version. There is a generic fallback definition but s390 has it's
> own. This change overrides the generic one for x86 probably as a fix or as
> an improvement. Kirill should be able to help classify it in which case it
> can be a separate patch.

I don't think it worth a separate patch.

--=20
 Kirill A. Shutemov
