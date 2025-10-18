Received: from mail-108-mta219.mxroute.com (mail-108-mta219.mxroute.com [136.175.108.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187B24886E
	for <linux-s390@vger.kernel.org>; Sat, 18 Oct 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807442; cv=none; b=namBBS5Z8Y+T6kH1hTKWchnpvIJM99WexZq9vBhrXmN4yxwrm+cXTDHefiEj2DfN4m+flrekmOU69+zYRhnGdTOBrQb4+IaI4WeFL1+0AoVfgouG5IrajZIAnzE4SSEPJnZ+wJHSwAusJ2xbbaggY0UdJNZrvc9zdb1QACWs3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807442; c=relaxed/simple;
	bh=isUv48RfC+32G6E/apPc1kh0jp1vA5KzEKDiZR4OVmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLG2ewqTuv/raQgEWE1pq8hlSTaxgMrGGdmRSQ2Tv/PR9ZttAviCV0mYT2xJf24+buqRPC+yDU+zeBveOJTFow+jRIu9GCUamxsLYZId9ZDXYYA5KrDiYh1PoY4CvUghyvTJQK2P+1VzS/HdVGrc2nino8lquGO3/BcMiilM2Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=LHLjF33F; arc=none smtp.client-ip=136.175.108.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="LHLjF33F"
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta219.mxroute.com (ZoneMTA) with ESMTPSA id 199f8487c2c000c217.006
 for <linux-s390@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 18 Oct 2025 17:05:24 +0000
X-Zone-Loop: 84cf6e81c9d65f4bb84c54021002abdba4cac4e02f23
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Sender:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=j5n2Zj0bvkxd7gcl32uW6FvwApEeWvBsdGCsdJ7/pxo=; b=LHLjF33FZVbK6SU0+Gf4mtjLDS
	2hTKzMiTDfozW9+Z8a6PdmgBAuoGZ40G0ClHWIUV13zBrq1G0fkKnrDSSLnOA4OM2KcdgTbYTevMi
	Z4h7aLqcq52GJI/f/IQv5uKVyfnI3ftD0i71rZC0BxZSPuUGuSF3UIa4IC+BRLMVVVovK8UGKegjV
	iztLvTKJbQPmNosHuElztTZAteX42aCTqohCp8mnuDhugK+5+tOsGe4Zm6fuJkblUKqIQ5c7R2vfV
	I2FSYcC9pdyB30dr8HLv+2c9Ln9XlwGEOasp1NrG1ycKvY/3ganO4WnqXIySs9gq9dTX9LiAGS+PI
	bDe5nAKw==;
From: Josephine Pfeiffer <hi@josie.lol>
To: agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] s390: ptdump: use seq_puts() in pt_dump_seq_puts() macro
Date: Sat, 18 Oct 2025 19:05:21 +0200
Message-ID: <20251018170521.3355738-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

The pt_dump_seq_puts() macro incorrectly uses seq_printf() instead of
seq_puts(). This is both a performance issue and conceptually wrong,
as the macro name suggests plain string output (puts) but the
implementation uses formatted output (printf).

The macro is used in dump_pagetables.c:67-68 and 131 to output
constant strings. Using seq_printf() adds unnecessary overhead for
format string parsing.

This bug was introduced in commit 6bf9a639e76e1 ("s390/mm,ptdump: make
page table dumping seq_file optional") in 2020, which explicitly stated
it was the "s390 version of commit ae5d1cf358a5 ("arm64: dump: Make the
page table dumping seq_file optional")", copying the buggy arm64
implementation.

Fixes: 6bf9a639e76e1 ("s390/mm,ptdump: make page table dumping seq_file optional")
Signed-off-by: Josephine Pfeiffer <hi@josie.lol>
---
 arch/s390/mm/dump_pagetables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index 9af2aae0a515..3692f9d20f0d 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -51,7 +51,7 @@ struct pg_state {
 	struct seq_file *__m = (m);		\
 						\
 	if (__m)				\
-		seq_printf(__m, fmt);		\
+		seq_puts(__m, fmt);		\
 })
 
 static void print_prot(struct seq_file *m, unsigned int pr, int level)
-- 
2.51.1.dirty

