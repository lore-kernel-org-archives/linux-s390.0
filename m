Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 6 Nov 2018 06:42:12 +0100
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Message-ID: <20181106054212.GA31768@nautica>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719205545.16512-24-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

(added various kvm/virtualization lists in Cc as well as qemu as I don't
know who's "wrong" here)

Pavel Tatashin wrote on Thu, Jul 19, 2018:
> Allow sched_clock() to be used before schec_clock_init() is called.
> This provides with a way to get early boot timestamps on machines with
> unstable clocks.

This isn't something I understand, but bisect tells me this patch
(landed as 857baa87b64 ("sched/clock: Enable sched clock early")) makes
a VM running with kvmclock take a step in uptime/printk timer early in
boot sequence as illustrated below. The step seems to be related to the
amount of time the host was suspended while qemu was running before the
reboot.

$ dmesg
...
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[283120.529821] kvm-clock: cpu 0, msr 321a8001, primary cpu clock
[283120.529822] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[283120.529824] tsc: Detected 2592.000 MHz processor
...

(The VM is x86_64 on x86_64, I can provide my .config on request but
don't think it's related)


It's rather annoying for me as I often reboot VMs and rely on the
'uptime' command to check if I did just reboot or not as I have the
attention span of a goldfish; I'd rather not have to find something else
to check if I did just reboot or not.

Note that if the qemu process is restarted, there is no offset anymore.

I unfortunately just did that so cannot say with confidence (putting my
laptop to sleep for 30s only led to a 2s offset and I do not want to
wait longer right now), but it looks like the clock is still mostly
correct after reboot after disabling my VM's ntp client. Will infirm
that tomorrow if I was wrong.


Happy to try to help fixing this in any way, as written above the quote
I'm not even actually sure who is wrong here.

Thanks!



(As a side, mostly unrelated note, insert swearing here about cf7a63ef4
not compiling earlier in this serie; some variable declaration got
removed before their use. Was fixed in the next patch but I didn't
notice the kernel didn't fully rebuild and wasted time in my bisect
heading the wrong way...)

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  init/main.c          |  2 +-
>  kernel/sched/clock.c | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 162d931c9511..ff0a24170b95 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -642,7 +642,6 @@ asmlinkage __visible void __init start_kernel(void)
>  	softirq_init();
>  	timekeeping_init();
>  	time_init();
> -	sched_clock_init();
>  	printk_safe_init();
>  	perf_event_init();
>  	profile_init();
> @@ -697,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
>  	acpi_early_init();
>  	if (late_time_init)
>  		late_time_init();
> +	sched_clock_init();
>  	calibrate_delay();
>  	pid_idr_init();
>  	anon_vma_init();
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 0e9dbb2d9aea..422cd63f8f17 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -202,7 +202,25 @@ static void __sched_clock_gtod_offset(void)
>  
>  void __init sched_clock_init(void)
>  {
> +	unsigned long flags;
> +
> +	/*
> +	 * Set __gtod_offset such that once we mark sched_clock_running,
> +	 * sched_clock_tick() continues where sched_clock() left off.
> +	 *
> +	 * Even if TSC is buggered, we're still UP at this point so it
> +	 * can't really be out of sync.
> +	 */
> +	local_irq_save(flags);
> +	__sched_clock_gtod_offset();
> +	local_irq_restore(flags);
> +
>  	sched_clock_running = 1;
> +
> +	/* Now that sched_clock_running is set adjust scd */
> +	local_irq_save(flags);
> +	sched_clock_tick();
> +	local_irq_restore(flags);
>  }
>  /*
>   * We run this as late_initcall() such that it runs after all built-in drivers,
> @@ -356,7 +374,7 @@ u64 sched_clock_cpu(int cpu)
>  		return sched_clock() + __sched_clock_offset;
>  
>  	if (unlikely(!sched_clock_running))
> -		return 0ull;
> +		return sched_clock();
>  
>  	preempt_disable_notrace();
>  	scd = cpu_sdc(cpu);
-- 
Dominique Martinet | Asmadeus
