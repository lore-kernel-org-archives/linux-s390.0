Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F9341AC1
	for <linux-s390@vger.kernel.org>; Fri,  5 Sep 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070202; cv=none; b=NfBSXHyPFrqwmQ+ffAq15v7dY5WJkujWASqr+wWBJXo52lrxoW3Gmgpay374n7CrgW9xwqnEluTBR433FQZGZ+i/K2T0KGPIY/V/8m/08lDMvG1/20QqWWEq5rJVHldChVGCxO/GrdWhsCKPGzC4z6vL6zg1f8i0Az38F+1mh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070202; c=relaxed/simple;
	bh=tGiTIgxzfL0ZubePlSyKKw5/M+qMw+lnVwvCXioNp8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFGOXWxEX44NjYCvYR62YXwjGbj+mqJMv7NO29i94qXJIA4zcQ2MSvCht5PQQibY4iBdynx1W3NWGAHcbC3GpLVsENBlOZOHqU0CvddbZvXZa0PYHfNgvrVMEdih0usxwWZpoz/AbuTGUMWjerFUVQnC3r5azS1krw+zFc6uYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jJB4KL6O; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jJB4KL6O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757070188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jU0V2LUx2VEIKkr5+zOng1DSdA2xbaRRNLzM6WgBwNk=;
	b=jJB4KL6On/uo/T/IUOcrWMuRYlRqrV4fGT2EtF8V8yB0rF3VlpYDSo4pRrz5gZMb9HJRhu
	WKbs8alWW12fMIEvBNCx6UDuNZe9SrpwKv+W/WQgOlEjFIqwwiXuWJfd9jyWu/59XM4rWp
	9FXFOHCmhO296R6htqJ+UYS8IHciEwE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/hmcdrv: Replace kmalloc() + copy_from_user() with memdup_user_nul()
Date: Fri,  5 Sep 2025 13:02:23 +0200
Message-ID: <20250905110226.485009-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user_nul() to
improve and simplify hmcdrv_dev_write(). Remove the manual
NUL-termination.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/s390/char/hmcdrv_dev.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index e069dd685899..b26fcf6849f2 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -244,24 +244,17 @@ static ssize_t hmcdrv_dev_write(struct file *fp, const char __user *ubuf,
 				size_t len, loff_t *pos)
 {
 	ssize_t retlen;
+	void *pdata;
 
 	pr_debug("writing file '/dev/%pD' at pos. %lld with length %zd\n",
 		 fp, (long long) *pos, len);
 
 	if (!fp->private_data) { /* first expect a cmd write */
-		fp->private_data = kmalloc(len + 1, GFP_KERNEL);
-
-		if (!fp->private_data)
-			return -ENOMEM;
-
-		if (!copy_from_user(fp->private_data, ubuf, len)) {
-			((char *)fp->private_data)[len] = '\0';
-			return len;
-		}
-
-		kfree(fp->private_data);
-		fp->private_data = NULL;
-		return -EFAULT;
+		pdata = memdup_user_nul(ubuf, len);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+		fp->private_data = pdata;
+		return len;
 	}
 
 	retlen = hmcdrv_dev_transfer((char *) fp->private_data,
-- 
2.51.0

