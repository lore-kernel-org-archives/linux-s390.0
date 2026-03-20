Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B2391E4E;
	Fri, 20 Mar 2026 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003275; cv=none; b=s4j7Lj984MktWsnEs7h+u6gxFIV/jjmh5mH0MP1i/JF3G9CyEirB6vsqAea6TxIPY2oSxzml8hSeGWGI1+Tl5U54XLigc1X8buE5oYDfu7AT8VmgvlY2Nt8chTeJzkR9XMxUlGTJRif7shJ/VfYQDI1Z+iyVTG1LRi/ZKHsIBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003275; c=relaxed/simple;
	bh=vpVQRC72hsKlKsly8+/GTjJniVRmFHuzXm2q5+hvNRE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZMoNWHPbcyYDixPe6xnnjjrPInQ0i7iHmcwd+YzvRkUgLPS/A1zIxZBWpCFSavScn4A+yEscMwFOtmGUW3CEBZw5i0N3yuPvThx0GXfWhp8Fo06MfsKdE9r+93+Lg0zQsreHMkYOroLepc979NFz9EjVfN5KmkGrXUNbOuvH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=e0Dh+Jkq; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="e0Dh+Jkq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hJSEOOAhj/r6zguq6KmRPCSMSABE64v2gT/NO93bRjA=;
	b=e0Dh+JkqNoMciVayHgin+0LjX4MpNFT6ER7rvoJu8i5SDzMhl/mWV/OtIMBdH/Nphhbfv/77p
	yVR4oRwD8pdUgqzsTDx1bv44cl23ZK1qW5wxLNk/xtNYX3d1Bw3uHxmgCgX7ILsrASKvrRFlQJK
	P5z3C70+WVwiTHfY8wJuhn0=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fcf8X1bpKzLlTD;
	Fri, 20 Mar 2026 18:35:08 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id F356840565;
	Fri, 20 Mar 2026 18:41:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 18:41:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<oleg@redhat.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<shuah@kernel.org>, <kevin.brodsky@arm.com>, <ruanjinjie@huawei.com>,
	<yeoreum.yun@arm.com>, <anshuman.khandual@arm.com>, <thuth@redhat.com>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <song@kernel.org>,
	<ziyao@disroot.org>, <linusw@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<akpm@linux-foundation.org>, <mathieu.desnoyers@efficios.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v14 0/4] arm64: Use generic TIF bits for common thread flags
Date: Fri, 20 Mar 2026 18:42:18 +0800
Message-ID: <20260320104222.1381274-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

This series use generic TIF bits for common thread flags and add
Syscall User Dispatch (SUD) testcase support for AArch64. So we can
enables RSEQ optimizations for arm64.

These patches follow the foundational series (v13 resend 1-10, "arm64:
entry: Convert to Generic Entry") and are intended for the next cycle or
an immutable branch based on v7.0-rc1.

Changes in v14:
- Split into two patch sets as Linus Walleij suggested, this is the second
  patch set.
- Remove TIF_FREEZE for arm64.
- Add Signed-off-by and test results for sud_benchmark.
- Collect Reviewed-by and Acked-by.
- Link to v13 resend: https://lore.kernel.org/all/20260317082020.737779-15-ruanjinjie@huawei.com/

Changes in v13 resend:
- Fix exit_to_user_mode_prepare_legacy() issues.
- Also move TIF_SINGLESTEP to generic TIF infrastructure for loongarch.
- Use generic TIF bits for arm64 and moving TIF_SINGLESTEP to
  generic TIF for related architectures separately.
- Refactor syscall_trace_enter/exit() to accept flags and Use
  syscall_get_nr() helper separately.
- Tested with slice_test for rseq optimizations.
- Add acked-by.
- Link to v13: https://lore.kernel.org/all/20260313094738.3985794-1-ruanjinjie@huawei.com/

Changes in v13:
- Rebased on v7.0-rc3, so drop the firt applied arm64 patch.
- Use generic TIF bits to enables RSEQ optimization.
- Update most of the commit message to make it more clear.
- Link to v12: https://lore.kernel.org/all/20260203133728.848283-1-ruanjinjie@huawei.com/

Changes in v12:
- Rebased on "sched/core", so remove the four generic entry patches.
- Move "Expand secure_computing() in place" and
  "Use syscall_get_arguments() helper" patch forward, which will group all
  non-functional cleanups at the front.
- Adjust the explanation for moving rseq_syscall() before
  audit_syscall_exit().
- Link to v11: https://lore.kernel.org/all/20260128031934.3906955-1-ruanjinjie@huawei.com/

Changes in v11:
- Remove unused syscall in syscall_trace_enter().
- Update and provide a detailed explanation of the differences after
  moving rseq_syscall() before audit_syscall_exit().
- Rebased on arm64 (for-next/entry), and remove the first applied 3 patchs.
- syscall_exit_to_user_mode_work() for arch reuse instead of adding
  new syscall_exit_to_user_mode_work_prepare() helper.
- Link to v10: https://lore.kernel.org/all/20251222114737.1334364-1-ruanjinjie@huawei.com/

Changes in v10:
- Rebased on v6.19-rc1, rename syscall_exit_to_user_mode_prepare() to
  syscall_exit_to_user_mode_work_prepare() to avoid conflict.
- Also inline syscall_trace_enter().
- Support aarch64 for sud_benchmark.
- Update and correct the commit message.
- Add Reviewed-by.
- Link to v9: https://lore.kernel.org/all/20251204082123.2792067-1-ruanjinjie@huawei.com/

Changes in v9:
- Move "Return early for ptrace_report_syscall_entry() error" patch ahead
  to make it not introduce a regression.
- Not check _TIF_SECCOMP/SYSCALL_EMU for syscall_exit_work() in
  a separate patch.
- Do not report_syscall_exit() for PTRACE_SYSEMU_SINGLESTEP in a separate
  patch.
- Add two performance patch to improve the arm64 performance.
- Add Reviewed-by.
- Link to v8: https://lore.kernel.org/all/20251126071446.3234218-1-ruanjinjie@huawei.com/

Changes in v8:
- Rename "report_syscall_enter()" to "report_syscall_entry()".
- Add ptrace_save_reg() to avoid duplication.
- Remove unused _TIF_WORK_MASK in a standalone patch.
- Align syscall_trace_enter() return value with the generic version.
- Use "scno" instead of regs->syscallno in el0_svc_common().
- Move rseq_syscall() ahead in a standalone patch to clarify it clearly.
- Rename "syscall_trace_exit()" to "syscall_exit_work()".
- Keep the goto in el0_svc_common().
- No argument was passed to __secure_computing() and check -1 not -1L.
- Remove "Add has_syscall_work() helper" patch.
- Move "Add syscall_exit_to_user_mode_prepare() helper" patch later.
- Add miss header for asm/entry-common.h.
- Update the implementation of arch_syscall_is_vdso_sigreturn().
- Add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP | SYSCALL_EMU"
  to keep the behaviour unchanged.
- Add more testcases test.
- Add Reviewed-by.
- Update the commit message.
- Link to v7: https://lore.kernel.org/all/20251117133048.53182-1-ruanjinjie@huawei.com/

Jinjie Ruan (3):
  s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
  asm-generic: Move TIF_SINGLESTEP to generic TIF bits
  arm64: Use generic TIF bits for common thread flags

kemal (1):
  selftests: sud_test: Support aarch64

 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/thread_info.h          | 61 ++++++++-----------
 arch/loongarch/include/asm/thread_info.h      | 11 ++--
 arch/s390/include/asm/thread_info.h           |  7 +--
 arch/s390/kernel/process.c                    |  2 +-
 arch/s390/kernel/ptrace.c                     | 20 +++---
 arch/s390/kernel/signal.c                     |  6 +-
 arch/x86/include/asm/thread_info.h            |  6 +-
 include/asm-generic/thread_info_tif.h         |  5 ++
 .../syscall_user_dispatch/sud_benchmark.c     |  2 +-
 .../syscall_user_dispatch/sud_test.c          |  4 ++
 11 files changed, 61 insertions(+), 64 deletions(-)

-- 
2.34.1

