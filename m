Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121F1F37FB;
	Fri,  4 Oct 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066154; cv=none; b=n/ucibU6O94UW+UOxCT5Dd2pj07cgVAHjjBv6qMp6yYE9jUD24r3+/V8jOvYcxTtzK7Rdvo0TMSeLRRJO+FuQKv4G2TelY0g1am/Xt55XdM3SWeIOwTXLLZDVp7jIzdqaKxu0GMYdBZjfZ1wFeU8/MtPOGnQjEz8JZRPT9IpPvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066154; c=relaxed/simple;
	bh=JpNjf2MSBYucpxgL9lA98UJxvh8wQgF14j7ccqK8ZlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSscc/PKCvt7vx44Gp9oPv1StRyfpqW7nnDPK6U5Lo+m2NYVot9vjAn8U4vxqW3HjLyyMVES5G8TRdqmhHxvWe5G2QlyWlBhG2UWmv42QQ3Y4xtxtP5m44956/Ah9DEWvuiPm8hBVgqwQlvI4Vy3/paN/6ybatZQZDJaxsZsnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3CQpuHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3CQpuHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24956C4CECD;
	Fri,  4 Oct 2024 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066154;
	bh=JpNjf2MSBYucpxgL9lA98UJxvh8wQgF14j7ccqK8ZlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3CQpuHRlPgViq/OtjolJg6889tdm8nWXcy9K7IwBGc8wJbSH/u1YwdeColdKVq4s
	 mOIlzdjNWIi7rEITzttD/6diDCMrTbucwvazbz2NWy1hBf7oxxu4AaAul3zJXKw3QC
	 3d2IaPD85gm+uZ2V5ZlQ8E4JRkMPEeGEz+UgUGEtuLQeVb4xgw+tOfEyEcjBWiktE7
	 jVKJiY2OShVu1uqQiW1Md75BCpgK6d+BQqhSVZdszboAYUIAPxY7X5yyoS5Q+gFglo
	 Mcx1ekATtPsD4ug6EjppZXBGOZVCwW/dzMRaxqmLIVJcmHu5qJfYOi7V1NK15u00Me
	 HBYVz1oMwKrEg==
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
Subject: [PATCH AUTOSEL 6.10 18/70] s390/traps: Handle early warnings gracefully
Date: Fri,  4 Oct 2024 14:20:16 -0400
Message-ID: <20241004182200.3670903-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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
index c666271433fb0..2c0729e34f6a3 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -176,8 +176,21 @@ static __init void setup_topology(void)
 
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

