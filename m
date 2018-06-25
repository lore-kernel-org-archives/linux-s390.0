Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 25 Jun 2018 12:40:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] s390/boot: block uncompressed vmlinux booting attempts
Message-ID: <20180625194005.GA21023@roeck-us.net>
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
 <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
 <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 25, 2018 at 05:09:19PM +0200, Vasily Gorbik wrote:
> Since uncompressed kernel image "vmlinux" elf file is not bootable under
> qemu anymore, add a check which would report that.
> 
> Qemu users are encouraged to use bzImage or
> arch/s390/boot/compressed/vmlinux instead.
> 
> The check relies on s390 linux entry point ABI definition, which is only
> present in bzImage and arch/s390/boot/compressed/vmlinux.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

With qemu:

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/s390/boot/head.S         |  4 ++--
>  arch/s390/include/asm/setup.h |  3 ++-
>  arch/s390/kernel/early.c      | 12 ++++++++++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
> index f09e792df495..f721913b73f1 100644
> --- a/arch/s390/boot/head.S
> +++ b/arch/s390/boot/head.S
> @@ -272,14 +272,14 @@ iplstart:
>  	.org	0x10000
>  ENTRY(startup)
>  	j	.Lep_startup_normal
> -	.org	0x10008
> +	.org	EP_OFFSET
>  #
>  # This is a list of s390 kernel entry points. At address 0x1000f the number of
>  # valid entry points is stored.
>  #
>  # IMPORTANT: Do not change this table, it is s390 kernel ABI!
>  #
> -	.ascii	"S390EP"
> +	.ascii	EP_STRING
>  	.byte	0x00,0x01
>  #
>  # kdump startup-code at 0x10010, running in 64 bit absolute addressing mode
> diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
> index be02f0558048..1d66016f4170 100644
> --- a/arch/s390/include/asm/setup.h
> +++ b/arch/s390/include/asm/setup.h
> @@ -9,7 +9,8 @@
>  #include <linux/const.h>
>  #include <uapi/asm/setup.h>
>  
> -
> +#define EP_OFFSET		0x10008
> +#define EP_STRING		"S390EP"
>  #define PARMAREA		0x10400
>  #define PARMAREA_END		0x11000
>  
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 827699eb48fa..45c5be3d8777 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -331,8 +331,20 @@ static void __init setup_boot_command_line(void)
>  	append_to_cmdline(append_ipl_scpdata);
>  }
>  
> +static void __init check_image_bootable(void)
> +{
> +	if (!memcmp(EP_STRING, (void *)EP_OFFSET, strlen(EP_STRING)))
> +		return;
> +
> +	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
> +	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
> +	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");
> +	disabled_wait(0xbadb007);
> +}
> +
>  void __init startup_init(void)
>  {
> +	check_image_bootable();
>  	time_early_init();
>  	init_kernel_storage_key();
>  	lockdep_off();
> -- 
> ⣔⢻⣟⢢ 2.18.0.rc2.13.g4da9a5d
> ⣿⢿⡿⣿ pacman edition
> 
