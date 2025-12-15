Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5581C2334
	for <linux-s390@vger.kernel.org>; Mon, 15 Dec 2025 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801360; cv=none; b=brGoGOxcTm7Gylok9Km4MkHRkkb7UXV8V20xWbaQKzpgM02qES08KcbT/lA2G0u/SxLqwEz5PwXOoBE+F+cwX4cEeoqM0ycU/womDN3McIBSHUKVgYi8CV7hWI44o3i8Ii9BzjJNlgZv7+WU/kgk8MNARJapOVPsXAxwMcb+YUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801360; c=relaxed/simple;
	bh=96QLPrrc2OBC50JADV6ayGtUDJLMXKRTwoyE2D7yP6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJJZ4Js23jUC071M/elH455Ggm0/S7MUGdGelLLi/dk1Taqe1ZW4pa4ockbBgBuINgEl4ztDolL0yr6waK0udhxf4BtQWCnxuK3Xh6x24PvqHrN37w/cf+OCMLyD6FiYy+2u0lyhSXPLC6Zdpd3mtdtLVr+Au3ONULpvXox/Jtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ox7RqcDJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ox7RqcDJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765801351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6ld/ZmD/dR1Psr1Cq3hfkaiQuLXvNdSYI64jtTRWPdE=;
	b=ox7RqcDJfCIcIN8Y6nnJ60fsocwgT9g22sg68FHHhiMZWthLRI5LHTYqnwNnFH6KrJQzGG
	t1XroUe6YNU4V1cy7aRmk682c1hrI4fbYGbZYjBG7fS+bwHQzIngYmUsrUN2bjCmPP3Ge6
	Cnw2tMXn5Xk8JyndLkvV23gQuky4j6Q=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/cmm: Account for NUL when calculating 'len' in cmm_timeout_handler
Date: Mon, 15 Dec 2025 13:22:14 +0100
Message-ID: <20251215122214.381098-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the input length 'lenp' equals sizeof(buf), the current code copies
all 64 bytes, but then immediately overwrites the last byte with a NUL
terminator. Limit the number of bytes to copy to 'sizeof(buf) - 1' to
reserve space for the NUL terminator.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/mm/cmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index eb7ef63fab1e..06512bc178a5 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -311,9 +311,9 @@ static int cmm_timeout_handler(const struct ctl_table *ctl, int write,
 	}
 
 	if (write) {
-		len = min(*lenp, sizeof(buf));
+		len = min(*lenp, sizeof(buf) - 1);
 		memcpy(buf, buffer, len);
-		buf[len - 1] = '\0';
+		buf[len] = '\0';
 		cmm_skip_blanks(buf, &p);
 		nr = simple_strtoul(p, &p, 0);
 		cmm_skip_blanks(p, &p);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

