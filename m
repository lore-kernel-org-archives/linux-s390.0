Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D0517C203;
	Sun, 12 Jul 2026 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891522; cv=none; b=FcNt77GolSz3z32K+ZtuaQn0ApXHtxvxwVZOlr4/njAbUN5ei/v2dcIE43Z9MrTBRVrEUdUdTnKHBObF2nEk4xjgYmukKngmTUKeavlwJIABBdbkA5C20E9k0a2UvoQ8GkaD0X1DMlJDW6mZGF/higEu6VQuAKjDiMIBbQUTzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891522; c=relaxed/simple;
	bh=xiQKERVLXlhv9R6+U6VqsicxLm/lazckEJoktsa0NN4=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G6CevikakztsYZIbxYJZRfmk5Uv7Su8VzIgdHtoJtO+fer8QMnlCLrxWh4RLY54LDYKYjE+8uYKqUg8+qseIu+0XiJgNgb/+S9MzWTXmeO27rdvt5Viti3axjsPR19Pmo8BmAal0Yr5HXEUJjaGbqFlLEvv9OibpY3tarOyULW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeR46zuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeR46zuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F6D1F000E9;
	Sun, 12 Jul 2026 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891520;
	bh=rQWZ8aJgOncbggueFnURmOMnwueR0POClkrjreehrRg=;
	h=Date:From:To:Cc:Subject:References;
	b=MeR46zuk5udFu+6sitLOWkIvT2D1oWkOX3LZL64wi0Wue7pZZoj92eYrZyCHwL6re
	 LtNulxNY9Xfv0bKY212BxpjPh6OQuqFHmkUTpzE0rrlt4QxqdZebZE1KDm4nZUEhMp
	 ZsMDsH3MWEuTn7puKH/TLmpD43nwClU5g498mnR/jpAbyFSVn7gqOikHCa1XfLi/OZ
	 AxtODzhSPI53UIID1Fh9XQID2bGnMTk5jyR9XlEl7In4QJRq8W/lVDvsymIMGYh57F
	 hQWVHq+yBg4dJ6sMKRBey0cUbgn5O4cPuwCH4e7tb62pq2ioZJr+suHGx6CzXWo5pw
	 5bSB+97HCh1VA==
Date: Sun, 12 Jul 2026 23:25:17 +0200
Message-ID: <20260712141346.576865340@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 1/4] entry: Rework syscall_audit_enter()
References: <20260712134433.549076055@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Move it out of line and let it reread the syscall number on it's own. That
makes the low level entry code denser and allows to move the reread to the
call site of syscall_trace_enter() once the tracer is fixed up.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h  |   14 +++-----------
 kernel/entry/syscall-common.c |   10 ++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -60,16 +60,7 @@ static __always_inline bool arch_ptrace_
 
 long trace_syscall_enter(struct pt_regs *regs, long syscall);
 void trace_syscall_exit(struct pt_regs *regs, long ret);
-
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
+void syscall_enter_audit(struct pt_regs *regs);
 
 static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
 						long syscall)
@@ -111,7 +102,8 @@ static __always_inline long syscall_trac
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		syscall = trace_syscall_enter(regs, syscall);
 
-	syscall_enter_audit(regs, syscall);
+	if (unlikely(audit_context()))
+		syscall_enter_audit(regs);
 
 	return syscall;
 }
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/audit.h>
 #include <linux/entry-common.h>
 
 #define CREATE_TRACE_POINTS
@@ -21,3 +22,12 @@ void trace_syscall_exit(struct pt_regs *
 {
 	trace_sys_exit(regs, ret);
 }
+
+void syscall_enter_audit(struct pt_regs *regs)
+{
+	long syscall = syscall_get_nr(current, regs);
+	unsigned long args[6];
+
+	syscall_get_arguments(current, regs, args);
+	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+}

