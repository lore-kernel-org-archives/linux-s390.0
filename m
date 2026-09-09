Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778646F489;
	Wed,  9 Sep 2026 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943910; cv=none; b=P6l7fUATJsXzBGopVJtgkgBwgrSzzPsjlxMfkFRFXg09Mos84KT7vwmPVktMW/k1LdJUfXB349UvNBmGLJS0Zhb/isYDo0b74OKhnW4QQhMmfZ1QnHwJ3uYJ3JPd1QN3jHyVVG9Zjw4OPmO8PVR1tMe4yBuMN9dEB94S5IFIQx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943910; c=relaxed/simple;
	bh=C6Fh+EQTCyl+s4g26T56GGCWX2U0MtHr/51cTDgzY94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuNZ9HqSfrq0aHrFG+HEcijd5MGJ9JHg4rVYKSGp9Sq76RY+MufF5UxXu8MXbF+KXNrNJ5TxPMHkCTlNABARxlrE/L0uPDgISvfoAsY/WOmgb54WjvyrK27/L84ZsVFRKwT9p0CxQiSZ5DD/dSwdqjI99to9D0p+sLR7qtBcfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2EgP00A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xg6fz2Oa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2EgP00A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xg6fz2Oa"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2FjQtlKuBRuzu4eO4IKv/TzmPoMG616xBuEpp/c8bc=;
	b=n2EgP00AGy2SQ4LhsPxtPFcrw12hi7WXrNw754S6JRZX1HFzsFe/pseBtP/fjyxUDKlDOn
	/Fr8WjmdlV9A0IGs3lUqPsFYY90n0IUQO5Hj6p21mT64kGEeGvGWuuTZPU5n496dF5M7Ms
	bcj2yDheQqOg+7JhGM0FJ/PojVqBQlQW3GT/MdnO6PBZU8yiPKLKbUCbTSyjQaawwkWvOc
	ntK+a7n4xZNVoAH7QQ2Ttqq2cchue1vDh0sAmhWeszDfCSPhAGfnZTc/nOs1yEvWMAnfNq
	/wvAMUyqxwWoNSKxuUocyo7gSfJX3HzwHWhwoB/5kRRfZSdUz+uRcSaJSayGqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2FjQtlKuBRuzu4eO4IKv/TzmPoMG616xBuEpp/c8bc=;
	b=xg6fz2OaJ/Xk4FVyNOThVXZ9GzDXOqKv0ZM2svim1anJaDd8tHxGt6Dcu201EiLHS+ELJL
	/Qm97XTr0L3JARCQ==
Date: Wed, 09 Sep 2026 10:51:28 +0200
Subject: [PATCH 15/15] vdso: Remove __ASSEMBLER__ guards from vsyscall.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-15-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1972;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=C6Fh+EQTCyl+s4g26T56GGCWX2U0MtHr/51cTDgzY94=;
 b=/pF3AoTQzmD4pEP7pZqPjpk1T5eSdh8cNjifxUmXeKgAF4pL9mdehQYC/Qro0bgZ/bG3BCQbX
 AwbkyNhcCofDs37bRkBnMPJkPmAKCpz/Hs/RJAXHs0uvQGQmO5ufIiW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These headers are only used from regular C code.

Remove the unnecessary guards.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/include/asm/vdso/vsyscall.h   | 4 ----
 arch/arm64/include/asm/vdso/vsyscall.h | 4 ----
 include/vdso/vsyscall.h                | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index 14f2ea9d8640..b97dda100e52 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
-
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
 
@@ -14,6 +12,4 @@ void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 }
 #define __arch_sync_vdso_time_data __arch_sync_vdso_time_data
 
-#endif /* !__ASSEMBLY__ */
-
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index 7d9d6bdd58b2..7c46c37fd36f 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLER__
-
 #include <vdso/datapage.h>
 
 #define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
@@ -19,6 +17,4 @@ void __arch_update_vdso_clock(struct vdso_clock *vc)
 }
 #define __arch_update_vdso_clock __arch_update_vdso_clock
 
-#endif /* !__ASSEMBLER__ */
-
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index 29dd4e097220..af62bbf04eac 100644
--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -2,10 +2,6 @@
 #ifndef __VDSO_VSYSCALL_H
 #define __VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLER__
-
 #include <asm/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLER__ */
-
 #endif /* __VDSO_VSYSCALL_H */

-- 
2.55.0

