Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v13 07/18] x86/xen/time: output xen sched_clock time from
 0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-8-pasha.tatashin@oracle.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <93178b98-8464-ae36-3536-0baa639b3467@oracle.com>
Date: Tue, 17 Jul 2018 11:43:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180712000419.5165-8-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

On 07/11/2018 08:04 PM, Pavel Tatashin wrote:
> It is expected for sched_clock() to output data from 0, when system boots.
> Add an offset xen_sched_clock_offset (similarly how it is done in other
> hypervisors i.e. kvm_sched_clock_offset) to count sched_clock() from 0,
> when time is first initialized.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/x86/xen/time.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> index 2ad61bf896d6..3c6f3d603373 100644
> --- a/arch/x86/xen/time.c
> +++ b/arch/x86/xen/time.c
> @@ -31,6 +31,8 @@
>  /* Xen may fire a timer up to this many ns early */
>  #define TIMER_SLOP	100000
>  
> +static u64 xen_sched_clock_offset __read_mostly;
> +
>  /* Get the TSC speed from Xen */
>  static unsigned long xen_tsc_khz(void)
>  {
> @@ -57,6 +59,11 @@ static u64 xen_clocksource_get_cycles(struct clocksource *cs)
>  	return xen_clocksource_read();
>  }
>  
> +static u64 xen_sched_clock(void)
> +{
> +	return xen_clocksource_read() - xen_sched_clock_offset;
> +}


Should other invocations of xen_clocksource_read() also be offset?

-boris


> +
>  static void xen_read_wallclock(struct timespec64 *ts)
>  {
>  	struct shared_info *s = HYPERVISOR_shared_info;
> @@ -367,7 +374,7 @@ void xen_timer_resume(void)
>  }
>  
>  static const struct pv_time_ops xen_time_ops __initconst = {
> -	.sched_clock = xen_clocksource_read,
> +	.sched_clock = xen_sched_clock,
>  	.steal_clock = xen_steal_clock,
>  };
>  
> @@ -505,6 +512,7 @@ static void __init xen_time_init(void)
>  
>  void __init xen_init_time_ops(void)
>  {
> +	xen_sched_clock_offset = xen_clocksource_read();
>  	pv_time_ops = xen_time_ops;
>  
>  	x86_init.timers.timer_init = xen_time_init;
