Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Dec 2020 05:06:57 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
Message-ID: <20201201130657.GA232197@roeck-us.net>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.594122626@infradead.org>
 <20201130210003.GA40619@roeck-us.net>
 <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
 <yt9dh7p54u50.fsf@linux.ibm.com>
 <20201201125246.GV2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125246.GV2414@hirez.programming.kicks-ass.net>
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org, mark.rutland@arm.com, will@kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Dec 01, 2020 at 01:52:46PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 12:56:27PM +0100, Sven Schnelle wrote:
> > Hi Peter,
> > 
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
> > >> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
> > >> > We call arch_cpu_idle() with RCU disabled, but then use
> > >> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> > >> > 
> > >> > Switch all arch_cpu_idle() implementations to use
> > >> > raw_local_irq_{en,dis}able() and carefully manage the
> > >> > lockdep,rcu,tracing state like we do in entry.
> > >> > 
> > >> > (XXX: we really should change arch_cpu_idle() to not return with
> > >> > interrupts enabled)
> > >> > 
> > >> 
> > >> Has this patch been tested on s390 ? Reason for asking is that it causes
> > >> all my s390 emulations to crash. Reverting it fixes the problem.
> > >
> > > My understanding is that it changes the error on s390. Previously it
> > > would complain about the local_irq_enable() in arch_cpu_idle(), now it
> > > complains when taking an interrupt during idle.
> > 
> > I looked into adding the required functionality for s390, but the code
> > we would need to add to entry.S is rather large - as you noted we would
> > have to duplicate large portions of irqentry_enter() into our code.
> > Given that s390 was fine before that patch, can you revert it and submit
> > it again during the next merge window?
> 
> I'm not sure I understand how s390 was fine without it, let me consdier.
> Also, what's the status of ARM64, they do need this too.

For v5.10-rc6:

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 426 pass: 421 fail: 5
Failed tests:
	s390:defconfig:initrd
	s390:defconfig:virtio-blk-ccw:rootfs
	s390:defconfig:scsi[virtio-ccw]:rootfs
	s390:defconfig:virtio-pci:rootfs
	s390:defconfig:scsi[virtio-pci]:rootfs

At least with qemu all other tests/architectures are fine.
You can find the tested architectures at https://kerneltests.org/builders.

Guenter
