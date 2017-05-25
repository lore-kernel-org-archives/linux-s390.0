Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 May 2017 14:28:20 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] s390: kernel: Delete an error message for a failed
 memory allocation in cpcmd()
Message-ID: <20170525182820.GJ877@windriver.com>
References: <225c2a55-eb6e-35cb-285a-cb664a34bc7e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <225c2a55-eb6e-35cb-285a-cb664a34bc7e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

[[PATCH] s390: kernel: Delete an error message for a failed memory allocation in cpcmd()] On 25/05/2017 (Thu 19:18) SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 25 May 2017 19:09:50 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 

Since I was Cc'd -- NACK.

Please, please stop sending garbage patches to every maintainer and
project you can find.

P.
--

> This issue was detected by using the Coccinelle software.
> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/s390/kernel/cpcmd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/cpcmd.c b/arch/s390/kernel/cpcmd.c
> index 9f0e4a2785f7..2f9c97813846 100644
> --- a/arch/s390/kernel/cpcmd.c
> +++ b/arch/s390/kernel/cpcmd.c
> @@ -95,10 +95,9 @@ int cpcmd(const char *cmd, char *response, int rlen, int *response_code)
>  	if ((virt_to_phys(response) != (unsigned long) response) ||
>  			(((unsigned long)response + rlen) >> 31)) {
>  		lowbuf = kmalloc(rlen, GFP_KERNEL | GFP_DMA);
> -		if (!lowbuf) {
> -			pr_warn("The cpcmd kernel function failed to allocate a response buffer\n");
> +		if (!lowbuf)
>  			return -ENOMEM;
> -		}
> +
>  		spin_lock_irqsave(&cpcmd_lock, flags);
>  		len = __cpcmd(cmd, lowbuf, rlen, response_code);
>  		spin_unlock_irqrestore(&cpcmd_lock, flags);
> -- 
> 2.13.0
> 
