Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D6420FA62;
	Fri,  4 Oct 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066460; cv=none; b=bMpdsOLy2ifEL4bux7nRLgmzo9cZiZ27iOQgQO3dB/XKrbTgaYO2HdxCNsRMX+farEzPJrXzG/ejzXQ04Io52uZE+OFkPS8BgV9xCjwqlyT51ADHOzhg5htONEgZ0VO7HvKz6Tyv68EhsjRaQf3EELqDTJfKOwiRWqFe/UHtOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066460; c=relaxed/simple;
	bh=22NiTlrLzqFA6vHmK8OCpWgZaefPmZnuRlMrNDQeUu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESPST1UyKePXuTZxLFKuUFj5vMxQiqTDMDOtY56XVx/BPOJ5zsXO4boaEe+oSUG/5unWB3bWe9U3D2o83Ajdqh42fDwIEUpPqKt11ajSGfgQSTb/mYGoHGC7EFc7JXlrrGgbKjasZ4D2BvtQpZdZ0zz1dJY2t5KFc1bEiIdDuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWfbmkEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWfbmkEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1DAC4CECC;
	Fri,  4 Oct 2024 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066460;
	bh=22NiTlrLzqFA6vHmK8OCpWgZaefPmZnuRlMrNDQeUu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWfbmkExz4yeVTZTPUIEABCvqsilPopqavMkgBopTu0mHQCZhRFHZVJqYJ/gz/PCm
	 /EIIvcyCt5qsXwgPPP7jiHqjbawk3ET6WQB/Tv5gMJa8chFz5pXe0hh9pUUSm0WEeZ
	 rwNgzQeE0yEEeA++AhEsgOPmPLSoJYr9IB0G4eLXUkpnocVUrSdmR4otdb7GjWsV8D
	 vT79/8IwxZLUMgwgVfOHYs82Tb5FZJoSAdBeSs3n/s054W0ZF8V31zx9lSMR0b3JkP
	 DhJYRucA1fhE7zADE1OWriWaumqSbKCbRmxLYn2oVQcwX83zo8BAsAtnVaamUcCuN3
	 0nkgjw8F3yPtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	brueckner@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/42] s390/traps: Handle early warnings gracefully
Date: Fri,  4 Oct 2024 14:26:23 -0400
Message-ID: <20241004182718.3673735-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 3c4d0ae0671827f4b536cc2d26f8b9c54584ccc5 ]

Add missing warning handling to the early program check handler. This
way a warning is printed to the console as soon as the early console
is setup, and the kernel continues to boot.

Before this change a disabled wait psw was loaded instead and the
machine was silently stopped without giving an idea about what
happened.

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/early.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index b3cb256ec6692..1dcdce60b89c7 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -151,8 +151,21 @@ static __init void setup_topology(void)
 
 void __do_early_pgm_check(struct pt_regs *regs)
 {
-	if (!fixup_exception(regs))
-		disabled_wait();
+	struct lowcore *lc = get_lowcore();
+	unsigned long ip;
+
+	regs->int_code = lc->pgm_int_code;
+	regs->int_parm_long = lc->trans_exc_code;
+	ip = __rewind_psw(regs->psw, regs->int_code >> 16);
+
+	/* Monitor Event? Might be a warning */
+	if ((regs->int_code & PGM_INT_CODE_MASK) == 0x40) {
+		if (report_bug(ip, regs) == BUG_TRAP_TYPE_WARN)
+			return;
+	}
+	if (fixup_exception(regs))
+		return;
+	disabled_wait();
 }
 
 static noinline __init void setup_lowcore_early(void)
-- 
2.43.0

