Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 28 Jun 2018 12:43:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 28 Jun 2018, Thomas Gleixner wrote:
> I still want to document the unholy mess of what is initialized and
> available when. We have 5 hypervisors and 3 different points in early boot
> where the calibrate_* callbacks are overwritten. The XEN PV one is actually
> post tsc_init_early() for whatever reason.
> 
> That's all completely obscure and any attempt of moving tsc_early_init()
> earlier than where it is now is just lottery.
> 
> The other issue is that double calibration, e.g. doing the PIT thing twice
> is just consuming boot time for no value.
> 
> All of that has been duct taped over time and we really don't want yet
> another thing glued to it just because we can.

So here is the full picture of the TSC/CPU calibration maze:

Compile time setup:
	native_calibrate_tsc
		CPUID based frequency read out with magic fixups
		for broken CPUID implementations

	native_calibrate_cpu
		Try the following:

		1) CPUID based (different leaf than the TSC one)
		2) MSR based
		3) Quick PIT calibration
		4) PIT/HPET/PMTIMER calibration (slow) and only
		   available in tsc_init(). Could be made working
		   post x86_dtb_init().


Boot sequence:

  start_kernel()

	INTEL_MID:
		x86_intel_mid_early_setup()
	   	calibrate_tsc = intel_mid_calibrate_tsc

	   	intel_mid_calibrate_tsc() { return 0; }

  setup_arch()

	x86_init.oem.arch_setup();
	  INTEL_MID:
		intel_mid_arch_setup()

		PENWELL:
		   x86_platform.calibrate_tsc = mfld_calibrate_tsc;

		   MSR based magic. Value would be available right away.
		   
		TANGIER:
		   x86_platform.calibrate_tsc = tangier_calibrate_tsc;
	
		   Different MSR based magic. Value would be available
		   right away.
		
	....
	
	init_hypervisor_platform()
	   vmware:
	           Retrieves frequency and store it for the
		   calibration function

		   khz = vmware_get_khz_magic()
		   vmware_tsc_khz = khz
		   calibrate_cpu = vmware_get_tsc_khz
	   	   calibrate_tsc = vmware_get_tsc_khz
		   preset_lpj(khz)

 	   hyperv:
		   if special hyperv MSRs are available:

		      calibrate_cpu = hv_get_tsc_khz
		      calibrate_tsc = hv_get_tsc_khz

		   MSR is readable already in this function

	   jailhouse:
	   
		   Frequency is available in this function and store
		   in a variable for the calibration function

		   calibrate_cpu	= jailhouse_get_tsc
		   calibrate_tsc	= jailhouse_get_tsc

	...
	
	kvmclock_init()

		if (magic_conditions)
			calibrate_tsc = kvm_get_tsc_khz
			calibrate_cpu = kvm_get_tsc_khz

			kvm_get_preset_lpj()
			   khz = kvm_get_tsc_khz()
			   preset_lpj(khz);

	tsc_early_delay_calibrate()
	    tsc_khz = calibrate_tsc()
	    cpu_khz = calibrate_cpu()

	    ....
	    set_lpj(tsc_khz);


	x86_init.paging.pagetable_init()    
	   xen_pagetable_init()
	      xen_setup_shared_info()
	         xen_hvm_init_time_ops()
	            if (XENFEAT_hvm_safe_pvclock)
	                calibrate_tsc = xen_tsc_khz

	         	PV clock based access

	tsc_init()
	    tsc_khz = calibrate_tsc()
	    cpu_khz = calibrate_cpu()


Putting this into a table:

Platform	tsc_early_delay_calibrate()	tsc_init()
-----------------------------------------------------------------------

Generic		native_calibrate_tsc()		native_calibrate_tsc()
		native_calibrate_cpu()		native_calibrate_cpu()
		(Cannot do HPET/PMTIMER)

-----------------------------------------------------------------------

INTEL_MID	intel_mid_calibrate_tsc()	intel_mid_calibrate_tsc()
Generic		native_calibrate_cpu()		native_calibrate_cpu()

INTEL_MID	mfld_calibrate_tsc()		mfld_calibrate_tsc()
PENWELL		native_calibrate_cpu()		native_calibrate_cpu()

INTEL_MID	tangier_calibrate_tsc()		tangier_calibrate_tsc()
TANGIER		native_calibrate_cpu()		native_calibrate_cpu()

-----------------------------------------------------------------------

VNWARE		vmware_get_tsc_khz()		vmware_get_tsc_khz()
		vmware_get_tsc_khz()		vmware_get_tsc_khz()

HYPERV		hv_get_tsc_khz()		hv_get_tsc_khz()
		hv_get_tsc_khz()		hv_get_tsc_khz()


JAILHOUSE	jailhouse_get_tsc()		jailhouse_get_tsc()
		jailhouse_get_tsc()		jailhouse_get_tsc()


KVM		kvm_get_tsc_khz()		kvm_get_tsc_khz()
		kvm_get_tsc_khz()		kvm_get_tsc_khz()

------------------------------------------------------------------------

XEN		native_calibrate_tsc()		xen_tsc_khz()
		native_calibrate_cpu()		native_calibrate_cpu()

------------------------------------------------------------------------

The only platform which cannot use the special TSC calibration routine
in the early calibration is XEN because it's initialized just _after_ the
early calibration runs.

For enhanced fun the early calibration stuff was moved from right after
init_hypervisor_platform() to the place where it is now in commit
ccb64941f375a6 ("x86/timers: Move simple_udelay_calibration() past
kvmclock_init()") to speed up KVM boot time by avoiding the PIT
calibration. I have no idea why it wasn't just moved past the XEN
initialization a few lines further down, especially as the change was done
by a XEN maintainer :) Boris?

The other HV guests all do more or less the same thing and return the same
value for cpu_khz and tsc_khz via the calibration indirection despite the
value being known in the init_platform() function already.

The generic initilizaiton does everything twice, which makes no sense,
except for the unlikely case were no fast functions are available and the
quick PIT calibration fails (PMTIMER/HPET) are not available in early
calibration. HPET 

The INTEL MID stuff is wierd and not really obvious. AFAIR those systems
don't have PIT or such, so they need to rely on the MSR/CPUID mechanisms to
work, but that's just working because and not for obvious reasons. Andy,
can you shed some light on that stuff?

So some of this just works by chance, things are done twice and pointlessly
(XEN). This really wants to be cleaned up and well documented which the
requirements of each platform are, especially the Intel-MID stuff needs
that.

Thanks,

	tglx
