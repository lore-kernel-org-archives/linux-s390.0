From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 01 Feb 2019 11:53:00 +0000
Subject: Re: [PATCH -next] s390: remove unused including <linux/version.h>
Message-Id: <20190201115300.GD3770@osiris>
In-Reply-To: <20190201020252.127647-1-yuehaibing@huawei.com>
References: <20190201020252.127647-1-yuehaibing@huawei.com>
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 01, 2019 at 02:02:52AM +0000, YueHaibing wrote:
> Remove including <linux/version.h> that don't need it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/s390/kernel/setup.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 3b416599f6ca..5e707eaa0b31 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -49,7 +49,6 @@
>  #include <linux/memory.h>
>  #include <linux/compat.h>
>  #include <linux/start_kernel.h>
> -#include <linux/version.h>

Applied, thanks.
