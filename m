Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520FE7082A
	for <linux-s390@vger.kernel.org>; Thu,  4 Sep 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986296; cv=none; b=fQaONNBxqPNBzH62iIb52p1k7d1yJOgmocE4IHC+DYwP9WMOs8/Ddex0dKihvmuExCNfcmHMCrnxLdiD50AtyCHCf86J5Y0MIBa8C+jW7aHr8bMbY0DRB40QyQIN0SO+7/tjMedv11Lrp5o9mJcG83+fvFYJ+GlSwIP6Rkb5Ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986296; c=relaxed/simple;
	bh=0SvCWsO/EmvjlGbOFiORpjpydwP4uAT2dCEsnnP9ucs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWL7mMUAlSCGxSb25JKWsslfbKjdoP0bVyNy7N4qabQV+snYVx/ozmX8u73FiO+PiFO2w+qhSyGjrrsDlQXzvIKzcEPyRJm27buivDzl7JgssWtsUtbzWAuBjEvB6pljWkQMl59waM0EmD1bQMWD2lrzVZx+4G58zfke8rVHd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wweGs0AU; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wweGs0AU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756986282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q/KBYixzTNLwvMvXGKgDgIGZ5IDJw9DNQGrVTgunH3k=;
	b=wweGs0AUebeqWDuIXbrUfaztEzaBXqwZKgzvD9tEzukR4rG7iVduRG/rZI3pCt9cBMc7I7
	VuxCO7tImsH6ZaAthWrWGjRZaXIv4LLBmzetxsZSucLPBKkRzMz7S5rtfYl40UYZY+RTsv
	6eKfxX36SUZhHK+1R5QKpRASX3YVN/k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	"Bill O'Donnell" <bodonnel@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Joel Granados <joel.granados@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Wei Liu <wei.liu@kernel.org>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/debug: Replace kmalloc() + copy_from_user() with memdup_user_nul()
Date: Thu,  4 Sep 2025 13:40:29 +0200
Message-ID: <20250904114031.353365-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user_nul() to
improve and simplify debug_get_user_string(). Remove the manual
NUL-termination.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/debug.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index c62100dc62c8..6a26f202441d 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1416,18 +1416,12 @@ static inline char *debug_get_user_string(const char __user *user_buf,
 {
 	char *buffer;
 
-	buffer = kmalloc(user_len + 1, GFP_KERNEL);
-	if (!buffer)
-		return ERR_PTR(-ENOMEM);
-	if (copy_from_user(buffer, user_buf, user_len) != 0) {
-		kfree(buffer);
-		return ERR_PTR(-EFAULT);
-	}
+	buffer = memdup_user_nul(user_buf, user_len);
+	if (IS_ERR(buffer))
+		return buffer;
 	/* got the string, now strip linefeed. */
 	if (buffer[user_len - 1] == '\n')
 		buffer[user_len - 1] = 0;
-	else
-		buffer[user_len] = 0;
 	return buffer;
 }
 
-- 
2.51.0

