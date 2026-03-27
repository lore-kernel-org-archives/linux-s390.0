Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A83939A9
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644906; cv=none; b=DC8cDJKLWobw9N8++KkVWvKW2Vl65hH1yUuDE22Gj4U5qlGJyFxR6vS1EvwoLlQTTOWl5t2+tIQOcQuzHZ/rZrowByGUY4nk3erGpTri7Hcg1OfbavG33AY9J2OAqWP3q4qp7yYg2JR/EwlVKWDysEbuu27wFZFo37v1zr6woyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644906; c=relaxed/simple;
	bh=sf6ZRopiRtrqEMlCQEVNfp8Vt7nygFqSKsvnUNGcEHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kX4u+zzDcpC3Ur9oBQrajmCAG2lKOZTbjycOopEF3lZUxKUxxsMih5l8mAlUihvjuHDMXkJbjHmX1ox/zwGaNs1qiKX8C3u65RTDjxtc9sKg/1ZqDnBG1v2vxnD7n4epQpclssQ1GfPzed8Ndowu/wwRvPzgjOXVG5zojGYeXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BkvU6rb4; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkvU6rb4"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so15858554c88.1
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644904; x=1775249704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=BkvU6rb4BYHmR4p3Wk+QDNO0TBlWxNe1tIlqSbA8NwcwUoHp8crupNLwnd0kc7yxWR
         UUh1cjLbFYrbZfPI64MPccmpFv0O8NixBRpiyejesyqEc5WFfuCzzmkO9tpSOpRKWYs/
         cqdx2b5PuFBULdT3aTK20OHyShX04fM1R2oZHyg8pdi5P+xHd2nG4bhYFD+W0nZam9XS
         a9+2VoUiEGXyuTOa6Xgw4QG4myUtjsDyDKH7vHbACg9YVySvSWRoJQMXlA7OLqSDednt
         4DalXTwS4A/KV5nZ8VCu6N8aimslENrM7w+tsHiEQ+8Cl14tWs6Rhcs4N1DQrZ85WVlV
         DcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644904; x=1775249704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=BA2agH7486e4HP7DVv6NhV1xhlvrQ7prDHtL/0TVvE8ERl0kJPZzb5Qq6XnsrQZW64
         aiJ0k4s8irOcQlC4/Oio0LY824tXSttAqVEfLv/XXNetW2d4OjW+3bDNxuE2CWwlosfe
         N4WgTntJ/XyTBk8QflgcXU4uUSkRx0+AN4qUW6PLqFdrZkuZH0XXgnYcutO1CgBvuYsw
         FRfXLzd4R9NOnVA/FuBsqYmdkHdHHJVQNjlsUEdxlSOvcefWE03s7S0giWjwCetY19M9
         aHkMtO9mjsOTd0E8A3bP26q3QG8cUERBrMXFnBtc5kUSBg5F6gGGyyvsHMsI5fHQIhnd
         z/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5wcMcK+fJNaExVW0IR4Xmv4IBt2+Ggb6fRPltRUs4ezbLvWX7w20yLntx+lmgBB1EnZ448paRNGtH@vger.kernel.org
X-Gm-Message-State: AOJu0YzEioQl0yUzhcO1p0VBfeGsxSICfKMCW8xqjTzff/O22T+BsGRB
	pWrr12eOMJnQcwtUvN961UXGV8ts1xIc3UCh9zpEmw2IlMnq/MuLsBAO+qvVQo9DEYaE7ZO5kQP
	/NgV9og==
X-Received: from dlbsj11.prod.google.com ([2002:a05:7022:f90b:b0:128:dfaf:10ac])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e982:b0:119:e569:f277
 with SMTP id a92af1059eb24-12ab28f2848mr2382854c88.32.1774644903670; Fri, 27
 Mar 2026 13:55:03 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:52 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-2-surenb@google.com>
Subject: [PATCH v6 1/6] mm/vma: cleanup error handling path in vma_expand()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

vma_expand() error handling is a bit confusing with "if (ret) return ret;"
mixed with "if (!ret && ...) ret = ...;". Simplify the code to check
for errors and return immediately after an operation that might fail.
This also makes later changes to this function more readable.
Change variable name for storing the error code from "ret" to "err".

No functional change intended.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 mm/vma.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a43f3c5d4b3d..ba78ab1f397a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1170,7 +1170,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	vma_flags_t sticky_flags =
 		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
 	vma_flags_t target_sticky;
-	int ret = 0;
+	int err = 0;
 
 	mmap_assert_write_locked(vmg->mm);
 	vma_start_write(target);
@@ -1200,12 +1200,16 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * Note that, by convention, callers ignore OOM for this case, so
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
-	if (remove_next)
-		ret = dup_anon_vma(target, next, &anon_dup);
-	if (!ret && vmg->copied_from)
-		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
-	if (ret)
-		return ret;
+	if (remove_next) {
+		err = dup_anon_vma(target, next, &anon_dup);
+		if (err)
+			return err;
+	}
+	if (vmg->copied_from) {
+		err = dup_anon_vma(target, vmg->copied_from, &anon_dup);
+		if (err)
+			return err;
+	}
 
 	if (remove_next) {
 		vma_flags_t next_sticky;
-- 
2.53.0.1018.g2bb0e51243-goog

