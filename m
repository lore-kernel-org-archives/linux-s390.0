Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com> <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Mar 2019 14:34:02 +0100
Message-ID: <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190320133402.R6559HcDBqSmiRHv9EwEUDmJokd_cEWGvr8DZxToYTs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I've added your patch to my randconfig test setup and will let you
> know if I see anything noticeable. I'm currently testing clang-arm32,
> clang-arm64 and gcc-x86.

This is the only additional bug that has come up so far:

`.exit.text' referenced in section `.alt.smp.init' of
drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
`exit.text' of drivers/char/ipmi/ipmi_msghandler.o

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index 201100226301..84b12e33104d 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
 const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
        unsigned int machine_nr);
 #else
-static inline const struct machine_desc *
+static __always_inline const struct machine_desc *
 setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 {
        early_print("no ATAGS support: can't continue\n");
