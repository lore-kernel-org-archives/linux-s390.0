Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DFF47C0F7;
	Wed,  9 Sep 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943909; cv=none; b=cIYe86svZyzk26ViCzULbcVA0B66/dEXSk98vjl/GZM0JDc8NH2Hxb7GzPWN3kvlOfEJ3PTbONwrKF0ucG6CQXU2lis72TXninQF7/x6R+E0hDaAwnJQiWgYVCtbXyisi7g3O/veEY9/hlBhZRHuusbFJgnVE5JTzdvrkWmgvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943909; c=relaxed/simple;
	bh=gLJEWgigGyJ7XawvovjYyQOfwIjsfDH42RIEWGgskXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGcfyYG417TrH+mgye39aaKb6PM1BDInR+Od4Y/MYHfhbW/AtLlB2l7d1AqMM2kwDn1qLGHcpKN8ePjXOVGu7lIOoLk9Y3G6KOH4lybY2Exmt4Dm+2JLS4TRkEFAqTVMCPshBxmGgEQyJCtME/Nsm6G8rInCMjbCjsoCSE3ggd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OuwvPY70; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRCjo4pp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OuwvPY70";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRCjo4pp"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788943886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRBWj4mHSE+gknjapqdIxCDI+b+DaeaenxvpulsS1K8=;
	b=OuwvPY70bFMkqtB5jpFaHm754bhGKnxYjRFqeq/NxUHsAi1S/l6DON/VFVG35d42rblTYT
	q6nPgppRoUf2NTOIeO19SzWG1Dgirc42Owbs6GVYpb3JRlXE0lZTUWmbSpdYa/IMY0+PSQ
	BpBSXtapXIZ3mUdmnI6qABHQMVSFVsywYuuxu2WTq380Uq/f2FD3rHQ+6dci7c5FY4beKt
	spLLl3asON8tW8f3/yj9ohsCwkhsjD3en/x7SdI5zE8pzWRPc5klauC/Draw/Ok6Tk5WgX
	qeDqlDtCTn4HBCSILi54ACQICpWadAvqQ4UBqYOAtZWu1+JDURIbjPxybYHzSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788943886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRBWj4mHSE+gknjapqdIxCDI+b+DaeaenxvpulsS1K8=;
	b=wRCjo4ppx3NZEr7blbkSnFDjUNREZe3LWFNZiakgUojTuDBVUpaNXO4d+N8RwyHc3AJBN/
	Awf+ktdqmalyM9Cg==
Date: Wed, 09 Sep 2026 10:51:24 +0200
Subject: [PATCH 11/15] arm64/vdso: Delete asm/vdso/vsyscall.h inclusions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-vdso-asm-generic-vsyscall-h-v1-11-63ae856cc659@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788943875; l=1045;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gLJEWgigGyJ7XawvovjYyQOfwIjsfDH42RIEWGgskXM=;
 b=dXObFU3KxzH9K1ul1RZRBGrqGW/wDZaQe1dxCAARQqeFJPUhpOY3RLhbeefuEg4MBu550yA8g
 Kiuma1H8fEGDwbk+wuxsy/poBd6Gxu2/vVk7ernHzK4zAYbhLyYb6VM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The inclusions are unnecessary, remove them.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/vdso/getrandom.h | 1 -
 arch/arm64/kernel/vdso/vdso.lds.S       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm/vdso/getrandom.h
index da1d58bbfabe..d9b9104d4ea1 100644
--- a/arch/arm64/include/asm/vdso/getrandom.h
+++ b/arch/arm64/include/asm/vdso/getrandom.h
@@ -6,7 +6,6 @@
 #ifndef __ASSEMBLER__
 
 #include <asm/unistd.h>
-#include <asm/vdso/vsyscall.h>
 #include <vdso/datapage.h>
 
 /**
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 52314be29191..6334ca0a7673 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -11,7 +11,6 @@
 #include <linux/const.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
-#include <asm/vdso/vsyscall.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <vdso/datapage.h>
 

-- 
2.55.0

