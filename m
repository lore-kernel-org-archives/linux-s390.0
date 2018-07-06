Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-5-pasha.tatashin@oracle.com> <fc67276e-643d-8a78-29e3-273c6dc79275@redhat.com>
 <alpine.DEB.2.21.1807061101040.1664@nanos.tec.linutronix.de>
 <52117b6e-cbdc-8583-494b-5e8e5d6d4265@redhat.com> <alpine.DEB.2.21.1807061142320.1664@nanos.tec.linutronix.de>
 <585b3646-5515-240a-db57-406d6c311a43@redhat.com> <alpine.DEB.2.21.1807061243400.1664@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807061248410.1664@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807061248410.1664@nanos.tec.linutronix.de>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 6 Jul 2018 11:03:54 -0400
Message-ID: <CAGM2reZ1fkvzECyy4Eo+O9ZE-ddJvE3hFtPGUAv=QJ9Cv_hJvw@mail.gmail.com>
Subject: Re: [PATCH v12 04/11] kvm/x86: remove kvm memblock dependency
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: tglx@linutronix.de
Cc: pbonzini@redhat.com, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I think using __initdata during init_hypervisor_platform()  +
allocating during x86_init.hyper.guest_late_init() is a good approach.
My only concern, it would mean we need to init/uinit/init clock for
boot cpu. Does it mean the clock continuity is preserved during the
transition? I believe so, but needs to be verified.

Pavel
On Fri, Jul 6, 2018 at 6:53 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 6 Jul 2018, Thomas Gleixner wrote:
> > On Fri, 6 Jul 2018, Paolo Bonzini wrote:
> > > On 06/07/2018 11:45, Thomas Gleixner wrote:
> > > >> One possibility is to introduce another layer of indirection: in
> > > >> addition to the percpu pvclock data, add a percpu pointer to the pvclock
> > > >> data and initialize it to point to a page-aligned variable in BSS.  CPU0
> > > >> (used by vDSO) doesn't touch the pointer and keeps using the BSS
> > > >> variable, APs instead redirect the pointer to the percpu data.
> > > > Yeah, thought about that, but the extra indirection is ugly. Instead of
> > > > using per cpu data, I just can allocate the memory _after_ the allocators
> > > > are up and running and use a single page sized static __initdata for the
> > > > early boot.
> > >
> > > Either works for me.  Assembly-wise, the indirection should be more or
> > > less the same as what we have now; even more efficient because it
> > > accesses a percpu pointer instead of computing it based on
> > > smp_processor_id().
> >
> > Good point. Let me try that.
>
> Duh, that either requires a static key or a static PER_CPU pointer thingy,
> which then wastes 8 bytes per cpu instead of 64 byte if unused.
>
> Thanks,
>
>         tglx
