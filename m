From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 21 Feb 2018 11:50:15 +0000
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <5067635.OiHnYRPVcg@amdc3058>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
        <CGME20180221084454epcas3p2a811c2c041e2933afb8288af39b216e2@epcas3p2.samsung.com>
        <f9ac0bc2-6c36-748a-9d71-44b6481ff261@de.ibm.com>
In-Reply-To: <f9ac0bc2-6c36-748a-9d71-44b6481ff261@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, geert@linux-m68k.org, tomi.valkeinen@ti.com, thuth@redhat.com
List-ID: <linux-s390.vger.kernel.org>


On Wednesday, February 21, 2018 09:44:43 AM Christian Borntraeger wrote:
> 
> On 02/19/2018 04:47 PM, Farhan Ali wrote:
> > The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> > added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> > "Graphics support" menu for S390. But if we enable VT layer for S390,
> > we would also need to enable the dummy console. So let's remove the
> > HAS_IOMEM dependency.
> > 
> > Move this dependency to sub menu items and console drivers that use
> > io memory.
> > 
> > Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> This patch is part of todays linux-next and so far no fallout was reported.
> Shall I take that patch via the s390kvm tree (then I would like to have
> an ack. Bart?) or is anybody on cc willing to take this?

I would like to see two things changed before acking this patch:

- add missing HAS_IOMEM dependency to VGA_CONSOLE

- extend "if HAS_IOMEM" in drivers/video/Kconfig to cover config items
  previously covered by this dependency (it should start before config
  HAVE_FB_ATMEL and end after config HDMI)

> Christian
> 
> 
> 
> > ---
> >  drivers/video/Kconfig         | 21 +++++++++++----------
> >  drivers/video/console/Kconfig |  4 ++--
> >  2 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 3c20af9..8f10915 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -3,7 +3,6 @@
> >  #
> > 
> >  menu "Graphics support"
> > -	depends on HAS_IOMEM
> > 
> >  config HAVE_FB_ATMEL
> >  	bool
> > @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
> >  config SH_LCD_MIPI_DSI
> >  	bool
> > 
> > -source "drivers/char/agp/Kconfig"
> > +if HAS_IOMEM
> > +	source "drivers/char/agp/Kconfig"
> > 
> > -source "drivers/gpu/vga/Kconfig"
> > +	source "drivers/gpu/vga/Kconfig"
> > 
> > -source "drivers/gpu/host1x/Kconfig"
> > -source "drivers/gpu/ipu-v3/Kconfig"
> > +	source "drivers/gpu/host1x/Kconfig"
> > +	source "drivers/gpu/ipu-v3/Kconfig"
> > 
> > -source "drivers/gpu/drm/Kconfig"
> > +	source "drivers/gpu/drm/Kconfig"
> > 
> > -menu "Frame buffer Devices"
> > -source "drivers/video/fbdev/Kconfig"
> > -endmenu
> > +	menu "Frame buffer Devices"
> > +	source "drivers/video/fbdev/Kconfig"
> > +	endmenu
> > 
> > -source "drivers/video/backlight/Kconfig"
> > +        source "drivers/video/backlight/Kconfig"
> > +endif
> > 
> >  config VGASTATE
> >         tristate
> > diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> > index 7f1f1fb..0023b16 100644
> > --- a/drivers/video/console/Kconfig
> > +++ b/drivers/video/console/Kconfig
> > @@ -85,7 +85,7 @@ config MDA_CONSOLE
> > 
> >  config SGI_NEWPORT_CONSOLE
> >          tristate "SGI Newport Console support"
> > -        depends on SGI_IP22 
> > +        depends on SGI_IP22 && HAS_IOMEM
> >          select FONT_SUPPORT
> >          help
> >            Say Y here if you want the console on the Newport aka XL graphics
> > @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
> > 
> >  config STI_CONSOLE
> >          bool "STI text console"
> > -        depends on PARISC
> > +        depends on PARISC && HAS_IOMEM
> >          select FONT_SUPPORT
> >          default y
> >          help

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
