Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAF20766F;
	Fri,  4 Apr 2025 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725244; cv=none; b=fx157cp+utk7Vro/aJlPvTHcYuuXvBY2yFiAK01woh1vTnUuv79qeLIDdzd5Lx+nO8ULs8ufz5oo8Je0T2UlIstKpD/e351nmMMdJz/qIGEiEbDV5OgAFjV+wMrQFPZloQE/Etv9qDGGee/0VYtTV8mTAzUJjyHjQDcSgpEosTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725244; c=relaxed/simple;
	bh=KtlHusmjeBo2ehofOvWtPiyNsUDcFcYrXb7AQYaismI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVsIlkz/GUv1JkzeSN4X0wQDEBV7c6c4Y92X3Mco548MePCRdSLTXmNCdDeuNFsHJienbueM892WOlpERY+knn2VM5fl3bK4/RVBQc2LNEQsGsCoDS1tjldmEY4SAcdDU7N1mMiIyGmQbvpy7siGzGd5tulqxiBTjcy0HHTxEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs9YoA0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs9YoA0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7B5C4CEE3;
	Fri,  4 Apr 2025 00:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725244;
	bh=KtlHusmjeBo2ehofOvWtPiyNsUDcFcYrXb7AQYaismI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rs9YoA0sa3KkIGTa+lCewrYq8uceQdS5afhY/u6DI/t18lAmB3ZquZZbv7KNJzmsi
	 gyeZBf3UucPLVWUTYhLsJ6hrBAp0Ltgg2LhqtN0RrlZtEOtc83sO/tJt3pikWVzv3c
	 8D655J63xserPiuBz5+I1BWKTZEKeVkQw5ClEx3vVfvUzLMkQyKseXiViolmCPuQgF
	 oAkcb0fdOWuVaXusq+zW8iC1TdsWhfgQY0kvm4qjoUVSE6k47CZQ3RpYltGZhxC4G4
	 IZvyPV2NMFzjReEq40RIsYjaG5FXaQEEBSuBXnAVFCMmUyiBxwo5buJrLKdkM+jkpW
	 oPYHv+TAFKbLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/10] s390/tty: Fix a potential memory leak bug
Date: Thu,  3 Apr 2025 20:06:59 -0400
Message-Id: <20250404000700.2689158-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000700.2689158-1-sashal@kernel.org>
References: <20250404000700.2689158-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 971fbb52740bf..432dad2a22664 100644
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

