Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0CF27604E
	for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767396; cv=none; b=j7sOm023OSKJXgmVXRc6mgALsjbP0v59i5SzqxL0x7Dg4mrKcubx7qChkKQKCBpdZQ86UP7QFz/86NwFRWgNiOAN9VMtV0NWtgLxNqgpPwJa9k4UIGzThuGI9Aq/QnqRIDq28XsnzWQIqxp7ER0RocOS6SXWiWGddqzCQSf5zEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767396; c=relaxed/simple;
	bh=s0deOUnNgMIFiGIX8UNyQZNO2RKvZSA/G/yOBXDqhdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PXU3hYfQK4sDsDAtryfwS7wOvHglUKkma8zJRmZmt2k4y1ouj3SdRM3Xv/qu/XfzhR6qu7S8MLJXvsMkzj2Zx8j4rhqgEjDbkUJxRUCpBxANxhajuvOu3vKrV8ntZuMeZtpGxkcQ1D3VA9opybt42BwIxbk8rA7An7k2tyOXTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2RVXD+v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2RVXD+v"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d1c24b25so37535955ad.0
        for <linux-s390@vger.kernel.org>; Fri, 28 Feb 2025 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767394; x=1741372194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cv0B4/uThibyDXPGrCU6CzEy8xZoS0FJOJ+cAKPL8G4=;
        b=e2RVXD+vmKeg6JaEbngDcna7T+WMYhxk0WKLlUgJD740Bw0So2cqUDsAOKVyHJqzV7
         Cdg4qEG1IV+pvMzDG6XpY22z+fzOrT+Act2cXkSTyed9QLQQtkjdOzsVNRIAlqrEgRYF
         VLP6wrF+449Fjr3bHO1fuEHbVCQskqbhQyqjnLs7+d7AyaBvyyq2LoiiBkoWteVL/F/1
         +4LUOMRwuMWiHld4Scd5jkNAoviLvmTt51fsCQC0yiQVaOna/57yAkXS3HYfXQUXxhkO
         DWQPS8L80zNfIV2CZDMsrFN/GvEmr7stKBwfV1iNCOEdcYuNvWeCTj28zZ+xxYCGTWUl
         RImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767394; x=1741372194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cv0B4/uThibyDXPGrCU6CzEy8xZoS0FJOJ+cAKPL8G4=;
        b=agCwzdYs9eIp6zH/pW4uL1s2HtSVhxh4c0MMqwF/Pnbo4fGU3dLlpq/tkNUKBtdm5y
         CkYAxdtsx6QbRk/mcwcABQc1PI7yZJl/9OcLCz3W4eBMqUaT+UuEICDE+OWmy/YJE8Yt
         OuucwTTX+KFCggOru9CGi1mkctXd9AoXw3bQKhJ7PtFzVyUzVuWkc26ukqgxvMbJBZ/B
         D17/EpcLnMw6Kh3byY3b0ICGyhiid9pEwBcPiPwgrmikGVCgeI6GiwDbMjs9uBnwmUVG
         04LZ6Zvq6BbrMD43VBs54RvdCD1wiCAb4Lif7Vx39DnoLFeMeoJLjddsmjbrpF67DZxh
         tOqg==
X-Forwarded-Encrypted: i=1; AJvYcCV+hpY7bzSYSaR9AqiLwA/bRRuuHzNWqCvfSF7QimCSm2ZFumovYwj3+rsmRoRIZoJMikHU0mzKOkSw@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSzszFDiidG+8K38wf9jB+7/n4HW3XZ/ymRMDr6hXpX5r53lL
	bXu6pBpgwl++Zenw6SZSiDqj6x0mwxHD8D4VMay2Q1LqLLgc5TAb7wNtGYct27lO1Xim6A==
X-Google-Smtp-Source: AGHT+IGsUKkAmT8g+s3WZ9uk+Wed7lmB9nB51UlYclAmGf34PovRshjaGeeXtqu2JnyLABvgZzxxfd3d
X-Received: from pljc15.prod.google.com ([2002:a17:903:3b8f:b0:220:bf5f:1984])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f693:b0:21f:9c48:254b
 with SMTP id d9443c01a7336-22368fa8f86mr82559765ad.24.1740767394131; Fri, 28
 Feb 2025 10:29:54 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:04 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-4-fvdl@google.com>
Subject: [PATCH v5 03/27] mm/cma: introduce cma_intersects function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
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
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
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
index 34caa6b29c99..8dc46bfa3819 100644
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
2.48.1.711.g2feabab25a-goog

