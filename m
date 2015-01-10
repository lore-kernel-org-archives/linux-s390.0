From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Sat, 10 Jan 2015 08:58:54 +0000
Subject: Re: [PATCH 1/2] s390/hmcdrv: Remove unnecessary version.h inclusion
Message-Id: <20150110085854.GA4491@osiris>
In-Reply-To: <00e101d02c1b$aca99b40$05fcd1c0$@samsung.com>
References: <00e101d02c1b$aca99b40$05fcd1c0$@samsung.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 09, 2015 at 08:20:54PM +0530, Syam wrote:
> Hi,
> 
> -----Original Message-----
> From: Syam Sidhardhan [mailto:s.syam@samsung.com] 
> Sent: Tuesday, December 30, 2014 4:47 PM
> To: schwidefsky@de.ibm.com; rhoppe@de.ibm.com; heiko.carstens@de.ibm.com;
> linux390@de.ibm.com; linux-s390@vger.kernel.org
> Cc: Syam Sidhardhan
> Subject: [PATCH 1/2] s390/hmcdrv: Remove unnecessary version.h inclusion
> 
> version.h inclusion is not necessary as detected by versioncheck.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  drivers/s390/char/hmcdrv_mod.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/s390/char/hmcdrv_mod.c b/drivers/s390/char/hmcdrv_mod.c
> index 505c6a7..251a318 100644
> --- a/drivers/s390/char/hmcdrv_mod.c
> +++ b/drivers/s390/char/hmcdrv_mod.c
> @@ -11,7 +11,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/version.h>
>  #include <linux/stat.h>
> 
>  #include "hmcdrv_ftp.h"
> 
> ping

Applied, thanks.
