Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC8424D44
	for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208255; cv=none; b=SRKRk4KrTNrlNqWfuuE6doTcfDgP1/F3Oe9M3RoOI7UrLE+yuVCf93tXWOiVwuh7emxMmKGHblDsoxpJuO8B9GIFNN3qzvSKA3mkZ5jePTPv879MghISznmr/rjpDlTDWV3FRq3mW7shmQicFmSBZaGo5AIXuDQraMFX+VDanPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208255; c=relaxed/simple;
	bh=AlWKq+WCpJ6jqrd7bHxM+xUmQDKopJjD0aSNOnzQ77Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWyoxt1QnMYOXNlhqTm7H7V8px87KJwzVqz8tTpCeSp2x5bmJ0pnQC4kH5YLaN1slJBKuy5Wvr/BZOZ39dtQk1caC4sBOU53+ryYCkccvulVSXWcm/y8e/F/52tidsDMx4dedflpnkHeBvotwgOQ4QYSJ+8PrZp1t9j7RimWlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=VlQlSpmE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="VlQlSpmE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so25079135e9.2
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2026 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208253; x=1784813053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=VlQlSpmE1Z3leOD1COLVeZhT+Hg9Mz8WNBDSoQQ9udLnHRDIamdI+5I90i9lFdObiC
         KygFfig72N2Y6nJTFQdaubmKvaPpg72DMiik8GnUK00qWd7/nxGEkGZrsaGCQen2AFxZ
         qJlmmWfTUm4lwQv1hkXl8VFpKe2PaMaEgC4IXfDWscZ3qExx4a8tTQBnCxrH4+jc18YU
         Cd01/dtXB1C5pfyjxjDRATPNp2hFbMTzA4Sn4rkyVx8cyN1vC1JPzcxKakzkoyhhjbc4
         CuwhiIINuyl+d1BTW71znX+olnpY7MyDZdcB83qDWVTp7aXbNzqHPCqj2dPZg+Yl2qSR
         tzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208253; x=1784813053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DAcALuj6CLiGGxg2YU+zPjUKqyxKHB8HUr7MGOtyF0=;
        b=VTLhzR/ptgE7Bpp7ZpgslcN6fuvKga9UpWUWy4kPh2zc49MiZ1CI7RzzcEgjlY9JSs
         ag2gZ/TwS72uJ8HCe5npx/HuCJkecyxHRaJe2Ye7mzB4aq4cr0Zl9oJ99VO8HGIFYeC6
         m79rJYVdEGMFBuQ9kaX/Rl3BvPXwJGazUvXkC4M2K6y7/dviajEYTqF/R/xQhiMMki/g
         aJDat13e+ZbpZ9E9dqCQaaTERMVZT/4JY04PQPZzQcSC6k9x618SMBqEj0Tl0DKygTnj
         aNeT9HctoJiOHvgThpBg8y43K3ULt8tvEzQiaUwmP2Ela5OKG786LIf/2Of8t3Jqn4xN
         QkuA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+R2dwcB+VRz3/1N7Rlo0HHM1fMHqwY9TvCTUg8np2QOU4NYN9vCnFY46Wvljgqw9J/cf+ixaMVlTz@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfR/VJuHizhafKwRnHgxnQkYgw0yK2H5daCzUGhMv/lN+IAb1
	yhUMEzDtCLPEm04V9pknDKbQg7InvM0DJ4xMX9B+tgIErD1LIdeblCBG6EbUcQTC16Y=
X-Gm-Gg: AfdE7cmhUkSVZD/4wEcqI7AgUZtOpncW34grt9HKJ3/+UeGEI4+B0JJS4fJ4Tmo1phV
	CKZUcUG8cz5Y88F/BkX5m+xBuzdT4V7ExNDbS6F/Y9+wcvlVjLaJnh/kavmNTfJyg3MQynLFz+g
	imyL9SsT5wYJlcbfaIQbZReA2VpxNk0jCHW0HeWOHqTrrMXbT7rfyKUhjoAlIe/RZvIvUTTChmZ
	x0UYpAf+w8xBwxlO1wEeqJuvHXgeXwBohNJGGyvPFQ3OS6RSCtjIQORAZIgfdKjCHSesPLiCXgr
	dp203yKNm9TBzEZhACOFHoDvGJM0XOOUuSjUQdsNC5cUkVE5B5RX+gff8RHi3j/xGt2SWClkabU
	YJpFlnEFVMzE2ds1QUzUiaOBlHQSJUj0PrXNwIEKbeoNMtoJTcbNH3MrhcLCVIsmo6xZzpwWZfF
	Q80wevoqgXNfzPvR3E9KLHFw==
X-Received: by 2002:a05:600c:6287:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-495474916eemr1028195e9.14.1784208252423;
        Thu, 16 Jul 2026 06:24:12 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a5d7sm23813896f8f.10.2026.07.16.06.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:24:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v3 13/14] RDMA/rxe: Implement disassociate_ucontext callback
Date: Thu, 16 Jul 2026 15:23:14 +0200
Message-ID: <20260716132316.1495242-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132316.1495242-1-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Implement an empty disassociate_ucontext() callback so the RDMA core
can move rxe devices between net namespaces. The core requires this
callback to reset user contexts without waiting for userspace.

rxe needs no teardown here: its user-mapped queues live in
reference-counted vmalloc memory (see rxe_mmap.c) that stays valid
while userspace holds the mappings.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 1ec130fee8ea..6eb10d2f0653 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
 }
 
+static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
+{
+}
+
 /* pd */
 static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
@@ -1478,6 +1482,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.destroy_srq = rxe_destroy_srq,
 	.detach_mcast = rxe_detach_mcast,
 	.device_group = &rxe_attr_group,
+	.disassociate_ucontext = rxe_disassociate_ucontext,
 	.enable_driver = rxe_enable_driver,
 	.get_dma_mr = rxe_get_dma_mr,
 	.get_hw_stats = rxe_ib_get_hw_stats,
-- 
2.54.0

