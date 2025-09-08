Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EB10E0
	for <linux-s390@vger.kernel.org>; Mon,  8 Sep 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345722; cv=none; b=Zfe51T0frTrYBUBcL8QGVn8VZbcOCV9K7z7zhcQcIr1khsLmM6BijXXJlpBwPNm+Gnp/4n1XnOT3y4C2RrZqUzWrhzfZ3hYiFgjPq45JmhepHoUb2ECMk3eenZz1x1GdGW/nowlUpHwWqjsooFmPJ9lxIOX7QLaLz+FJFdeg9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345722; c=relaxed/simple;
	bh=bf11lNYOfKOGdVhpjFK7D3XO7DUq0x7sFn4ma1VbFxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lq7Q073UglMYZSTuiQF6CTnketA2xZJbTRjm6IEf3GQSAaDXRHMyX2uRd4wst+CqIlbogFjWpVWaVXfUek3GGpo7vYZL0WRHg2jkqWiGSh1YYNrihJ0ZGiKV/x+0LXofAmty67t3ELyF7lQQ2W8mC2aQaZ6rc1yfr3WzHjdO1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YBYK6YYA; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YBYK6YYA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757345713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YxBWbrmxjtRNQvr31SS6Y35A0V/RFBLkoHxTxyFl//s=;
	b=YBYK6YYAyaGj/5RvCtM103gWwkBVSCF+3cZRE+MFywCm41flsuSg1z6S5jmrAe3DuYOG66
	EvLazttcOfqxRh4WtXpFyNbXxedBE8ccQTaNlGAQkrxfIEpt1qcq/Za32kAGSytOdY9ZWp
	iUM509MTnA+VHohqsz85dngty0yg638=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/nmi: Simplify return statement in nmi_registers_valid()
Date: Mon,  8 Sep 2025 17:32:20 +0200
Message-ID: <20250908153221.383589-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Don't negate the 'mci.*' operands and use the logical AND operator to
simplify the return statement.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/nmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 11f33243a23f..cbefd6bde104 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -321,9 +321,7 @@ static bool notrace nmi_registers_valid(union mci mci)
 	cr2.reg = get_lowcore()->cregs_save_area[2];
 	if (cr2.gse && !mci.gs && !test_cpu_flag(CIF_MCCK_GUEST))
 		return false;
-	if (!mci.ms || !mci.pm || !mci.ia)
-		return false;
-	return true;
+	return mci.ms && mci.pm && mci.ia;
 }
 NOKPROBE_SYMBOL(nmi_registers_valid);
 
-- 
2.51.0

