From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 06/14] x86/ptrace: run seccomp after ptrace
Date: Thu, 9 Jun 2016 19:01:45 -0700
Message-ID: <CAGXu5jKzOzfzMuOqfVCpgyzXrPrKYC60-AOYQmRVQUiqFpB0JQ@mail.gmail.com>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
 <1465506124-21866-7-git-send-email-keescook@chromium.org> <CALCETrVk-UauwaRtZZR0fKQO6kyAx-r=ZCurKRdhQk9nA-TqeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <CALCETrVk-UauwaRtZZR0fKQO6kyAx-r=ZCurKRdhQk9nA-TqeQ@mail.gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-parisc <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 9, 2016 at 3:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Jun 9, 2016 at 2:01 PM, Kees Cook <keescook@chromium.org> wrote:
>> This moves seccomp after ptrace on x86 to that seccomp can catch changes
>> made by ptrace. Emulation should skip the rest of processing too.
>>
>> We can get rid of test_thread_flag because there's no longer any
>> opportunity for seccomp to mess with ptrace state before invoking
>> ptrace.
>>
>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: x86@kernel.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>> ---
>>  arch/x86/entry/common.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> index df56ca394877..81c0e12d831c 100644
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -73,6 +73,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>
>>         struct thread_info *ti = pt_regs_to_thread_info(regs);
>>         unsigned long ret = 0;
>> +       bool emulated = false;
>>         u32 work;
>>
>>         if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>> @@ -80,11 +81,19 @@ static long syscall_trace_enter(struct pt_regs *regs)
>>
>>         work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
>>
>> +       if (unlikely(work & _TIF_SYSCALL_EMU))
>> +               emulated = true;
>> +
>> +       if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
>> +           tracehook_report_syscall_entry(regs))
>> +               return -1L;
>> +
>> +       if (emulated)
>> +               return -1L;
>> +
>
> I think that this code will result in ptrace-induced skips calling the
> audit exit hook but not the audit entry hook.  I don't know whether
> this is a problem.  It's also worth making sure that ptracing a
> seccomp-skipped syscall calls the exit hook with the right regs.
>
> I suspect it's fine, but I want to think about it a little bit more.

I don't think this is true, since all architectures already needed to
handle an immediate return from seccomp, so audit shouldn't be touched
on the exit path either.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
