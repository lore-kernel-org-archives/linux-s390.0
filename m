Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 23 Jan 2019 10:24:43 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190121122131.GG4020@osiris>
 <alpine.DEB.2.21.1901211411290.1582@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901222212490.1628@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901222212490.1628@nanos.tec.linutronix.de>
Message-Id: <20190123092443.GA3424@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 22, 2019 at 10:14:00PM +0100, Thomas Gleixner wrote:
> On Mon, 21 Jan 2019, Thomas Gleixner wrote:
> > On Mon, 21 Jan 2019, Heiko Carstens wrote:
> > 
> > > Hi Thomas,
> > > 
> > > [full quote below]
> > > 
> > > Did you have any time to look into this yet? :)
> > > 
> > > The warning is still reproducible.
> > 
> > Yeah, it's on my list of stuff which I need to take care of urgently. In
> > the next couple of days I hope...
> 
> Hmm. Doesn't
> 
>      da791a667536 ("futex: Cure exit race")
> 
> address that issue?

It doesn't look like it does. One occurrence was the one below when
using commit 7939f8beecf1 (which is post 5.0-rc2) for building the
kernel:

 WARNING: CPU: 14 PID: 23505 at kernel/futex.c:1483 do_futex+0xa9a/0xc50
 Kernel panic - not syncing: panic_on_warn set ...
 CPU: 14 PID: 23505 Comm: ld.so.1 Not tainted 5.0.0-20190116.rc2.git0.7939f8beecf1.300.fc29.s390x+git #1
 Hardware name: IBM 3906 M04 704 (LPAR)
 Call Trace:
 ([<0000000000112e60>] show_stack+0x58/0x70)
  [<0000000000a671fa>] dump_stack+0x7a/0xa8
  [<0000000000143f52>] panic+0x11a/0x2d0
  [<0000000000143db0>] __warn+0xf8/0x118
  [<0000000000a662f8>] report_bug+0xd8/0x150
  [<00000000001014ac>] do_report_trap+0xc4/0xe0
  [<0000000000101680>] illegal_op+0x138/0x150
  [<0000000000a87270>] pgm_check_handler+0x1c8/0x220
  [<00000000001e9aea>] do_futex+0xa9a/0xc50
 ([<00000000001e9c4e>] do_futex+0xbfe/0xc50)
  [<00000000001ea13c>] compat_sys_futex+0xe4/0x170
  [<0000000000a86e84>] system_call+0xd8/0x2c8
