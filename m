Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733274AbgFWRfp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:45 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 17/28] s390/ptrace: pass invalid syscall numbers to tracing
Date: Tue, 23 Jun 2020 13:35:12 -0400
Message-Id: <20200623173523.1355411-17-sashal@kernel.org>
In-Reply-To: <20200623173523.1355411-1-sashal@kernel.org>
References: <20200623173523.1355411-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 00332c16b1604242a56289ff2b26e283dbad0812 ]

tracing expects to see invalid syscalls, so pass it through.
The syscall path in entry.S checks the syscall number before
looking up the handler, so it is still safe.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/entry.S  | 2 +-
 arch/s390/kernel/ptrace.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 3ae64914bd144..9584e743102b7 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -368,9 +368,9 @@ ENTRY(system_call)
 	jnz	.Lsysc_nr_ok
 	# svc 0: system call number in %r1
 	llgfr	%r1,%r1				# clear high word in r1
+	sth	%r1,__PT_INT_CODE+2(%r11)
 	cghi	%r1,NR_syscalls
 	jnl	.Lsysc_nr_ok
-	sth	%r1,__PT_INT_CODE+2(%r11)
 	slag	%r8,%r1,3
 .Lsysc_nr_ok:
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 3f29646313e82..fca78b269349d 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -848,11 +848,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	 * call number to gprs[2].
 	 */
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    (tracehook_report_syscall_entry(regs) ||
-	     regs->gprs[2] >= NR_syscalls)) {
+	    tracehook_report_syscall_entry(regs)) {
 		/*
-		 * Tracing decided this syscall should not happen or the
-		 * debugger stored an invalid system call number. Skip
+		 * Tracing decided this syscall should not happen. Skip
 		 * the system call and the system call restart handling.
 		 */
 		goto skip;
-- 
2.25.1
