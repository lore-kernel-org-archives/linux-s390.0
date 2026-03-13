Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325336DA06;
	Fri, 13 Mar 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395251; cv=none; b=YhsRBLxpsGuLM3ecPUuqmdbVMdJp/TxeSIvawKhIAk5xAzhwE9mgbqR9t4tTI7OZpIVETHzztkRwwRTt/h+mIe/cckiOdoc9ZjGR/4WaXAWdcDDwuGAbYlwFamaAUGD3Ci6FP5TjCrHgIGP+vbBnAJr2J1pYzBjzTB/1FCllLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395251; c=relaxed/simple;
	bh=mTmZxkoctPI4blsvdg/EVhzfBoxJeEf7YXrogebdG8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOwjUHCuLhpo0u9tJbywqE97c1B0+L1riHxPwJ+AUf8KGu037lICx8EYKkFEhZVZl2+zSjNK8GQqAvriHnF+121uylf2K4cpSwNTRIoObUG8GIh2l7f9E5BaWgeoCPQHZprFiT16xCHlDigsqXpKh5XB79mGRifzoNya1chAhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zBji1bSp; arc=none smtp.client-ip=113.46.200.222
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
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fXKJw44vlzLlvg;
	Fri, 13 Mar 2026 17:42:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 0135C4055B;
	Fri, 13 Mar 2026 17:47:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 17:47:19 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <arnd@arndb.de>, <shuah@kernel.org>, <kees@kernel.org>,
	<luto@amacapital.net>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<charlie@rivosinc.com>, <macro@orcam.me.uk>, <deller@gmx.de>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <pengcan@kylinos.cn>, <liqiang01@kylinos.cn>,
	<thuth@redhat.com>, <andreas@gaisler.com>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<jgross@suse.com>, <mathieu.desnoyers@efficios.com>, <yeoreum.yun@arm.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <akpm@linux-foundation.org>,
	<reddybalavignesh9979@gmail.com>, <richard.weiyang@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 02/12] arm64/ptrace: Expand secure_computing() in place
Date: Fri, 13 Mar 2026 17:47:28 +0800
Message-ID: <20260313094738.3985794-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313094738.3985794-1-ruanjinjie@huawei.com>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
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

