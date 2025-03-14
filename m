Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAD202F93;
	Fri, 14 Mar 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968500; cv=none; b=iq8bpzvBs4qIvQMRO/+MBLnnZe/NO2qt5gxK24fuZCEY3MFX43cpR1GCXzz2DDO4CMIrfZWqxo10JeEmNfmr0p4I2/yCJQ5je8Mw/qwLp1Ztj7xpx9sCQoqBQm63mYoDrVqBtho4gUMY0geUPk6eXDsfjLtTXvy1TUBdjANDKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968500; c=relaxed/simple;
	bh=4e/ZYIqbaPlbrji9W2swzGj5tfRCnq/Rty9Zu4FuQEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUTXKnIv5GtSSwClT58oABcEFqvl3yJHlpohT8DoBiHygIlbc+8wwOp2nQOTyoZlcitjHC3Zg55t87bPb5YDMEfse0y5YXgFm9BA1sWhYj83Jm1y7q6ZrVAi3MKY7OwiHKbeHxTQqE2jwQdjZQ/QIUqoeLL/DcxMI98/5OK587o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbKBXtqU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9ZCSbYg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbKBXtqU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9ZCSbYg"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741968497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+ZKfpmr3pMXsS3E912MhMX/FXEkzo/mSsNGFHgHyLc=;
	b=UbKBXtqU9pdR+b68bgmKTxa9Hx7qyZPmdOzYhngeIKt51cXbv6/V5dIA1TfZWu+84Wbp9r
	MfqtaAXiUu+zQF/gx+MzM328NmTmndtPzcvaIjdw9TATcG+m6f9rcyGq8A3u6tyWsTUgBX
	Luz97fLu1CvW3nfBm2xlki5wrEkThDw/0TfY4Y2ofCXaewWlqbmsca9FtwHY++a+C1o19z
	5sDckkg57xTh1/4bDniTMMZzjXcer9V4lGiPVe2R20NBU0Y0tMsqfz4rPARsIM/448KAY6
	5qDLOcjce1NheIrZTdV8tw/04ZR348JddIzGdsXIrKribBW3umivGf6cV8Taog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741968497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+ZKfpmr3pMXsS3E912MhMX/FXEkzo/mSsNGFHgHyLc=;
	b=Z9ZCSbYgWPSr53UuSaRsAH8OOwQcsZaqwBKzr4qjORVCv7gYqjIkaQzDIof3h3Egag4Bbr
	TKo7cSDP7OlBQJCg==
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
Subject: [PATCH v4 6/9] s390: Rely on generic printing of preemption model.
Date: Fri, 14 Mar 2025 17:08:07 +0100
Message-ID: <20250314160810.2373416-7-bigeasy@linutronix.de>
In-Reply-To: <20250314160810.2373416-1-bigeasy@linutronix.de>
References: <20250314160810.2373416-1-bigeasy@linutronix.de>
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

