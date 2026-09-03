Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C289463B8E;
	Thu,  3 Sep 2026 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421303; cv=none; b=YUib1FVRkB4SJCQ3QkUik2yKX4gbDgUU3tB8A163eoeUmvWnlw3vPC/bTXV55+H0o3yP19HT2aozOmQgawWtwKCAYmGD2RTkYbDqOAKuNBxz6OxasMsR9BwELELB0V2PqurOoZcvLOKCSJAnInjDDUiG7NB4mRx6OAleAFmFmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421303; c=relaxed/simple;
	bh=h0d3/9vi5+RkvDv34sEYqTWGje2TjQ5iv2oSp1yFOKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4NiVlmG5TJ4jC+b5t7d34vfUZoKJDzkPgGpaky0WAsoSWDQSXq1hGJdRa+dAJaxGzHfxLB0M1ZPKOxjXZPXzrmk/AGSHloFtGvR1PORCzsrVTv/fgfAagqVUExA4GUho3/hkKleuPuffRPGQ7vNBGYCNAMJuUXFWiiaS6eEKFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2n1aEsew; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=amGLpWRC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2n1aEsew";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="amGLpWRC"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788421298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aZut8kA+4chJGGwM3gCf5+HQ533NpmMKcsyR+MQing=;
	b=2n1aEsewcEY2O/4HmcehE0YE0VieS3W2Gs7Xi6wKvR4tHUFLZZdAgWR7QSYOOUkhJPQYgK
	Kf2YukB5g2gEpDitBxuqTpqVK1ts0CgTyVz6Ft/ZacoKjUo1xHG5dq9fA1bxtdIte/vSMa
	58oCWjCpgyI39K14Qkp11rzvyd7YXsrvwZGArqXZ/wa7XZbFvsNdzIviRN6F3eu02VelMS
	0IR+KoFKvbjgJLQBuTr2jCrJ0mmGsc4gS7EcrDz4+L54rrwo5R2h8w1UoisMF/Lh8uc4m0
	RuqlyQoxX8m9GiTcSRlUh4IIaO/IBeLdHZwcZlUEiN865f/h5LeGkrWqIAfMTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788421298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0aZut8kA+4chJGGwM3gCf5+HQ533NpmMKcsyR+MQing=;
	b=amGLpWRCPzszmWf2agPqW3Fg7V59XzpRILVaIxSaD3ICIskVDU9Cfpi1H6/i1xn+cRW6Jq
	FawyH8+8sQE1GjBg==
Date: Thu, 03 Sep 2026 09:41:30 +0200
Subject: [PATCH v2 15/15] auxvec.h: Drop fallback AT_VECTOR_SIZE_ARCH
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-at-vector-size-arch-v2-15-5bc32a71e3d8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421286; l=772;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=h0d3/9vi5+RkvDv34sEYqTWGje2TjQ5iv2oSp1yFOKY=;
 b=JaGBRkuyra1orRqWHzX95kpMA0xW4S8rfsJ0pler5rGlI0La87KEeut8woUGbU1ptSxEISgz0
 Ljvg0UEOZ/ZBH8ervfYSiUK0bZeaLfogWTUGiQhqsWdwyQWXx54SvJ8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All asm headers now define this constant.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 include/linux/auxvec.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
index de1c33c4a256..f7ddea1dbc8e 100644
--- a/include/linux/auxvec.h
+++ b/include/linux/auxvec.h
@@ -9,10 +9,6 @@
 #define AT_VECTOR_SIZE_BASE 24 /* NEW_AUX_ENT entries in auxiliary table */
   /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
 
-#ifndef AT_VECTOR_SIZE_ARCH
-#define AT_VECTOR_SIZE_ARCH 0
-#endif
-
 #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
 
 #endif /* _LINUX_AUXVEC_H */

-- 
2.55.0

