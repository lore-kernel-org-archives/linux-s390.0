Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v13 06/18] x86/xen/time: initialize pv xen time in
 init_hypervisor_platform
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-7-pasha.tatashin@oracle.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <cf7ef6d0-8650-3e8a-0e15-5150b58d1b50@oracle.com>
Date: Tue, 17 Jul 2018 11:28:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180712000419.5165-7-pasha.tatashin@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

On 07/11/2018 08:04 PM, Pavel Tatashin wrote:
> In every hypervisor except for xen pv time ops are initialized in
> init_hypervisor_platform().
>
> Xen PV domains initialize time ops in x86_init.paging.pagetable_init(),
> by calling xen_setup_shared_info() which is a poor design, as time is
> needed prior to memory allocator.
>
> xen_setup_shared_info() is called from two places: during boot, and
> after suspend. Split the content of xen_setup_shared_info() into
> three places:
>
> 1. add the clock relavent data into new xen pv init_platform vector, and
>    set clock ops in there.
>
> 2. move xen_setup_vcpu_info_placement() to new xen_pv_guest_late_init()
>    call.
>
> 3. Re-initializing parts of shared info copy to xen_pv_post_suspend() to
>    be symmetric to xen_pv_pre_suspend
>
> Also, remove code duplications by calling xen_init_time_ops() from
> xen_hvm_init_time_ops().
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/x86/xen/enlighten_pv.c | 51 +++++++++++++++++--------------------
>  arch/x86/xen/mmu_pv.c       |  6 ++---
>  arch/x86/xen/suspend_pv.c   |  5 ++--
>  arch/x86/xen/time.c         | 14 +++-------
>  arch/x86/xen/xen-ops.h      |  6 ++---
>  5 files changed, 35 insertions(+), 47 deletions(-)
>
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 8d4e2e1ae60b..615ad0f16848 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -119,6 +119,27 @@ static void __init xen_banner(void)
>  	       version >> 16, version & 0xffff, extra.extraversion,
>  	       xen_feature(XENFEAT_mmu_pt_update_preserve_ad) ? " (preserve-AD)" : "");
>  }
> +
> +static void __init xen_pv_init_platform(void)
> +{
> +	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
> +	HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
> +
> +	/* xen clock uses per-cpu vcpu_info, need to init it for boot cpu */
> +	xen_vcpu_info_reset(0);


I don't believe this is necessary, it has been done in
xen_start_kernel() for PV guests.


> +
> +	/* pvclock is in shared info area */
> +	xen_init_time_ops();
> +}
> +



>  }
>  
> -void __ref xen_init_time_ops(void)
> +void __init xen_init_time_ops(void)
>  {
>  	pv_time_ops = xen_time_ops;
>  
> @@ -542,17 +542,11 @@ void __init xen_hvm_init_time_ops(void)
>  		return;
>  
>  	if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
> -		printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
> -				"disable pv timer\n");
> +		pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
>  		return;
>  	}
> -
> -	pv_time_ops = xen_time_ops;
> +	xen_init_time_ops();


As we discussed elsewhere, now that HVM guests call this routine as well
we need to make sure that x86_init.timers.timer_init is not updated
there for HVM since those guests expect a "real" timer to be connected
to IO-APIC.

-boris

>  	x86_init.timers.setup_percpu_clockev = xen_time_init;
>  	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
> -
> -	x86_platform.calibrate_tsc = xen_tsc_khz;
> -	x86_platform.get_wallclock = xen_get_wallclock;
> -	x86_platform.set_wallclock = xen_set_wallclock;
>  }
>  #endif
>
