Return-Path: <linux-kernel-owner+w=401wt.eu-S1753585AbZCIPwA@vger.kernel.org>
Subject: Re: [BUG,2.6.29-rc7,s390] System goes into endless loop during
 boot or logon
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <200903091643.13803.elendil@planet.nl>
References: <200903080835.14032.elendil@planet.nl>
	 <200903090253.34173.elendil@planet.nl> <1236587118.8389.20.camel@laptop>
	 <200903091643.13803.elendil@planet.nl>
Content-Type: text/plain
Date: Mon, 09 Mar 2009 16:51:42 +0100
Message-Id: <1236613902.8389.675.camel@laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2009-03-09 at 16:43 +0100, Frans Pop wrote:
> On Monday 09 March 2009, Peter Zijlstra wrote:
> > On Mon, 2009-03-09 at 02:53 +0100, Frans Pop wrote:
> > > Follow-up to an issue reported on the linux-s390 list, seen in the
> > > Hercules S/390 emulator.
> > >
> > > On Sunday 08 March 2009, Frans Pop wrote:
> > > > Well, not quite. It does boot successfully and I do get a login
> > > > prompt. I can also login on the console or connect with SSH, but in
> > > > both cases the system again gets into some loop before I actually
> > > > get a shell prompt.
> > >
> > > During the bisection series the system would sometimes enter the loop
> > > during the boot procedure, before I tried to logon. After it enters
> > > the loop one processor just goes racing at 100%.
> >
> > Where? Do you have NMI watchdog output, or even sysrq-t?
> 
> Hmmm. Your commit log message for ca109491f612aab5c8152207631c0444f63da97f 
> does explicitly mention the risk of an infinite loop, as does a comment 
> in hrtimer_enqueue_reprogram().
> 
> Any chance the cause is there? Any way to test for that?

a6037b61c2f5fc99c57c15b26d7cfa58bbb34008 should have fixed the mentioned
issue (along with the deadlock mentioned in the changelog).

The issue was that you could enqueue an expired timer, run it in place,
enqueue it again, etc..

The current code would not run it in place, but instead fire a softirq
to handle it. That opens up a preemption window.

Note, this can only happen with HRTIMER_RESTART timers, and those should
be careful to avoid hogging the CPU anyway.

Doesn't this s390 thing have a sysrq key you can press to get some
traces out?
