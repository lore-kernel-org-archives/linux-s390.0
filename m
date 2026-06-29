Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F1408628;
	Mon, 29 Jun 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738412; cv=none; b=sVy0EvgRuvBFDszfgnAM7isktzQPtovpHkqreBXxPzu9ybkO+bAezxYd+ZsJeN1LGzV85XwLWi+eBIhZ6FtpjeEU8W7/fvxyzM2QBpD6BNlvmMSChyR4hpvBdx9cqDTNRkY3MyB+E/TcL35VLUVPjhP7zaALs6sjqX6IDE/awLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738412; c=relaxed/simple;
	bh=KhIpM3aBFMGY/oNLaLf1OZpaD6XBIBTgzFtjKfJzKTw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMz1D7LFb8I4NRwO/2t8YplB2A/yrxjcIVgsUmbcg2z9Hso83+LNLyGGTqpIDqrB4sCSSVOxBzUa/ZgH51pvfZlyApNqR5lsy+i17RFJmqFKzQc5+AA/naIGCIvBX7e8xrjynMqQuz+5R6orEWs0xz4+Fl3niPADXXEWAOkt3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=K5W+RbBF; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="K5W+RbBF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QajGHSeELTeFwAo2Vi+cAigxNZFa68v7esARJOfEGL8=;
	b=K5W+RbBF/b3OBpG5ddsT3bmnCLBLEzgyzzh300maR3q5Yzre6htvRd1h62EH0Qq8ZRLKiCyVR
	7x2r9MGY/Q4YnrsdD5+L1K+xmcJorhcRgEsexa89co6ktYK7W/JX4y7GLJ/9v16AQNEERwnh96q
	DwurhrJk6XJseic49PmwfnU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gpmXL5DzdzLmHQ;
	Mon, 29 Jun 2026 20:57:38 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3797E40572;
	Mon, 29 Jun 2026 21:06:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:06:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@HansenPartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <thuth@redhat.com>, <mark.rutland@arm.com>,
	<ada.coupriediaz@arm.com>, <kevin.brodsky@arm.com>, <linusw@kernel.org>,
	<yeoreum.yun@arm.com>, <song@kernel.org>, <james.morse@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <liqiang01@kylinos.cn>,
	<pengcan@kylinos.cn>, <ryan.roberts@arm.com>, <yangtiezhu@loongson.cn>,
	<sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>, <austin.kim@lge.com>,
	<jchrist@linux.ibm.com>, <arnd@arndb.de>, <thomas.weissschuh@linutronix.de>,
	<sohil.mehta@intel.com>, <andrew.cooper3@citrix.com>, <jgross@suse.com>,
	<kas@kernel.org>, <x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
Subject: [PATCH v16 02/18] syscall_user_dispatch: Introduce a weak fallback for arch_syscall_is_vdso_sigreturn()
Date: Mon, 29 Jun 2026 21:06:00 +0800
Message-ID: <20260629130616.642022-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629130616.642022-1-ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Currently, multiple architectures (LoongArch, RISC-V, S390, Powerpc)
provide identical stubs for arch_syscall_is_vdso_sigreturn() that simply
return false. This results in redundant boilerplate code across the tree.

Introduce a default __weak implementation of
arch_syscall_is_vdso_sigreturn() directly in syscall_user_dispatch.c that
returns false. This allows architectures that do not utilize a vDSO
sigreturn to entirely drop their redundant inline definitions.

Architectures requiring a specialized check (such as x86) will continue to
override this fallback with their strong symbol definitions.

Clean up the redundant implementations in loongarch, riscv, s390
and powerpc.

Cc: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/include/asm/syscall.h  | 5 -----
 arch/powerpc/include/asm/syscall.h    | 5 -----
 arch/riscv/include/asm/syscall.h      | 5 -----
 arch/s390/include/asm/syscall.h       | 5 -----
 include/linux/syscall_user_dispatch.h | 1 +
 kernel/entry/syscall_user_dispatch.c  | 5 +++++
 6 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index df8ea223c77b..946886794ced 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -85,9 +85,4 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
-
 #endif	/* __ASM_LOONGARCH_SYSCALL_H */
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 834fcc4f7b54..4b3c52ed6e9d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -139,9 +139,4 @@ static inline int syscall_get_arch(struct task_struct *task)
 	else
 		return AUDIT_ARCH_PPC64;
 }
-
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
 #endif	/* _ASM_SYSCALL_H */
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 8067e666a4ca..987c9a78806f 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -112,11 +112,6 @@ static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
 	regs->a0 = fn(regs);
 }
 
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
-
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
 asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 4271e4169f45..5f310caad1fc 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -89,11 +89,6 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_S390X;
 }
 
-static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
-{
-	return false;
-}
-
 #define SYSCALL_FMT_0
 #define SYSCALL_FMT_1 , "0" (r2)
 #define SYSCALL_FMT_2 , "d" (r3) SYSCALL_FMT_1
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index 3858a6ffdd5c..73d69e02807d 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -10,6 +10,7 @@
 
 #ifdef CONFIG_GENERIC_ENTRY
 
+bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 			      unsigned long len, char __user *selector);
 
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index d89dffcc2d64..acf545774d37 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -32,6 +32,11 @@ static void trigger_sigsys(struct pt_regs *regs)
 	force_sig_info(&info);
 }
 
+bool __weak arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
+
 bool syscall_user_dispatch(struct pt_regs *regs)
 {
 	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
-- 
2.34.1

