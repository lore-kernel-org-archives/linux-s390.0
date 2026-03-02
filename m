Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCC36E473;
	Mon,  2 Mar 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454353; cv=none; b=fRyn0vQ0TxLZ+TobP96baqVnmYHtSAd+DJ2/g28/D3OpR9K275RbV/VFsnEa/9fRIn51xbtfGar2IpZ7muN5+56u7rF9Pz8VI6Glx8pHrvjByw/rH4uQMjkqVSnCpLbMx5UjwMuWuqQT+6Qt1ca9CDKo3QrVu1skbLEGUt03MZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454353; c=relaxed/simple;
	bh=KhAA9NBJJtHIM22o0JEE0DI+I7SP3GR1+cUX6gC6bWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMbGJ3GxXFMVwBAZVtHJfjuU/2Yecn7lDlIIQgqAS4HvAVXO9OExryeX7WYt0r8mcwmPVQ5vPhaF/ch0yPRWxGXlXUIbdD1HtA1pAC/7tAKqamX1vq3GVg2QDmpHhMyhsHE7ZhReP7xbMdqrUhuaQ1xck5XeNpuoUDffIYVSCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCoq9RLG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvOwc5/7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCoq9RLG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvOwc5/7"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJXnjzhafvwvwcLJeLx/JDThum82eNRZ+z9+q40EfBA=;
	b=zCoq9RLGS8+8Po3hHcth4EHhs3ixn4AZwUIPixmCjgLS1Hf03Lgv9rf45OpQ6lXKNYcXmO
	x0ZUWl6+/PgitXxeWXIAzELn5d1DXLXNveRN9V3nF0ozyW2UUehdzvPfjGObc1KJJdDrL4
	nptOdJbV7CxiN74qy7BRfU4PGFVQaeTGo+XxFJnmWo0PTJnjnUg5HmCvvm22q9qyxQgeJ7
	X5BS/l8Yhy3jYQfDTK8hyatzbIIv6JfQsxytr6PIJESv6V9EwDsSq/G6tuk7rOU8/WH9fV
	LGEhauN3fOdaJMmrQI1L3e6wvuXkuiFz2uTYTcldWK1Zipo7oGvhkQShz2ob/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJXnjzhafvwvwcLJeLx/JDThum82eNRZ+z9+q40EfBA=;
	b=jvOwc5/7jBII+uejUvR7Ec31ujH98q8FcAeuuCJ+X8H4M7QnsAQzjQ0jhftKvsfJJyxGq/
	KBFXdSVINJ5ZpaAg==
Date: Mon, 02 Mar 2026 13:25:34 +0100
Subject: [PATCH 10/15] powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-at-vector-size-arch-v1-10-a11f03ba2ca8@linutronix.de>
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=1572;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=KhAA9NBJJtHIM22o0JEE0DI+I7SP3GR1+cUX6gC6bWM=;
 b=1xI34QvitdF0I83i8CIUtWdYTc0yBgqiKjqBALtMj6mhthZIMQsEaK/I9frbiDgrwa8Dyn2kR
 BAhEAkxtO/bDDzmtnODmzu2v6S9A4iYl4oRMI1eIsDxYQs6Kx5lcAWN
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
2.53.0

