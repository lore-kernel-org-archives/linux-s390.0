Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC030202F7A;
	Fri,  4 Oct 2024 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066332; cv=none; b=LeMmGNEb/HST0KBITwjQbCel7fDqfbJXVGwNdy2qLvcFPQ3sU0mj3IxFlmRiwZiNStupdmUcreSKizBa6vG2bwij080wcVOYWQDqXd2UzDXrAbj6HYy2kMXWM6bTjf9ZDUNvIcw+N1rf9L8QVUFzpJ923tIBNyqGb8QTPYkioOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066332; c=relaxed/simple;
	bh=ZEJKq/ubhV1Vn7Nh2b6yEgBNxLnYrYqefCGOyXboopI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoiIPjJG01sTJNM/kB4KpGVr13FQfN+Z9g3aHmL+E+bVY8BISth8JZhrNuy4UtkwR82aJmtfodrsN8WyirDdRKnhqCnUp9C0fRJ1zAi4q/N4mEh+O4BVNK0di0zFoOgoprZLDxO9kroP67PavyY4HmWwxvaPwJTclw63OnucHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLof01CW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLof01CW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E386C4CECD;
	Fri,  4 Oct 2024 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066332;
	bh=ZEJKq/ubhV1Vn7Nh2b6yEgBNxLnYrYqefCGOyXboopI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLof01CWTq65n4hxrDLjtefwFztcJLqPuvdS9VLFhVbdk50ZA0Se+VQslVvO4ukHL
	 V/N/bqL8y7x+idDXl88PCytvXxJIsc1GM9ZZF2aIkGLkxdw1pR8d+KDsYcSTEwDC3A
	 VJzGMB9yH5WKks+dksnM8S8GU4ho/Yjp5+I3QC/CBIG7A4BZhhl979IuMngmgH9LwK
	 BhiBlWWLW9A6Fx6vs7P79XnRilN38kEaEoJ5ltOIZuohVANLe+JN6KrkKqp06wGUH/
	 4f/rqwRZxmYZVCyRRU1RoVrypcy2AhGc2LPn3oxGOymeUW7tk8j35+UZPSx+dBXq6W
	 cHA+f2G9dr36Q==
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
Subject: [PATCH AUTOSEL 6.6 16/58] s390/traps: Handle early warnings gracefully
Date: Fri,  4 Oct 2024 14:23:49 -0400
Message-ID: <20241004182503.3672477-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 3a54733e4fc65..eb6307c066c8a 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -174,8 +174,21 @@ static __init void setup_topology(void)
 
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

