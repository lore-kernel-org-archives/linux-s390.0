Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgH3Pwq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 30 Aug 2020 11:52:46 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF2D52087D
        for <linux-s390@vger.kernel.org>; Sun, 30 Aug 2020 15:52:45 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id x9so3199494wmi.2
        for <linux-s390@vger.kernel.org>; Sun, 30 Aug 2020 08:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
 <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
In-Reply-To: <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 30 Aug 2020 08:52:33 -0700
Message-ID: <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com>
Subject: Re: ptrace_syscall_32 is failing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Sat, Aug 29, 2020 at 9:40 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Sat, Aug 29, 2020 at 12:52 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Seems to be a recent regression, maybe related to entry/exit work changes.
> >
> > # ./tools/testing/selftests/x86/ptrace_syscall_32
> > [RUN]    Check int80 return regs
> > [OK]    getpid() preserves regs
> > [OK]    kill(getpid(), SIGUSR1) preserves regs
> > [RUN]    Check AT_SYSINFO return regs
> > [OK]    getpid() preserves regs
> > [OK]    kill(getpid(), SIGUSR1) preserves regs
> > [RUN]    ptrace-induced syscall restart
> >     Child will make one syscall
> > [RUN]    SYSEMU
> > [FAIL]    Initial args are wrong (nr=224, args=10 11 12 13 14 4289172732)
> > [RUN]    Restart the syscall (ip = 0xf7f3b549)
> > [OK]    Restarted nr and args are correct
> > [RUN]    Change nr and args and restart the syscall (ip = 0xf7f3b549)
> > [OK]    Replacement nr and args are correct
> > [OK]    Child exited cleanly
> > [RUN]    kernel syscall restart under ptrace
> >     Child will take a nap until signaled
> > [RUN]    SYSCALL
> > [FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
> > [RUN]    SYSCALL
> > [OK]    Args after SIGUSR1 are correct (ax = -514)
> > [OK]    Child got SIGUSR1
> > [RUN]    Step again
> > [OK]    pause(2) restarted correctly
>
> Bisected to commit 0b085e68f407 ("x86/entry: Consolidate 32/64 bit
> syscall entry").
> It looks like it is because syscall_enter_from_user_mode() is called
> before reading the 6th argument from the user stack.

Ugh.  I caught, in review, a potential related issue with exit (not a
problem in current kernels), but I missed the entry version.

Thomas, can we revert the syscall_enter() and syscall_exit() part of
the series?  I think that they almost work for x86, but not quite as
indicated by this bug.  Even if we imagine we can somehow hack around
this bug, I imagine we're going to find other problems with this
model, e.g. the potential upcoming exit problem I noted in my review.

I really think the model should be:

void do_syscall_whatever(...)
{
  irqentry_enter(...);
  instrumentation_begin();

  /* Do whatever arch ABI oddities are needed on entry. */

  Then either:
  syscall_begin(arch, nr, regs);
  dispatch the syscall;
  syscall_end(arch, nr, regs);

  Or just:
  generic_do_syscall(arch, nr, regs);

  /* Do whatever arch ABI oddities are needed on exit from the syscall. */

  instrumentation_end();
  irqentry_exit(...);
}

x86 has an ABI oddity needed on entry: this fast syscall argument
fixup.  We also might end up with ABI oddities on exit if we ever try
to make single-stepping of syscalls work fully correctly.  x86 sort of
gets away without specifying arch because the arch helpers that get
called for audit, etc can deduce the arch, but this is kind of gross.
I suppose we could omit arch as an explicit parameter.

Or I suppose we could try to rejigger the API in time for 5.9.
Fortunately only x86 uses the new APIs so far.  I cc'd a bunch of
other arch maintainers to see if other architectures fit well in the
new syscall_enter() model, but I feel like the fact that x86 is
already broken indicates that we messed it up a bit.

--Andy
