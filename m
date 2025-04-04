Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DE18FC91;
	Fri,  4 Apr 2025 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725210; cv=none; b=Hf2yg87/bskJcjnRSRQ610Zb3eCZQ8JtyC02NzJ90RQdGoXq874nc0OWWn8UrbOeKLsV+gvplX/dUsh3+8SZ4YXRlSyNzS2JlAxAhD20HqJUCXCcA4Ux8CweCtWBUttLWsFu+MBdjJbEnNFtScwNTILQn0BvVFiKJxGtj2hWKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725210; c=relaxed/simple;
	bh=JSFwJZEgvBBAEh3o/BWvEhtTm1uFo2p9JFN1QMelrkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbUBS3xmxzJzbZnhi74f+pWJIFPXGy6oAPjFCWTYWm3iQVMdaSZGslksX6n13Q0ngsrWIJavDhWwb0pjiYBXhZBzkOK0EC2nFkPJ4FRMdI8ZrKK974VYCCgFGPEZPP1Oqm57zM+DDpc2JJ4zJlz1Ffoobz2y22ExBhuGOYy5A0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiNSXXPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiNSXXPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A7BC4CEE3;
	Fri,  4 Apr 2025 00:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725210;
	bh=JSFwJZEgvBBAEh3o/BWvEhtTm1uFo2p9JFN1QMelrkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiNSXXPthKAnWRKFCUDXul1AgJCJcOWRcHs9jh7eeek2xUx+2wtQSNWNeegBpRp71
	 YsMUbYQ1YTh2BWe2F+0r315ejpUu4DN2Wlgy2GrQFzOnrCPvcMK9GEcT7r0LnU03EM
	 /dolA+DS6qyoUW7y8DQOBJUoZbb+Pf8B5yBMDdmHSeTxIyQGPbsgr09GYlQ3cbc6xy
	 fg5lHWfj+U8NzgYpGDTUzcgvTXP3FeSlrJ8E2WT5toonrrBXL2/yKrsoskJmXa8z6c
	 6arogRqAD0ruhDrJxjopP+kjtMnqj7U8dAtuKYpu8R/lT8oCoC0Sb0hHho+Lz79WdZ
	 7W//vj5mKXkUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/16] s390/tty: Fix a potential memory leak bug
Date: Thu,  3 Apr 2025 20:06:18 -0400
Message-Id: <20250404000624.2688940-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit ad9bb8f049717d64c5e62b2a44954be9f681c65b ]

The check for get_zeroed_page() leads to a direct return
and overlooked the memory leak caused by loop allocation.
Add a free helper to free spaces allocated by get_zeroed_page().

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250218034104.2436469-1-haoxiang_li2024@163.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/char/sclp_tty.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 892c18d2f87e9..d3edacb6ee148 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -490,6 +490,17 @@ static const struct tty_operations sclp_ops = {
 	.flush_buffer = sclp_tty_flush_buffer,
 };
 
+/* Release allocated pages. */
+static void __init __sclp_tty_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_tty_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 static int __init
 sclp_tty_init(void)
 {
@@ -516,6 +527,7 @@ sclp_tty_init(void)
 	for (i = 0; i < MAX_KMEM_PAGES; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
 		if (page == NULL) {
+			__sclp_tty_free_pages();
 			tty_driver_kref_put(driver);
 			return -ENOMEM;
 		}
-- 
2.39.5

