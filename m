Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091F25B083;
	Thu,  3 Sep 2026 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421302; cv=none; b=PZNTJcHJiRuD5LLqeA4+cXE7iYqQB0rBMROBft2bArbaRaKsBHwAo6MJJ2X68aM70h/ZHheZ1a6WozIf5CA0IJut+aGVKSmqRlqd8DgNetaswueZ56sTonI+Z2pRaEHXSppv8mkE8v/H9cbzfbSseqXtMSL9Sif77QCygCXiGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421302; c=relaxed/simple;
	bh=YKN2r1KwV0S2heb/8Y+Jhhyff24Np1SwL0Bw1UDwB4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGJoK7DIJQDu+fj6QL1KLmfnpiYy+MfCxSbhMwRjBC76s3nP8WL5y5fpbaPS68ploHLWTVyH3KNC/D+SlURrVqT5jp16+20w11bmvYLgHU38q4VHdMP5iUEPq1wxxMihsRR93D5xy38Br9s/3OVndcSu/HDxGJMYSp9Fr90ynmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jP4Qdtf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2g2u1zE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jP4Qdtf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2g2u1zE"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acT7QjZNdUmpfnBE9uBNeofdPEPn+BimCrNJZCbn/To=;
	b=3jP4QdtfvdGKafZk4gV8HAs0JKCcq1g5wS/L1M3Qb1c7h/bp22yYQ4TGtOpk0Mr1S/c40K
	vezg61PPYZqPkMIMi0P+MeWnhIYlWcTdnwH+SRrFrQj+nHm3Q7XiGS+vPJ4prnY7NtnqS4
	Xcm7eDuut8ABcFWFXYthMXqf5wGy9Ccz9usV3DQF9udUqTs+ZSL1h0G/e/uPiHShZ/Ewxu
	mmqEjU6o4o8g1buldyiSf74wUiAqSpfnewCZQA6Jv6yvahNkaYBKs1k4bYgN+RF3gqYYZY
	9mJxAv66dqtq8g2IiUO/pUOHIbenwPQiYRyIjphamnJW3UILkPOqYRUhshZy9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acT7QjZNdUmpfnBE9uBNeofdPEPn+BimCrNJZCbn/To=;
	b=s2g2u1zE4MoDzQePYnFomJgqRmXe5nRTN2VoD8bDtfLrzofrwt3d1WEshMMUnT7M9XzlRA
	0xw/D3K/rl1yL3Bw==
Date: Thu, 03 Sep 2026 09:41:28 +0200
Subject: [PATCH v2 13/15] sh: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-13-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1608;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YKN2r1KwV0S2heb/8Y+Jhhyff24Np1SwL0Bw1UDwB4U=;
 b=useSqq1PQgc5jzt7dwdzir5U98FAJIkoH55nFNQGYdoiuFZAdgXYdssF8gR1E00nS8bRYsyyN
 V4+Vyu8LX0EAHidn3hUqdF1MdUf5WBlzeDxA5S/zQiX92l2UKGbW/Vx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/sh/include/asm/auxvec.h      | 7 +++++++
 arch/sh/include/uapi/asm/auxvec.h | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/auxvec.h b/arch/sh/include/asm/auxvec.h
new file mode 100644
index 000000000000..f0830808eb19
--- /dev/null
+++ b/arch/sh/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SH_AUXVEC_H
+#define __ASM_SH_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 5 /* entries in ARCH_DLINFO */
+
+#endif /* __ASM_SH_AUXVEC_H */
diff --git a/arch/sh/include/uapi/asm/auxvec.h b/arch/sh/include/uapi/asm/auxvec.h
index 63fcc39e2c6a..cf0f13da977a 100644
--- a/arch/sh/include/uapi/asm/auxvec.h
+++ b/arch/sh/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_SH_AUXVEC_H
-#define __ASM_SH_AUXVEC_H
+#ifndef __UAPI_ASM_SH_AUXVEC_H
+#define __UAPI_ASM_SH_AUXVEC_H
 
 /*
  * Architecture-neutral AT_ values in 0-17, leave some room
@@ -30,6 +30,4 @@
 #define AT_L1D_CACHESHAPE	35
 #define AT_L2_CACHESHAPE	36
 
-#define AT_VECTOR_SIZE_ARCH 5 /* entries in ARCH_DLINFO */
-
-#endif /* __ASM_SH_AUXVEC_H */
+#endif /* __UAPI_ASM_SH_AUXVEC_H */

-- 
2.55.0

