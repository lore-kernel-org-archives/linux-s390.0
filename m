Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5E481AA6;
	Wed,  9 Sep 2026 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943905; cv=none; b=DBMcuLXUy2wNS7j8HiuZa6wgR0O07B6Vs6WmqaPee+BQfPhLKa9jtO058WvYVWhXaB5gJ9eur0QoD0+7A1ct8BMn+p/AtEPQD4M6Ga/Txz195VeZYiZk808aj1HvYOSx8FukEYH/8IPDG+NYPpHtdHBBAGizltLzsCR4AMevhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943905; c=relaxed/simple;
	bh=XEkGmHaO9UQ15JGGo9EFCqoDzN0VZwQacIVpi6I6eho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eg2yg9wUvPIWCLXi9OAjZFYeR/1XsFIsuEJ29991iCimkjVC1vKaHDCG7rGq+h0iFDDBMRECgZ5+vpYhBm8fkOcGjOKBhpME7unM9yVfQsK9lJSByLtIrOXj33FJnjKqsLHA9g92y/VZt1Dze8py7ZeKJbnPaCNMKKt3zeYOnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fY43G6LB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fS/qMfZf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fY43G6LB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fS/qMfZf"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu21AANy6bk1mlm0NmAgLdaZdlkGyn68YRFNRQ9INwY=;
	b=fY43G6LBWdQkHYdyVBIxlLabTz9sY1wdEwbix3guUJj3EMTAlgttvjyicJzcS1byA/EYdy
	G2GOcuMDfq5geeNDnOjPbvRb7EzsEL1Clk/H8WaN0sddjYKMQS4eG0BqCIjRr0OlvTLJSN
	RN90tB/5INV6w2dlX8afOXI3xFKQezguucJCgLOZTNwjr6RY6fTr4CjhnpG2JJQfq8bTxY
	xQ1o1MTBSTdqjdBasvcUb1G+ogTvTjmpXkvfnYDAWwEY82x7oyBpb3faiydAcgcQB9K5Yj
	qx0k7QtEbJReCwJRQceG/UD512/jPmjWdRPduWsrE9i7v+i6KjtZJ5SCxfdJxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pu21AANy6bk1mlm0NmAgLdaZdlkGyn68YRFNRQ9INwY=;
	b=fS/qMfZfymFeZyXXZSlfW6pLXpcG8P6cUd3bXFewTMfnuYEoBNdNlxmu56kaFJOQgmnkTU
	azAqtLuPsNDaytDw==
Date: Wed, 09 Sep 2026 10:51:21 +0200
Subject: [PATCH 08/15] s390/vdso: Delete asm/vdso/vsyscall.h inclusions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-8-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1455;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XEkGmHaO9UQ15JGGo9EFCqoDzN0VZwQacIVpi6I6eho=;
 b=tWx5LzZMM3tFuh6dvop7MXiyaao+GWjDBE8xefvCVu+hYibUJLQsMpisPmgpEGcWAc/Wv8tBg
 BkTPk+qz6khArKF3lgV/FIsobdzvGD8+AIMA3xOqRUfKNBft+tKTA1x
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The inclusions are unnecessary, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/s390/include/asm/vdso/getrandom.h | 1 -
 arch/s390/kernel/vdso.c                | 1 -
 arch/s390/kernel/vdso/vdso.lds.S       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/s390/include/asm/vdso/getrandom.h b/arch/s390/include/asm/vdso/getrandom.h
index 6741a27199f8..ff5882f2fc70 100644
--- a/arch/s390/include/asm/vdso/getrandom.h
+++ b/arch/s390/include/asm/vdso/getrandom.h
@@ -6,7 +6,6 @@
 #ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
 #include <asm/syscall.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 0fe616c49fcc..a905f989f910 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -18,7 +18,6 @@
 #include <linux/random.h>
 #include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
 #include <asm/alternative.h>
 #include <asm/vdso.h>
 
diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
index 841daeec4be2..6bcdb64315f2 100644
--- a/arch/s390/kernel/vdso/vdso.lds.S
+++ b/arch/s390/kernel/vdso/vdso.lds.S
@@ -4,7 +4,6 @@
  * library
  */
 
-#include <asm/vdso/vsyscall.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
 #include <asm-generic/vmlinux.lds.h>

-- 
2.55.0

