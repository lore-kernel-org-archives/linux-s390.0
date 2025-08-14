Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2ED244692;
	Thu, 14 Aug 2025 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155777; cv=none; b=nrrhH4H1OF6Amyzd1Lya0oNIJegHmLSK5Xm5JuI1uvgmsrkXhJncul+BtP6s3eDYsAA6/01sDkl94az/bzF4QnpVUhtcTZpR0TZwobNwHxoJXykdx45syECWendz1QBsrUWeHA14nUWoxac1uSlZH5mVlA66mNKLcG3R92N/wI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155777; c=relaxed/simple;
	bh=7F8y5ue+Ljj669VJqRAfgRzBVAZrTs+p3rxcP0T5c6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NA6iQ1k8+ujsVkxYD/NUJvE46+w11hLjbB1eM3tS3FWF91RdzrTsPZrxfdY9/H4htAGJ4td4ZJX6kKclq7x3+hFfs5250nJGsMJe6lY9b0eE4jlTRX9KfFY+Pcwbkq6Cr4cllFZf4aCNNllmv58d6EWJNkIza/K2KjQ76P88iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ox78AAHs; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ox78AAHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xz
	Lv3ijIJoHi13MX3kHuTDReVrDhgR/G//ZFkMTDDMU=; b=ox78AAHsyBjLnMfYco
	3IQK6fOoayTQRAU7ersYQiGO7n6K31ULH03SZX/tO/9nro/QahDo1XL4Y9quzBAn
	E4nRFDjuzpLxZuD/8Iu0WLLzMogv7hFcsHMk6Q/ATU9UVYp8Cs1OOrKIgg4UW48r
	pHnQMdceOQ4JD03RRZmF9WZS8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnb140jZ1ogkKQBw--.39100S2;
	Thu, 14 Aug 2025 15:16:05 +0800 (CST)
From: Yang Xiuwei <yangxiuwei2025@163.com>
To: sth@linux.ibm.com,
	hoeppner@linux.ibm.com
Cc: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] s390/dasd: use IS_ERR_OR_NULL() for debugfs error checking
Date: Thu, 14 Aug 2025 15:12:47 +0800
Message-Id: <20250814071247.2572569-1-yangxiuwei2025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb140jZ1ogkKQBw--.39100S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4Dtr48JF4fGw13Xw13Jwb_yoW8Gryfpa
	18Cw1xtw1vyF47Za4fAan7Ca4rZ34kWayfW3WUuw18Aw1xCr43Aw1kJ3W5X3s5WrZ5Xw4U
	Xa12yryj9a17KFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jurW7UUUUU=
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/1tbiMQWpkGidiKWhEwAAsn

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Current code checks both `!pde` and `IS_ERR(pde)` separately when
handling debugfs directory creation. Replace with IS_ERR_OR_NULL()
for more concise error checking.

This change applies to:
1. dasd_debugfs_setup() helper function
2. dasd_statistics_createroot() initialization code

Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 506a947d00a5..78a9c8d781b3 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -215,7 +215,7 @@ static struct dentry *dasd_debugfs_setup(const char *name,
 	if (!base_dentry)
 		return NULL;
 	pde = debugfs_create_dir(name, base_dentry);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR_OR_NULL(pde))
 		return NULL;
 	return pde;
 }
@@ -1089,11 +1089,11 @@ static void dasd_statistics_createroot(void)
 
 	dasd_debugfs_root_entry = NULL;
 	pde = debugfs_create_dir("dasd", NULL);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR_OR_NULL(pde))
 		goto error;
 	dasd_debugfs_root_entry = pde;
 	pde = debugfs_create_dir("global", dasd_debugfs_root_entry);
-	if (!pde || IS_ERR(pde))
+	if (IS_ERR_OR_NULL(pde))
 		goto error;
 	dasd_debugfs_global_entry = pde;
 	dasd_profile_init(&dasd_global_profile, dasd_debugfs_global_entry);
-- 
2.25.1

