Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgIBAJt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Sep 2020 20:09:49 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8354921582
        for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2020 00:09:48 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id b79so2766352wmb.4
        for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2020 17:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
 <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
 <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com> <87k0xdjbtt.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k0xdjbtt.fsf@nanos.tec.linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 1 Sep 2020 17:09:35 -0700
Message-ID: <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com>
Subject: Re: ptrace_syscall_32 is failing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Tue, Sep 1, 2020 at 4:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, Aug 30 2020 at 08:52, Andy Lutomirski wrote:
> >> > [RUN]    SYSCALL
> >> > [FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
> >> > [RUN]    SYSCALL
> >> > [OK]    Args after SIGUSR1 are correct (ax = -514)
> >> > [OK]    Child got SIGUSR1
> >> > [RUN]    Step again
> >> > [OK]    pause(2) restarted correctly
> >>
> >> Bisected to commit 0b085e68f407 ("x86/entry: Consolidate 32/64 bit
> >> syscall entry").
> >> It looks like it is because syscall_enter_from_user_mode() is called
> >> before reading the 6th argument from the user stack.
>
> Bah.I don't know how I managed to miss that part and interestingly
> enough that none of the robots caught that either
>
> > Thomas, can we revert the syscall_enter() and syscall_exit() part of
> > the series?
>
> Hrm.
>
> > I think that they almost work for x86, but not quite as
> > indicated by this bug.  Even if we imagine we can somehow hack around
> > this bug, I imagine we're going to find other problems with this
> > model, e.g. the potential upcoming exit problem I noted in my review.
>
> What's the upcoming problem?

If we ever want to get single-stepping fully correct across syscalls,
we might need to inject SIGTRAP on syscall return. This would be more
awkward if we can't run instrumentable code after the syscall part of
the syscall is done.

>
> > I really think the model should be:
> >
> > void do_syscall_whatever(...)
> > {
> >   irqentry_enter(...);
> >   instrumentation_begin();
> >
> >   /* Do whatever arch ABI oddities are needed on entry. */
> >
> >   Then either:
> >   syscall_begin(arch, nr, regs);
> >   dispatch the syscall;
> >   syscall_end(arch, nr, regs);
> >
> >   Or just:
> >   generic_do_syscall(arch, nr, regs);
> >
> >   /* Do whatever arch ABI oddities are needed on exit from the syscall. */
> >
> >   instrumentation_end();
> >   irqentry_exit(...);
> > }
>
> I don't think we want that in general. The current variant is perfectly
> fine for everything except the 32bit fast syscall nonsense. Also
> irqentry_entry/exit is not equivalent to the syscall_enter/exit
> counterparts.

If there are any architectures in which actual work is needed to
figure out whether something is a syscall in the first place, they'll
want to do the usual kernel entry work before the syscall entry work.
Maybe your patch actually makes this possible -- I haven't digested
all the details yet.

Who advised you to drop the arch parameter?

> ---
>  arch/x86/entry/common.c      |   29 ++++++++++++++++--------
>  include/linux/entry-common.h |   51 +++++++++++++++++++++++++++++++++++--------
>  kernel/entry/common.c        |   35 ++++++++++++++++++++++++-----
>  3 files changed, 91 insertions(+), 24 deletions(-)
>
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -60,16 +60,10 @@
>  #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
>  static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
>  {
> -       unsigned int nr = (unsigned int)regs->orig_ax;
> -
>         if (IS_ENABLED(CONFIG_IA32_EMULATION))
>                 current_thread_info()->status |= TS_COMPAT;
> -       /*
> -        * Subtlety here: if ptrace pokes something larger than 2^32-1 into
> -        * orig_ax, the unsigned int return value truncates it.  This may
> -        * or may not be necessary, but it matches the old asm behavior.
> -        */
> -       return (unsigned int)syscall_enter_from_user_mode(regs, nr);
> +
> +       return (unsigned int)regs->orig_ax;
>  }
>
>  /*
> @@ -91,15 +85,29 @@ static __always_inline void do_syscall_3
>  {
>         unsigned int nr = syscall_32_enter(regs);
>
> +       /*
> +        * Subtlety here: if ptrace pokes something larger than 2^32-1 into
> +        * orig_ax, the unsigned int return value truncates it.  This may
> +        * or may not be necessary, but it matches the old asm behavior.
> +        */
> +       nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
> +
>         do_syscall_32_irqs_on(regs, nr);
>         syscall_exit_to_user_mode(regs);
>  }
>
>  static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>  {
> -       unsigned int nr = syscall_32_enter(regs);
> +       unsigned int nr = syscall_32_enter(regs);
>         int res;
>
> +       /*
> +        * This cannot use syscall_enter_from_user_mode() as it has to
> +        * fetch EBP before invoking any of the syscall entry work
> +        * functions.
> +        */
> +       syscall_enter_from_user_mode_prepare(regs);

I'm getting lost in all these "enter" functions...
