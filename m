From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Date: Thu, 18 Apr 2019 15:20:47 +0200
Message-ID: <20190418132047.GA21430@gmail.com>
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org, x86@kernel.org, linux-mtd@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Dave Hansen <dave@sr71.net>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
List-ID: <linux-s390.vger.kernel.org>


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

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
> 
> This also slightly improves the "Kernel hacking" Kconfig menu.
> Commit e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen')
> mentioned this config option would be a good fit in the "compiler option"
> menu. I did so.

No objections against moving it from x86 code to generic code.

Thanks,

	Ingo
