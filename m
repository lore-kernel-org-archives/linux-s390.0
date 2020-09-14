Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgINPjp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 11:39:45 -0400
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/3] arm64: Convert to ARCH_STACKWALK
Date: Mon, 14 Sep 2020 16:34:06 +0100
Message-Id: <20200914153409.25097-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miroslav Benes <mbenes@suse.cz>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>

This series updates the arm64 stacktrace code to use the newer and much
simpler arch_stack_walk() interface, the main benefit being a single
entry point to the arch code with no need for the arch code to worry
about skipping frames. Along the way I noticed that the reliable
parameter to the arch_stack_walk() callback appears to be redundant
so there's also a patch here removing that from the existing code to
simplify the interface.

This is preparatory work for implementing reliable stack trace for
arm64.

v3:
 - Rebase onto v5.9-rc3.
 - Fix handling of task == current.
 - Flip the sense of the walk_stackframe() callback.
v2:
 - Rebase onto v5.9-rc1.

Mark Brown (3):
  stacktrace: Remove reliable argument from arch_stack_walk() callback
  arm64: stacktrace: Make stack walk callback consistent with generic
    code
  arm64: stacktrace: Convert to ARCH_STACKWALK

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/stacktrace.h |  2 +-
 arch/arm64/kernel/perf_callchain.c  |  6 +--
 arch/arm64/kernel/return_address.c  |  8 +--
 arch/arm64/kernel/stacktrace.c      | 84 +++++------------------------
 arch/s390/kernel/stacktrace.c       |  4 +-
 arch/x86/kernel/stacktrace.c        | 10 ++--
 include/linux/stacktrace.h          |  5 +-
 kernel/stacktrace.c                 |  8 ++-
 9 files changed, 32 insertions(+), 96 deletions(-)


base-commit: f75aef392f869018f78cfedf3c320a6b3fcfda6b
-- 
2.20.1
