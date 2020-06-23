Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <20200623083645.277342609@infradead.org>
Date: Tue, 23 Jun 2020 10:36:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 0/8] lockdep: Change IRQ state tracking to use per-cpu variables
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

Ahmed and Sebastian wanted additional lockdep_assert*() macros and ran into
header hell. I figured using per-cpu variables would cure that, and also
ran into header hell, still tracktable though.

By moving the IRQ state into per-cpu variables we remove the dependency on
task_struct.

Patches go on top of anything recent I think, an actual git tree with them
in is (for now) here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/irqstate

Which 0day blessed with 0 build fails.
