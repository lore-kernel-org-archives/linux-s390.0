Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2330F523
	for <linux-s390@vger.kernel.org>; Fri, 14 Nov 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118287; cv=none; b=uHqqUAli7yMOS0oWbNqBAP5GJ1UO8qW90RgzM8SXGrRN0VTgttyCJ/0eEsFJvvKpMF4n75amJGcULZ+tm3dvCE7caQqsB5UDEwZN1Oez3u7IDO+9+dxIjB6OL2FtBjK+CPx3R1SECOXjyPCNSwIRCyk02QK95L0mYh1Fc15H60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118287; c=relaxed/simple;
	bh=zvAFH2SXB30UAn6qz6xX6eBnz8aGm3voARxl900oEMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erDli2cVesq187MFYnVH5KbaQTBxUtSLhgygo42vkSsqC9byuEnlVFCtGsA3j//oI3nOE9lUPLmGw8qmMADXBRQXWajcyO8OtaLV1APIN3K4X0gfC0mYJcrP84VIGMY0VP/ZfCEM/qcmvU+nJkq9N9m7n8QAhgDw0NEEnC1E7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fFZ/h1TD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fFZ/h1TD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763118283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMO0tCG/LEghxfpjK39W2mQmoJJBFATXLCsLtK3dZtw=;
	b=fFZ/h1TDBp3nxtn6kS7/gLLLOpzQfd/PcmN0H5Vd0X69z9twAurXfQRvCGfAbxahM4BIWH
	Ohvt/y3O78VTnR8X55e8IbM6Nz45oG6K8hop0cjDf/JSGzAcCnkAppPES1mQbc01Uvn2zQ
	mAkW3Y1Pgs4AC0SLPBm3O0u4FvByBGI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] s390/kdump: Mark __machine_kexec as __noreturn
Date: Fri, 14 Nov 2025 12:03:54 +0100
Message-ID: <20251114110358.169429-4-thorsten.blum@linux.dev>
In-Reply-To: <20251114110358.169429-2-thorsten.blum@linux.dev>
References: <20251114110358.169429-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

__machine_kexec() ends by calling the non-returning function
__do_machine_kexec() and therefore also never returns. Annotate it with
the __noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 9be6f58a6553..1d1c709bc088 100644
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

