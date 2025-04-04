Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C30620967A;
	Fri,  4 Apr 2025 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725265; cv=none; b=MZ+6v4ElO0ISj9eFuIXGRTu+6uszluJO+TWmRxfCfYT0L0nbaRPPElwZ7Otf6YiiSip1AhvBGELidrkNbzOHDKSk+K0W5xVjkAtRSWrQzxeAf7Ao8RZWTojO1V+kN7qs+h/JL/AihfVuYVJeHW+kHYQTHiCzJuh9YCXeOXQBr7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725265; c=relaxed/simple;
	bh=0R6JZFKvBVwUWDQOVvhGUO8V6OZzqEomBf5wQswfFd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qh61BfBhLyJV0zUcIJARqpR/C3QgSGvWMjGI1SMb4OIUw5z878vSHXyQ2b7XLeakfoOVi/UkVFyXEunYD7nUeUz6MlD0czH5Krv7pu1hXDQ043/MJNW8U8wDeBUsk641XtcZnJ60dusswrYT0H+TNTVftd4n34CNAhL4tA0DtpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac7MTYW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac7MTYW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BCBC4CEE5;
	Fri,  4 Apr 2025 00:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725264;
	bh=0R6JZFKvBVwUWDQOVvhGUO8V6OZzqEomBf5wQswfFd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ac7MTYW04lee3sR+B9KCt4TmUlKRstxO3840r593YD+HKQzGpuazrIDl4hy/nilSO
	 0DMWJNW7EvuAXlfNSqfh8IooXXB4tts0W7T8svW9wCSvLQzK1Ga/8TgNtdBfpyB2hx
	 vFzytPfGJ0uJlcsgevDdbmj129zkg3Dw2XOu8oxEivJeWm2Vu3TPAgiduDtM2BxDny
	 MejbOzd6aq2lpMcwsEpfi6kChAhg2U6zWTXZPPayl7cia4+NThGI6aay4ERy7quJiR
	 L9yrH7PawT8pLEgParpf8nWFJcVlHBEz8E+UeNwUI4QGNTtUh5d2+5RMMAQPevoobI
	 UqITJeL+1oHlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/8] s390/sclp: Add check for get_zeroed_page()
Date: Thu,  3 Apr 2025 20:07:24 -0400
Message-Id: <20250404000728.2689305-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000728.2689305-1-sashal@kernel.org>
References: <20250404000728.2689305-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index de028868c6f4a..4e5d5da258d68 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -260,6 +260,19 @@ static struct console sclp_console =
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
@@ -279,6 +292,10 @@ sclp_console_init(void)
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

