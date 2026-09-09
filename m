Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24947C0E3;
	Wed,  9 Sep 2026 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943903; cv=none; b=Ee1CAZ32rJBwrvJ656o0AzjzJD1l0+Ljg4GPmpHG/himyVd7cCORn3IP30pOEntD8aJdMy6ylh7ztwbAD+dIaCYp6paKUo2yW4GW3MpzZfz6hYEyG8o++ocLBla/4l1NbU12ceZpdhieYfsGwU8oHkc5UzC4QMmQfCIU/W6Fg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943903; c=relaxed/simple;
	bh=VaPdauFQWLU0KJEV2a1f+WJtOXR8fxXaZFpswc0b434=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObUOZMpIkziVkC2FHnoc0pTEvwVUF7xmkWsD59eZYs6ckEtPskSbYXnQg7AOh6TJxJYX0RJwTPni3ezaoLQcUBiUATOZUOwAcx4yo9XAqGQ9MdC9gpQM/bAnA+eNG7+6Pdy6YuF7F9teomyWjVRFu1cPOueYAz8XvT3fkMe3FYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IdgLyGap; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VVFeQNO/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IdgLyGap";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VVFeQNO/"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ6ZZ42sEo0FMBMnZaDqvhvFmH70JPCseJfddupHf7M=;
	b=IdgLyGapCdf08hmIlLUWBy5AL4aW14xA2DS8OXFT1Zb3CfDnLbwZzDeXVhoDtbepPja8BN
	ryTtklMY2ERezCHSjJlc8z6NqAmiDSIy1DJogjFxpiZHuvKq7I5LB3MdZv9H4OozHj6Tng
	jbuQ4bPlOXu2wnT85khiyqOCKQBqOycEa8gaAjPIKxtVnd7LNbfnR49SgNv8Yl+pmxE0Ms
	s+Yl7j6gRiBR+fdcJhs4gs56Mczg7vk4/5aJnJbPl7DjBAqCEpkK7rppWwNbmLG9BrzDR7
	ChLjxpdfSnPxkp9jo/Sqv2fznf1ecuWEK6Jrcl1M/D7NpH6KpEFrKYbzuewvbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQ6ZZ42sEo0FMBMnZaDqvhvFmH70JPCseJfddupHf7M=;
	b=VVFeQNO/Qr/Vdm/q5BIomEtSc9i3kd9MK5TvsOwwjy2HYSUJfnaUQnR6L8aW7POLHXLm9j
	GGUXnc3tC3NpprCg==
Date: Wed, 09 Sep 2026 10:51:20 +0200
Subject: [PATCH 07/15] sparc/vdso: Move __VDSO_PAGES to asm/vdso.h
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-7-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1764;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VaPdauFQWLU0KJEV2a1f+WJtOXR8fxXaZFpswc0b434=;
 b=jH77Q51ITwUmOjNWzqUo9lEC+d/JgkdmQkYyv3oztNYP+7L0bV4RFQRJ0PdkZOHP7kKbcLVEn
 InKr6KCGEt+AhGlPxfVPXNdvyax8i9utdLhbRU/m9JgTxddcG4QStTx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Most architectures define the __VDSO_PAGES page macro in asm/vdso.h.

Align the SPARC headers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/vdso.h          | 6 ++++++
 arch/sparc/include/asm/vdso/vsyscall.h | 2 --
 arch/sparc/vdso/vdso-layout.lds.S      | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index f08562d10215..b17c37c8075b 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -5,6 +5,10 @@
 #ifndef _ASM_SPARC_VDSO_H
 #define _ASM_SPARC_VDSO_H
 
+#define __VDSO_PAGES 4
+
+#ifndef __ASSEMBLER__
+
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
@@ -17,4 +21,6 @@ extern const struct vdso_image vdso_image_64_builtin;
 extern const struct vdso_image vdso_image_32_builtin;
 #endif
 
+#endif /* __ASSEMBLER__ */
+
 #endif /* _ASM_SPARC_VDSO_H */
diff --git a/arch/sparc/include/asm/vdso/vsyscall.h b/arch/sparc/include/asm/vdso/vsyscall.h
index b08e0bd5e309..ff62b291e4eb 100644
--- a/arch/sparc/include/asm/vdso/vsyscall.h
+++ b/arch/sparc/include/asm/vdso/vsyscall.h
@@ -3,6 +3,4 @@
 #ifndef _ASM_SPARC_VDSO_VSYSCALL_H
 #define _ASM_SPARC_VDSO_VSYSCALL_H
 
-#define __VDSO_PAGES 4
-
 #endif /* _ASM_SPARC_VDSO_VSYSCALL_H */
diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.lds.S
index 180e5d0ee071..920396203a2e 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -6,7 +6,7 @@
 
 #include <vdso/datapage.h>
 #include <vdso/page.h>
-#include <asm/vdso/vsyscall.h>
+#include <asm/vdso.h>
 
 SECTIONS
 {

-- 
2.55.0

