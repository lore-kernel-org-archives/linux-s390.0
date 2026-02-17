Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24E36F42E
	for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345978; cv=none; b=A4loxCpynF7FEcnZN0tauFn32cT4CuvsKP4qdM9FPASmrybfTSl3YpTAE0jQinJIJjcjKgoR8sLgzInLCQvAHqAShq4RPN27w15q8OGTowTvIu4IM7KEEA0JwehZlyMqpdvHi1lfVjSSFqGx/a+MHAP1aN7MBjbNILAjaShDnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345978; c=relaxed/simple;
	bh=5ko5sZevaLLikb5YibeDPV/ZAP+l239Wav0R9HXJvE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ufaTDMiwi6y3B2tc8hN/IAP5e2ewsP+FnozJsVR1XiC9FZCZgMPblX9OvflAG5gBXSpc0H6bW/Shx3ZGpXXLC2bU/K7Bvs1n7Oz6gozPQvfpzwYlaq3tbictFrsftyAemqauyLIvp6iQNGvLwakYzXjQEVFLcvsWS90g7lH6Sbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOWYw/xS; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOWYw/xS"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba7e98178fso3967450eec.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 08:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771345976; x=1771950776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=20E8AsSTFCwzOiRhIxVDRmNYTsZqkvgm04spnyQD6co=;
        b=bOWYw/xStgqGO07nAt1N/mPv4mjbNFx5rwkOmNskCAIDmK/psW1QNnwiPfynqy3NYM
         VS7bhu9aGntGS3x9AchPlDChjJrf3hw+7z3iV6GXjRP99vVF6ZnoeT2evUXIUp9vNVFd
         vXSuHVGgDfmvVdc2ZZlNHRGbj/pCxMyJ42eoH+H/6ZvRs3MvB1VjW/ni2ApGYKfzL6F/
         8X59PEHnwE9DDzMMElmWPljhM4XR/91T13MD1n5GfZZd3K5j2db5J0Grg7kI+wGmgc01
         njnuORIIdlmXV5hzy0V4XWcpoBUbmBM/q92sTBf6U6MYg2yf2VyFpOr32Cs4A5g8UhTb
         a2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771345976; x=1771950776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20E8AsSTFCwzOiRhIxVDRmNYTsZqkvgm04spnyQD6co=;
        b=Fst5PJqjAxWJvU6OljZ4b717MP/QsH0uBtRtkYjf+45MIoZBEaBK8luSPBAFEzjfJQ
         CiBewK9noH2V0zf4gXreKoDqfXXtEuq7ZJs5ZXbS6IAS+1jPtjA4MD8fXpr1VjzugUm3
         3qtmd7oh3qkO+j9eRKMOyYFiYmNfhA0Bq9tVXYlUNVeKjPjIvUHWd8qWc3LnAsXK5UtC
         engOTfGXJ7LMmDuOzsFJ6AWj9lNN0DR3uR6IbTtR+gxB/4PuqJLSMohhqWvw56xMxh0c
         ekEOI4rUDDFstBfBoX3xZ+CJFZR4H78EZnqkqf5vyS5rykQRyqDpZGeWwqZCR/kDpHm7
         6AEg==
X-Forwarded-Encrypted: i=1; AJvYcCVrJ9v1zUoKQPoe4f5M+CJygMC8n+L9/s4LMltNU37dp+vkLf0i4nwsLFmXdRh4Upsdf02KbK1ZEEYK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqha1X91XRyuJ0XMDOaDIUvtlSggtO3LXll+wRe/TkyIil1VW0
	vwCL6vzdSji4i7WMB20elE67QTyZ2fgibXGSo6HPXQcYC9GeLL2iYj0CdAh8i9/Z3BnyMczfIBe
	q+fijaw==
X-Received: from dybmv5.prod.google.com ([2002:a05:7300:cd45:b0:2ba:9f53:8c70])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c8b:b0:2ba:7f8c:6754
 with SMTP id 5a478bee46e88-2bac97ceddbmr4300008eec.37.1771345975648; Tue, 17
 Feb 2026 08:32:55 -0800 (PST)
Date: Tue, 17 Feb 2026 08:32:48 -0800
In-Reply-To: <20260217163250.2326001-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217163250.2326001-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260217163250.2326001-2-surenb@google.com>
Subject: [PATCH v2 1/3] mm/vma: cleanup error handling path in vma_expand()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vma_expand() error handling is a bit confusing with "if (ret) return ret;"
mixed with "if (!ret && ...) ret = ...;". Simplify the code to check
for errors and return immediately after an operation that might fail.
This also makes later changes to this function more readable.

No functional change intended.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index be64f781a3aa..bb4d0326fecb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1186,12 +1186,16 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * Note that, by convention, callers ignore OOM for this case, so
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
-	if (remove_next)
+	if (remove_next) {
 		ret = dup_anon_vma(target, next, &anon_dup);
-	if (!ret && vmg->copied_from)
+		if (ret)
+			return ret;
+	}
+	if (vmg->copied_from) {
 		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	if (remove_next) {
 		vma_start_write(next);
-- 
2.53.0.273.g2a3d683680-goog

