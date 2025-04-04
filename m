Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559B12B94;
	Fri,  4 Apr 2025 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725077; cv=none; b=kMGGOFtc3KN/MyrouTJpxxvHJNYqJyiyPibueqK3QcvpC9eOWwIcBlsVrjku1r81NDW2I9IhxUpsqijsOr4c3ccs0nl+YZ2uFWP9McHXbB5k+bL8amv85KDYHcRijh5wpaIIsagnp98JAp0ks6rE/uQ/izHA8srMLbXVTgNNvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725077; c=relaxed/simple;
	bh=JSFwJZEgvBBAEh3o/BWvEhtTm1uFo2p9JFN1QMelrkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMQksoi4VI4wcgkGKGl8BXyTUaa9bPT6HoE2ioM9Q7l/VGFgFhlVsmrUAKL4E9XJgT18aCM18UhRSBspVORaqv+Ur2yzrIn/t0TpP3z7Fy4PteoUUqUh9tcAooMZzJMQcjpV/4lryBPigERvkPb/yDQEUoAVgFBNkCzZp1kUdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zfc4dCla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfc4dCla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18037C4CEE3;
	Fri,  4 Apr 2025 00:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725077;
	bh=JSFwJZEgvBBAEh3o/BWvEhtTm1uFo2p9JFN1QMelrkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zfc4dClaOGx0gXPetd/zoDQipREQH2AKcXM56vtqyuHgREEPMSebYXjsiQU8p3ul4
	 AJ/qYVze/EWUHyFK6C7OJpMqSABkKPrah5kjPwekyfPXPux2OXH0NPk1foLWrYlIBz
	 Q1bGUdHh21ZMC4m14tQls2xpyF9qLrtUmidHd99cKDeYx/m74jCA8pAAR+gyF6pbbk
	 LJZxoREeKgro9vNNcoo8z5kw+A/+/cxSnzjBNqTXPjI8R9xWeHyzkH+LjBiqrsOnf6
	 fGmhdHtvlQeXc2lJY3X6fBS3cVzeFwIjfJ0YnKgki8IHZ/R8zA6a0f5sQTh27EzKeJ
	 ybC3O1RR50E9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 15/23] s390/tty: Fix a potential memory leak bug
Date: Thu,  3 Apr 2025 20:03:52 -0400
Message-Id: <20250404000402.2688049-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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

