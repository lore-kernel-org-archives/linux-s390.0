Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D12310624
	for <linux-s390@vger.kernel.org>; Mon, 10 Nov 2025 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781358; cv=none; b=ub/mk3gkYgjZICPFS9BxTiSZm+7BbXagH+PJKAiN8GX8+TNuW6I8o3ctmb3xZ427wp1wqF8EzyPeO0O/Z0Va/X8UGrIohxbOTsoU39RxItl5ZLb2TtaIblwizcEk2F8S6cI6AzFu4e5BNtx8wOQmsj6nYeHPRwAa1uOhZKXsIgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781358; c=relaxed/simple;
	bh=NQHYzOxzMSFlK5q4fg9nfPPuCyjP3a7r6rDd6M5f+4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp5+1s6yLBJT94LFLYbPX+KY5FmcQYr87cZ7xpmtBWSFA6sVGxDDMEjdK+bviWUlU5aT4RFpbhYpO8l0TWq+bNfj6RWqspwHJ+J6UhFALco4aRGNzEXryflfW7UJhlloWfGG7CuNIHbKMeokP0DKgmkHj2jmUZC0UfkOEpgeZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YGOGJ2Yq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YGOGJ2Yq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762781354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXrzkiqOIat+yMo66KFgP8YRHTHFfZvWlhYSmGepi0I=;
	b=YGOGJ2YqrBlPDzoDVSlMuNlcqVZijPEIf4p6/NGkoQPQyJQUIxd0Uw9mjNIPlJkvKlyDDw
	8JywBrPijsmwXNdq+nLsPNvYjym4CLK3dso77Ey3Hmd91yZxAip4bNM2DE4miXE0IKIog5
	3jnStzMP35Lj5ikmVrNhuM0xAH+UnKE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] s390/kdump: Mark __machine_kdump as __noreturn
Date: Mon, 10 Nov 2025 14:27:52 +0100
Message-ID: <20251110132803.1520-2-thorsten.blum@linux.dev>
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

__machine_kdump() ends by calling the non-returning function
store_status() and therefore also never returns. Annotate it with the
__noreturn attribute to improve compiler optimizations.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index baeb3dcfc1c8..b6b0a85816f3 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -77,7 +77,7 @@ static void __do_machine_kdump(void *data)
  * Start kdump: create a LGR log entry, store status of all CPUs and
  * branch to __do_machine_kdump.
  */
-static noinline void __machine_kdump(void *image)
+static noinline void __noreturn __machine_kdump(void *image)
 {
 	struct mcesa *mcesa;
 	union ctlreg2 cr2_old, cr2_new;
-- 
2.51.1

