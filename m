Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-8-pasha.tatashin@oracle.com> <93178b98-8464-ae36-3536-0baa639b3467@oracle.com>
In-Reply-To: <93178b98-8464-ae36-3536-0baa639b3467@oracle.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 17 Jul 2018 21:59:15 -0400
Message-ID: <CAGM2rea50hAAa2L2_zPYgY6-08eTMWVRjoP_KAZpRg21TEd11Q@mail.gmail.com>
Subject: Re: [PATCH v13 07/18] x86/xen/time: output xen sched_clock time from 0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: boris.ostrovsky@oracle.com
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

> > +static u64 xen_sched_clock(void)
> > +{
> > +     return xen_clocksource_read() - xen_sched_clock_offset;
> > +}
>
>
> Should other invocations of xen_clocksource_read() also be offset?
>

I do not believe so. Look in arch/x86/kernel/kvmclock.c
kvm_clock_get_cycles() is not normalized for instance. We need to
normalize kvm_sched_clock_read() and xen_sched_clock(), because it is
used by printk() as a sched_clock() prefix. So not to be confusing we
print time starting from 0, but the other instances where
xen_clocksource_read()  is used do not need that.

Thank you,
Pavel
