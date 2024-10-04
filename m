Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8511DD873;
	Fri,  4 Oct 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065943; cv=none; b=jmMIBV+yaM1YS6ZaGeC+nj2IfJV+K7RDrk2EI2RnxX7N3b7p8PsYoVluLbLFQzvbmXFQYYMr9q0R8Hub2fuTYMFJJxWahf+3dETpGeAnWZ2g1gOVASQGCD8p1zBrtqXydVvdGswjjsgLkvdDWM7ChUcb7AJa8pTB2+VNphZRo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065943; c=relaxed/simple;
	bh=J/CJ1wHjeMBBZix/ZJOLlFTggi6BPobk8g6fjsbu52A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLKk0NfSiVpnuVOJ/BH+2oXsPyIGgCevC17kzjezpjmRFzEVHGdwE04AMpilCo9pIzEBfy8ksNUXsEygtYSAotVdtG2F5MxWMFnUBaYqg0tH1K/yU2Vxz929Gx5urixeFI7yg0ueWQdf+XXQUKzerZsdTo08Y/nTvwxvm0Kw20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfqqXA4m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfqqXA4m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE53DC4CEC6;
	Fri,  4 Oct 2024 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065942;
	bh=J/CJ1wHjeMBBZix/ZJOLlFTggi6BPobk8g6fjsbu52A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfqqXA4m71EjTyUxopqvlAEIiX0ADRIYrW6svsy8aE6vSyItU9LdCrUxyCt4J7eL/
	 ZwylOouMI/yiQ0VZ0Eaf5SapOGZICmlRsESf7daEUK5MfbBkWNsZY0LwSX/rX9fDTx
	 2gBBNJqN0AjWo4fonNG1BMqHMBY1ZJ3GUofTvlttoffoKKOEs2Fe0dTit0T12emtG4
	 iv+96adf40EGbjjLMZSDLnGuZoPIJ7a5MbtwtK2mc8Wse9La6sdswQLqnApPLBsaMp
	 MdIwgw6hBJXhqbOTas3iz8zECchi421m0zfpkCm4IAqwtr/DL+D4kPvTsDTRWlKtid
	 5kGrfb57SXfeg==
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
Subject: [PATCH AUTOSEL 6.11 19/76] s390/traps: Handle early warnings gracefully
Date: Fri,  4 Oct 2024 14:16:36 -0400
Message-ID: <20241004181828.3669209-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index 14d324865e33f..ecae246e8d5d4 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -177,8 +177,21 @@ static __init void setup_topology(void)
 
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

