Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EF1487F6;
	Tue, 18 Feb 2025 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850078; cv=none; b=dSaiVWnuypl0cNo2BB2dj184Ho+WcXjMtB0iccZ1L+W0yaTSdvgj5FbwYWiDLWJ407JGg4LgGeNN+1S+POq5pPSUnnMuVeUXb/F6DErKw40Vt6Bt7UOcptixE01ChB8tIYy16yg8QzVU2nIdUe2L4gju+S4C3QmRlJfBtV4chkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850078; c=relaxed/simple;
	bh=ievi5V7ymy8Kxe+ga7GFwE2aypNQq5i+fAHtUgio86E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mmqu5pcWBGzNxsbicdYvv5DJ0z/yCl1lSj9rD8J/jd+u0KhtI+uViQXeSZ91FBZQjBDDth0waskE7KilkLsnhBF9oHOFQVmUWlZPZtagXGfB05PLAy4Xx/uqpD6lyByoNlM4RLdFdsRwBSBOOi3sAaPonXn7VgUC0qjbf90JtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MaC0YGeN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MaC0YGeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1txZt
	33yFZE+rx3Zu10ikaUc47KcCwWtOpqWiiC44Ik=; b=MaC0YGeN6R7n5BzFUHT7c
	ZVkrO11HqUDqfyotqaUBj3jV7Wvh5MYSxcSN6CU7//SvnBbtY7UKYSyZVqfVcmL7
	2LN18OGRHnAoPrwRmFZd6JMyEEbdPbUHdFBm5d6Ofcgs7DqVQ0UOsTN10VMTlgDK
	dbSDP3HafX0uj3QVYtro08=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXZaRSAbRnZsPdMw--.41856S4;
	Tue, 18 Feb 2025 11:41:08 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	haoxiang_li2024@163.com
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] s390/tty: Fix a potential memory leak bug
Date: Tue, 18 Feb 2025 11:41:04 +0800
Message-Id: <20250218034104.2436469-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXZaRSAbRnZsPdMw--.41856S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrur18uw4UCw47WF4fZr1DKFg_yoW8JF1UpF
	s8KrWYy3WUJ39rZF13J3WDCrWfCan7WrW2gay29345Wr15ZFyjy34ftFyIqF4DJry8Xay3
	JrW5Kr13tFs0yrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pim9aDUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAv3bmez-ES6CgAAsm

The check for get_zeroed_page() leads to a direct return
and overlooked the memory leak caused by loop allocation.
Add a free helper to free spaces allocated by get_zeroed_page().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/s390/char/sclp_tty.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 892c18d2f87e..99de33694fe3 100644
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
+		free_page((unsigned long) page);
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
2.25.1

