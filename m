From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 11:26:16 +0000
Subject: Re: [PATCH] s390/console: enable dummy console for vt
Message-Id: <CAMuHMdWCK1V3PWXHMNZUmFVMCSqi5xhs72mT_M=gE96TSzMN9w@mail.gmail.com>
References: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
 <20180215111423.96598-1-borntraeger@de.ibm.com>
In-Reply-To: <20180215111423.96598-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Thomas Huth <thuth@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Christian,

On Thu, Feb 15, 2018 at 12:14 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> To enable the virtual terminal layer with virtio-gpu, we need to
> provide the dummy console. This console is hidden behind CONFIG_IOMEM
> via the graphics support. Instead of fully enabling the graphic
> drivers lets just provide a Kconfig option for the dummy console.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> New version: instead of moving around the graphic and console stuff,
> let's just keep an s390 specific variant of CONFIG_DUMMY_CONSOLE
>  arch/s390/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index cbe1d978693a..a69690f616f3 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -952,6 +952,11 @@ config S390_HYPFS_FS
>
>  source "arch/s390/kvm/Kconfig"
>
> +config DUMMY_CONSOLE
> +       bool
> +       depends on VT
> +       default y
> +
>  config S390_GUEST
>         def_bool y
>         prompt "s390 support for virtio devices"

Really?

You already have your own copy of HAS_IOMEM, which makes it hard for
people to track which one applies where.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
