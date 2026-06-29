Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB13407CD8;
	Mon, 29 Jun 2026 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738463; cv=none; b=b68prMxLFu+N2m9zLiQDL3PB3CndAWtTouMM83tAZKYpAJXlUtmxyCtL0D5PIYV6HEuduN2WYChj87UCleHI8Xdew4AlcFsAv2Fpy/vnZaEs2ZGGUSo1B8L1kr8y71C80bYtzaiNjTv1mDtbzTg/U5X1jZSPjyg1riNemenIhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738463; c=relaxed/simple;
	bh=f0TQLiH8xim07Y7RucbCEKU4cAJ4PrukQpe50zlWasE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RILCE6Xle/dO09NZxeiWaUxpDNibE8rcQk9OzEh+sTXjqcXh7dGaSEMvcthVuClAZ7Qrr2HVDnXmSNxNOu6yWunP7qoKe49OE1ZWc8iQniEE9vZ9ip9XidKZZ9jNte4mR0jR3tbo7t2qgCcaMMyxYciNHmWBi/PgzHrl5LYTEj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WOSDlhXC; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WOSDlhXC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2sNn+EhmZkPBnxB5RQNDtHQcKZyPX1Y9+NQI7nSKf14=;
	b=WOSDlhXCtKSH9DuQjQF7cN7xo24WszR3BWM9oku/cs7+saNJ+E9vPIIg/8CLYSaNprTRXxF7A
	hEdudLHYk8HD7RmzXNu55qhb9nXz/Ltq92CIWHTtxa3KkGjW/uQOvRjsjjeEpCF/QRk1Rs1R7/e
	KTNbN8PrEwYPo0zlJjtVoUU=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gpmY93S2gz1cyT2;
	Mon, 29 Jun 2026 20:58:21 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E40040586;
	Mon, 29 Jun 2026 21:07:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:07:24 +0800
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
Subject: [PATCH v16 12/18] arm64: syscall: Use exit-specific flags check in el0_svc_common()
Date: Mon, 29 Jun 2026 21:06:10 +0800
Message-ID: <20260629130616.642022-13-ruanjinjie@huawei.com>
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

Use exit-specific _TIF_SYSCALL_EXIT_WORK mask to filter out entry-only
flags during the system call exit path checks. This aligns arm64 with
the generic entry framework's SYSCALL_WORK_EXIT semantics.

[Rationale]
The current syscall exit path re-evaluates the thread flags using
the global _TIF_SYSCALL_WORK mask. However, _TIF_SYSCALL_WORK includes
flags that are strictly relevant to system call entry processing:

1. _TIF_SECCOMP: Seccomp filtering (__secure_computing()) only runs
  on entry. There is no seccomp callback for syscall exit.

2. _TIF_SYSCALL_EMU: In PTRACE_SYSEMU mode, the syscall is
  intercepted and skipped on entry. Since the syscall is never fully
  executed, reporting a separate syscall exit stop is unnecessary.

[Changes]
- _TIF_SYSCALL_EXIT_WORK: A new mask containing only flags
  requiring exit-time processing: _TIF_SYSCALL_TRACE, _TIF_SYSCALL_AUDIT,
  and _TIF_SYSCALL_TRACEPOINT.

- Optimize re-evaluation check: Use _TIF_SYSCALL_EXIT_WORK inside the
  el0_svc_common() fast-path block to prevent redundant exit work execution
  when entry-only flags fluctuate or are synchronously modified under
  the hood. The outermost gating maintains _TIF_SYSCALL_WORK to preserve
  architectural entry-exit symmetry for tracers.

- Cleanup: Remove the has_syscall_work() helper as it is no longer
  needed, supporting direct flag comparison to clearly distinguish between
  entry and exit mandates.

[Impact]
Unnecessary exit tracing and auditing processing are safely bypassed when
entry-specific flags fluctuate during the fast-path re-check block. This
safely streamlines the syscall exit sequence to mirror the generic entry
loop behaviors without breaking debugger expectations.

No functional changes intended

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/syscall.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 6de1fe281d61..5dd94bece929 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -54,11 +54,6 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	syscall_set_return_value(current, regs, 0, ret);
 }
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
@@ -95,7 +90,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		return;
 	}
 
-	if (has_syscall_work(flags)) {
+	if (unlikely(flags & _TIF_SYSCALL_WORK)) {
 		/*
 		 * The de-facto standard way to skip a system call using ptrace
 		 * is to set the system call to -1 (NO_SYSCALL) and set x0 to a
@@ -125,9 +120,9 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 * check again. However, if we were tracing entry, then we always trace
 	 * exit regardless, as the old entry assembly did.
 	 */
-	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
+	if (!(unlikely(flags & _TIF_SYSCALL_WORK)) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
 		flags = read_thread_flags();
-		if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
+		if (unlikely(flags & _TIF_SYSCALL_EXIT_WORK) || flags & _TIF_SINGLESTEP)
 			syscall_exit_to_user_mode_work(regs);
 		return;
 	}
-- 
2.34.1

