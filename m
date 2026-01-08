Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C83EDADC
	for <linux-s390@vger.kernel.org>; Thu,  8 Jan 2026 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865891; cv=none; b=U7JbWc9mCs2SmMePz3lWvJYsnjtv9MmLeKKBMlIUjXmzgXtzAYeJTcL1P0P7K6SlFz2uyH0WZXw/9jJKPkMhcQwLDAFAOHYwLYx7aN87tu0jmTbX6X6P/rtIO60RAdCV8XcXeIxILLheh377UFQHqVGoCEdxqLfFJlTzWQL6FG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865891; c=relaxed/simple;
	bh=xmLo2lZhXu53rBZMy/uNhBUFyiTKl5Fm7JdKRqI2KVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e71KTeOK1C+LP/2lPaSmEToi6Lc4j2JIGwWyYY1mnBi7R23607I+qkqFcy9du+wZ/AIGhIQmhqCqU31bZFd+aXNkpyHjER3dXOSDHFW/Ij6oCj9buA6QM2o4KuL2l4W5c8/HvEXfGfqR/czdp79IIQOjC7ziuvy0TL9LXmg7zm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=spGeKWvx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="spGeKWvx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767865872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0aBPheDGqSPPstciKVANmfZuxM6igW5CLYMltjipJ5U=;
	b=spGeKWvxq6zz0HoLO0DsRhn5qck9IGbw+KY7C6SQpVjX1x7EVbjVRNf2MlZ5Iwyv2MyvQX
	1iWtfuyyXjrxCjdLZ+g0LaEjhf/YzreK1rGxL+Sl7Zmi8+HiZ8iE6N+akOMY4ra1ltM0v2
	f7X5U8m/N7/+44H4JSSopcJOKqW59tw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nam Cao <namcao@linutronix.de>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/time: Replace simple_strtoul with kstrtouint in sysfs online_store
Date: Thu,  8 Jan 2026 10:50:08 +0100
Message-ID: <20260108095010.99059-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtoul() with the recommended kstrtouint() for parsing
the input buffer. Unlike simple_strtoul(), which returns an unsigned
long, kstrtouint() converts the string directly to an unsigned integer
and avoids implicit casting.

Check the return value of kstrtouint() and reject invalid values. This
adds error handling while preserving behavior for existing values, and
removes use of the deprecated simple_strtoul() helper. The current code
silently sets 'value = 0' if parsing fails, instead of returning
-EINVAL.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/time.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index bd0df61d1907..8439516dc4c4 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -787,7 +787,8 @@ static ssize_t online_store(struct device *dev,
 {
 	unsigned int value;
 
-	value = simple_strtoul(buf, NULL, 0);
+	if (kstrtouint(buf, 0, &value))
+		return -EINVAL;
 	if (value != 0 && value != 1)
 		return -EINVAL;
 	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

