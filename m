Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 26 Jun 2018 17:42:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Pavel,

first of all, sorry for my last outburst. I just was in a lousy mood after
staring into too much half baken stuff and failed to make myself stay away
from the computer.

On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> And this early init sequence also needs to pull over the tsc adjust
> magic. So tsc_early_delay_calibrate() which should btw. be renamed to
> tsc_early_init() should have:
> 
> {
> 	cpu_khz = x86_platform.calibrate_cpu();
>         tsc_khz = x86_platform.calibrate_tsc();
> 
>         tsc_khz = tsc_khz ? : cpu_khz;
>         if (!tsc_khz)
>                 return;
> 
>         /* Sanitize TSC ADJUST before cyc2ns gets initialized */
>         tsc_store_and_check_tsc_adjust(true);
> 
> 	calc_lpj(tsc_khz);
> 		
> 	tsc_sched_clock_init();
> }

Peter made me look deeper into this and there are a few issues, which I
missed, depending on when some of the resources become available. So we
probably cannot hook all of this into tsc_early_delay_calibrate().

I have an idea how to distangle it and we'll end up in a staged approach,
which looks like this:

    1) Earliest one (not sure how early yet)

       Attempt to use MSR/CPUID. If not running on a hypervisor this can
       try the quick PIT calibration, but nothing else.

    2) Post init_hypervisor_platform()

       An attempt to use the hypervisor data can be made.

    3) Post early_acpi_boot_init()

       This can do PIT/HPET based calibration

    4) Post x86_dtb_init()

       PIT/PMTIMER based calibration

Once tsc_khz is known, no further attempts of calibration are made. I'll
look into that later tonight.

Thanks,

	tglx
