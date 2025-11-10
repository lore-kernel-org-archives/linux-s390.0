Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF63101D3
	for <linux-s390@vger.kernel.org>; Mon, 10 Nov 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781360; cv=none; b=B7j78To9Ije2cKqC2qvrReSFsg5VOMuD5rujOZdg0aF76TW+KiZPMYtqEKtFcb+elzeEBy0ckwqrfoGBKUpQ3A/P8ywSr+5XIjBWSvhxxAgfjBcADqwFEDuoSx9DY8WBdm0u1B/tV2gdCE+0Ii3G9gqDL8QZdzyD3YXcqDeZjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781360; c=relaxed/simple;
	bh=zYepKhINTdx3cLOvwGeszHra/lG8KNEXE97uI0WJVDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIhaXpGvJc21talwr/cWCW0zmDY4wDiKV+qJOp15CNYa229JUVKUHiKMH84NPQsc8HBKUHlgnOjDY6qFNbs/xqhAjq0P5Cx4dQ3WUHSgpIx7ATUGomtZseI7dSG3Aq/hl0PbtbCtnksy7GfgdHGfathhwUWfR2jjhIOaJNW11/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qo8768C8; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qo8768C8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762781356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeZJ+jbR8/W9OWxk5IDd3y5+uQTQiwiDSB0XrGHvajI=;
	b=qo8768C8X21mw9aLYZ13u14D/Q4T4JSzO9I3tnewe9BAMgC8zWgjmZCz7KONsJYjR7dZU6
	Nhtpc9hkODRIQ/OaIODiJmRxgvAOkgIqfpbsPpANT2BNyeC1v58rrOyiWoJ0f2G7wkvx45
	p1yGatrt7lU+Jb0TRjoOtlPfox22kSw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] s390/kdump: Mark __do_machine_kexec as __noreturn
Date: Mon, 10 Nov 2025 14:27:53 +0100
Message-ID: <20251110132803.1520-3-thorsten.blum@linux.dev>
In-Reply-To: <20251110132803.1520-1-thorsten.blum@linux.dev>
References: <20251110132803.1520-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

__do_machine_kexec() ends by calling the non-returning function
disabled_wait() and therefore also never returns. Annotate it with the
__noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index b6b0a85816f3..6de5e0fde49a 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -224,7 +224,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 /*
  * Do normal kexec
  */
-static void __do_machine_kexec(void *data)
+static void __noreturn __do_machine_kexec(void *data)
 {
 	unsigned long data_mover, entry, diag308_subcode;
 	struct kimage *image = data;
-- 
2.51.1

