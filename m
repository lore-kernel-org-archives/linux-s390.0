Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 11 Feb 2013 10:11:09 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: Add missing PAGE_SHARED as an alias for PAGE_RW
Message-ID: <20130211091109.GA3890@osiris>
References: <1360432485-25726-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1360432485-25726-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Feb 09, 2013 at 06:54:45PM +0100, Geert Uytterhoeven wrote:
> s390 allmodconfig:
> 
> drivers/gpu/drm/udl/udl_fb.c:237:52: error: 'PAGE_SHARED' undeclared (first use in this function)
> drivers/media/pci/zoran/zoran_driver.c:2955:14: error: 'PAGE_SHARED' undeclared (first use in this function)
> drivers/media/usb/cpia2/cpia2_core.c:2405:66: error: 'PAGE_SHARED' undeclared (first use in this function)
> drivers/video/udlfb.c:337:52: error: 'PAGE_SHARED' undeclared (first use in this function)
> drivers/video/smscufx.c:795:52: error: 'PAGE_SHARED' undeclared (first use in this function)
> drivers/video/vfb.c:431:52: error: 'PAGE_SHARED' undeclared (first use in this function)
> 
> According to an email from Martin a few years ago, the equivalent define
> for s390 is PAGE_RW, so make PAGE_SHARED an alias for PAGE_RW.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/s390/include/asm/pgtable.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 098adbb..0ca3e62 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -386,6 +386,7 @@ extern unsigned long MODULES_END;
> 
>  #define PAGE_KERNEL	PAGE_RW
>  #define PAGE_COPY	PAGE_RO
> +#define PAGE_SHARED	PAGE_RW

Thanks Geert. A similar patch however is already in linux-next, together
with a whole bunch of other patches which try to make s390's allmodconfig
compile again after PCI, HAS_DMA and HAS_IOMEM got enabled by our new PCI
code.
