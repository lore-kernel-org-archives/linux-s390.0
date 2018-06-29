Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
Message-ID: <3ae524498e6833abd5bb225987de97580262c4de.camel@linux.intel.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 29 Jun 2018 17:30:25 +0300
In-Reply-To: <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
         <20180621212518.19914-10-pasha.tatashin@oracle.com>
         <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
         <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
         <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
         <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
         <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2018-06-28 at 12:43 +0200, Thomas Gleixner wrote:
> On Thu, 28 Jun 2018, Thomas Gleixner wrote:
> > I still want to document the unholy mess of what is initialized and
> > available when. We have 5 hypervisors and 3 different points in
> > early boot
> > where the calibrate_* callbacks are overwritten. The XEN PV one is
> > actually
> > post tsc_init_early() for whatever reason.
> > 
> > That's all completely obscure and any attempt of moving
> > tsc_early_init()
> > earlier than where it is now is just lottery.
> > 
> > The other issue is that double calibration, e.g. doing the PIT thing
> > twice
> > is just consuming boot time for no value.
> > 
> > All of that has been duct taped over time and we really don't want
> > yet
> > another thing glued to it just because we can.

Hmm... Good question about Intel MID, I would try to put my
understanding here.

> Boot sequence:
> 
>   start_kernel()
> 
> 	INTEL_MID:
> 		x86_intel_mid_early_setup()
> 	   	calibrate_tsc = intel_mid_calibrate_tsc
> 
> 	   	intel_mid_calibrate_tsc() { return 0; }

This sounds like a stub against very old calibration code since Intel
MID has no PIT, HPET, PMTIMER to calibrate from.

> 
>   setup_arch()
> 
> 	x86_init.oem.arch_setup();
> 	  INTEL_MID:
> 		intel_mid_arch_setup()
> 
> 		PENWELL:
> 		   x86_platform.calibrate_tsc = mfld_calibrate_tsc;
> 
> 		   MSR based magic. Value would be available right away.
> 		   
> 		TANGIER:
> 		   x86_platform.calibrate_tsc = tangier_calibrate_tsc;
> 	
> 		   Different MSR based magic. Value would be available
> 		   right away.		

This stuff is how we can read TSC frequency on those platforms.

The commit 7da7c1561366 ("x86, tsc: Add static (MSR) TSC calibration on
Intel Atom SoCs") introduced a common way for all those chips to get TSC
frequency, while forgetting remove old code.

Surprisingly, the same guy even amended legacy code in the commit
f3a02ecebed7 ("x86/tsc: Set TSC_KNOWN_FREQ and TSC_RELIABLE flags on
Intel Atom SoCs").



> INTEL_MID	intel_mid_calibrate_tsc()	intel_mid_calibrate_
> tsc()
> Generic		native_calibrate_cpu()		native_ca
> librate_cpu()
> 
> INTEL_MID	mfld_calibrate_tsc()		mfld_calibrate_ts
> c()
> PENWELL		native_calibrate_cpu()		native_ca
> librate_cpu()
> 
> INTEL_MID	tangier_calibrate_tsc()		tangier_calibr
> ate_tsc()
> TANGIER		native_calibrate_cpu()		native_ca
> librate_cpu()
> 


Taking above into consideration, I think we may just remove the legacy
code from mfld.c and mrfld.c and see what happen.

If you can tell me points to test, I can prepare patches to remove and
test on both Medfiled and Merrifield platforms (Penwell and Tangier SoCs
respectively).

> The INTEL MID stuff is wierd and not really obvious. AFAIR those
> systems
> don't have PIT or such, so they need to rely on the MSR/CPUID
> mechanisms to
> work, but that's just working because and not for obvious reasons.
> Andy,
> can you shed some light on that stuff?

Hope above makes sense.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
