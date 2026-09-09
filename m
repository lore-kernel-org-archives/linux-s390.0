Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA23B42C4;
	Wed,  9 Sep 2026 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943909; cv=none; b=eVuYvdEQi9l18obXoL43VGwUXvD3mLoNJzlb1JX4MCoHyHT+qLnURLpK3YmyC/9e/slXZZwhK3GT/QAHZwzKH15luDISnLYOTlsWjzw6j6zx3qe094LgPrc16caPqBfCh32HZS2EP7uk13E9vEbE5mL/tTzbE/XgpGemZgmrcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943909; c=relaxed/simple;
	bh=9yrup1COiXMcfGgNW5FQUG/LXYB+NuTSGZ1TprnDeUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z32hWybDrdc2hvXP54T5C2hSDUupL834IAiQQDI3kosIC9gYvxzI+TquE9Lrxe+uz6OymMsZS/Fl14xU/Z2gzFNs5rag+XF7vYaIUCjhZuZrVsaZEhdjrFy4jMLJn3DsyiLJSmYgHESYmlDhfe3fTRQZ11WV2T6aedSaWuOwqOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eqP8ughI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVX4AN8O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eqP8ughI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVX4AN8O"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Fb4eCjj+zAUQPiYalGdgIWLIgi0C9tMG4Wk6//rL0=;
	b=eqP8ughIWhO/zWHJqIcpnE1zH5Z6Uff68ylB3fNburq8lG10nepXJX4mazfWoFN07g/dX7
	5wWpfbwXq9syptiaqVr3s9+qB4IaIQrVCTAykoJ3QyyS89SBjIELA0HirxAHeEao/1LMrn
	mYJ99pvmZ+Cf8lKwtDGgAIK2wgT6AyFSHcC68XUyJBj3+gzEtXFKKntUgyQqG8N1vRRiPb
	DHx18kQ5moP+Qf8QI/7uM00WxhtbVuhIFqEZJMDAJy9seLj+k7Uvfcn2IZ5FrBhRjdrWpp
	6RfkROg5QYm6c7U22E17G5cR6V1fJGvzVdEn0cSjxT4h2w+oBW9Z6HQZd5kfkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2Fb4eCjj+zAUQPiYalGdgIWLIgi0C9tMG4Wk6//rL0=;
	b=jVX4AN8Oo8E9jDY7LdgbDqTks4Y9ztR5jIkatGeWIeYHKeeAd8NyDi0CnbjzwTRgsKH/kz
	dZEpI1oJQvAAeWCQ==
Date: Wed, 09 Sep 2026 10:51:19 +0200
Subject: [PATCH 06/15] x86/vdso: Move vDSO page definitions to asm/vdso.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-6-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1480;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9yrup1COiXMcfGgNW5FQUG/LXYB+NuTSGZ1TprnDeUQ=;
 b=8lsoI5rYTpgQdz12XqHek0bQOa8lDAtlAIBJKnJGQxBA5RZp/X59vjJa3XzdUUOBGktVHG8Xt
 hROTC4EoOEOABpAp1sl+WEhhmKISJWSG/lG/6la5vX3KZWy9RTginJR
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Most architectures define the vDSO page macros in asm/vdso.h.

Align the x86 headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/include/asm/vdso.h          | 7 +++++++
 arch/x86/include/asm/vdso/vsyscall.h | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 4e735158c1b2..071e4a262b50 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -6,6 +6,13 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+#define __VDSO_PAGES	6
+
+#define VDSO_NR_VCLOCK_PAGES	2
+#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VDSO_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE)
+#define VDSO_PAGE_PVCLOCK_OFFSET	0
+#define VDSO_PAGE_HVCLOCK_OFFSET	1
+
 #ifndef __ASSEMBLER__
 
 #include <linux/mm_types.h>
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 57598db8763b..65d10f4cc718 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,13 +2,6 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#define __VDSO_PAGES	6
-
-#define VDSO_NR_VCLOCK_PAGES	2
-#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VDSO_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE)
-#define VDSO_PAGE_PVCLOCK_OFFSET	0
-#define VDSO_PAGE_HVCLOCK_OFFSET	1
-
 #ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>

-- 
2.55.0

