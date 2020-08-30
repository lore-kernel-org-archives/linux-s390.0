Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
In-Reply-To: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 30 Aug 2020 00:40:42 -0400
Message-ID: <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
Subject: Re: ptrace_syscall_32 is failing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Aug 29, 2020 at 12:52 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Seems to be a recent regression, maybe related to entry/exit work changes.
>
> # ./tools/testing/selftests/x86/ptrace_syscall_32
> [RUN]    Check int80 return regs
> [OK]    getpid() preserves regs
> [OK]    kill(getpid(), SIGUSR1) preserves regs
> [RUN]    Check AT_SYSINFO return regs
> [OK]    getpid() preserves regs
> [OK]    kill(getpid(), SIGUSR1) preserves regs
> [RUN]    ptrace-induced syscall restart
>     Child will make one syscall
> [RUN]    SYSEMU
> [FAIL]    Initial args are wrong (nr=224, args=10 11 12 13 14 4289172732)
> [RUN]    Restart the syscall (ip = 0xf7f3b549)
> [OK]    Restarted nr and args are correct
> [RUN]    Change nr and args and restart the syscall (ip = 0xf7f3b549)
> [OK]    Replacement nr and args are correct
> [OK]    Child exited cleanly
> [RUN]    kernel syscall restart under ptrace
>     Child will take a nap until signaled
> [RUN]    SYSCALL
> [FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
> [RUN]    SYSCALL
> [OK]    Args after SIGUSR1 are correct (ax = -514)
> [OK]    Child got SIGUSR1
> [RUN]    Step again
> [OK]    pause(2) restarted correctly

Bisected to commit 0b085e68f407 ("x86/entry: Consolidate 32/64 bit
syscall entry").
It looks like it is because syscall_enter_from_user_mode() is called
before reading the 6th argument from the user stack.

--
Brian Gerst
