Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF4139D
	for <linux-s390@vger.kernel.org>; Sat, 13 Dec 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765629210; cv=none; b=Z+H8wkR+R+JDeCNVjvvWLdIZEQjw+7rGnJb5DiIxcr4yJxK++jaSiSpfxhdE9pJE09UR/j/XxxTb3s/dQhFLgie/1lpEWg/IBIrYIBpL5St2716ijsl8mm5VOlPFJcUd6nvWupzZPKwEiHUWBrxxK0s54n/EpL6RaI1HhQlqNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765629210; c=relaxed/simple;
	bh=T8Xv7Tq1k9McpqKzeUlwzm0ylkMotFRSnFV/GmzHSlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9MDTZaFpn38L37SOJGn7XQuou/mGkzsASb/LsNh7RPH7tGw3PJGlMYWT10fyVqLMtkx/3OENKApFugfBJKuwqMNhmFH+IDRIhfZBz1l7OiWNWnzhYgXnVupB8/0gqFw+Z3BUrYss65MmNxIkLdsl218G1qk9qfz9FXBbz4tblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=riz5adSQ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="riz5adSQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765629206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZQ8NeLmf4O9dG9dLoQ1tMwqXQsf0kJoqCqVhJUZDe0M=;
	b=riz5adSQYic5bcjZX7wRbHotgD/JnLhAL00Os4HAJDqdlYHBlGRaRRoScN7+MzlNQZ0JIv
	9XZ3SSzrlRR8wOjRIxFPtDY5+5v3Uvg4qYAegXy+K2IR9IXQp4majFE/X00SIssGw6Yf2o
	lo5aIrPbfq1CRiWzlka7h5y6/JT+Siw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	joel granados <joel.granados@kernel.org>,
	Juergen Christ <jchrist@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/spinlock: Replace simple_strtoul with kstrtouint in spin_retry_setup
Date: Sat, 13 Dec 2025 13:32:44 +0100
Message-ID: <20251213123246.356155-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtoul() with the recommended kstrtouint() for parsing
the 'spin_retry=' boot parameter. Unlike simple_strtoul(), which returns
an unsigned long, kstrtouint() converts the string directly to an
unsigned integer.

Check the return value of kstrtouint() and reject invalid values. This
adds error handling while preserving existing behavior for valid values,
and removes use of the deprecated simple_strtoul() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/lib/spinlock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index 10db1e56a811..b4ca53356b96 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -34,8 +34,7 @@ early_initcall(spin_retry_init);
  */
 static int __init spin_retry_setup(char *str)
 {
-	spin_retry = simple_strtoul(str, &str, 0);
-	return 1;
+	return kstrtouint(str, 0, &spin_retry) == 0;
 }
 __setup("spin_retry=", spin_retry_setup);
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

