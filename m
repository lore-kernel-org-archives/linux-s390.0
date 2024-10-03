Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AC146A73;
	Thu,  3 Oct 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956961; cv=none; b=R9qioF0qv6wq5V6vigscQfGP5PLmWdtomkrzK0zBJGfMixWLZA1UWwn5SiKbyOH+veyloQOFPezKwnDOFKN+pXZOCwbghcZp0x7o/Vo6cslV29xPsisDohcpH34gt6QGLD/QPAwlSd+ZuY02hPXT3JX/kj9BWWVCavvrC2RfHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956961; c=relaxed/simple;
	bh=iLCrUuOVzAYv1y7l14VGKpaWltyXFfLqv/OjMjsEi5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7WCIRqUHtC1lA67mETbvHybfuuUrbSeekd/mJxeyFKEHNQJ2CHcIOGZ9AiqWv53eelPxMOqR1qsSpA/1uQ/+kshW17vrqndwcm+nET9m7hD6G5AtuC8+easKuJjHBFAy8WncCciZe0KddpTzvJ8q9t3+u/1voRvYExM6ibw38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toertel.de; spf=pass smtp.mailfrom=toertel.de; dkim=pass (2048-bit key) header.d=toertel.de header.i=@toertel.de header.b=bWxy/mFk; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toertel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toertel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toertel.de header.i=@toertel.de header.b="bWxy/mFk"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4XK9CK3BvDz7ywf;
	Thu,  3 Oct 2024 13:57:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toertel.de; s=key2;
	t=1727956637; bh=iLCrUuOVzAYv1y7l14VGKpaWltyXFfLqv/OjMjsEi5A=;
	h=From:To:Cc:Subject:Date:From;
	b=bWxy/mFkJCQposUC4x8DM/lEgf/2XisJdi/XtYiNqmcVl9HMkFQYD5yrF8yeJ2sKI
	 AnCjkdKIK94Uyk++gT1vZ13YICfa8uUTfycCHRM0vUUfHBl0PB0qKvZ8vASQc4FuYB
	 hZznxepOM79lvap52YEtB6tWWvNBAJAI4TP+eUeij25GQmU44ZR6NQDfRWWGE5pKnC
	 gaa/Z0VmlLcswIXyPYDJg4grMvH8lAJXPcTai2DNQHG+iSYtfVdjw8lEa6unyqiQJ7
	 DSvw2tXY53HYJW37Ro3XZeod70hpCAkqbTAlcMvZxK73GmdYLV4UDVe2CVHEuRwOe3
	 Vz6V/s2pzS+nQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4XK9CK2n56z7ywV;
	Thu,  3 Oct 2024 13:57:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe932.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4XK9CJ5y57z8tZ8;
	Thu,  3 Oct 2024 13:57:16 +0200 (CEST)
Received: from localhost.localdomain (p5b3330c7.dip0.t-ipconnect.de [91.51.48.199])
	by mxe932.netcup.net (Postfix) with ESMTPSA id 27E04603CF;
	Thu,  3 Oct 2024 13:57:12 +0200 (CEST)
Authentication-Results: mxe932;
	spf=pass (sender IP is 91.51.48.199) smtp.mailfrom=antonia@toertel.de smtp.helo=localhost.localdomain
Received-SPF: pass (mxe932: connection is authenticated)
From: Antonia Jonas <antonia@toertel.de>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	toertel@gmail.com,
	Antonia Jonas <antonia@toertel.de>
Subject: [PATCH] s390: Correct typo CYLCE
Date: Thu,  3 Oct 2024 13:56:40 +0200
Message-ID: <20241003115648.26188-1-antonia@toertel.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <172795663255.537852.16134110211128304351@mxe932.netcup.net>
X-Rspamd-Queue-Id: 27E04603CF
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: awclxUwxGO/2dI8cQH18HrQ1x3p31oda0kI7IxPNJcyM9A==

Signed-off-by: Antonia Jonas <antonia@toertel.de>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index e2e0aa463fbd..b32da69c2281 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -835,7 +835,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 	return validate_ctr_version(hwc->config, set);
 }
 
-/* Events CPU_CYLCES and INSTRUCTIONS can be submitted with two different
+/* Events CPU_CYCLES and INSTRUCTIONS can be submitted with two different
  * attribute::type values:
  * - PERF_TYPE_HARDWARE:
  * - pmu->type:
-- 
2.43.0

