Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99A35948
	for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627221; cv=none; b=C829AatWSdoVtzLrX8XGwlhncpuO9Kfzln2VVK8iNqJzTxO+VRAayJsMVnQz9rHgS7k+w1zbV1jy+7Z8wkECGInqh3F7NTf2jPq0M9ncmrFDhZEPQjk/65iC4WYsEkzzQ38HHmwQGqkUa0FpyQdF0n7AZYXyLGV9syy7cS9jWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627221; c=relaxed/simple;
	bh=05k5hO8WIGfcO8n7ZaBd6+95lgroAl4PspGuhUL7DOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjwDnOelyIcHt2XqR181nfFVJh28R62rWQ2ce6H1awyyMvkQuF1j7AqBX1lI+W7l1atkLL4A8E7P7N89Jo4IiGroDb2f6GIIYX90o+vK9uXqmVdasXHgGnNQfvwMNoqzwj20PP9X3LmgUrRK+nSmQca4UNB0xktenuG2MyLkOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cxxz+vEw; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cxxz+vEw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757627206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gJvtzpnT8UuY6/UseMpuukXO7AAd+YqjyZJPLK1pdU4=;
	b=cxxz+vEwTzmDem/JcivptG3cNntfMNFGeqhxqWvmO/ZIDJThMUQTsqVIskajA+PmZf87J/
	zIvTRWY8gNQycG9OcJFjAaRhpvgCgPJ6NRfUPhhId6w640xybMiuscgzMuGyTmlfR3tjEn
	9XtS9wCcfb0YU5JiBZxY8ysvcoSOVNo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/hypfs_sprp: Replace kzalloc() + copy_from_user() with memdup_user()
Date: Thu, 11 Sep 2025 23:45:38 +0200
Message-ID: <20250911214539.1483234-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify __hypfs_sprp_ioctl().

Return early if an error occurs instead of trying to allocate memory for
'diag304' when memory allocation for 'data' already failed.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/hypfs/hypfs_sprp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_sprp.c b/arch/s390/hypfs/hypfs_sprp.c
index 9fc3f0dae8f0..be11634bc7db 100644
--- a/arch/s390/hypfs/hypfs_sprp.c
+++ b/arch/s390/hypfs/hypfs_sprp.c
@@ -73,15 +73,16 @@ static int __hypfs_sprp_ioctl(void __user *user_area)
 	void *data;
 	int rc;
 
-	rc = -ENOMEM;
 	data = (void *)get_zeroed_page(GFP_KERNEL);
-	diag304 = kzalloc(sizeof(*diag304), GFP_KERNEL);
-	if (!data || !diag304)
-		goto out;
+	if (!data)
+		return -ENOMEM;
 
-	rc = -EFAULT;
-	if (copy_from_user(diag304, user_area, sizeof(*diag304)))
+	diag304 = memdup_user(user_area, sizeof(*diag304));
+	if (IS_ERR(diag304)) {
+		rc = PTR_ERR(diag304);
 		goto out;
+	}
+
 	rc = -EINVAL;
 	if ((diag304->args[0] >> 8) != 0 || diag304->args[1] > DIAG304_CMD_MAX)
 		goto out;
-- 
2.51.0

