Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 29 Jun 2018 09:30:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
 <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de> <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, andriy.shevchenko@linux.intel.com, boris.ostrovsky@oracle.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 28 Jun 2018, Pavel Tatashin wrote:
> On Thu, Jun 28, 2018 at 11:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> Hi Thomas,
> 
> In addition to above, we have xen hvm:
> 
> setup_arch()
>     ...
>     init_hypervisor_platform();
>         x86_init.hyper.init_platform();
>             xen_hvm_guest_init()
>                 xen_hvm_init_time_ops();

Duh. Missed that completely.

>     ...
>     tsc_early_delay_calibrate();
>         tsc_khz = x86_platform.calibrate_tsc(); == xen_tsc_khz()
>     ...
> 
> Which works early.
> 
> So, what should we do with xen, which seems to be the only platform
> that would provide different tsc frequency early and late, because of
> different calibration method?

Fix it? I have no idea why XEN has two variants of the scheme and I neither
have a clue why the KVM clock stuff is late.

Thanks,

	tglx
