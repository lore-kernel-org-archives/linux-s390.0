Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Apr 2016 14:11:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PREEMPT-RT] [PATCH] s390/cpum_sf: Remove superfluous SMP
 function call
Message-ID: <20160405121155.GF6890@osiris>
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris>
 <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris>
 <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de>
 <5703A836.7030708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5703A836.7030708@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Cc: rcochran@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 05, 2016 at 01:57:42PM +0200, Sebastian Andrzej Siewior wrote:
> On 04/05/2016 01:51 PM, rcochran@linutronix.de wrote:
> > On Tue, Apr 05, 2016 at 01:36:38PM +0200, Heiko Carstens wrote:
> >> On Tue, Apr 05, 2016 at 01:23:36PM +0200, Heiko Carstens wrote:
> >>> Subsequently, in this case, the setup_pmc_cpu() call will be executed on
> >>> the wrong cpu.
> >>
> >> .. or to illustrate this behaviour: the following patch (white space
> >> damaged due to copy-paste) results in the following:
> > 
> > I guess you are missing the following commit?
> …
> >     cpu/hotplug: Move online calls to hotplugged cpu
> 
> No, Heiko is right here. If one of the "CPU_DOWN_PREPARE" fails then
> the following CPU_DOWN_FAILED will be invoked on the correct CPU.
> 
> However if we are further down the road and the final ARCH specific
> "die" failed (just before CPU_DYING) are invoked then we get this done
> on the wrong CPU.

I think there is more broken: if I willingly let __cpu_disable() fail and
try to offline e.g. cpu 2 for the second time chcpu will never return.
Plus the console contains several "NOHZ: local_softirq_pending 01"
messages.

# cat /proc/1619/stack 
[<000000000013e460>] cpuhp_kick_ap_work+0x78/0x1b8
[<00000000008a1972>] _cpu_down+0xca/0x1c0
[<000000000013f362>] do_cpu_down+0x5a/0x88
[<0000000000682308>] device_offline+0xb8/0xe0
[<000000000068244e>] online_store+0x5e/0x98
[<000000000037ecea>] kernfs_fop_write+0x13a/0x190
[<00000000002ee26e>] __vfs_write+0x36/0x108
[<00000000002ef3e4>] vfs_write+0x94/0x1a0
[<00000000002f0ace>] SyS_write+0x66/0xd8
[<00000000008aa944>] system_call+0x244/0x264
[<ffffffffffffffff>] 0xffffffffffffffff

(1619 is the pid of chcpu)

All of this works without problems on vanilla 4.5 kernel.

I think you can reproduce this on any architecture :)
