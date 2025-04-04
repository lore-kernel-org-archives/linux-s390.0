Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FD202991;
	Fri,  4 Apr 2025 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725207; cv=none; b=R/Sksxj8EWqd/fzDbmmHdBTGuUEHEeN7+KDeLF+RRME5TxZYCsjSZc02OjsMAuM08ZjLblig6MDq58anCMleMVpBjHKhuwhk/Vd91JDSyq+wrIuNORFXkiAYmRzsqvLJIFqSe9lw8elWZn9uysYJSSr3SsndwfymTbFo07YZE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725207; c=relaxed/simple;
	bh=mk+yGaMYbXEcpKulZAEG/o59etxEz+0+S7aN3CTTJd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pe8zHJs7CuGKOAMeMogXx5xaZff3R9u+F3tPL6C2PTl4ZgB9g8ScqZAtWrbvDRsP98NxvPK4MzcUMlnZ6Ob0B8lSy8sFNMqARSBCuZlmh5m9C2R0DxEQtSbP9oOzOJrjTBbqIHfzp2FtwLHtI0p/xjwnsRYNCTMZPF1gsuasluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlAG90Ih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlAG90Ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7744BC4CEE3;
	Fri,  4 Apr 2025 00:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725207;
	bh=mk+yGaMYbXEcpKulZAEG/o59etxEz+0+S7aN3CTTJd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlAG90IhTo33m2fxgDajVQnl+18iqUKcYfUPK+yxa+8gV9hBLQ1h63mqOynlYYjMV
	 S3W9q+yb23y1cZaY1i1tiiBDW4ijYCwllpIwqrYS8x9jEPFk2rVe34GHimtdZRH7rK
	 zcCXIR2EIe5PxlD+CgGlajV9kzKv1eyaGK9zk4DHUwpHR3qWyfu5MOa8DVHYbiEU5T
	 r8WlGk0CZBydNHH6gWnR9hkJkbzi9QF5yLoCwrYZkztkbjSo6b182kq5WzjAEcC5QT
	 NuwkqJ1KQTfrLiG0p1u5iwKp6707oMSRU58cAsWANLO44pAsmA36xr9y0OOxWPO7hs
	 Vx52fcxLYIIAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/16] s390/sclp: Add check for get_zeroed_page()
Date: Thu,  3 Apr 2025 20:06:17 -0400
Message-Id: <20250404000624.2688940-9-sashal@kernel.org>
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

[ Upstream commit 3db42c75a921854a99db0a2775814fef97415bac ]

Add check for the return value of get_zeroed_page() in
sclp_console_init() to prevent null pointer dereference.
Furthermore, to solve the memory leak caused by the loop
allocation, add a free helper to do the free job.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250218025216.2421548-1-haoxiang_li2024@163.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/char/sclp_con.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index e5d947c763ea5..6a030ba38bf36 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -263,6 +263,19 @@ static struct console sclp_console =
 	.index = 0 /* ttyS0 */
 };
 
+/*
+ *  Release allocated pages.
+ */
+static void __init __sclp_console_free_pages(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_con_pages) {
+		list_del(page);
+		free_page((unsigned long)page);
+	}
+}
+
 /*
  * called by console_init() in drivers/char/tty_io.c at boot-time.
  */
@@ -282,6 +295,10 @@ sclp_console_init(void)
 	/* Allocate pages for output buffering */
 	for (i = 0; i < sclp_console_pages; i++) {
 		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		if (!page) {
+			__sclp_console_free_pages();
+			return -ENOMEM;
+		}
 		list_add_tail(page, &sclp_con_pages);
 	}
 	sclp_conbuf = NULL;
-- 
2.39.5

