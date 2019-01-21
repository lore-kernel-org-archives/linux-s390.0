Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 21 Jan 2019 13:21:31 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
MIME-Version: 1.0
In-Reply-To: <20181129112321.GB3449@osiris>
Message-Id: <20190121122131.GG4020@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Thomas,

[full quote below]

Did you have any time to look into this yet? :)

The warning is still reproducible.

On Thu, Nov 29, 2018 at 12:23:21PM +0100, Heiko Carstens wrote:
> On Wed, Nov 28, 2018 at 03:32:45PM +0100, Thomas Gleixner wrote:
> > Heiko,
> > 
> > On Tue, 27 Nov 2018, Heiko Carstens wrote:
> > 
> > > with the glibc self-tests I was able to trigger the "this should not
> > > happen" warning ;) below on s390 (with panic_on_warn=1 set). It looks
> > > like it is hardly reproducible.
> > 
> > Any idea which self-test triggered that?
> > 
> > > This one happened with commit d146194f31c9 for compiling the kernel.
> > > Config can be re-created with "make ARCH=s390 performance_defconfig".
> > 
> > Which is not really helpful for people who do not own a s390. And no, I
> > don't want one unless IBM pays the power bill as well :)
> > 
> > > [  649.596938] WARNING: CPU: 0 PID: 58886 at kernel/futex.c:1418 do_futex+0xa9a/0xc50
> > > [  649.596946] Kernel panic - not syncing: panic_on_warn set ...
> > > [  649.596951] CPU: 0 PID: 58886 Comm: ld64.so.1 Not tainted 4.20.0-20181125.rc3.git0.d146194f31c9.300.fc29.s390x+git #1
> > 
> > That's ld64.so.1. Weird, but what do I know about glibc self tests.
> > 
> > I still fail to see how that can happen, but I usually page out the futex
> > horrors immediately. I'll keep staring at the code...
> 
> I looked into the system dumps, and if I didn't screw up, then the
> command line for both occurrences was
> 
> /root/glibc-build/nptl/tst-robustpi8
> 
> And indeed, if I run only this test case in an endless loop and do
> some parallel work (like kernel compile) it currently seems to be
> possible to reproduce the warning:
> 
> while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done
> 
> within the build directory of glibc (2.28).
> 
> See
> https://sourceware.org/git/?p=glibc.git;a=blob;f=nptl/tst-robustpi8.c;h=cbea3d6d77abb00be05ec7b466d8339c26dd2efb;hb=3c03baca37fdcb52c3881e653ca392bba7a99c2b
> 
> which includes this one:
> 
> https://sourceware.org/git/?p=glibc.git;a=blob;f=nptl/tst-robust8.c;h=9c636250d4cb0bcd6d802910e8f9ea31568bb73f;hb=3c03baca37fdcb52c3881e653ca392bba7a99c2b
> 
