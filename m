Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 18 Jul 2015 16:34:55 -0700
From: Guenter <linux@roeck-us.net>
Subject: Re: Build error due to "x86/fpu, sched: Dynamically allocate 'struct
 fpu'"
Message-ID: <20150718233455.GA3273@groeck-UX31A>
References: <20150718232717.GA3235@groeck-UX31A>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150718232717.GA3235@groeck-UX31A>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Jul 18, 2015 at 04:27:17PM -0700, Guenter wrote:
> Hi,
> 
> Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
> causes s390 builds in mainline to fail as follows.
> 
> arch/s390/kernel/traps.c: Assembler messages:
> arch/s390/kernel/traps.c:262: Error: operand out of range
> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> arch/s390/kernel/traps.c:300: Error: operand out of range
> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> 

Also:

arm64:allmodconfig:

arch/arm64/kernel/entry.S: Assembler messages:
arch/arm64/kernel/entry.S:588: Error: immediate out of range
arch/arm64/kernel/entry.S:597: Error: immediate out of range
make[1]: *** [arch/arm64/kernel/entry.o] Error 1

I didn't bisect that one, but it looks like the cause is the same.

Guenter
