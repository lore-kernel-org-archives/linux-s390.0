From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH linux-next] fix s390 compile error due to
	smp_call_function
Date: Wed, 9 Jul 2008 16:36:39 +0200
Message-ID: <20080709143639.GB24152@osiris.boeblingen.de.ibm.com>
References: <200807081625.50437.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807081625.50437.borntraeger@de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 08, 2008 at 04:25:50PM +0200, Christian Borntraeger wrote:
> Hello Jens,
> 
> the following patch in linux-next (v2.6.26-rc9-7220-g5e36ed1)
> 
> commit 8691e5a8f691cc2a4fda0651e8d307aaba0e7d68
> Author: Jens Axboe <jens.axboe@oracle.com>
> Date:   Fri Jun 6 11:18:06 2008 +0200
> smp_call_function: get rid of the unused nonatomic/retry argument
> 
> causes a build error on s390.
>   CC      arch/s390/kernel/time.o
> arch/s390/kernel/time.c: In function 'stp_work_fn':
> arch/s390/kernel/time.c:1448: error: too many arguments to 
> function 'smp_call_function'
> arch/s390/kernel/time.c:1481: error: too many arguments to 
> function 'smp_call_function'
> 
> The fix is simple and obvious, remove the unneeded argument.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> ---
>  arch/s390/kernel/time.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-next/arch/s390/kernel/time.c
> ===================================================================
> --- linux-next.orig/arch/s390/kernel/time.c
> +++ linux-next/arch/s390/kernel/time.c
> @@ -1445,7 +1445,7 @@ static void stp_work_fn(struct work_stru
>  	 */
>  	memset(&stp_sync, 0, sizeof(stp_sync));
>  	preempt_disable();
> -	smp_call_function(clock_sync_cpu_start, &stp_sync, 0, 0);
> +	smp_call_function(clock_sync_cpu_start, &stp_sync, 0);
>  	local_irq_disable();
>  	enable_sync_clock();
> 
> @@ -1478,7 +1478,7 @@ static void stp_work_fn(struct work_stru
>  		stp_sync.in_sync = 1;
> 
>  	local_irq_enable();
> -	smp_call_function(clock_sync_cpu_end, NULL, 0, 0);
> +	smp_call_function(clock_sync_cpu_end, NULL, 0);
>  	preempt_enable();
>  }

Stephen, could you add this patch to your build fixes?
Currently it won't fit into git-s390 or Jens' smp_call_function
tree, since these two call sites are introduced with a new
patch in git-s390 (stp support).
