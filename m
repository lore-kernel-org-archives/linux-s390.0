Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB617C203;
	Sun, 12 Jul 2026 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891526; cv=none; b=DziCGML0ckC1Gc1eswJdDZIv4sOUQ08CVz+xp8WCYf7QhKPZEjWd6PFOxKKR7r/dDhXgSsqSCdsx9h5jouIFnGvS2MLZ9Po5ATivPS8MIDU6amKrM7b3hNozFOJMHLbCyJzeKa+xI2R7LwTM7+Yb6YxufXWG+Qo2YOK4dfoTLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891526; c=relaxed/simple;
	bh=vnUndRc7gzdHX7DknVwrYPY2as0EUIrJp2S28xgLaT8=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QBMGZzpb37CJ2M41Dud94IJ67bGny5JJWpVV6QhXflVEHNGCJm1L6/XPJdBBNLE1keiwredzesI1sHX+JtKw00+KhjxH11d9q9k85gk6m6474Y7OMx/wo5l3VAUie4iGIpVDbkEN2nJ//gJGA9l4CgaPoGvUGlgGMlncYzcNXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzeCuuT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzeCuuT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF891F000E9;
	Sun, 12 Jul 2026 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891525;
	bh=2JItWlUO0RtFZwJ9AedXkVw8o5YILdxQ5hx8qr2Nb5s=;
	h=Date:From:To:Cc:Subject:References;
	b=mzeCuuT0JQcjq0ffdG1mMOXvwVg7uBygi4ikhxj2XYUNlmMfzmfn3U2nH5Q/s2tYT
	 hE6So6oMIRH9zZo8P+kLDM1SHxS9ep4XeX4OI3bWj66SvgdPaw44aKEwaw1MYINh0H
	 4zCSmz9lTSmItEjpfX/V5TRcJOf34STaoyRjMoXNl0u96NUZtWitt5VWhcdZN+gCWy
	 1VFaBHkKtdt0C3blUBtUpl6PbzJYJ53qjO+yF+0U6mYoA2Nbt0/kmPWWjLEgxJP/cY
	 oOTjW6RijF7rhFsJnEwV9x1TsJubt24VulGi6dqcPQSyG1yrH+hb9EUlxjDaCvPx9L
	 hy+Ix8nbOcXZQ==
Date: Sun, 12 Jul 2026 23:25:22 +0200
Message-ID: <20260712141346.639115923@kernel.org>
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
Subject: [patch 2/4] entry: Rework trace_syscall_enter()
References: <20260712134433.549076055@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Reread the syscall number from pt_regs and stop returning the eventually
modified syscall number.

That moves the reread to the end of the syscall_trace_enter() and prepares
for moving it to the call site.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h  |   10 ++++------
 kernel/entry/syscall-common.c |    9 ++-------
 2 files changed, 6 insertions(+), 13 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
 }
 #endif
 
-long trace_syscall_enter(struct pt_regs *regs, long syscall);
+void trace_syscall_enter(struct pt_regs *regs);
 void trace_syscall_exit(struct pt_regs *regs, long ret);
 void syscall_enter_audit(struct pt_regs *regs);
 
@@ -96,16 +96,14 @@ static __always_inline long syscall_trac
 			return -1L;
 	}
 
-	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
-
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
-		syscall = trace_syscall_enter(regs, syscall);
+		trace_syscall_enter(regs);
 
 	if (unlikely(audit_context()))
 		syscall_enter_audit(regs);
 
-	return syscall;
+	/* Either of the above might have changed the syscall number */
+	return syscall_get_nr(current, regs);
 }
 
 /**
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -8,14 +8,9 @@
 
 /* Out of line to prevent tracepoint code duplication */
 
-long trace_syscall_enter(struct pt_regs *regs, long syscall)
+void trace_syscall_enter(struct pt_regs *regs)
 {
-	trace_sys_enter(regs, syscall);
-	/*
-	 * Probes or BPF hooks in the tracepoint may have changed the
-	 * system call number. Reread it.
-	 */
-	return syscall_get_nr(current, regs);
+	trace_sys_enter(regs, syscall_get_nr(current, regs));
 }
 
 void trace_syscall_exit(struct pt_regs *regs, long ret)

