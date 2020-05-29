Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 May 2020 16:29:17 -0700 (PDT)
Message-Id: <20200529.162917.1970892823680223252.davem@davemloft.net>
Subject: Re: [RFC][PATCH v3 1/5] sparc64: Fix asm/percpu.h build error
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200529214203.673108357@infradead.org>
References: <20200529213550.683440625@infradead.org>
        <20200529214203.673108357@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: peterz@infradead.org
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 29 May 2020 23:35:51 +0200

> ../arch/sparc/include/asm/percpu_64.h:7:24: warning: call-clobbered register used for global register variable
> register unsigned long __local_per_cpu_offset asm("g5");

The "-ffixed-g5" option on the command line tells gcc that we are
using 'g5' as a fixed register, so some part of your build isn't using
the:

KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare

from arch/sparc/Makefile for some reason.
