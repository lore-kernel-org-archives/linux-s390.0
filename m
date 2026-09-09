Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E13B47EB;
	Wed,  9 Sep 2026 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943895; cv=none; b=XPCXIbgFPfxdlYts50EArnSU2rY7mcBTgRRPPajdBjrN6xV/UJC03Pkq4EwmZDjvocxcWVLiIwgamwGY9bIuSL17kkvqXgR0LUfXz35tCnF1Aj4wUNrAN8CUz0rLWul52gUhd/v+cQIehnZYvRkSnclsPoXLl3Pk3tnZw+x4Ufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943895; c=relaxed/simple;
	bh=5Ojd0VZyBuWlT1Vlm9OCcvjNe/c3y4B8B7OiZI04IfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaCdzRXcIuAbQUrB+UYn90wxziC9kpU6GCX4PopV6IjFJf1gTKcMTeOo9dQHS1nKJXJrK3QGl0Ia21NwxcXvCCYPVViXKT7+AEvv47ssUWYRSb6HwomKsidxp9+84ei+nWbVH1bjmT4VAZVPcO+i/8S05wF7AV+KncNtC/CJVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X09Yejo/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYA/s1bW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X09Yejo/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYA/s1bW"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzQOMxzxshTh4wmqEu29Gu2VPX+xEoLqk1yFbDrb8uM=;
	b=X09Yejo/JqqKtXCBERrNnRAYA35ImQKVCAF+aSCtG2F6PKrzCaElWrLHCAxGtzr7vC7OOu
	w0HUGAq/x4Pq3gNZtO6+iPsEvOwxvPbU1eDFXpf/ovbFERZB00bGkzZGvYmYJW9ldJ+TqS
	QLNVMEHKXIz5pnTCub3fdLep8HnNx+Lwy8VwNv++2kJBMAasTB9ZIDMciuBfKiHjHkPOx5
	tC3004wXfoTPdEjwfIlJE/qyREnrsnkGz8wj1Jtp35FtBZ281kpRX+N5IgSTM4LnIdUKJV
	xZiars5kzubb+8wkquYE/jKHmF25JTco2ilJeYOEa4VaT6+D19ljJZA18zrpnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzQOMxzxshTh4wmqEu29Gu2VPX+xEoLqk1yFbDrb8uM=;
	b=cYA/s1bWs/UKgyEP7Ti0e2vw1WhICfuqGpLaEZeMxwrx7+M/smOGJv8avR0BVCzMnxs/GQ
	tXZzBptfzYAlvhDA==
Date: Wed, 09 Sep 2026 10:51:15 +0200
Subject: [PATCH 02/15] vdso/gettimeofday: Define fallback
 __arch_get_vdso_u_time_data() in gettimeofday.c
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-2-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1583;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Ojd0VZyBuWlT1Vlm9OCcvjNe/c3y4B8B7OiZI04IfU=;
 b=VGAO2rm1dloGKPPn6fG5mfwo6sz2glPNKl5GoEyuD+WCr61o80au+loFA+6grZFSc94CCx300
 8Gh0V0u0lq7CxoWtxOpnah08gZTdMGr+JgfY05geFzjXERrVbBldpxr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

__arch_get_vdso_u_time_data() is only used in gettimeofday.c. vsyscall.h
has become a dumping ground for different kinds of fallbacks.

Move the fallback function definition into gettimeofday.c,
similar to other fallbacks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h | 7 -------
 lib/vdso/gettimeofday.c             | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index a6b03cfba0e2..fe12fb1fb442 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,13 +4,6 @@
 
 #ifndef __ASSEMBLER__
 
-#ifndef __arch_get_vdso_u_time_data
-static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
-{
-	return &vdso_u_time_data;
-}
-#endif
-
 #ifndef __arch_get_vdso_u_rng_data
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
 {
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index f7a591aba59f..b867c2301d5c 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -93,6 +93,13 @@ static inline bool vdso_cycles_ok(u64 cycles)
 }
 #endif
 
+#ifndef __arch_get_vdso_u_time_data
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
+{
+	return &vdso_u_time_data;
+}
+#endif
+
 static __always_inline bool vdso_clockid_valid(clockid_t clock)
 {
 	/* Check for negative values or invalid clocks */

-- 
2.55.0

