Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5D2063E3;
	Mon,  3 Feb 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592211; cv=none; b=gHErJIoPgSxC1UUNOrlMGAQqANKMxJuuFy96YBV6mnDmuQycLx2tO7mYDIixvMOsZxN/0htGBaBOPuYn203pPgzvYU57COQ7g+9oylInGuaLDOxW6EnV+z4PyzmGoIfzvLgdQXS7zIRi/uN7Mbe295UCzHHqomhJtogtrVRt3io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592211; c=relaxed/simple;
	bh=b+loM8yJYh32YROeOAXd4ziR4AXAC0u8e7nMQUX/Fd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaodEnr1p2ihM3K4mosNaOl+DtWo0zJKASLdpnVLbsA41JuT2T1M6bmQSNlozL+x3Btir+Y9D71O1MQbvNWEjtjSlfjJ+Rtf5N86ICoC677VK4WjB2b62ZOQpqgdlKjEl/XYF2uw+9UYKmCVfTqpmUFRkOa2YfBR8+3MOqLzDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOev1tAx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qG3s3WLZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOev1tAx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qG3s3WLZ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738592207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnAjnbiDbkQdywZgkGEyBzcKooPnQROG9QRQ+L6wVm8=;
	b=qOev1tAx6C+RVzlqSZ2392Zeb8cCE8l6POFionzfZ6fW6gtBNxpKrojsUE8B7CaI9cN+6D
	ALQBEeTLui66ft0Drd+QLBMiKK23mggetjX0WGsvZ4ZZbTUtkgKBlwYz62MNGmtrAuVijI
	0Q141lDvEqEOGsGZkCLsTblL+n2Zc8VNrjOouw3lYSbAMB4/bu2ODZ3xFrnGlSDQFMAR5K
	gBi9BrniY/J/7Up5B8cOILyx/+XkJbwXoAoOo/iMpEyvsWooQe+flexorRRjSBfhOMmczR
	DOw9tkG9vVcZVpBEaEURlSISzXH1xPXW8ZQcnweQI9Q/BUEmhvAyfPNHx35h/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738592207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnAjnbiDbkQdywZgkGEyBzcKooPnQROG9QRQ+L6wVm8=;
	b=qG3s3WLZLVT4B3Ujl/+r8XbEWGulo88EnNLgXl9RKfbO11H9d2fr/1FwL05YOSvdCtybsY
	La2RfI5ZPrb7EbBw==
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
Subject: [PATCH v2 6/9] s390: Rely on generic printing of preemption model.
Date: Mon,  3 Feb 2025 15:16:29 +0100
Message-ID: <20250203141632.440554-7-bigeasy@linutronix.de>
In-Reply-To: <20250203141632.440554-1-bigeasy@linutronix.de>
References: <20250203141632.440554-1-bigeasy@linutronix.de>
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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/s390/kernel/dumpstack.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 1ecd0580561f6..542098678189e 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -198,13 +198,8 @@ void __noreturn die(struct pt_regs *regs, const char *=
str)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("%s: %04x ilc:%d [#%d] ", str, regs->int_code & 0xffff,
-	       regs->int_code >> 17, ++die_counter);
-#ifdef CONFIG_PREEMPT
-	pr_cont("PREEMPT ");
-#elif defined(CONFIG_PREEMPT_RT)
-	pr_cont("PREEMPT_RT ");
-#endif
+	pr_emerg("%s: %04x ilc:%d [#%d]", str, regs->int_code & 0xffff,
+		 regs->int_code >> 17, ++die_counter);
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
 		pr_cont("DEBUG_PAGEALLOC");
--=20
2.47.2

