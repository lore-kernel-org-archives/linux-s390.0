From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 21 Feb 2018 08:44:43 +0000
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <f9ac0bc2-6c36-748a-9d71-44b6481ff261@de.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, tomi.valkeinen@ti.com, thuth@redhat.com, b.zolnierkie@samsung.com
List-ID: <linux-s390.vger.kernel.org>



On 02/19/2018 04:47 PM, Farhan Ali wrote:
> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> "Graphics support" menu for S390. But if we enable VT layer for S390,
> we would also need to enable the dummy console. So let's remove the
> HAS_IOMEM dependency.
> 
> Move this dependency to sub menu items and console drivers that use
> io memory.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>

This patch is part of todays linux-next and so far no fallout was reported.
Shall I take that patch via the s390kvm tree (then I would like to have
an ack. Bart?) or is anybody on cc willing to take this?

Christian



> ---
>  drivers/video/Kconfig         | 21 +++++++++++----------
>  drivers/video/console/Kconfig |  4 ++--
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3c20af9..8f10915 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -3,7 +3,6 @@
>  #
> 
>  menu "Graphics support"
> -	depends on HAS_IOMEM
> 
>  config HAVE_FB_ATMEL
>  	bool
> @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
>  config SH_LCD_MIPI_DSI
>  	bool
> 
> -source "drivers/char/agp/Kconfig"
> +if HAS_IOMEM
> +	source "drivers/char/agp/Kconfig"
> 
> -source "drivers/gpu/vga/Kconfig"
> +	source "drivers/gpu/vga/Kconfig"
> 
> -source "drivers/gpu/host1x/Kconfig"
> -source "drivers/gpu/ipu-v3/Kconfig"
> +	source "drivers/gpu/host1x/Kconfig"
> +	source "drivers/gpu/ipu-v3/Kconfig"
> 
> -source "drivers/gpu/drm/Kconfig"
> +	source "drivers/gpu/drm/Kconfig"
> 
> -menu "Frame buffer Devices"
> -source "drivers/video/fbdev/Kconfig"
> -endmenu
> +	menu "Frame buffer Devices"
> +	source "drivers/video/fbdev/Kconfig"
> +	endmenu
> 
> -source "drivers/video/backlight/Kconfig"
> +        source "drivers/video/backlight/Kconfig"
> +endif
> 
>  config VGASTATE
>         tristate
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 7f1f1fb..0023b16 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -85,7 +85,7 @@ config MDA_CONSOLE
> 
>  config SGI_NEWPORT_CONSOLE
>          tristate "SGI Newport Console support"
> -        depends on SGI_IP22 
> +        depends on SGI_IP22 && HAS_IOMEM
>          select FONT_SUPPORT
>          help
>            Say Y here if you want the console on the Newport aka XL graphics
> @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
> 
>  config STI_CONSOLE
>          bool "STI text console"
> -        depends on PARISC
> +        depends on PARISC && HAS_IOMEM
>          select FONT_SUPPORT
>          default y
>          help
> 
