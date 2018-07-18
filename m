Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-7-pasha.tatashin@oracle.com> <cf7ef6d0-8650-3e8a-0e15-5150b58d1b50@oracle.com>
In-Reply-To: <cf7ef6d0-8650-3e8a-0e15-5150b58d1b50@oracle.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 17 Jul 2018 21:38:02 -0400
Message-ID: <CAGM2reZTfuMhKZLApidBcenbeJTYt6n_56htaK5YkDPseb_Bqw@mail.gmail.com>
Subject: Re: [PATCH v13 06/18] x86/xen/time: initialize pv xen time in init_hypervisor_platform
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: boris.ostrovsky@oracle.com
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

> > +     set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
> > +     HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
> > +
> > +     /* xen clock uses per-cpu vcpu_info, need to init it for boot cpu */
> > +     xen_vcpu_info_reset(0);
>
>
> I don't believe this is necessary, it has been done in
> xen_start_kernel() for PV guests.

We need it, because HYPERVISOR_shared_info has changed from dummy.
And, to output timestamps we must have access to the actual shared
page.

> > +
> > +     /* pvclock is in shared info area */
> > +     xen_init_time_ops();
> > +}
> > +
>
>
>
> >  }
> >
> > -void __ref xen_init_time_ops(void)
> > +void __init xen_init_time_ops(void)
> >  {
> >       pv_time_ops = xen_time_ops;
> >
> > @@ -542,17 +542,11 @@ void __init xen_hvm_init_time_ops(void)
> >               return;
> >
> >       if (!xen_feature(XENFEAT_hvm_safe_pvclock)) {
> > -             printk(KERN_INFO "Xen doesn't support pvclock on HVM,"
> > -                             "disable pv timer\n");
> > +             pr_info("Xen doesn't support pvclock on HVM, disable pv timer");
> >               return;
> >       }
> > -
> > -     pv_time_ops = xen_time_ops;
> > +     xen_init_time_ops();
>
>
> As we discussed elsewhere, now that HVM guests call this routine as well
> we need to make sure that x86_init.timers.timer_init is not updated
> there for HVM since those guests expect a "real" timer to be connected
> to IO-APIC.

Yes, I decided to keep xen_init_time_ops() and xen_hvm_init_time_ops()
separate. The unification does not save that many LOC, but increase
the complexity.

Thank you,
Pavel
