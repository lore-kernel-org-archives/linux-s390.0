Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D30405862;
	Mon, 29 Jun 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738481; cv=none; b=M4vaYKxDNm6Q/mLC6L9iiPBY5kiZZ+JekMFXkVgWfK01ifoN1od7nfXfWASbu7cXWzbUKvmiB0B4+F9cawPEG6YDH9ApjNyDUmmRzJPPWUBT6eOTxh4JV4J9Rfjv9z5Ja+CkZPvR6tWD0U2ZbphIb7oHr/Z6A/y1qsZrsIGkM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738481; c=relaxed/simple;
	bh=OdHSko/zczx8ujiWfn1DqHfqt0tTl02PWSTnINrpaRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSio+Reu0tZomNYgeaUC/HvIlMKPPCnzMRPJp9cDz4FC3Qp6KVrIPUF/iTbPdgDaI8gfNni0N+ftiTFxW1lw+4fu//6sarfeTGtq9cKl3+okhe4YZyhA9Wrtca/tdZHHdEg8PbaTXwwk18+birEoJ5ywqs8FfXXGMXXCgk+zqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=n8efmFXZ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="n8efmFXZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nXlEqg7p36Jks1c4yuaOXWFRq7Kp2sLsUwczenqjsfU=;
	b=n8efmFXZdzG/h0lZ6Y0o4MsHme01XM8L7okaKbD/TR5W3fhAEUiS3084Q2F4FbdJWy9onNHJn
	NoyvX82wTsDRv9G5PxGTgVIRQ7Jcm5Hx10ZCpPXtHg6aMkk03hx8R8iCitsSqg5zLYEjQwsADbU
	ewPWK6UfSGus42FOPWCcAkU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gpmZ82YsKznTbW;
	Mon, 29 Jun 2026 20:59:12 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D6CF40588;
	Mon, 29 Jun 2026 21:07:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:07:49 +0800
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
Subject: [PATCH v16 18/18] arm64: vdso: Expose sigreturn address on vdso to the kernel
Date: Mon, 29 Jun 2026 21:06:16 +0800
Message-ID: <20260629130616.642022-19-ruanjinjie@huawei.com>
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

Syscall User Dispatch (SUD) requires the signal trampoline code to not be
intercepted. This is necessary to support returning with a locked selector
while avoiding infinite recursion back into the signal handler.

Implement arch_syscall_is_vdso_sigreturn() for arm64 to support this
exclusion mechanism. For native 64-bit tasks, it checks whether the current
PC matches the 'svc #0' instruction inside the vDSO sigreturn trampoline.

	SYM_CODE_START(__kernel_rt_sigreturn)
	        mov     x8, #__NR_rt_sigreturn
	        svc     #0
	SYM_CODE_END(__kernel_rt_sigreturn)

For COMPAT tasks, it verifies if the instruction falls within
the architecture's 'sigpage' range, allowing the kernel to safely bypass
dispatching syscalls originating from these areas back to userspace.

Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Suggested-by: kemal <kmal@cock.li>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/elf.h |  1 +
 arch/arm64/kernel/vdso.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index d2779d604c7b..f43d4dea916a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -185,6 +185,7 @@ do {									\
 struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
+extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 
 /* 1GB of VA */
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 592dd8668de4..5a0314a3c26e 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -343,3 +343,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return ret;
 }
+
+bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	unsigned long sigtramp;
+
+#ifdef CONFIG_COMPAT
+	if (is_compat_task()) {
+		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
+
+		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
+	}
+#endif
+	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
+
+	return regs->pc == (sigtramp + 8);
+}
-- 
2.34.1

