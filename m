Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <20200529213550.683440625@infradead.org>
Date: Fri, 29 May 2020 23:35:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 0/5] lockdep: Change IRQ state tracking to use per-cpu variables
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org

Ahmed and Sebastian wanted additional lockdep_assert*() macros and ran
into header hell.

Move the IRQ state into per-cpu variables, which removes the dependency on
task_struct, which is what generated the header-hell.

These patches are intended to go on top of:

 https://lkml.kernel.org/r/20200529212728.795169701@infradead.org

but should apply on current tip/master without much difficulty.

There are a few build fixes for Sparc64, PowerPC64 and s390. Especially the
Sparc one I'm not sure about.
