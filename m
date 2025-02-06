Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8771A00E7
	for <linux-s390@vger.kernel.org>; Thu,  6 Feb 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867883; cv=none; b=DsX+yIV1E13jNIawCtf5unDcFbvqBwLE1W72axJYDyGS/NaWXQzw/c74FgnWhYUxNTobWxjnE1avppEbgxfcdWuy0pfYyt550V65RcHjv4H31gkmyHIlDiucKpMKzX4oclVpLqi+j3rGg8tuR9p176jGKIsmcZDbMMkbqGrfloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867883; c=relaxed/simple;
	bh=kZMcsQE8tmWol8Wm7lSOkd2XdB59ZsBJwEwnyhHgas4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vF+DV4kP0p71AC0J95x0wHnkUki/7MZ0s01Am4Cew9iZPlUM+MhWfEJxXMtvDFdhbwlfEsFVjWe3pkJww+YDz5xAstoQViRtNDRn2mLBpOPmpd4dNQFqHyf0Nd53SJBQtQ4WTx7zFoy2RNPnD5Scg2jXxoyzV5gzYGUNhjloQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dphu4B57; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dphu4B57"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa228b4143so147542a91.0
        for <linux-s390@vger.kernel.org>; Thu, 06 Feb 2025 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738867881; x=1739472681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxP6S0l3dQ+6CkO+pIY1HsOnc8ShdfnkIOi767vYzT8=;
        b=dphu4B57lvnXi/LCOv7bhjTlnIDICM0nicd5OGOo3jdvqOKtFOG9b9WhBVzhIeGvB6
         +HUDaVfp0zb/U+HmUr6XZztPZLkX4tA/DRA1c/d7VXxBsylkHDsPRGZr+YDYxWDFDz/r
         wc/mLGsmNoHCoRU4PwtXoMgUfmK+lcevjR9eJXct8FpPnlRgWDj9tdyMUipeGKBWml+5
         aSZt9wl44X4NRvzTDCQAlVqrRjxLJ+xwiqPX8NLkudh1vxuYRdh+Q2e9XUSj0lzFKnRx
         wSZLKtAObQv0El0EkXcmwrhbz/sE3Eg+g+i5ocAxu8GwN4KS5YWxiLr92pZatKEWx16K
         xRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867881; x=1739472681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxP6S0l3dQ+6CkO+pIY1HsOnc8ShdfnkIOi767vYzT8=;
        b=eievF8nKkHQW7Uf6jHfr62E4Dl8pTBhKlnkHxODFleYUl0AD89sceCVITizomk/rtI
         JN5BEqqzH0zXa1SkZhkUm/fooSWJpy2CUhoWOFLqR83v7829fyZnQgno2HCVhICEJttl
         5JhjMhqZBz3doh3aOCvPapFh5xjdnh0u+m0ZiFPk0/o2nEoC2NxnL8NMM4Z48SjDF0UJ
         hbrWbz6xMH0Z2zwf3cCijWtMXiJ1CAQmVy6ZDRz/R9ZhWjyaoClDiVu7Ou2bwiUOQLBP
         Yg4m0fEuPOngHGiimfEr2lg5eHTMywZDSVmbetTpBtcTJ+mnaM8NXgfDIiNUqPXb69Vk
         Rf3g==
X-Forwarded-Encrypted: i=1; AJvYcCUd8MGBBKkv8lV082/qUTua6TCNf/VWdbhIMQe2ahiK303Ep6izLyC+idaKNUXw3I8TfDbAVQUvQBkX@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTS3NaE8gBy8FneKN1BfuxtGFdKFK8KMbup3rGDuOchcurd/N
	8eUN/pMpn20PAzxhNUqzIr40dRJv18hWegCA8YWDyxZ51ORmGMfVkseaGCfkzyvma98UCg==
X-Google-Smtp-Source: AGHT+IFhAWowVYwEoYtx6mfFOivywbt3Piw8sNnJL4ZJYNh4M1FuUx2ERPDZanvYPgCeFa64BAkgYsQp
X-Received: from pjbse15.prod.google.com ([2002:a17:90b:518f:b0:2f4:3e59:8bb1])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1946:b0:2fa:17e4:b1cf
 with SMTP id 98e67ed59e1d1-2fa247f9fcdmr44198a91.2.1738867881130; Thu, 06 Feb
 2025 10:51:21 -0800 (PST)
Date: Thu,  6 Feb 2025 18:50:43 +0000
In-Reply-To: <20250206185109.1210657-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250206185109.1210657-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206185109.1210657-4-fvdl@google.com>
Subject: [PATCH v3 03/28] mm/cma: introduce cma_intersects function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that CMA areas can have multiple physical ranges,
code can't assume a CMA struct represents a base_pfn
plus a size, as returned from cma_get_base.

Most cases are ok though, since they all explicitly
refer to CMA areas that were created using existing
interfaces (cma_declare_contiguous_nid or
cma_init_reserved_mem), which guarantees they have just
one physical range.

An exception is the s390 code, which walks all CMA
ranges to see if they intersect with a range of memory
that is about to be hotremoved. So, in the future,
it might run in to multi-range areas. To keep this check
working, define a cma_intersects function. This just checks
if a physaddr range intersects any of the ranges.
Use it in the s390 check.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/s390/mm/init.c | 13 +++++--------
 include/linux/cma.h |  1 +
 mm/cma.c            | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f2298f7a3f21..d88cb1c13f7d 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -239,16 +239,13 @@ struct s390_cma_mem_data {
 static int s390_cma_check_range(struct cma *cma, void *data)
 {
 	struct s390_cma_mem_data *mem_data;
-	unsigned long start, end;
 
 	mem_data = data;
-	start = cma_get_base(cma);
-	end = start + cma_get_size(cma);
-	if (end < mem_data->start)
-		return 0;
-	if (start >= mem_data->end)
-		return 0;
-	return -EBUSY;
+
+	if (cma_intersects(cma, mem_data->start, mem_data->end))
+		return -EBUSY;
+
+	return 0;
 }
 
 static int s390_cma_mem_notifier(struct notifier_block *nb,
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 863427c27dc2..03d85c100dcc 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -53,6 +53,7 @@ extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
 
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
+extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end);
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
 
diff --git a/mm/cma.c b/mm/cma.c
index 6ac9173d3a7d..c7116a5819c5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -978,3 +978,24 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+
+bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end)
+{
+	int r;
+	struct cma_memrange *cmr;
+	unsigned long rstart, rend;
+
+	for (r = 0; r < cma->nranges; r++) {
+		cmr = &cma->ranges[r];
+
+		rstart = PFN_PHYS(cmr->base_pfn);
+		rend = PFN_PHYS(cmr->base_pfn + cmr->count);
+		if (end < rstart)
+			continue;
+		if (start >= rend)
+			continue;
+		return true;
+	}
+
+	return false;
+}
-- 
2.48.1.502.g6dc24dfdaf-goog

