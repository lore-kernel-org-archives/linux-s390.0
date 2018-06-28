Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 28 Jun 2018 14:27:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <20180628114615.GF2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806281421550.1778@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de> <20180628114615.GF2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 28 Jun 2018, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:43:59PM +0200, Thomas Gleixner wrote:
> > 	init_hypervisor_platform()
> > 	   vmware:
> > 	           Retrieves frequency and store it for the
> > 		   calibration function
> > 
> > 		   khz = vmware_get_khz_magic()
> > 		   vmware_tsc_khz = khz
> > 		   calibrate_cpu = vmware_get_tsc_khz
> > 	   	   calibrate_tsc = vmware_get_tsc_khz
> > 		   preset_lpj(khz)
> > 
> >  	   hyperv:
> > 		   if special hyperv MSRs are available:
> > 
> > 		      calibrate_cpu = hv_get_tsc_khz
> > 		      calibrate_tsc = hv_get_tsc_khz
> > 
> > 		   MSR is readable already in this function
> > 
> > 	   jailhouse:
> > 	   
> > 		   Frequency is available in this function and store
> > 		   in a variable for the calibration function
> > 
> > 		   calibrate_cpu	= jailhouse_get_tsc
> > 		   calibrate_tsc	= jailhouse_get_tsc
> > 
> > 	...
> > 	
> > 	kvmclock_init()
> > 
> > 		if (magic_conditions)
> > 			calibrate_tsc = kvm_get_tsc_khz
> > 			calibrate_cpu = kvm_get_tsc_khz
> > 
> > 			kvm_get_preset_lpj()
> > 			   khz = kvm_get_tsc_khz()
> > 			   preset_lpj(khz);
> 
> Note that all these which get TSC values from a HV _should_ set
> X86_FEATURE_TSC_KNOWN_FREQ to avoid the late recalibrate.

True.

> Calibrating against a virtual PIT/HPET/PMTIMER is utterly pointless.

It kinda works :)
 
> > The generic initilizaiton does everything twice, which makes no sense,
> > except for the unlikely case were no fast functions are available and the
> > quick PIT calibration fails (PMTIMER/HPET) are not available in early
> > calibration. HPET 
> 
> Incomplete; but I suspect you want to talk about how we can make HPET
> available early by putting it in a fixmap.

As I figured out now that's only part of the picture. We also need to do
that past x86_dtb_init() because early_quirks() and the early acpi/sfi/dtb
stuff needs to be completed before it makes sense to access hpet. But at
that point we also have the PMTIMER info.

> And only if we fail, do we at a later stage try again using PMTIMER.
> 
> Currently it all works by accident, since !hpet and acpi_pm_read_early()
> returns 0, but really we should not be running the fallback crap at all
> that early.

Right.

Thanks,

	tglx
