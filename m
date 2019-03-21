Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 21 Mar 2019 09:01:33 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20190321080133.GB3916@osiris>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190321080133.WZv7jYxtsdyGEdQE1OAlyOY9VXT4GSmjkug7UK4a4Kc@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org, x86@kernel.org, linux-mtd@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Dave Hansen <dave@sr71.net>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 20, 2019 at 03:20:27PM +0900, Masahiro Yamada wrote:
> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
> 
> The idea is obviously arch-agnostic although we need some code fixups.
> This commit moves the config entry from arch/x86/Kconfig.debug to
> lib/Kconfig.debug so that all architectures (except MIPS for now) can
> benefit from it.
> 
> At this moment, I added "depends on !MIPS" because fixing 0day bot reports
> for MIPS was complex to me.
> 
> I tested this patch on my arm/arm64 boards.
> 
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
> 
> For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
> 
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after

Well, this will change, since now people (have to) start adding
__always_inline annotations on all architectures, most likely until
all have about the same amount of annotations like x86. This will
reduce the benefit.

Not sure if it's really a win that we get the inline vs
__always_inline discussion now on all architectures.
