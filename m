Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424036DA16;
	Mon,  2 Mar 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454353; cv=none; b=Q6XmaTjoDlqa2G3KdIcKTRq2AOLOPZnjrrYDx+Uu0adTsHRVSfavTz7nUXMhSpPxX+whh1bjNdAS/ZKTZh/odieczpls/hxG29vpCL76VXELdwRgTS2fRt4Ai/lq6QcVMTKn3qM3C8wmWsPwdQfx78EPA0x2s7aEQCeqQZ7gZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454353; c=relaxed/simple;
	bh=wSV5J7HzEFuS3KJbZLwjne1zxmW3zDPxdBoyG55t7aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tujOWzssvB+ebaO7TeCqbKPFN7Qy8HSXXHFILc5TqjxyTqBcUXitIRh5xfNg0t0JN6qGOSI59HNwN9zO6j4BsibTpAJCw0kbhBpldqj0MQ3El+eHC1QQl+jNd9HAu67c6CBkOzs1yo6vS/dJ8IPpYKhBYABiIltmwmaPQz7QS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHM8ly0i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M5bdRgSQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHM8ly0i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M5bdRgSQ"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772454350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGu4YUonqtswtsX27rVZnBUBJm/UklEpSAAXy65RzL4=;
	b=NHM8ly0iuYcuh7E4eVeKeGXpReTprXhsGXJI+WYqlEaUf/lJYOUtBGH2QJnSAmI3I5QAPW
	LY468YWc+wcltpXurLXAtczrS3GRRs7ErvM61alrkPsKE3X9qmMsWKbpRyDz62q6oE5QGd
	Cw8Ohv3wtKFFpU4zvThVjA5RvZbBiw4fuurA+7UNWmQxvsskDaVVA4bfSSZgB12N/2TAie
	0omDMNnN9zOIOVB7ao1DehqzId2upP6OirsIQL+gbHRxhanTRwW23vCB34naWTWXi9Htpn
	0i4DmvsTWUtmu8SNg8v9pArAePWhRXG5bmVWZWSE0NmChST4B+21+gbeLT8M7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772454350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGu4YUonqtswtsX27rVZnBUBJm/UklEpSAAXy65RzL4=;
	b=M5bdRgSQ3QlnfcfTl+A8OeDFC/IW8uhkG1G/LEw+Ak1w+mPEMp7EWeeSHFb/e7QgJ7ScQS
	t/VtnQymro8BskCg==
Date: Mon, 02 Mar 2026 13:25:33 +0100
Subject: [PATCH 09/15] s390: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-at-vector-size-arch-v1-9-a11f03ba2ca8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772454343; l=1408;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wSV5J7HzEFuS3KJbZLwjne1zxmW3zDPxdBoyG55t7aA=;
 b=DiL9Q3q9a2OSCTrfhnV8gNkfPXzhPZlr/JwJIjpZtjcaaAF6eqOl6SEEE9FmY9unQs6qSC3IS
 Tt2RIf9FHBFC64LLNTZGUWGPwKnIoYVR6wJCeubfkDRjuZzU3F/usem
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
2.53.0

