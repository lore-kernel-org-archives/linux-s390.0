Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE339C65D;
	Tue, 17 Mar 2026 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735623; cv=none; b=IlLJBVZxzwpNRbqiCtl+JgMquiByihhXX3aiW5EZYPryyyJhCTgj7qRT2cizphI7EAZUCqS1nbxOmrFiftn3sEw2chkum2f0jgvbCAN5EZdQQs6c1VRpfeWL7lJLsM7affKHHVHgjQPesqDOOcbZqmOMLoJySaXLy/AK9728C0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735623; c=relaxed/simple;
	bh=6z1/3WCDlleINA85Y6p70z60dKZed+IqwEEdTcCl3PI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkoRtF4ZEfZ0MjmkBFPSQusLGiIhWe44HiZYbmmBUqLsZoq+aSok6AHkJ2BTGQW9ABU3vJCPsOYWGB73O16uitpfYdFTeg8kdmze+1o04uYI5yEIO2cXZLEl+ZPhJlINnshIxVmfaai0Bz1+RMiyLvO6cRNUUyK/4bRj156aJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yBqIZEW9; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yBqIZEW9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WEzP5z/SdtokaYujOa6eZX4XKze4duwTwqEgtATO8ak=;
	b=yBqIZEW9LgAAaW8S+Vos0a1k5NpqTpDEAQB6i+ZPVNj/jEQkmigBZVCWwZ5VND1sPFCfCrdtO
	MNTO6IQTPbIRh5/tWcn+5dfs4YzcUb+3vmx4bpS0rCEGcUY/VykMs2MJzZj0GP1TkQKC9sG6pw6
	P/83Iiu9uA2t/p340yyARKE=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fZl9z0w7Jz12LJv;
	Tue, 17 Mar 2026 16:14:47 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BE9340561;
	Tue, 17 Mar 2026 16:20:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<deller@gmx.de>, <macro@orcam.me.uk>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <ryan.roberts@arm.com>,
	<mark.rutland@arm.com>, <thuth@redhat.com>, <song@kernel.org>,
	<ada.coupriediaz@arm.com>, <linusw@kernel.org>, <broonie@kernel.org>,
	<pengcan@kylinos.cn>, <liqiang01@kylinos.cn>, <ziyao@disroot.org>,
	<guanwentao@uniontech.com>, <guoren@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<david@kernel.org>, <mathieu.desnoyers@efficios.com>, <edumazet@google.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 RESEND 08/14] arm64/ptrace: Skip syscall exit reporting for PTRACE_SYSEMU_SINGLESTEP
Date: Tue, 17 Mar 2026 16:20:14 +0800
Message-ID: <20260317082020.737779-9-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317082020.737779-1-ruanjinjie@huawei.com>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Align the syscall exit reporting logic with the generic entry
framework by skipping the exit stop when PTRACE_SYSEMU_SINGLESTEP is
in effect.

[Rationale]
When a tracer uses PTRACE_SYSEMU_SINGLESTEP, both _TIF_SYSCALL_EMU
and _TIF_SINGLESTEP flags are set. Currently, arm64 reports a syscall
exit stop whenever _TIF_SINGLESTEP is set, regardless of the
emulation state.

However, as per the generic entry implementation (see
include/linux/entry-common.h):
"If SYSCALL_EMU is set, then the only reason to report is when SINGLESTEP
is set (i.e. PTRACE_SYSEMU_SINGLESTEP). This syscall instruction has been
already reported in syscall_trace_enter()."

Since PTRACE_SYSEMU intercepts and skips the actual syscall
execution, reporting a subsequent exit stop is redundant and
inconsistent with the expected behavior of emulated system calls.

[Changes]
- Introduce report_single_step(): Add a helper to encapsulate the
  logic for deciding whether to report a single-step stop at syscall
  exit. It returns false if _TIF_SYSCALL_EMU is set, ensuring the
  emulated syscall does not trigger a duplicate report.

- Update syscall_exit_work(): Use the new helper to determine
  the stepping state instead of directly checking _TIF_SINGLESTEP.

[Impact]
- PTRACE_SINGLESTEP: Continues to report exit stops for actual
  instructions.

- PTRACE_SYSEMU: Continues to skip exit stops.

- PTRACE_SYSEMU_SINGLESTEP: Now correctly skips the redundant exit
  stop, aligning arm64 with the generic entry infrastructure.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 3cac9668aaa8..766de3584cff 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2454,14 +2454,25 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 	return ret ? : syscall;
 }
 
+static inline bool report_single_step(unsigned long flags)
+{
+	if (flags & _TIF_SYSCALL_EMU)
+		return false;
+
+	return flags & _TIF_SINGLESTEP;
+}
+
 static void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
 {
+	bool step;
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
+	step = report_single_step(flags);
+	if (step || flags & _TIF_SYSCALL_TRACE)
 		report_syscall_exit(regs);
 }
 
-- 
2.34.1

