Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD090399351;
	Tue, 17 Mar 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735615; cv=none; b=oRri02CYhGxeJEr+Ma+sMwtFJoIs9pgTbSFq4847uh/GQRe3BYcVN34NTqOL/fnPTQPcvJakeaOLFo/xrIPQqwJe+Yc94bnwqUwu0a0XeCjGPMeDglGDjgdFvyvmvYe9cIYqOvWV39rj/FBCWnoiG6HoordWJ7Mqiw9Zp/HMMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735615; c=relaxed/simple;
	bh=lprEyZwSvvY7oYLKAef1Q7ik1sFF41UBb5hN8a26DKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXEJep9PGxBoQ66Ns/P5GnTCohXSaj18BpqVljXWY11tTnWYs04sNFPgwXi2okcpGQ4PNQ/I8bjkHo2wZ/NzEOSN1XSeYCcY7B4xqgK55V8Suy7Ck3ImlWcxdwXkO54MsI/VJdHATq1KEZvvqu/YXYOswn71Z5wu6xMxBsYt1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NDABjQXu; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NDABjQXu"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2C3xUm5DjLxc/SIMZ8u7vfUUWnpj82cAfyp1WR99tWc=;
	b=NDABjQXunNMnlF7oHYKZVrxDBaFs/eqPG52mvXUBJL4aiYZeV11EIZJCWQfKMTgeBBo5G4W0b
	WBDZuMjPF7dG1A/7Ey1xqEIN3teGKZQG98dhjPZhWUEKRyP98M74TY/54ktv3GNA/53iqP1fKul
	oghNToMR+H4P0Na21iJ6JYs=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fZlB24TT6z1T4GZ;
	Tue, 17 Mar 2026 16:14:50 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6426720168;
	Tue, 17 Mar 2026 16:20:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:08 +0800
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
Subject: [PATCH v13 RESEND 04/14] arm64/ptrace: Use syscall_get_arguments() helper for audit
Date: Tue, 17 Mar 2026 16:20:10 +0800
Message-ID: <20260317082020.737779-5-ruanjinjie@huawei.com>
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

Extract syscall_enter_audit() helper and use syscall_get_arguments()
to get syscall arguments, matching the generic entry implementation.

The new code:
- Checks audit_context() first to avoid unnecessary memcpy when audit
  is not active.
- Uses syscall_get_arguments() helper instead of directly accessing
  regs fields.
- Is now exactly equivalent to generic entry's syscall_enter_audit().

No functional changes.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d68f872339c7..3cb497b2bd22 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2408,6 +2408,16 @@ static void report_syscall_exit(struct pt_regs *regs)
 	}
 }
 
+static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
 int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 {
 	long syscall;
@@ -2439,8 +2449,7 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 		 syscall = syscall_get_nr(current, regs);
 	}
 
-	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
-			    regs->regs[2], regs->regs[3]);
+	syscall_enter_audit(regs, syscall);
 
 	return ret ? : syscall;
 }
-- 
2.34.1

