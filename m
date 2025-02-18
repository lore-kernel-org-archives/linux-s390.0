Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7304313BC35;
	Tue, 18 Feb 2025 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847153; cv=none; b=hbA3J2YWNPzfbGjuwspD/spo1Rv7qzCLGFI8i3VfHxuxny8+m97eTgn9InxDrXDOJbWfwSBOKTfliOpFKsJEDsKtbvk8tqI+4lfCK0SAb5aAu7/OUJk5KWgeys40n7P8XW8FLjiWq++xmaj55Wd2a50o5UWuJF7Q2LgJuhpgS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847153; c=relaxed/simple;
	bh=PWHofPdlpUwGUnc4/kTVRwpJM2awBxl5+OMElxXC2qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOlxB6CfLo/573LwbOvlvivbpI8frmPNIJofGszs8NbNy3xbVJ76hEFrMkL906RxVHcxrI65JCAWQtnw/w375ngV16yusggygnA/3rqEg8NoqeKJoB391+KqDI9KFbcwRe3IlKCo58kbrVfwbKHPvtSkvFKectCpTtFMbJLkaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V27KFIIx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V27KFIIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HMfjP
	3H+w2jYqpSYoxGCZQMFuo04FYmpgP9iP4Vdo6s=; b=V27KFIIxsfhw6UP4wxIHH
	NactfnX++wuOeINRRakHEuCPZRf0CGhv4g9tkp9BMWf74s/BBXipzw3nSIEwtmwU
	0bp5FJgvTX5OtglSIrpUmKJM/CrheIPfAKTANKv4siJhXycC3zwShdqNJ/yk9d4v
	7dKFlspMwDK6KnOWWtjOO0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDn85zi9bNnu4TUMw--.38146S4;
	Tue, 18 Feb 2025 10:52:19 +0800 (CST)
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
Subject: [PATCH v2] s390/sclp: Add check for get_zeroed_page()
Date: Tue, 18 Feb 2025 10:52:16 +0800
Message-Id: <20250218025216.2421548-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn85zi9bNnu4TUMw--.38146S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1UJF1fCr47Cr1rJw1UKFg_yoW8CF17pF
	s8Gr4Ykan8Ja9xAFy3J3ZrCayrWw48KrWUtayxAwnxXF13GrWIya47ta4rZFW5Kr18Jay3
	JFWjyF13GF4DW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqRz3bmez7+a-ggAAsM

Add check for the return value of get_zeroed_page() in
sclp_console_init() to prevent null pointer dereference.
Furthermore, to solve the memory leak caused by the loop
allocation, add a free helper to do the free job.

Fixes: 4c8f4794b61e ("[S390] sclp console: convert from bootmem to slab")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- Add a free helper to solve the memory leak caused by loop allocation.
- Thanks Heiko! I realized that v1 patch overlooked a potential memory leak.
After consideration, I choose to do the full exercise. I noticed a similar
handling in [1], following that handling I submit this v2 patch. Thanks again!

Reference link:
[1]https://github.com/torvalds/linux/blob/master/drivers/s390/char/sclp_vt220.c#L699
---
 drivers/s390/char/sclp_con.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index e5d947c763ea..c87b0c204718 100644
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
+		free_page((unsigned long) page);
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
2.25.1

