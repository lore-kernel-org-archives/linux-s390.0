Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E9F21CA1B;
	Mon, 17 Feb 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806327; cv=none; b=Wgn0qBU7wvmZJlTMODP/z5PzpT/adE4jZA5wX7o5rL3dEMtNGzczowijef4s84jdAqD0Pb3i/ZwgUuCXJ/t9obRdkHR7zC5g0hzL5dUEXyLSv9lkZeeIprRhs00zBPJYy/X9EKiJW6GpDSVBJ72erdjz9wix28NKDm8Qvm5+7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806327; c=relaxed/simple;
	bh=q3khwAyoHreVsQTO6f5RNs2o/1AjT1OEnU8/sgeoSJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VnuO/5/VTUP/LRVW4uDHGpDOnXMPvRdixYIuWZJEdOJnbt091odDn10wfg6D/LB/iR6kLqAsikP1tgi/iRyeRc8xIYxbvLerYAK5jpTTj6b6X8izIONE3jWtLKTguHMcyMlNLBH4Vj3wTMldFIunD7ppCkkeS5Xgz8mSio/2gaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kVLWk0mK; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kVLWk0mK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EakCJ
	gmHHcD5iI2lwxDZEQW+5T30z54RrIINRcx7WX0=; b=kVLWk0mKkQxRfZi16Iz7K
	j62DVxXHWhgxvJRZu/X1xnEGHA2rS/qYE2cA+c1Ur+wVrbaxx7wHQm3PMABuJWCy
	3vsO/AsjXEjTWM0eQ33SIl7/2UwgQRJSDAte6Vwb0h9Ja+5Oayd/JYM6kCTL3cOm
	fzirC4/DWsXpA55fLpZsmE=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBX4f1kVrNnR188MQ--.4855S4;
	Mon, 17 Feb 2025 23:31:49 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	haoxiang_li2024@163.com,
	schwidefsky@de.ibm.com
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] s390/sclp: Add check for get_zeroed_page()
Date: Mon, 17 Feb 2025 23:31:46 +0800
Message-Id: <20250217153146.2372134-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX4f1kVrNnR188MQ--.4855S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruw48Zw15JrW7uFyfZw4UXFb_yoWfGrg_K3
	4xWr92yryYgry7ZFyjy3WIvrySkr1kur1v9F43try3Ar17WFnYvr1jyFWfurykJF4j9r9F
	934xAFykCry8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0g32bmezSa7LCwAAs0

Add check for the return value of get_zeroed_page() in
sclp_console_init() to prevent null pointer dereference.

Fixes: 4c8f4794b61e ("[S390] sclp console: convert from bootmem to slab")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/s390/char/sclp_con.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index e5d947c763ea..7447076b1ec1 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -282,6 +282,8 @@ sclp_console_init(void)
 	/* Allocate pages for output buffering */
 	for (i = 0; i < sclp_console_pages; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		if (!page)
+			return -ENOMEM;
 		list_add_tail(page, &sclp_con_pages);
 	}
 	sclp_conbuf = NULL;
-- 
2.25.1

