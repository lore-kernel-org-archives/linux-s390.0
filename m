Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8ADDD2;
	Fri,  4 Apr 2025 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725075; cv=none; b=GRAjUNGPfdVYh8G5Ma/8sMZJYo8gIIxqqxgh6ruqnKKzBx/c8DgfX1F9rPKjsohHjwEQTyBy1BWluN+6RYjbaYFSw5TUPD/Wwu2rataZU037A23wVWsqzNUqpL4eY/kyVBHkpP2fqGTTpL+GKmpSmbSsMozalZALgNHg+b0IpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725075; c=relaxed/simple;
	bh=mk+yGaMYbXEcpKulZAEG/o59etxEz+0+S7aN3CTTJd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AEJXHmlvqaZiBb1FY7+/0N2aAUDHdw7lmSh6qe2ioOKezIQkxQIFNawjrbb+Z9HXpOhyZY9uNNoHArqI7N/Fdrd2mGFaCt90MfzlHeL+LHdJfUFrHi8xEySDqGNz1eSN5PJQIzd/+PbV/HyCIAAMicy/Z5o64rNXIBdaW8yEeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKGQFuD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKGQFuD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B372C4CEE5;
	Fri,  4 Apr 2025 00:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725074;
	bh=mk+yGaMYbXEcpKulZAEG/o59etxEz+0+S7aN3CTTJd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKGQFuD1t/Zsw81l0q3OkfE9624iIp3hDeNS4i7JQ2kU9r687hwk66KVbNPXxLeTj
	 ziHhh/usUtcVH5vHvSZH0v4fd9Gdtdc4DMkM3aMyC81ZALXdd6lfXIPlHqLfH5jXiT
	 OchXeS0b6fq+mBkHtIrMUxLGQbjXltTkvzYmZ8E5S5nrw2CZU5jAvaTqvVo7zjrv00
	 8Id8ttYGI3eyWpCYzQe4rS+j2BJjAtsbp01vwRixF2vtWY43BPeh+7D5FfX4D8BVjp
	 843bYXtDwgbF9M9jBbeuRMPRBoHvZxVekjDgAFWpVDnzpMAVzMGDCDtotq+jDjobwu
	 znR1uf6ySOiVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 14/23] s390/sclp: Add check for get_zeroed_page()
Date: Thu,  3 Apr 2025 20:03:51 -0400
Message-Id: <20250404000402.2688049-14-sashal@kernel.org>
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

