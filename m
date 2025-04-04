Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCB1FBCA6;
	Fri,  4 Apr 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725171; cv=none; b=HlILjNglSL355DWUzY8yvLi60AFyzomlwK310uCuPrgjnxTHMl+Tg4//yikwuqIur1K9BGs0t/JW9mqp873IHqPApTw88Lwu5g6l8dXd5KSZLpGB1geEJhWwdrHf4AObdn0xGapRM0Yw1NfZGm0ndw4Z7Bqkz72bvLUnox2VxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725171; c=relaxed/simple;
	bh=mk+yGaMYbXEcpKulZAEG/o59etxEz+0+S7aN3CTTJd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QVw29yq8Rr8/GvBrd/93ERxUKyXo2hmYzb89E9lG2XG2wMF+RZ0n9DyqbWjLVJV7X4VeHE9oykBLGivGBqd/0xkVuOQd7MwzvCSaKihapDf2bD9pVCDA8jS54Jr2wneEuQOR0YaCxnJwrDoHoCsnXeCvZJ2buzpFJ0Dw+pS9ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8CkyPvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8CkyPvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A33C4CEE9;
	Fri,  4 Apr 2025 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725171;
	bh=mk+yGaMYbXEcpKulZAEG/o59etxEz+0+S7aN3CTTJd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8CkyPvX2CsZs8kl2ZbTFUd0U0QXOU9oSD65zlUunoygKRd71olKR66rjcEAg1u2u
	 IB05ns/ScoL6B5DJJSW96RtYOn6Kx0Wu6I7AqiILSGkBpmROUPczM08Ik9cFBDLyNy
	 fGSnIC2JVDS90zBkA+d1aAIFU0xKK2NS/CAJTjCmMX86uSLnpN0+3PRw640rinQIlM
	 IP2vyDFEoFqmtlV7YTNgAjjeMy+YaUbtnBe/UgnV2ooIwELm+5rS821VgOeIwvfn+k
	 KL8ceyD9PGLdsCbpdwPQadFdUNReVp33OA18XhRLFYBRsxFriTIGpM72YYDcPcK8Z0
	 0z0DXA3/7XDzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 13/20] s390/sclp: Add check for get_zeroed_page()
Date: Thu,  3 Apr 2025 20:05:33 -0400
Message-Id: <20250404000541.2688670-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000541.2688670-1-sashal@kernel.org>
References: <20250404000541.2688670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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

