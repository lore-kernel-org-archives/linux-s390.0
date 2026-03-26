Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00C350A05
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512527; cv=none; b=sZVBLukwNIrmzE9dOGOtaYbV8OG58SyQb0kA0FndoJSuRTaUhPrGIUYHHGplHfHaW/ggTbCimiLvUhlrrwyNh2aBS1ZANzEsNj+EfEvdZBjL6Q1HpipgGBNiZKHq0qGAeaGpc1jbhUQyPB0taHY4x/c6uW029fJiSdh3UJFIeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512527; c=relaxed/simple;
	bh=sf6ZRopiRtrqEMlCQEVNfp8Vt7nygFqSKsvnUNGcEHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EZmjrbnrCz2+wH6G5BYZj663A7/4kFuAeFt3v2xVjH5slZILp6XLOV1rwen3g/84JGlbywdK9XooXPCXcPAgRHe5bCdJCUBffS5HHkjllqHgKBcnqOC0XWkKwyfinmtElztGfxliVUZdRwb+UoiEB+991WT2SslkIiq2c+a7ijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUvHAW7L; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUvHAW7L"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so701473c88.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512524; x=1775117324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=LUvHAW7LNoZv8pxT5kMz299rQ3sQw5KTiRBTHyeSYvnHX3ReTAMcmTsE1upIxRTQJS
         hmNH4G4YgL2xFLEo/9apgYlNbmZ0io9gsE2MOl4ahN+ANNKgxlW+T7P2uXY0+C8naLY/
         YComYY787qk4vXbIIAbbO5J3eRGQe7Ew3bY52n57aNxsucOuoYjf2uZTSedFs/mM/6TQ
         b/iKt2GlTUHmuQKHzWKqa4ZuCMHAVuRAj0Q9ZhqmOc5A1NEWmTvp+GvRnxBaPjXRp14z
         Txx1f5CYqN7XhqNZN3ST+xT4jQPUeKXJC7nfyPG2jl4w8tE9LKnZYWmxNrAZgXCMIX10
         qPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512524; x=1775117324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=UoSyjYrYlkWdb0qqscCNdy1+TYazMOSBnz8tTF2tmZ85LUMqJk2xFL1QaOXnBd4DKr
         rOvMzbB2Nkk7TvAM5H65dvE7AP3iqRH01BrA4Wt0XYz5gVZS2k5XiHFH5L3wZoV+GPEH
         +qeFwfTVRN/bzP3E8ROvJ1GEZMgTN+8MIQqABMqjWjxOH+ily/rvQ6iEguODn95YE9ZF
         k3Yh3C7ixCuisOD5+C8xLcnn7NJcCjtnLvrC5YP2t3jr62SocodGSSjvFAMDCmdkeX0d
         ShNrcqpDLlAptE9f7IqdAzn/w2j0nlpDHTMuErr4s34hcctpQqZ5lPhAVygyi6/h2YCf
         7Liw==
X-Forwarded-Encrypted: i=1; AJvYcCWVgq+9sUivH21GXJTA7orid1sKCzggCbdDts5cmwejSZnRoufq8DvrJTtjdEB7H9L62BvCGIUJFBAP@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIJuG8ZxUgBYI8pdc5PUybzRCp2AKsM+18F9thdMFem1wXAy2
	yzf6u/hNA1bs01/ruf9NOkvGcRaTZyai8BfOsXFL2gc7LzP0rCNmhv9cT556Oed6ZgGhPtJmrZj
	GJwg1Sg==
X-Received: from dykg12.prod.google.com ([2002:a05:7300:578c:b0:2c0:da3c:9f74])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc05:b0:2c0:f424:b545
 with SMTP id 5a478bee46e88-2c15d350374mr3760721eec.15.1774512523474; Thu, 26
 Mar 2026 01:08:43 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:31 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-2-surenb@google.com>
Subject: [PATCH v5 1/6] mm/vma: cleanup error handling path in vma_expand()
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

