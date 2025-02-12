Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5320F095;
	Wed, 12 Feb 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367698; cv=none; b=WOh27M1eIbfz88xJvxdkHwqEdDAYmo0zLSu9hlvequ5GXwz2gmrJLGy8+CN8gxH6Uu1Vt3v9aech84lh/mDe7Q/T844ow8R3MyluFuVSXsgtmuPIC7byG2hpPlbI4dWBrzkrq5d4Zw/u5c+oFC3USjFN9YvCtwbet5ZMefhFGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367698; c=relaxed/simple;
	bh=4e/ZYIqbaPlbrji9W2swzGj5tfRCnq/Rty9Zu4FuQEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLiDPCMvQMu8v1QjKwELE66FsVmv+o10Bqx6+nWJTg9iXogKT/8dmrs4Y4WqutIxpLhi7SIT3XPId5UjAYqbdsVrtEp71Eaz/+yDcEflSE+kVUhiyU8cRzZaW5dTOLWQSZZjI9eSDw4NyA2B6COF8fUwFiAvn0OiZpNzJ6VGM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dspNOYO0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzPHKOUe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dspNOYO0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzPHKOUe"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739367693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+ZKfpmr3pMXsS3E912MhMX/FXEkzo/mSsNGFHgHyLc=;
	b=dspNOYO0K/D5UQ/G9+0xYJILQLJKiHPSkIWmj84YXZk8CDayDygUef43E6R24K1OS0Xf4k
	qFgIqSBD4GkfyU2zip9sFdgvAMtypnjiTHN8rX4fmrmR+BOwOWhdopv8jJj208ijM9tasw
	FTJX0tHeQ+c7YY9LG0IL3Hcg6h+0UnUhbD7JYm/lx7k7+1pL76InMRU6eveBOZzQhHX9Y7
	41NO4mL2qDRi6kVqChUQL65DgA84YEiHMTL1OB2oKbr5YaHuCi3wNAi/2Qeuz32BVv3lyE
	mr4zHijsXfaVEKtNgYveauolcvXiEjMpJrlwbo36oFm/Bha8x95cCAnp3M2e7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739367693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+ZKfpmr3pMXsS3E912MhMX/FXEkzo/mSsNGFHgHyLc=;
	b=QzPHKOUed5mExwdCUb43cqPscJfujsztACtE5CF67vmd2RTpJgkT4uHYDkgxc7qQzIKEXC
	0RK/Hg+LUIiuD6Cg==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH v3 6/9] s390: Rely on generic printing of preemption model.
Date: Wed, 12 Feb 2025 14:41:12 +0100
Message-ID: <20250212134115.2583667-7-bigeasy@linutronix.de>
In-Reply-To: <20250212134115.2583667-1-bigeasy@linutronix.de>
References: <20250212134115.2583667-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

die() invokes later show_regs() -> show_regs_print_info() which prints
the current preemption model.
Remove it from the initial line.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/s390/kernel/dumpstack.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 1ecd0580561f6..911b95cd57e58 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -198,13 +198,8 @@ void __noreturn die(struct pt_regs *regs, const char *=
str)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("%s: %04x ilc:%d [#%d] ", str, regs->int_code & 0xffff,
+	printk("%s: %04x ilc:%d [#%d]", str, regs->int_code & 0xffff,
 	       regs->int_code >> 17, ++die_counter);
-#ifdef CONFIG_PREEMPT
-	pr_cont("PREEMPT ");
-#elif defined(CONFIG_PREEMPT_RT)
-	pr_cont("PREEMPT_RT ");
-#endif
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
 		pr_cont("DEBUG_PAGEALLOC");
--=20
2.47.2

