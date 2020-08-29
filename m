Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 29 Aug 2020 09:48:37 -0700
Message-ID: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
Subject: ptrace_syscall_32 is failing
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

Seems to be a recent regression, maybe related to entry/exit work changes.

# ./tools/testing/selftests/x86/ptrace_syscall_32
[RUN]    Check int80 return regs
[OK]    getpid() preserves regs
[OK]    kill(getpid(), SIGUSR1) preserves regs
[RUN]    Check AT_SYSINFO return regs
[OK]    getpid() preserves regs
[OK]    kill(getpid(), SIGUSR1) preserves regs
[RUN]    ptrace-induced syscall restart
    Child will make one syscall
[RUN]    SYSEMU
[FAIL]    Initial args are wrong (nr=224, args=10 11 12 13 14 4289172732)
[RUN]    Restart the syscall (ip = 0xf7f3b549)
[OK]    Restarted nr and args are correct
[RUN]    Change nr and args and restart the syscall (ip = 0xf7f3b549)
[OK]    Replacement nr and args are correct
[OK]    Child exited cleanly
[RUN]    kernel syscall restart under ptrace
    Child will take a nap until signaled
[RUN]    SYSCALL
[FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
[RUN]    SYSCALL
[OK]    Args after SIGUSR1 are correct (ax = -514)
[OK]    Child got SIGUSR1
[RUN]    Step again
[OK]    pause(2) restarted correctly
