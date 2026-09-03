Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82836459ACF;
	Thu,  3 Sep 2026 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421300; cv=none; b=paLiZ2+2gaZMdgi9DNd3TwJZ3yEmoN01zHw8BWrKs062xvqHTiObChulldu8uOe2Fimtllfba5xhKrMA2kHJaeAmLWVc1U69pTjrZwUXmJcxEUJBbzoCVmWPyv3bwKTbW8QVuGuyDcTAun+npVUd8IPr89R1tJuX5BvTVAfclVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421300; c=relaxed/simple;
	bh=BmY0rNeTgoOTIM8NoOSOBKd7iOT2/BoW3MMuJmEOpcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sly+C1TLU/pB/SY0Jzapqr00GpsWEbFsLrkAKwHPyEDQzIAvamGqy9h89x3GXSPNPQZCtWCRTspI58ot+dloCBwPRFDWEIFlH8fgYOIC3zvXBluoKNDGgb1yVn+m5NpQj/j+KeuCnG7J5rYTS+jqvXP1mCO6hMBCEub0nv70IbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A7uMxPFG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4+LXrGA1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7uMxPFG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+LXrGA1"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrAnP/C3vIIV9MfVxkKNdnam3FAI0o97+nAzFrr7A6o=;
	b=A7uMxPFGSNRKyM+CJ+qi+nH0EVA+MdWp35wphWaEq2E8+0fRn9MbLOB3YpV2ixqEZxN/yY
	o3xT6U8duMUicllU/fFzqeNAcXNYjnmbWLuP9Ch69tr76jl5AlQe3N6DjUD5g9hRhZ57WZ
	olbXOlRtqjhM3eDLMpgailyhTg1ViVGBqUv/W2UKgy4MqAlW6aRfOEnyEMEaTbcMfyg3v3
	AzKBzF8fw0Tus/oHpwhzkco2BlB0yaOGb/fhK0uWDRdoSDCtKLzR4FiKRwpXRiUZBZAdVK
	n+fwbsrReekXVse4Vgc+2+OQC9qpYeuhvgKdvyN3IcmTz6oKlgewhGS31B7Vvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrAnP/C3vIIV9MfVxkKNdnam3FAI0o97+nAzFrr7A6o=;
	b=4+LXrGA1BNsb+1bt9PPBXeYwlB5OKLjrbTPg3/JyXLOelfRU9JW6w01qpy84FUq6+qD8x1
	o8BYkU71G9JpY9Bg==
Date: Thu, 03 Sep 2026 09:41:27 +0200
Subject: [PATCH v2 12/15] sparc: Remove AT_VECTOR_SIZE_ARCH from UAPI
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-12-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=1455;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BmY0rNeTgoOTIM8NoOSOBKd7iOT2/BoW3MMuJmEOpcY=;
 b=k8LJMytIpq8a92cFKJDRyQD9G2gB9e4yHENKcxQqZFuxwyQL3K6Na9Pxjb+tfuD8ycnpiW86k
 er0SGyhyT3cByQa0pEx46UyDAAhL+iId74x9DTkTy68/ftCipnFboFb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

There is nothing userspace can do with this value. In the kernel is
always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
userspace and also changes from time to time.

Move the symbol to a kernel-internal header.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 arch/sparc/include/asm/auxvec.h      | 6 ++++++
 arch/sparc/include/uapi/asm/auxvec.h | 8 +++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/auxvec.h b/arch/sparc/include/asm/auxvec.h
new file mode 100644
index 000000000000..50c249a8bd17
--- /dev/null
+++ b/arch/sparc/include/asm/auxvec.h
@@ -0,0 +1,6 @@
+#ifndef __ASMSPARC_AUXVEC_H
+#define __ASMSPARC_AUXVEC_H
+
+#define AT_VECTOR_SIZE_ARCH	4
+
+#endif /* !(__ASMSPARC_AUXVEC_H) */
diff --git a/arch/sparc/include/uapi/asm/auxvec.h b/arch/sparc/include/uapi/asm/auxvec.h
index ab8780fb9df1..0fab3b29148a 100644
--- a/arch/sparc/include/uapi/asm/auxvec.h
+++ b/arch/sparc/include/uapi/asm/auxvec.h
@@ -1,5 +1,5 @@
-#ifndef __ASMSPARC_AUXVEC_H
-#define __ASMSPARC_AUXVEC_H
+#ifndef __UAPI_ASMSPARC_AUXVEC_H
+#define __UAPI_ASMSPARC_AUXVEC_H
 
 #define AT_SYSINFO_EHDR		33
 
@@ -10,6 +10,4 @@
 #define AT_ADI_NBITS	49
 #define AT_ADI_UEONADI	50
 
-#define AT_VECTOR_SIZE_ARCH	4
-
-#endif /* !(__ASMSPARC_AUXVEC_H) */
+#endif /* !(__UAPI_ASMSPARC_AUXVEC_H) */

-- 
2.55.0

