From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 6/8] asm-generic/io.h: Implement generic {read,write}s*()
Date: Mon, 29 Sep 2014 10:54:34 +0200
Message-ID: <CAMuHMdW4emoma3nRUGna985tE17yPh5pNjMb-jxe5yc5UVr=cw@mail.gmail.com>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
	<1407925738-26170-7-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1407925738-26170-7-git-send-email-thierry.reding@gmail.com>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, the arch/x86 maintainers <x86@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Aug 13, 2014 at 12:28 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> #ifndef memset_io
> -#define memset_io(a, b, c)     memset(__io_virt(a), (b), (c))
> +#define memset_io memset_io
> +static inline void memset_io(void __iomem *addr, int value, size_t size)
> +{
> +       memset(__io_virt(addr), value, size);
> +}
>  #endif

xtensa/allmodconfig:

include/asm-generic/io.h:820:2: error: implicit declaration of
function 'memset' [-Werror=implicit-function-declaration]
include/asm-generic/io.h:829:2: error: implicit declaration of
function 'memcpy' [-Werror=implicit-function-declaration]
arch/xtensa/include/asm/string.h:110:14: error: conflicting types for 'memset'
arch/xtensa/include/asm/string.h:113:14: error: conflicting types for 'memcpy'

http://kisskb.ellerman.id.au/kisskb/buildresult/12028900/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
