From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: asm-geniric: for atomic_set_mask() 1st param, use
 'unsigned int' instead of 'unsigned long'
Date: Sat, 8 Jun 2013 10:31:59 +0200
Message-ID: <CAMuHMdVg12Wm4fZYDdgV0m4+Bo76hm=nckGtSkobRfbsmNo2wA@mail.gmail.com>
References: <51B2E262.3030603@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <51B2E262.3030603@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Hirokazu Takata <takata@linux-m32r.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, realmz paranoid <realmz6@gmail.com>, linux390@de.ibm.com, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Haven't done a real review, but my eye fell on it:

On Sat, Jun 8, 2013 at 9:50 AM, Chen Gang <gang.chen@asianux.com> wrote:
> diff --git a/arch/m32r/include/asm/atomic.h b/arch/m32r/include/asm/atomic.h
> index 0d81697..233c743 100644
> --- a/arch/m32r/include/asm/atomic.h
> +++ b/arch/m32r/include/asm/atomic.h
> @@ -264,7 +264,7 @@ static __inline__ int __atomic_add_unless(atomic_t *v, int a, int u)
>  }
>
>
> -static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
> +static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *addr)
>  {
>         unsigned long flags;
>         unsigned long tmp;

Shouldn't this become "unsigned int tmp" for consistency, too?

> @@ -286,7 +286,7 @@ static __inline__ void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
>         local_irq_restore(flags);
>  }
>
> -static __inline__ void atomic_set_mask(unsigned long  mask, atomic_t *addr)
> +static __inline__ void atomic_set_mask(unsigned int mask, atomic_t *addr)
>  {
>         unsigned long flags;
>         unsigned long tmp;

Likewise.

There may be other places that need changes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
