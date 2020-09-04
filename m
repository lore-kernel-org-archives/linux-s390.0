Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDKNU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Sep 2020 06:13:20 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ptrace_syscall_32 is failing
In-Reply-To: <CALCETrUuyXpG0Vhrb-9m-G8J94+2bGqdrJkKfz+-5z7dsGLK8Q@mail.gmail.com>
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com> <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com> <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com> <87k0xdjbtt.fsf@nanos.tec.linutronix.de> <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com> <87blioinub.fsf@nanos.tec.linutronix.de> <CALCETrUuyXpG0Vhrb-9m-G8J94+2bGqdrJkKfz+-5z7dsGLK8Q@mail.gmail.com>
Date: Fri, 04 Sep 2020 12:13:15 +0200
Message-ID: <87mu254zpg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Andy,

On Wed, Sep 02 2020 at 09:49, Andy Lutomirski wrote:
> On Wed, Sep 2, 2020 at 1:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> But you might tell me where exactly you want to inject the SIGTRAP in
>> the syscall exit code flow.
>
> It would be a bit complicated.  Definitely after any signals from the
> syscall are delivered.  Right now, I think that we don't deliver a
> SIGTRAP on the instruction boundary after SYSCALL while
> single-stepping.  (I think we used to, but only sometimes, and now we
> are at least consistent.)  This is because IRET will not trap if it
> starts with TF clear and ends up setting it.  (I asked Intel to
> document this, and I think they finally did, although I haven't gotten
> around to reading the new docs.  Certainly the old docs as of a year
> or two ago had no description whatsoever of how TF changes worked.)
>
> Deciding exactly *when* a trap should occur would be nontrivial -- we
> can't trap on sigreturn() from a SIGTRAP, for example.
>
> So this isn't fully worked out.

Oh well.

>> >> I don't think we want that in general. The current variant is perfectly
>> >> fine for everything except the 32bit fast syscall nonsense. Also
>> >> irqentry_entry/exit is not equivalent to the syscall_enter/exit
>> >> counterparts.
>> >
>> > If there are any architectures in which actual work is needed to
>> > figure out whether something is a syscall in the first place, they'll
>> > want to do the usual kernel entry work before the syscall entry work.
>>
>> That's low level entry code which does not require RCU, lockdep, tracing
>> or whatever muck we setup before actual work can be done.
>>
>> arch_asm_entry()
>>   ...
>>   arch_c_entry(cause) {
>>     switch(cause) {
>>       case EXCEPTION: arch_c_exception(...);
>>       case SYSCALL: arch_c_syscall(...);
>>       ...
>>     }
>
> You're assuming that figuring out the cause doesn't need the kernel
> entry code to run first.  In the case of the 32-bit vDSO fast
> syscalls, we arguably don't know whether an entry is a syscall until
> we have done a user memory access.  Logically, we're doing:
>
> if (get_user() < 0) {
>   /* Not a syscall.  This is actually a silly operation that sets AX =
> -EFAULT and returns.  Do not audit or invoke ptrace. */
> } else {
>   /* This actually is a syscall. */
> }

Yes, that's what I've addressed with providing split interfaces.

>> You really want to differentiate between exception and syscall
>> entry/exit.
>>
>
> Why do we want to distinguish between exception and syscall
> entry/exit?  For the enter part, AFAICS the exception case boils down
> to enter_from_user_mode() and the syscall case is:
>
>         enter_from_user_mode(regs);
>         instrumentation_begin();
>
>         local_irq_enable();
>         ti_work = READ_ONCE(current_thread_info()->flags);
>         if (ti_work & SYSCALL_ENTER_WORK)
>                 syscall = syscall_trace_enter(regs, syscall, ti_work);
>         instrumentation_end();
>
> Which would decompose quite nicely as a regular (non-syscall) entry
> plus the syscall part later.

There is a difference between syscall entry and exception entry at least
in my view:

syscall:
                enter_from_user_mode(regs);
                local_irq_enable();

exception:
                enter_from_user_mode(regs);

>> we'd have:
>>
>>   arch_c_entry()
>>      irqentry_enter();
>>      local_irq_enble();
>>      nr = syscall_enter_from_user_mode_work();
>>      ...
>>
>> which enforces two calls for sane entries and more code in arch/....
>
> This is why I still like my:
>
> arch_c_entry()
>   irqentry_enter_from_user_mode();
>   generic_syscall();
>   exit...

So what we have now (with my patch applied) is either:

1) arch_c_entry()
        nr = syscall_enter_from_user_mode();
        arch_handle_syscall(nr);
        syscall_exit_to_user_mode();

or for that extra 32bit fast syscall thing:

2) arch_c_entry()
        syscall_enter_from_user_mode_prepare();
        arch_do_stuff();
        nr = syscall_enter_from_user_mode_work();
        arch_handle_syscall(nr);
        syscall_exit_to_user_mode();

So for sane cases you just use #1.

Ideally we'd not need arch_handle_syscall(nr) at all, but that does not
work with multiple ABIs supported, i.e. the compat muck.

The only way we could make that work is to have:

    syscall_enter_exit(regs, mode)
      nr = syscall_enter_from_user_mode();
      arch_handle_syscall(mode, nr);
      syscall_exit_to_user_mode();

and then arch_c_entry() becomes:

    syscall_enter_exit(regs, mode);

which means that arch_handle_syscall() would have to evaluate the mode
and chose the appropriate syscall table. Not sure whether that's a win.

Thanks,

        tglx
