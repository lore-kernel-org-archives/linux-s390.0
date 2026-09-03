Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F744A3F1;
	Thu,  3 Sep 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421298; cv=none; b=OSDyrQg2jzEuD6HT77vbzNS8LubOHEcILYRvOOq4WgBAiNQPtAL6y2b/bpE7f4Uum0gqpNVZHFXeKOQTH6gbZi5onX0RNZ53hqKARE99fMQIOl7o8IMRgeKevsEJXSeupKSGNkwMfoRvOyh4Xawnz6InMM7q1ZBLuyXfMUTKVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421298; c=relaxed/simple;
	bh=SvAg75HBK8bLtuaKgOOLDr10ibDxxL9SdBfOzzfNWls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaZiMFSUJeTLvbQcHkRARoYs6CHPbRDy1kx3l//NlZS/Rgk3Gz1ao+bgYqjCcieRqxpmYU67cbWQFTjOfK2gP6XLO2Sk0ohCgHr+jMcXzuKaDPewn5pMHZK8TNsqMQhIESUIWVVFoLOEDJc2y5zZN/TroPT2sv/n48dZ2UfNCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=APQB2vuQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kMqEoxbn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="APQB2vuQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMqEoxbn"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUcarKasoX0h99dw6M4/xD5hiQ/p+f+NjembhaSjUVQ=;
	b=APQB2vuQicLW7Zb8jMJr8A8PXWF7rS0zkF9Ri7xRZz0NsPEweiKDr7QnuZXaZEvkpJG+4v
	K4RMcVqqimnh0TCJyD8QgGasKT3klSt0i/t9LuY/5GXUbyPDPWKT/4dWU6jcyXMNbq3QSY
	tWglOGTMDhufCZNh4xqwF/KN9UqbmPUZn3x3MB/GHS1WhgREN9lSNUhpFZvq9Y8R7n4jrc
	RzUDRhuuzFI6IhveVU/KEl+OXPL1RML61ZFBzasXiEbV82Qy8nBURU/YjV1AwndNfUiRnF
	pVVKkQaJsMt+N+OB0YtlNGJkvmD9mgWghcpmB4U+XKodetrCpm8ZE1xKF4sWgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUcarKasoX0h99dw6M4/xD5hiQ/p+f+NjembhaSjUVQ=;
	b=kMqEoxbn4idATtgPsStZnSGqmHcSXU6olXd8YPdu0q+KeHi8EXRyVYj+Mj6ubqC9aAtVS4
	PHj2p3DSjWMbZIBw==
Date: Thu, 03 Sep 2026 09:41:24 +0200
Subject: [PATCH v2 09/15] s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-9-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1450;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=SvAg75HBK8bLtuaKgOOLDr10ibDxxL9SdBfOzzfNWls=;
 b=3RT19pLNWlOURXZVikzalNwkQhefjiPlou99ySXRRsmtxX0e69Nl8D5OGCHH4DyrLWTIuCnAG
 MABfP++jZRoDuSWe0OPaLheUiQwuWtT2e9LUHAy/E3h86Qgzctp8htY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/s390/include/asm/auxvec.h      | 7 +++++++
 arch/s390/include/uapi/asm/auxvec.h | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/auxvec.h b/arch/s390/include/asm/auxvec.h
new file mode 100644
index 000000000000..beaaefe12a84
--- /dev/null
+++ b/arch/s390/include/asm/auxvec.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASMS390_AUXVEC_H
+#define __ASMS390_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
+#endif
diff --git a/arch/s390/include/uapi/asm/auxvec.h b/arch/s390/include/uapi/asm/auxvec.h
index a056c4637ffc..54bbfd68d709 100644
--- a/arch/s390/include/uapi/asm/auxvec.h
+++ b/arch/s390/include/uapi/asm/auxvec.h
@@ -1,9 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASMS390_AUXVEC_H
-#define __ASMS390_AUXVEC_H
+#ifndef __ASMS390_UAPI_AUXVEC_H
+#define __ASMS390_UAPI_AUXVEC_H
 
 #define AT_SYSINFO_EHDR		33
 
-#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
-
 #endif

-- 
2.55.0

