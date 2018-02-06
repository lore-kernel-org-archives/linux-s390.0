From: Thomas Huth <thuth@redhat.com>
Date: Tue, 06 Feb 2018 12:36:12 +0000
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <c4acb3f9-2b91-0ec4-7e76-028a8ecec1d0@redhat.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <49ef903a791cbca658194c68932eb90450027774.1517508744.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <49ef903a791cbca658194c68932eb90450027774.1517508744.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, schwidefsky@de.ibm.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <linux-s390.vger.kernel.org>

On 01.02.2018 19:41, Farhan Ali wrote:
> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
> "Graphics support" menu for S390. But if we enable VT layer for S390,
> we would also need to enable the dummy console. So let's remove the
> HAS_IOMEM dependency.
> 
> Move this dependency to Opencores framebuffer driver which would fail to build
> with CONFIG_HAS_IOMEM disabled:
> 
> ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/video/Kconfig       | 1 -
>  drivers/video/fbdev/Kconfig | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 3c20af9..41e7ba9 100644
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
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 2f615b7..ec9c9ce 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -966,7 +966,7 @@ config FB_PVR2
>  
>  config FB_OPENCORES
>  	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
> -	depends on FB && HAS_DMA
> +	depends on FB && HAS_DMA && HAS_IOMEM
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
