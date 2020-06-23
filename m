Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbgFWUIi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 16:08:38 -0400
Date: Tue, 23 Jun 2020 22:08:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623200800.GD2483@worktop.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
 <CANpmjNMmYYa-mVo_Ao_n+9KzwxhGYcb6B6C72yCHyD9sZudDfA@mail.gmail.com>
 <20200623191335.GA86296@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623191335.GA86296@elver.google.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, bigeasy@linutronix.de, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk, Qian Cai <cai@lca.pw>

On Tue, Jun 23, 2020 at 09:13:35PM +0200, Marco Elver wrote:
> [   10.182354] ------------[ cut here ]------------
> [   10.183058] WARNING: CPU: 7 PID: 136 at kernel/locking/lockdep.c:398 lockdep_hardirqs_on_prepare+0x1c6/0x270
> [   10.184347] Modules linked in:
> [   10.184771] CPU: 7 PID: 136 Comm: systemd-journal Not tainted 5.8.0-rc1+ #3
> [   10.185706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> [   10.186821] RIP: 0010:lockdep_hardirqs_on_prepare+0x1c6/0x270
> [   10.187594] Code: 75 28 65 48 8b 04 25 28 00 00 00 48 3b 44 24 08 0f 85 b9 00 00 00 48 83 c4 10 5b 41 5e 41 5f c3 65 48 ff 05 d4 24 4e 75 eb d8 <0f> 0b 90 41 c7 86 c4 08 00 00 00 00 00 00 eb c8 e8 65 09 71 01 85
> [   10.190203] RSP: 0018:ffffa7ee802b7848 EFLAGS: 00010017
> [   10.190989] RAX: 0000000000000001 RBX: ffff955e92a34ab0 RCX: 0000000000000001
> [   10.192053] RDX: 0000000000000006 RSI: ffff955e92a34a88 RDI: ffff955e92a341c0
> [   10.193117] RBP: ffffa7ee802b7be8 R08: 0000000000000000 R09: 0000ffffffffffff
> [   10.194186] R10: 0000ffffffffffff R11: 0000ffff8d07e268 R12: 0000000000000001
> [   10.195249] R13: ffffffff8e41bb10 R14: ffff955e92a341c0 R15: 0000000000000001
> [   10.196312] FS:  00007fd6862aa8c0(0000) GS:ffff955e9fd80000(0000) knlGS:0000000000000000
> [   10.197513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.198373] CR2: 00007fd6837dd000 CR3: 0000000812acc001 CR4: 0000000000760ee0
> [   10.199436] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   10.200494] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   10.201554] PKRU: 55555554
> [   10.201967] Call Trace:
> [   10.202348]  ? _raw_spin_unlock_irqrestore+0x40/0x70
> [   10.203093]  trace_hardirqs_on+0x56/0x60			<----- enter IRQ flags tracing code?
> [   10.203686]  _raw_spin_unlock_irqrestore+0x40/0x70  		<----- take report_lock
> [   10.204406]  prepare_report+0x11f/0x150
> [   10.204986]  kcsan_report+0xca/0x6c0 			<----- generating a KCSAN report

Oh, duh.. that's because lockdep_off() ;-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ab7571c1a1f5..c9ea05edce25 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -395,7 +395,7 @@ void lockdep_init_task(struct task_struct *task)
 
 static __always_inline void lockdep_recursion_finish(void)
 {
-	if (WARN_ON_ONCE(--current->lockdep_recursion))
+	if (WARN_ON_ONCE((--current->lockdep_recursion) & LOCKDEP_RECURSION_MASK))
 		current->lockdep_recursion = 0;
 }
 
