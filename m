Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55AD065B.1050103@roeck-us.net>
Date: Mon, 20 Jul 2015 07:31:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
Subject: Re: sched, s390: Fix the fallout of increasing the offset of 'thread_struct'
 within 'task_struct'
References: <20150718232717.GA3235@groeck-UX31A> <20150720073417.GA10134@gmail.com>
In-Reply-To: <20150720073417.GA10134@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dave Hansen <dave@sr71.net>
List-ID: <linux-s390.vger.kernel.org>

On 07/20/2015 12:34 AM, Ingo Molnar wrote:
>
> * Guenter <linux@roeck-us.net> wrote:
>
>> Hi,
>>
>> Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
>> causes s390 builds in mainline to fail as follows.
>>
>> arch/s390/kernel/traps.c: Assembler messages:
>> arch/s390/kernel/traps.c:262: Error: operand out of range
>> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
>> arch/s390/kernel/traps.c:300: Error: operand out of range
>> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
>
>
> Yeah, so I'm really out on a limb here as I know next to nothing about s390
> assembly, but the build failure appears to be analogous to the arm64 one: the
> offset of thread_struct fields within task_struct increased due to commit
> 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'"), which
> increased assembly offsets beyond the limit this instruction can apparently
> encode.
>
> Does the (untested!) patch below help?
>
> It's an equivalent transformation on the C side, but it might cause GCC to
> generate different assembly code, because we now have a temporary variable with
> much smaller offsets.
>
> The code is also a tiny bit cleaner this way, as the 'current->thread.fp_regs'
> pattern isn't repeated twice.
>
> In case this works:
>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
> Thanks,
>
> 	Ingo
>
> ================>
>
>   arch/s390/kernel/traps.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 4d96c9f53455..db6f0eec55b5 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -251,6 +251,7 @@ int alloc_vector_registers(struct task_struct *tsk)
>
>   void vector_exception(struct pt_regs *regs)
>   {
> +	s390_fp_regs *fp_regs = &current->thread.fp_regs;
>   	int si_code, vic;
>
>   	if (!MACHINE_HAS_VX) {
> @@ -259,8 +260,9 @@ void vector_exception(struct pt_regs *regs)
>   	}
>
>   	/* get vector interrupt code from fpc */
> -	asm volatile("stfpc %0" : "=m" (current->thread.fp_regs.fpc));
> -	vic = (current->thread.fp_regs.fpc & 0xf00) >> 8;
> +	asm volatile("stfpc %0" : "=m" (fp_regs->fpc));
> +	vic = (fp_regs->fpc & 0xf00) >> 8;
> +

No idea why, but this still fails with the same error (I suspect the compiler
tries to optimize the fp_regs variable away). I can compile the code by using
a local variable '__u32 fpc', but obviously I don't know if that is correct.
I don't have a working qemu configuration for s390, so I can not run any tests.

Guenter
