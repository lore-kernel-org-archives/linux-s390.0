Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 28 Nov 2018 15:32:45 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20181127081115.GB3625@osiris>
Message-ID: <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Heiko,

On Tue, 27 Nov 2018, Heiko Carstens wrote:

> with the glibc self-tests I was able to trigger the "this should not
> happen" warning ;) below on s390 (with panic_on_warn=1 set). It looks
> like it is hardly reproducible.

Any idea which self-test triggered that?

> This one happened with commit d146194f31c9 for compiling the kernel.
> Config can be re-created with "make ARCH=s390 performance_defconfig".

Which is not really helpful for people who do not own a s390. And no, I
don't want one unless IBM pays the power bill as well :)

> [  649.596938] WARNING: CPU: 0 PID: 58886 at kernel/futex.c:1418 do_futex+0xa9a/0xc50
> [  649.596946] Kernel panic - not syncing: panic_on_warn set ...
> [  649.596951] CPU: 0 PID: 58886 Comm: ld64.so.1 Not tainted 4.20.0-20181125.rc3.git0.d146194f31c9.300.fc29.s390x+git #1

That's ld64.so.1. Weird, but what do I know about glibc self tests.

I still fail to see how that can happen, but I usually page out the futex
horrors immediately. I'll keep staring at the code...

Thanks,

	tglx
