Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FB39B4A9;
	Tue, 17 Mar 2026 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735619; cv=none; b=RkZzqfMuy/o08zqmVewOgP5wW2D5u7TST2Aok479MSELdJM4DJZX5h1mRTkVlU7J016xDewef+pGfhpWOS52kUJRtAk8c/dyEuNlARxSoQmv6I7EOZnQYYwJk+W/8gb5NFM3oOhbJzzSLumFQRDYqdlVcQaeQLiOxOv7D3O06PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735619; c=relaxed/simple;
	bh=mTmZxkoctPI4blsvdg/EVhzfBoxJeEf7YXrogebdG8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVhnThxcL6TVoJ4K2dXD0VEWq0Q0Q+LgT39aotNxkYGKqWHGJAaMvj3C7pdEHqxzDAIf9mCdnZOQD3V1FUIVaoPIF04ZUhnbKREw6tZZFuW1ycY+EzRfu+lbCcrbixS9Xay9bYMmPpxkmk2IVHbskn+GM83nokfj1KNZLMLW2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zBji1bSp; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zBji1bSp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=egLlSVzHKLlWrE+C1u4R4GAY3SI2tDu6OysUmWNLQGo=;
	b=zBji1bSpBelhC7PD5LAuv3cDCWhKFnwrRZ0FgtFV8Z0eftCOx8GJPRFWH9ju9qbS/g1a7AaKF
	l/jSZlBK0Aq3Hu9/5UjscYjNJRmGrTSfmDEs0AewVRmzPp8Xu8ky3+WP7nfBAfSZ42EJD5hulna
	O8aoV/VLnU1f2lzQPy3fuCE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fZl9y2XYxzpT04;
	Tue, 17 Mar 2026 16:14:46 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 35D1540561;
	Tue, 17 Mar 2026 16:20:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:05 +0800
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
Subject: [PATCH v13 RESEND 03/14] arm64/ptrace: Expand secure_computing() in place
Date: Tue, 17 Mar 2026 16:20:09 +0800
Message-ID: <20260317082020.737779-4-ruanjinjie@huawei.com>
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

Refactor syscall_trace_enter() by open-coding the seccomp check
to align with the generic entry framework.

[Background]
The generic entry implementation expands the seccomp check in-place
instead of using the secure_computing() wrapper. It directly tests
SYSCALL_WORK_SECCOMP and calls the underlying __secure_computing()
function to handle syscall filtering.

[Changes]
1. Open-code seccomp check:
   - Instead of calling the secure_computing() wrapper, explicitly check
     the 'flags' parameter for _TIF_SECCOMP.
   - Call __secure_computing() directly if the flag is set.

2. Refine return value handling:
   - Use 'return ret ? : syscall' to propagate the return value.
   - Ensures any unexpected non-zero return from __secure_computing()
     is properly propagated is properly propagated.
   - This matches the logic in the generic entry code.

[Why this matters]
- Aligns the arm64 syscall path with the generic entry implementation,
  simplifying future migration to the generic entry framework.
- No functional changes are intended; seccomp behavior remains identical.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8d296a07fbf7..d68f872339c7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2420,8 +2420,11 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 	}
 
 	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
-		return NO_SYSCALL;
+	if (flags & _TIF_SECCOMP) {
+		ret = __secure_computing();
+		if (ret == -1)
+			return NO_SYSCALL;
+	}
 
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
@@ -2439,7 +2442,7 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 	audit_syscall_entry(syscall, regs->orig_x0, regs->regs[1],
 			    regs->regs[2], regs->regs[3]);
 
-	return syscall;
+	return ret ? : syscall;
 }
 
 void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
-- 
2.34.1

