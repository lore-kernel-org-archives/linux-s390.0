Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15842FE0F;
	Mon, 13 Jul 2026 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783914864; cv=none; b=KDzXE7muWiIP4VUQs0i+410FPwCRMI+JGhqHBDZCcutCRCPJRj2hMVnY7E0s8IwmPh/rVM58ZZyDWqoHNYIyfUcP70UpCSnpzd430pvAP7Mhqhv4dN68j/YAH5veKJw3h90ntW5nFWzb9+MlNi/m51FNLZXxg+owCvgJecIpQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783914864; c=relaxed/simple;
	bh=xoVEx/HC3IncUU0hoh83dAvnFkuhHxVxkOOL4kk1kVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ak+ftp2UnYuEKJnc216CkEj/iVIDYOvRZLMhefNDRZgE4oQ0kkL+09jtNCXug3l6svhPuhWAiz7E6XSKDGpnUEcNy152XL8rNpo5NXMciv285+YJxUyrzJe9d0nHkvMelAUf5yEUbFjyaTrznXvEHr/POfHB2CFp3G/Amu5qNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EHSxG8IT; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EHSxG8IT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Wll8mTLBn9B2fPK9pm24mOajugHT7OtRM0GeQhTtfeg=;
	b=EHSxG8IT53N6k+cl2pDQ/HnOvdvCXTaXD5Wu1EI7I5nfI2mEAXDXd3NzfNSDRc23QAHsZL9OK
	18UrkbYTp1rtOo5ehYoaYcq+JhN138Umz5lQOKl81MDZhFz/A5xndUvG09QEDEjbHiu4F/kVhpq
	6xZtSFLFEo2Rih9MgpKl2ho=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gz7ch73wrzpT0s;
	Mon, 13 Jul 2026 11:45:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 9517640561;
	Mon, 13 Jul 2026 11:54:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Jul
 2026 11:54:11 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alex@ghiti.fr>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <nathan@kernel.org>,
	<kees@kernel.org>, <xur@google.com>, <arnd@arndb.de>, <peterz@infradead.org>,
	<gourry@gourry.net>, <lukas.bulwahn@redhat.com>, <ryan.roberts@arm.com>,
	<yangtiezhu@loongson.cn>, <mchauras@linux.ibm.com>, <sshegde@linux.ibm.com>,
	<austin.kim@lge.com>, <jchrist@linux.ibm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH RESEND] syscall_user_dispatch: Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Date: Mon, 13 Jul 2026 11:54:22 +0800
Message-ID: <20260713035422.582771-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Currently, only x86 genuinely implements and supports Syscall User
Dispatch (SUD). Multiple architectures provide a stub
arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
GENERIC_ENTRY compilation, which creates a false impression of feature
support.

Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
stub functions from other architectures.

Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v1 -> RESEND
- Define missing ARCH_SUPPORTS_SYSCALL_USER_DISPATCH.
---
 arch/Kconfig                         | 4 ++++
 arch/loongarch/include/asm/syscall.h | 6 ------
 arch/powerpc/include/asm/syscall.h   | 5 -----
 arch/riscv/include/asm/syscall.h     | 5 -----
 arch/s390/include/asm/syscall.h      | 5 -----
 arch/x86/Kconfig                     | 1 +
 6 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d2dbed524f15..066263cc44fe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -114,8 +114,12 @@ config GENERIC_ENTRY
 	select GENERIC_IRQ_ENTRY
 	select GENERIC_SYSCALL
 
+config ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
+	bool
+
 config SYSCALL_USER_DISPATCH
 	bool "Syscall User Dispatch"
+	depends on ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
 	depends on GENERIC_ENTRY
 	default y
 	help
diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index df8ea223c77b..d9275010f548 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -84,10 +84,4 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_LOONGARCH64;
 #endif
 }
-
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..f3f8ad107eeb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -335,6 +335,7 @@ config X86
 	select SCHED_SMT			if SMP
 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
 	select ARCH_SUPPORTS_SCHED_MC		if SMP
+	select ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
 	select HAVE_SINGLE_FTRACE_DIRECT_OPS	if X86_64 && DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config INSTRUCTION_DECODER
-- 
2.34.1

