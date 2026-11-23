Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426654;
	b=knAIprg7/XHb4dJDCYlf9+UiSr8GWRfpgJGn1YUx6RWXLRTU8rEj442zrUkPSw1+M3po
	 RL73H7tZZ+044KCb5S02jIvojCgVXNKL7ym5wl1PFEotijIsLb9wWk1tg538f5IBxxThW
	 ynFlwYE7uTXLmw9HlLh07aA8GUYJxwnKhXi2vJz8EltrkI7EP1Fro3JJauNWWuEMovLtp
	 7zXMxjqcvn1dKKKiIaukn/T+5rR/sY7rD4L3RKo5rMsTIE3q764/4cmY2ZyeR8LJ/ET+G
	 mXNNdMTR+eeiDmueUWngtIMHnySFL4wCeTv/5bMKQr2P2beb/8R5RzQwOAjA2SeRaxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426654;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=wyQVJDn0J0MtFHgb5Qr9bVYS1xHAFGjzONhCtcrDq0g=;
	b=tw8OVrkb+Jj9DmhnDAcicCYwGRXPTBtXJ1nuK2V4EYMjLO9/rssjmbjDM5/GugNyVQ1e
	 6/d4cufYk3MNu0odl+FhN06rpl5kep/WuPhyB+yLjTULWQIVg2NdLj1K8S7jHpOtSaix/
	 Ka4DEIzv6zMAAevnQKFi1/1B1azAe+ICx916gLrsTyBnVQDv0w1I8Afu3WTIbgsUQ9hnV
	 zU7h+7K7QOWNH9F0hQPfMvYuyAnIVBz765QtWiON/gr3c63PUnKKO9ulZ570jdEI83R9Y
	 wCZcElO2UHapw8naQVdwEIj3RUtuNtb7z4diygOJR0xFwnM64fJ2Yzp4Ag7OuZqk2Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sy6wKMMi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=EIfbqxqQ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172CD606A6A8;
	Mon, 23 Nov 2026 09:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172CD606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sy6wKMMi;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=EIfbqxqQ
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795426652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyQVJDn0J0MtFHgb5Qr9bVYS1xHAFGjzONhCtcrDq0g=;
	b=sy6wKMMiSIYJJrLVs8OtFCFEbAMDezBV33VL71jtQheALKkWfogtOtkMSo7f3iDpx1hnmH
	DCow9DPdvS16RqXtCng1RNmV+NhFA2xClLPkTLPOYfmJGRa8ojIpmcuQsaxu56R6M4Fm+F
	kWBEw+7wIe+yzmSezbHp2T0eZORxNQJkDKd/9DCeDLuJAd/R7aeaufQ9FSQHhA2EizTWnq
	xfUG5037egX7h41/8CHjMiihW5FLjTaXA3mTegbNGNV896H0etpBsr0RNnEtHhkJFChwPx
	ujWRQS8fQWadjGCep69ydOg4Axb/KfFESJIPml36wiPo21QQXQ8D1RJkrL8ZZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795426652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyQVJDn0J0MtFHgb5Qr9bVYS1xHAFGjzONhCtcrDq0g=;
	b=EIfbqxqQDY5EeJRfGC/cqaJZmr3BsSxE/bXQsnuaukyukzxhYJf5e7OI+OIDmQ4Kkwp59O
	ifnISwgD66ulBTCQ==
Date: Mon, 23 Nov 2026 10:37:15 +0100
Subject: [PATCH v3 10/15] powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-at-vector-size-arch-v3-10-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795426640; l=1614;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lq2CTgfwZG73WGl5OVl7p6mIHPWbhjx1Tz1RNRtR7N8=;
 b=bJ5A5zd3pfSWIa+VMd5QiOGWtRTF6UJscvwGWocaeSTuxYx7he2xiLti1KebdjyptmSFP9R36
 LWL13Cj7QasDcyXmn53dOiu+z7BAW25TVHWTaylnvQbJlD/oDtlC0ip
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/include/asm/auxvec.h      | 7 +++++++
 arch/powerpc/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/auxvec.h b/arch/powerpc/include/asm/auxvec.h
new file mode 100644
index 000000000000..d6c180e9ac2c
--- /dev/null
+++ b/arch/powerpc/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_AUXVEC_H
+#define _ASM_POWERPC_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH	15 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/powerpc/include/uapi/asm/auxvec.h b/arch/powerpc/include/uapi/asm/auxvec.h
index aa7c16215453..9ab5b6d17929 100644
--- a/arch/powerpc/include/uapi/asm/auxvec.h
+++ b/arch/powerpc/include/uapi/asm/auxvec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_POWERPC_AUXVEC_H
-#define _ASM_POWERPC_AUXVEC_H
+#ifndef _UAPI_ASM_POWERPC_AUXVEC_H
+#define _UAPI_ASM_POWERPC_AUXVEC_H
 
 /*
  * We need to put in some extra aux table entries to tell glibc what
@@ -50,6 +50,4 @@
 
 #define AT_MINSIGSTKSZ		51      /* stack needed for signal delivery */
 
-#define AT_VECTOR_SIZE_ARCH	15 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.56.1

