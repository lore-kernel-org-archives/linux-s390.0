Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55ACFD1C.8090907@roeck-us.net>
Date: Mon, 20 Jul 2015 06:52:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
Subject: Re: [PATCH] sched, arm64: Fix the fallout of increasing the offset
 of 'thread_struct' within 'task_struct'
References: <20150718232717.GA3235@groeck-UX31A> <20150718233455.GA3273@groeck-UX31A> <20150720072043.GA7696@gmail.com>
In-Reply-To: <20150720072043.GA7696@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Olof Johansson <olof@lixom.net>
List-ID: <linux-s390.vger.kernel.org>

On 07/20/2015 12:20 AM, Ingo Molnar wrote:
>
> * Guenter <linux@roeck-us.net> wrote:
>
>> On Sat, Jul 18, 2015 at 04:27:17PM -0700, Guenter wrote:
>>> Hi,
>>>
>>> Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'=
")
>>> causes s390 builds in mainline to fail as follows.
>>>
>>> arch/s390/kernel/traps.c: Assembler messages:
>>> arch/s390/kernel/traps.c:262: Error: operand out of range
>>> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000=
000fff)
>>> arch/s390/kernel/traps.c:300: Error: operand out of range
>>> 	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000=
000fff)
>>>
>>
>> Also:
>>
>> arm64:allmodconfig:
>>
>> arch/arm64/kernel/entry.S: Assembler messages:
>> arch/arm64/kernel/entry.S:588: Error: immediate out of range
>> arch/arm64/kernel/entry.S:597: Error: immediate out of range
>> make[1]: *** [arch/arm64/kernel/entry.o] Error 1
>>
>> I didn't bisect that one, but it looks like the cause is the same.
>
> Hm, it looks like the new, increased offset of 'thread_struct' within
> 'task_struct' goes over a limit that these instructions are able to suppo=
rt on
> arm64:
>
>   arch/arm64/kernel/asm-offsets.c:  DEFINE(THREAD_CPU_CONTEXT,    offseto=
f(struct task_struct, thread.cpu_context));
>   arch/arm64/kernel/entry.S:      add     x8, x0, #THREAD_CPU_CONTEXT
>   arch/arm64/kernel/entry.S:      add     x8, x1, #THREAD_CPU_CONTEXT
>
> If there's no instruction that can support such offset sizes then I suspe=
ct the
> straightforward fix would be to pass in thread_struct instead - like the =
patch
> below. That's a tiny bit cleaner for type encapsulation anyway.
>

Olof submitted a different patch to solve the problem:
	http://www.spinics.net/lists/kernel/msg2036825.html

His patch is passing cpu_context instead of thread_context.

> Warning: it's not even build tested, but in case it works:
>
>    Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
> Thanks,
>
> 	Ingo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   arch/arm64/include/asm/processor.h | 4 ++--
>   arch/arm64/kernel/asm-offsets.c    | 2 +-
>   arch/arm64/kernel/process.c        | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/=
processor.h
> index e4c893e54f01..890f84bb3b8c 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -152,8 +152,8 @@ static inline void cpu_relax(void)
>   #define cpu_relax_lowlatency()                cpu_relax()
>
>   /* Thread switching */
> -extern struct task_struct *cpu_switch_to(struct task_struct *prev,
> -					 struct task_struct *next);
> +extern struct task_struct *cpu_switch_to(struct thread_struct *prev,
> +					 struct thread_struct *next);
>
>   #define task_pt_regs(p) \
>   	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offs=
ets.c
> index c99701a34d7b..3785373c2369 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -39,7 +39,7 @@ int main(void)
>     DEFINE(TI_TASK,		offsetof(struct thread_info, task));
>     DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
>     BLANK();
> -  DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct task_struct, thread.cpu_con=
text));
> +  DEFINE(THREAD_CPU_CONTEXT,	offsetof(struct thread_struct, cpu_context)=
);
>     BLANK();
>     DEFINE(S_X0,			offsetof(struct pt_regs, regs[0]));
>     DEFINE(S_X1,			offsetof(struct pt_regs, regs[1]));
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 223b093c9440..436e95bda1b2 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -325,7 +325,7 @@ struct task_struct *__switch_to(struct task_struct *p=
rev,
>   	dsb(ish);
>
>   	/* the actual thread switch */
> -	last =3D cpu_switch_to(prev, next);
> +	last =3D cpu_switch_to(&prev.thread, &next.thread);

Doesn't compile.

arch/arm64/kernel/process.c: In function =91__switch_to=92:
arch/arm64/kernel/process.c:328:28: error: request for member =91thread=92 =
in something not a structure or union
   last =3D cpu_switch_to(&prev.thread, &next.thread);
                             ^
arch/arm64/kernel/process.c:328:42: error: request for member =91thread=92 =
in something not a structure or union
   last =3D cpu_switch_to(&prev.thread, &next.thread);

It would have to be
	last =3D cpu_switch_to(&prev->thread, &next->thread);

which does compile, but fails to run in qemu.

Guenter
