Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DF443E4A;
	Thu,  3 Sep 2026 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421296; cv=none; b=uiv6RVliVwaDMha9+6y1ydnP5B5IIuzU3V6hIab/GVwrc9HMFz+0BU4R5MTLL1/fn6BR1j6ejwZbUPxf30+y4n9LaigEU4wCnU7N2Va+CMjzMFHcSRBweKqaZnohbU7gTUP1VZiC3KmGrxT6pbJQlF0RW/RRysBfqXQi9aN3xrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421296; c=relaxed/simple;
	bh=0OrggZCxf341yuayoYgLFkIud/BbXPm8wUo8eswQB68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWDQmTIa3Nlzz3jLoEfgZyGEQhaWFLUZsn37rKWOeQpleaw2jv8qEnfJYPfnFAnXoXDDwYkVJdQoKqvnvSCKNHw/VtpyKoehcAXM5wrp/1JKZIJBxwKDTaHnecucgSHNh/Dj4IQLI76WxXZwQ53P23iOZWZfK5sGzLNwZK9gHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRAktFNX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rK84N3Jl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRAktFNX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rK84N3Jl"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ki6vCDtSsDDzCEZI/NcbNJ3KgWETZe+Z10mKdQ4zEk=;
	b=JRAktFNXxfqlu91+k0T2FMDT4dsLDIeVGQryd6RNRQsuL46sy/f9GL5vDjkZKQ30As6CcG
	y4jIxtHNpGkyX+UhGpiNboqpvEodSBecEITblgygLwQokeFFzkr4Ll4/Kox4gQrXToVFIp
	kon8oSRUeQS9RYhfREsXXYvbviB3VOFMEYbPe44WYPcSnEZuE7YOVTEGDeSAcTLSfytBB2
	JOTRwiImSbzXdhs1ON3fmLAM3LhOaWZKK8smMIzsqPrz2JndfdBbQN+CbPhNhe8sM/Iz6b
	eANcYhOIf4zoYbsM667zurVliaQFBYG8cKeHkcXVNim7ooOJoagfrjvMhfBmMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ki6vCDtSsDDzCEZI/NcbNJ3KgWETZe+Z10mKdQ4zEk=;
	b=rK84N3JlIpaV6T1bzwKE39uGn8xsTCz7f8WrxvWFFv+kVDj8BN/3RvEkemb1aT2Nkwh7du
	noB85/lLZP64wTAg==
Date: Thu, 03 Sep 2026 09:41:22 +0200
Subject: [PATCH v2 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-7-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
In-Reply-To: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Andy Chiu <andybnac@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1597;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0OrggZCxf341yuayoYgLFkIud/BbXPm8wUo8eswQB68=;
 b=zhOmyJcp+hUlpRYlMOMkNTdyZ8WTdo37I7acj8KYZ6OLWoNxxSsviLjOF6r/Sk08e+CLGGGht
 PvbTNZ2WTwDAQepQqfT+Q6q1+uLkzHf02DaJ7pId4DOxwMaHCCDF5eb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv
Reviewed-by: Andy Chiu <andybnac@gmail.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/riscv/include/asm/auxvec.h      | 13 +++++++++++++
 arch/riscv/include/uapi/asm/auxvec.h |  2 --
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/auxvec.h
new file mode 100644
index 000000000000..fb4233445276
--- /dev/null
+++ b/arch/riscv/include/asm/auxvec.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ */
+
+#ifndef _ASM_RISCV_AUXVEC_H
+#define _ASM_RISCV_AUXVEC_H
+
+/* entries in ARCH_DLINFO */
+#define AT_VECTOR_SIZE_ARCH	10
+
+#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index 95050ebe9ad0..0a725f2aa2e7 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -33,8 +33,6 @@
 #define AT_L3_CACHESIZE		46
 #define AT_L3_CACHEGEOMETRY	47
 
-/* entries in ARCH_DLINFO */
-#define AT_VECTOR_SIZE_ARCH	10
 #define AT_MINSIGSTKSZ		51
 
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */

-- 
2.55.0

