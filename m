Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15447124E;
	Wed,  9 Sep 2026 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943898; cv=none; b=HEn1yZYKd9vxmFbajQsAT88a5S3NviEUXFe4B4izL/0E7DH7KtDeFzZOsuTvCd/1y4KBeHYuzR4giXMOAikj6OOqU5jZz2OOak3tuNUIJFTIgl798o5oJawHhnxlCUg0t+c1A43A6fGdPXoraKYcuoCRRDPAoD3H6BlikWhigco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943898; c=relaxed/simple;
	bh=Inx1GMMAL9hTofIIG5CeNr2zKHZu0vdSWjUErNB5P+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbiUNSjzcthuLhF/B02d+997jzR9H3z8p+BWRRdN5Q1WejV/mhcbTvoIJq8wLO397nthhquU1T2Bmn8eb590j1QN5isTRFGTAaAj86MdN4aC5t282+B1lG9AAnNB8g+LP1EPt76hX2ztYvXVhP79zb7RCUsZijd04iMFZRb2sOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zLyb9Fwu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/A0UM8L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLyb9Fwu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/A0UM8L"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csWZa+FXPkZtKlamZnzOe5wDFOkHxV9+VSViUYlt1Zs=;
	b=zLyb9Fwu7jbI0CwCPLxrGbMAjONAtXhsvd2aOXrsZeTIM+Vd6cAkXeT/9cSCtBgc6rUvND
	gGL505R+4si2jE3aeqnbSbLIG8k98l5iRxrDYXFAKQOWMVSkZxKFlP21c6TSMA2i/iy116
	/ylwRK8HcPiR9PgT8J7h2y8C76UQ6h/hhfKtVfvGj6xJZzmOon5VHgnFpIj7kux2X934+R
	88gvKVckykd4QMY7I4EvAl22PfX5GKMA8NcVnV99WfoKqT9h3DM3L6nfOz4IF1LXAzPclD
	t74OiDujJWbszZsh0qrw62upWw14+r6iyZ4jcroh7b+1fqc9tncGYHc7XAbHiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csWZa+FXPkZtKlamZnzOe5wDFOkHxV9+VSViUYlt1Zs=;
	b=N/A0UM8L3DUA6/r4Ux30sANcZeIqXCYs4ZXEjCKOONRgT4pANRJ15Uu4BotsUrawfjPr6e
	4wH9FEacXhaQoNBg==
Date: Wed, 09 Sep 2026 10:51:16 +0200
Subject: [PATCH 03/15] vdso/getrandom: Define fallback
 __arch_get_vdso_u_rng_data() in getrandom.c
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-3-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1595;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Inx1GMMAL9hTofIIG5CeNr2zKHZu0vdSWjUErNB5P+Q=;
 b=S5UXcl0xftPFhFxyzIYGTlv2hiN5xVRt8TcojCGkIIJlfpcJoQYHo8t1Vw1w+qVFkJDkfU+DX
 KiIc9K+4lvbCboRLbKhU8xLm4rTxtAlsgsM1YN6LzOWh2SHeS6QsfsX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__arch_get_vdso_u_rng_data() is only used in getrandom.c. vsyscall.h
has become a dumping ground for different kinds of fallbacks.

Move the fallback function definition into getrandom.c,
similar to other fallbacks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h | 7 -------
 lib/vdso/getrandom.c                | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index fe12fb1fb442..cdf7b39cd349 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,13 +4,6 @@
 
 #ifndef __ASSEMBLER__
 
-#ifndef __arch_get_vdso_u_rng_data
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
-{
-	return &vdso_u_rng_data;
-}
-#endif
-
 #ifndef __arch_update_vdso_clock
 static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 2851afa9154f..6ff46549281c 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -19,6 +19,13 @@
 /* Bring in default accessors */
 #include <vdso/vsyscall.h>
 
+#ifndef __arch_get_vdso_u_rng_data
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
+{
+	return &vdso_u_rng_data;
+}
+#endif
+
 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
 	while (len >= sizeof(type)) {						\
 		__put_unaligned_t(type, __get_unaligned_t(type, src), dst);	\

-- 
2.55.0

