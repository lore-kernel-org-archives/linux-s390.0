Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Apr 2016 12:49:12 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/cpum_sf: Remove superfluous SMP function call
Message-ID: <20160405104912.GC3937@osiris>
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 04, 2016 at 12:27:20PM +0200, Anna-Maria Gleixner wrote:
> Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this SMP
> function calls are no longer required.
> 
> Replace smp_call_function_single() with a direct call of
> setup_pmc_cpu(). To keep the calling convention, interrupts are
> explicitely disabled around the call.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>  arch/s390/kernel/perf_cpum_sf.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> --- a/arch/s390/kernel/perf_cpum_sf.c
> +++ b/arch/s390/kernel/perf_cpum_sf.c
> @@ -1510,7 +1510,6 @@ static void cpumf_measurement_alert(stru
>  static int cpumf_pmu_notifier(struct notifier_block *self,
>  			      unsigned long action, void *hcpu)
>  {
> -	unsigned int cpu = (long) hcpu;
>  	int flags;
> 
>  	/* Ignore the notification if no events are scheduled on the PMU.
> @@ -1523,11 +1522,15 @@ static int cpumf_pmu_notifier(struct not
>  	case CPU_ONLINE:
>  	case CPU_DOWN_FAILED:
>  		flags = PMC_INIT;
> -		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
> +		local_irq_disable();
> +		setup_pmc_cpu(&flags);
> +		local_irq_enable();
>  		break;

...but at least the CPU_DOWN_FAILED callback will not necessarily be called
on the cpu that couldn't be brought offline.
