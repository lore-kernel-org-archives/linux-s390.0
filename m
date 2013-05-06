From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 06 May 2013 11:03:58 +0000
Subject: Re: [PATCH] S390: Remove non existent reference to GENERIC_KERNEL_THREAD
Message-Id: <20130506110358.GB4322@osiris>
In-Reply-To: <1367755169-13211-1-git-send-email-shc_work@mail.ru>
References: <1367755169-13211-1-git-send-email-shc_work@mail.ru>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 05, 2013 at 03:59:29PM +0400, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 2c9789d..da183c5 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -98,7 +98,6 @@ config S390
>  	select CLONE_BACKWARDS2
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_CPU_DEVICES if !SMP
> -	select GENERIC_KERNEL_THREAD

Applied, thanks.
