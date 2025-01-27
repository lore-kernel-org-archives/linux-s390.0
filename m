Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071A1DDC2E
	for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020151; cv=none; b=RveEj/zmJdQqzAEA4JfiFGgEA+5MglZULMwtkKpcPjkpSOmOrcJhWX1aNjIg9VyNLxu7YD940zSfUsKe81EYPAWQAd/s9GqL5dABoeNr/XlSfOZJ/ZibN9bsoe5rmrs35JBq2TGW07DbCahQZIPaY3Mrp2SFhcSD0qekMmkMweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020151; c=relaxed/simple;
	bh=iIVz0iaFnVdC85TvJU7bWEbfgairNIkAhFvDjYIxMbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6fraf4/gVkBGblJaO+D84luXQD0B+WLaoRDp+MHDVYe5V5GnaifJ6wUMdZ/sxZRyR12l+LANu+qP22ey39v30PBcTblt4jR/+m3WfQf3GZZLV+BykD5V4GV232W/FURJZdaoH43qgc2ymQNQ/o6T35C7nYCK6MJeFu1tGxD45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NV5Axanp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NV5Axanp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216405eea1fso97807935ad.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Jan 2025 15:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738020149; x=1738624949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXf4/6vVFsOQWOL4yP6AMC2Up5+2J9mezQuBbeYawcA=;
        b=NV5AxanpGTPKE2svJEeFxEBuavTTev+inAhjJBomQBV/deZT978GSKOttAngSnHT7X
         vSJN7CQqBGWBDEvI2yWe81FmurtJdD5fvylkrDBYmHePN/HtIfqAk79jaocIbRnnEAKy
         ovALf906N2x3Um3mt8253+hGc84MV9pQjyjEZry3i1uVdD9WFNJx2lP//bBkGCPCwn9q
         vwj/aX3Rh0AJLiadx6nnUf9evrrWNfxsG7k7fwb7VuOWR7+tYYaIW6E9kZy+Z915cce7
         IxTvoZVbNG7uFZDIR3wHasUGsDRWYgCjDUonVhhHKB6rr3iT7l/hFAoLNv59nRIaX6NG
         FyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738020149; x=1738624949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXf4/6vVFsOQWOL4yP6AMC2Up5+2J9mezQuBbeYawcA=;
        b=VbAWWv0LPpVosWjrXG2KwMSi9k2Vmqu9oV3lbNZXvN2AJRoueSf6mewCda4m51dk5j
         B0aCckFKDpGuyjgqJmy9NX9U+1KuW3nyEKzPesT+xMhZbTOfi/7rjOCcKhXhdvHbWzlc
         gXopsqlkI3mkruCSccWXxxnLzjUk6/FPhaH24CZHTVXXDua0U8leF3SOznJ7xez8Gc6H
         W0kcPOreqFQbG8Rgy4FbVRzVSzZ9UmuicAX3jUmpNMoNN2nNmrwqyjM4iJqVXQAAS+t+
         QEHnilO+O/HrCRdRsCELfeSZijOpNukJbMcbOCHoZghz8/HNJzBzIJb9PU7bsCsedPC0
         Niew==
X-Forwarded-Encrypted: i=1; AJvYcCUQIJbYQZl3pABC8Onqcpe29RhF20Uhqx2IfjDIBU2E8Ds6nYgptb8oZeDJNmSbyKYSPWxBSKA2+UuC@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4rNDsRg1To/q/VnR+I5+MkGDhdAqSS59ngo341JQwL1NYkgq
	WmkYwDCB2m7MpGyJgpZUe/6KaiWz84Pd9rAVqOXIJYPqvLberDHMhnHpfAeN3Gk77Os6hA==
X-Google-Smtp-Source: AGHT+IHacT0c2glOz6iHxFPEkg2efzrTP0CNHsnhpI9lKFAWHWkywal7QfbYZsPNCZVylM+1koVThcNB
X-Received: from pfbcg7.prod.google.com ([2002:a05:6a00:2907:b0:728:aad0:33a4])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:8411:b0:1e7:6f82:3217
 with SMTP id adf61e73a8af0-1eb21465271mr67484709637.3.1738020148864; Mon, 27
 Jan 2025 15:22:28 -0800 (PST)
Date: Mon, 27 Jan 2025 23:21:43 +0000
In-Reply-To: <20250127232207.3888640-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250127232207.3888640-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250127232207.3888640-4-fvdl@google.com>
Subject: [PATCH 03/27] mm/cma: introduce cma_intersects function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usama.arif@bytedance.com, joao.m.martins@oracle.com, 
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
index c20255161642..1704d5be6a07 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -988,3 +988,24 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
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
2.48.1.262.g85cc9f2d1e-goog

