Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 29 Jun 2018 04:57:52 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Message-ID: <20180629085752.zkbxlwc2rzlm63lk@xakep.localdomain>
References: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
 <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
 <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
 <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, andriy.shevchenko@linux.intel.com, boris.ostrovsky@oracle.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 18-06-29 09:30:10, Thomas Gleixner wrote:
> On Thu, 28 Jun 2018, Pavel Tatashin wrote:
> > On Thu, Jun 28, 2018 at 11:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Hi Thomas,
> > 
> > In addition to above, we have xen hvm:
> > 
> > setup_arch()
> >     ...
> >     init_hypervisor_platform();
> >         x86_init.hyper.init_platform();
> >             xen_hvm_guest_init()
> >                 xen_hvm_init_time_ops();
> 
> Duh. Missed that completely.
> 
> >     ...
> >     tsc_early_delay_calibrate();
> >         tsc_khz = x86_platform.calibrate_tsc(); == xen_tsc_khz()
> >     ...
> > 
> > Which works early.
> > 
> > So, what should we do with xen, which seems to be the only platform
> > that would provide different tsc frequency early and late, because of
> > different calibration method?
> 
> Fix it? I have no idea why XEN has two variants of the scheme and I neither
> have a clue why the KVM clock stuff is late.

kvm clock  I have fixed in my series.
http://lkml.kernel.org/r/20180621212518.19914-5-pasha.tatashin@oracle.com

It was late because, it depended on memblock, which is initialized later,
after e820 ranges are read.

So, after my series kvm clock will work right after
init_hypervisor_platform, the same as with most other hypervisors.

With xen, it is a little more challenging: I do not have a hardware
configured to run xen to test it.

On the other hand, most likely that tsc_early_delay_calibrate() now
fails to calibrate tsc on xen, and calibrates correctly later in
tsc_init().  I doubt, that we can use CPUID method to determine tsc
frequency on xen cpu. Anyways, that would be accidental behavior.

To make xen clock available early, we need HYPERVISOR_shared_info. So, at
least that part of xen_setup_shared_info() must be called/available from
init_hypervisor_platform():

void xen_setup_shared_info(void)
{
	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);

	HYPERVISOR_shared_info =
		(struct shared_info *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);

	xen_setup_mfn_list_list();
	...

Which, I have no idea if it is possible, or safe to do.

For now, in my series, I would like check in tsc_early_init() if we are
running xen, and set tsc_khz to 0 if so. Later in tsc_init() we will get
a proper calibration. The question is how to make this check least
intrusive.

Pavel
