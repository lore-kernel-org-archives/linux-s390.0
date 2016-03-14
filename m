Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 Mar 2016 09:51:50 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] s390/cpum_sf: Fix cpu hotplug notifier transitions
Message-ID: <20160314085150.GA5346@osiris>
References: <1457693558-45970-1-git-send-email-anna-maria@linutronix.de>
 <1457693558-45970-3-git-send-email-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457693558-45970-3-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Mar 11, 2016 at 11:52:38AM +0100, Anna-Maria Gleixner wrote:
> The cpumf_pmu_notfier() hotplug callback lacks handling of the
> CPU_DOWN_FAILED case. That means, if CPU_DOWN_PREPARE failes, the PMC
> of the CPU is not setup again. Furthermore the CPU_ONLINE_FROZEN case
> will never be processed because of masking the switch expression with
> CPU_TASKS_FROZEN.
> 
> Add handling for CPU_DOWN_FAILED transition to setup the PMC of the
> CPU. Remove CPU_ONLINE_FROZEN case.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>  arch/s390/kernel/perf_cpum_sf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -1518,7 +1518,7 @@ static int cpumf_pmu_notifier(struct not
> 
>  	switch (action & ~CPU_TASKS_FROZEN) {
>  	case CPU_ONLINE:
> -	case CPU_ONLINE_FROZEN:
> +	case CPU_DOWN_FAILED:
>  		flags = PMC_INIT;
>  		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
>  		break;

This is a bit odd, but independent from your patch: setup_pmc_cpu() will
only deallocate buffers but not allocate them.

Looking at the code a bit further this seems to imply that sampling will
not work on cpus that were added later.

Hendrik, could you please have a look?
