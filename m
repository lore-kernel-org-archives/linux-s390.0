Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Jul 2015 16:45:13 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC PATCH] sched, s390: Fix the fallout of increasing the
 offset of 'thread_struct' within 'task_struct'
Message-ID: <20150720144513.GD3607@osiris>
References: <1437403315-31221-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437403315-31221-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:41:55AM -0700, Guenter Roeck wrote:
> Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
> moved the thread_struct to the bottom of task_struct. As a result, the
> offset is now too large to be used in an immediate stfpc operation on s390,
> resulting in the following compile error.
> 
> arch/s390/kernel/traps.c: Assembler messages:
> arch/s390/kernel/traps.c:262: Error: operand out of range
> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> arch/s390/kernel/traps.c:300: Error: operand out of range
> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> 
> Use a local variable to store fpc to solve the problem.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Compile tested only.
> Wonder if storing fpc in current->thread.fp_regs.fpc is necessary.

A proper patch is availabler here:

https://git.kernel.org/cgit/linux/kernel/git/s390/linux.git/commit/?h=for-linus&id=3827ec3d8fd51aef8352b0282b14f0f3ab615930
