Return-Path: <linux-arch-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 00/14] run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:01:50 -0700
Message-ID: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160609210150.02iS_UclFlk_k7F0bR5WeuTNvzgPV0QghkKvuUN5tIY@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

There has been a long-standing (and documented) issue with seccomp
where ptrace can be used to change a syscall out from under seccomp.
This is a problem for containers and other wider seccomp filtered
environments where ptrace needs to remain available, as it allows
for an escape of the seccomp filter.

Since the ptrace attack surface is available for any allowed syscall,
moving seccomp after ptrace doesn't increase the actually available
attack surface. And this actually improves tracing since, for
example, tracers will be notified of syscall entry before seccomp
sends a SIGSYS, which makes debugging filters much easier.

The per-architecture changes do make one (hopefully small)
semantic change, which is that since ptrace comes first, it may
request a syscall be skipped. Running seccomp after this doesn't
make sense, so if ptrace wants to skip a syscall, it will bail
out early similarly to how seccomp was. This means that skipped
syscalls will not be fed through audit, though that likely means
we're actually avoiding noise this way.

This series first cleans up seccomp to remove the now unneeded
two-phase entry, fixes the SECCOMP_RET_TRACE hole (same as the
ptrace hole above), and then reorders seccomp after ptrace on
each architecture.

Thanks,

-Kees
