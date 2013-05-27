From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: s390: appldata: using strncpy() instead of sprintf()
Date: Mon, 27 May 2013 10:34:15 +0200
Message-ID: <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com>
References: <51A2CC07.5010100@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <51A2CC07.5010100@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, jang@linux.vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 27, 2013 at 4:59 AM, Chen Gang <gang.chen@asianux.com> wrote:
> 'buf[2]' is 2 bytes length, and sprintf() will append '\0' at the end
> of string "?\n", so original implementation is memory overflow.

Nice catch!

> Need use strncpy() instead of sprintf().

Or memcpy(), as the string is always 2 bytes?
Of course that would break future extension with multi-digit responses, but in
that case, the buffer size needs to be expanded, too.

Anyway, this code needed some more brain cycles to actually understand
what's it doing, and whether it's correct. So I guess it's ripe for more
refactoring...

> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/s390/appldata/appldata_base.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
> index bae0f40..566ea87 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -212,7 +212,8 @@ appldata_timer_handler(ctl_table *ctl, int write,
>                 return 0;
>         }
>         if (!write) {
> -               len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");

Before, len was always 2. The string was zero-terminated but the zero was
not returned to user space, which is OK.

> +               len = strncpy(buf, appldata_timer_active ? "1\n" : "0\n",
> +                                                               sizeof(buf));

Oops, strncpy() doesn't return a size, but a pointer! So this doesn't work.
I guess you haven't compiled this?
http://kernel.org/pub/tools/crosstool/files/bin/

>                 if (len > *lenp)
>                         len = *lenp;
>                 if (copy_to_user(buffer, buf, len))

What about creating a "uprintf()" that formats strings to a userspace buffer?

> @@ -317,7 +318,7 @@ appldata_generic_handler(ctl_table *ctl, int write,
>                 return 0;
>         }
>         if (!write) {
> -               len = sprintf(buf, ops->active ? "1\n" : "0\n");
> +               len = strncpy(buf, ops->active ? "1\n" : "0\n", sizeof(buf));

Same here.

>                 if (len > *lenp)
>                         len = *lenp;
>                 if (copy_to_user(buffer, buf, len)) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
