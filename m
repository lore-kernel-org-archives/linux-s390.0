Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556093126D3
	for <linux-s390@vger.kernel.org>; Mon, 10 Nov 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781365; cv=none; b=thv115MZo/uYXDqK0JsfWRVaqDAxpuikw5NKgUXziSvipTrLjFr4plT0KMawd0SCax6x2BR/AnWhuHUL/cRhjBVNZER2UCpHb0UFfU6cwnQWNFKHUKAZe9LEKSOu26CJUExjJNVNsORF5KfQPG0hSkfIORP4gs59XG1mKfiYLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781365; c=relaxed/simple;
	bh=sLrBJ3ZBCMXSlM2kVgpb17So7cyIbxsv4aWi1ytbqt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUuMwCRrG8KApm6Q/N+U5MzOOFvjkIyovVZZhJLjQcKgKS4FTA+DJtW/6M69BVU7ICPOZ8vSgo134QU+vf5lRVB314yw8cAG1eOME8QBaW50lCbkl5YdF9Sy4rm8i43FKlvF1i0F3pV/e6n02l2SN8wshL4T0CAMPaOwgDqOLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQCrwzpQ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQCrwzpQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762781361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqc1Y3D89IlDs+imNtvKdTBaY5sfXC6Hj3Uje44k5s0=;
	b=MQCrwzpQVwtH++wzXwvGBkXdV7iWkFlx+IDJN2PgcXUdnb3GsuuUeYQgkCg8r/U2svcW2z
	vBV3ztCi1epne8UwOB+MgJHGwFbDRU2UxMXmivS9WsvwFWLkTL+mGRfIR5ZEWQ6tXBmBHa
	A7/FfZZZ0jXTVPPNw3xqwRH48dadkL0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] s390/kdump: Mark __do_machine_kdump as __noreturn
Date: Mon, 10 Nov 2025 14:27:55 +0100
Message-ID: <20251110132803.1520-5-thorsten.blum@linux.dev>
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

__do_machine_kdump() ends by calling the non-returning function
disabled_wait() and therefore also never returns. Annotate it with the
__noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index d78e6e3d962f..ca51168500fe 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -45,7 +45,7 @@ extern const unsigned long long relocate_kernel_len;
  * Reset the system, copy boot CPU registers to absolute zero,
  * and jump to the kdump image
  */
-static void __do_machine_kdump(void *data)
+static void __noreturn __do_machine_kdump(void *data)
 {
 	struct kimage *image = data;
 	purgatory_t purgatory;
-- 
2.51.1

