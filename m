Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEF470EA3;
	Wed,  9 Sep 2026 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943899; cv=none; b=i+N1eDbtYVmfi3l1Ez2XvX8OL9XcGPIaQEid3WRUzdu/va/N1cQ/OoNvSGtBf6s7tQZ9I2pxjbEZcNgE6oG+YN1hwoBxGA1aimU0GWhkK9Z0bxSvvChNc32gqL8cPhhsrEtHuFORcpfvT9PULqfXoDQS5tUH0K20DmQXjTlaQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943899; c=relaxed/simple;
	bh=sUPCnKCUGSNrK6kUHNVPQIEZiXKtWEAStKPxMYG7MFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAVZpdNdHZaHLMmGnvEis1+qDklXRXV+sx/bNtc9S6TGS2BgM68cTTTZOozcMRezzbR8o1id2ZTHZMkZl90ccZspMl6hx/afj4p9c9zP+5WT5kmZh35+wEL/Dh2zHgns5exBC3/9Gh4ym++PZu2iH6oY52+PSnNnYI2nAZjU14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5zzVmOy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9huAc0xk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5zzVmOy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9huAc0xk"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8ISCnsd1kBgxpKDcNux5gAnw7Y6k/Yo3uUbNdp9+qI=;
	b=O5zzVmOyrKpaHp2u4bUY98lgwCvVarLkNgeAPPVX89i5JBg3rHp4+Y8F9L4P7sCCu7APVT
	Al93fxOcU0nkxzrDGMp9ojUNo/XMGidIJmj5ushFZTsVzhhH2/4847wUgewnz4odH33RCG
	rYEV6IXxTfCoYWNjLI1njWpXKiTQzh4hlJ2nAfWSRVlSvIRdZ8jZlx0oLL8v+H9qcVdvTu
	VCEGXnt6KMhztEQTNXeBUDeApxeuzzOKfXXfabG23aFg593biDM8h5sQ9dSVqWDjHQtLqp
	9TYPesEC1SSI+QAvRjLvNdyJHhqsK2SHpCmurN0Bhvkm5WRkaGF5W+rYh+i8Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8ISCnsd1kBgxpKDcNux5gAnw7Y6k/Yo3uUbNdp9+qI=;
	b=9huAc0xk9QcC4SgqamXcnykpmbUho6tKXuFLvtEqd+RfqJ7UdPuClzkoIyvHwlR5apQHEl
	EoLJQecYy/nKN7DQ==
Date: Wed, 09 Sep 2026 10:51:17 +0200
Subject: [PATCH 04/15] vdso/vsyscall: Define fallback time synchronization
 functions in vsyscall.c
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-4-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1827;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=sUPCnKCUGSNrK6kUHNVPQIEZiXKtWEAStKPxMYG7MFQ=;
 b=lrpRL87RH6Jns+QOQuU8vG+UhFyds9BwYL/rt0fjZCb0s1Oj7j4AIKDMavYVvjgkUDUjPhvEc
 T9kztup5hZYCOHnR9RnzqXUPyVZQLUeJCQxyJrgUgGCsXxKa0apJ8Bi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__arch_update_vdso_clock() and __arch_sync_vdso_time_data() are only
used in vsyscall.c. vsyscall.h has become a dumping ground for different
kinds of fallbacks.

Move the fallback function definitions into vsyscall.c.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h | 11 -----------
 kernel/time/vsyscall.c              | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index cdf7b39cd349..cfb740e82cb5 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,17 +4,6 @@
 
 #ifndef __ASSEMBLER__
 
-#ifndef __arch_update_vdso_clock
-static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
-{
-}
-#endif /* __arch_update_vdso_clock */
-
-#ifndef __arch_sync_vdso_time_data
-static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
-{
-}
-#endif /* __arch_sync_vdso_time_data */
 
 #endif /* !__ASSEMBLER__ */
 
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 12e205d86e7f..193a02d78b11 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -16,6 +16,18 @@
 
 #include "timekeeping_internal.h"
 
+#ifndef __arch_update_vdso_clock
+static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
+{
+}
+#endif /* __arch_update_vdso_clock */
+
+#ifndef __arch_sync_vdso_time_data
+static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
+{
+}
+#endif /* __arch_sync_vdso_time_data */
+
 static inline void fill_clock_configuration(struct vdso_clock *vc, const struct tk_read_base *base)
 {
 	vc->cycle_last	= base->cycle_last;

-- 
2.55.0

