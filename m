From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2018 13:41:09 +0000
Subject: Re: [PATCH v1 0/2] Kconfig changes to enable Graphics Support for S390
Message-Id: <CAMuHMdW7jR2Oa6dsameR76FLhSnX+kZ7jXqpfQC+oHy_uaMJaQ@mail.gmail.com>
References: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Farhan,

On Thu, Jan 25, 2018 at 4:47 PM, Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
> This series of patches are in preparation for enabling an additional
> tty and console for a S390 KVM guest using a virtio-gpu device[1].
> One of the steps to do this would be to enable CONFIG_VT for S390,
> and this would also require the dummy console (CONFIG_DUMMY_CONSOLE).
>
> Patch 1 enables the "Graphics support" menu which is
> needed to enable dummy console, since the VT layer needs it.
>
> Patch 2 fixes a Kconfig dependency issue for opencores
> framebuffer devices. This issue was exposed by the previous
> patch.
>
> Thanks
> Farhan
>
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg04184.html
>
> Farhan Ali (2):
>   Kconfig : Remove HAS_IOMEM dependency for Graphics support
>   fbdev: Kconfig: Add HAS_IOMEM dependency for FB_OPENCORES
>
>  drivers/video/Kconfig       | 1 -
>  drivers/video/fbdev/Kconfig | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Shouldn't the order of your two patches be inverted, to avoid patch 1
introducing
build breakage fixed by patch 2?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
