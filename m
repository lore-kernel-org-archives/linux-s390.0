Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921930506A
	for <linux-s390@vger.kernel.org>; Mon, 10 Nov 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781363; cv=none; b=bN2ZriTJGQ/DzkNh8+GKPD9u92DE/dyLtZ1r1ptSIo78Kw6ZSydNJUDFtFx8vUZj3MN69HNOgkg7efE71N5jYVwZwkx7uGH9L4URFLABN7kpOMDScT0/nTftD8sQVIMAA3e8m7bru4NrgnrsD4JCmQkjsxBaEioYu09RWJsL298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781363; c=relaxed/simple;
	bh=83H4ePpsefRka7bwB9uGZTP1DRTwZNRZinTPeZ9HVys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOTrGH2TH1G9G2wBOxLUKeEh0fs27oNbySjXh1lInHcXYDIuP8s2a0Wk58Lvp3Lfg0dbLFWK1eTwqVmYQqlIKPUDV20ocNrNAF1lPsI82jsT78x3Xa4TzYgcEYqDXrWio5Xf/ArfqQP/yP9TW3P/xrf6wjMWVw0dpkbrsLNbF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUBlrVeO; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUBlrVeO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762781359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heT8e1KmeABQ3OYytyv2US5RHC0leUiNDnCymrmaD8o=;
	b=nUBlrVeO17n6vE+32Ay2uSRBTADtar1fNb5oRTLYaSvxq7GeOVrhQpJeTpeTxcr0Tu5CSH
	FMJqw3gBkyv+YYHY0H4zmTtdV7nyl1BXsyaSMc8y2xFZ84sa+u0cSNFcGi/mNLyqK36s7X
	COI+yAksDhlfXu3imK7Ef8mFfFrVd4Q=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] s390/kdump: Mark __machine_kexec as __noreturn
Date: Mon, 10 Nov 2025 14:27:54 +0100
Message-ID: <20251110132803.1520-4-thorsten.blum@linux.dev>
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

__machine_kexec() either ends by calling the non-returning function
__machine_kdump() or the non-returning function __do_machine_kexec(),
and therefore also never returns. Annotate it with the __noreturn
attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 6de5e0fde49a..d78e6e3d962f 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -248,7 +248,7 @@ static void __noreturn __do_machine_kexec(void *data)
 /*
  * Reset system and call either kdump or normal kexec
  */
-static void __machine_kexec(void *data)
+static void __noreturn __machine_kexec(void *data)
 {
 	pfault_fini();
 	tracing_off();
-- 
2.51.1

