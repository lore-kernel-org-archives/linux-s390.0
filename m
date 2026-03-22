Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86933F59F
	for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774158207; cv=none; b=ZKk7cGjU7aIsx0Xsw5GaTxU+ruHkL6tK0NNZZ7sCtNZS4IiZ5qwf35NQqiNsReLECde8SydYrEwA8xpADRVlnolukrIV0kI/Gj/2ruLHVV8GpL0gqMR7yGmgtrbATdpGZQ4bh2o1u7yqD80LcqQFN8J+kojACqRj0xXKrKzDjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774158207; c=relaxed/simple;
	bh=e3gWeXeUqlHXWzHbzz4ImGosonpJ2v75QKooiU11Mi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eIYqF0EticGgd/xnx+6PrQFXxUgu/wzI59hTkr4oNbE+qTzIoyhP2NVCPEEWwhjm4oyx98FoSwlBp/x46kSCrS2/Hj3c7TQaedVVi++Mf2cuz8YidY7uSS/3A1kl3tXvN1x8gYY4z3i1EjIR8YTwpBwrY7bc30t00qAABFqdX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLOLW2/A; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLOLW2/A"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so3196656eec.1
        for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 22:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158202; x=1774763002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyZbVSMoPQsW5Fww5l9TjItBhtVQ4rSW6pB2FXRdwC8=;
        b=WLOLW2/AyaZEOkBGbNYcql4O4fVEXA+nfjD6oSIQtq/bAj4eotghev7zRVGu1yJ8xP
         5qkbj0Z/fGzHRjNQ/Ep71dLFC6nSaQqx+jYRUDepojhxpRIbQtU5ceT3RBA+YYndwqOQ
         ++McDa6zTJ2y5I+sW+mOQpOZUKl0oyZdM3LCAvSbCLd5BOwDinyyo7RBAILToDgU48a9
         gHciXI895qOfpleuJIxg5HEp7XXs1AVtaVa4Lx6qBH/SSJDmwfOXmguJbw9/pDua1zKX
         TgEfjS/PY55GtLPTm3sorywiZXQzkvJzAZRnfmskE5IDKmgqRCebaCnZ0VbOKGuBVWoJ
         ZzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158202; x=1774763002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyZbVSMoPQsW5Fww5l9TjItBhtVQ4rSW6pB2FXRdwC8=;
        b=sV4t5aq0ACJyT2r/kSFK3gCJNkqiYt0Zo8eZuCAOg9B1EYnXLprlthfrsFAYagfNGB
         7WFYTfsc/GnlhsUfTCdRUf33uDfXqXeWTuxQYVLNOxkt2X1MqM5rsEc0QXrAye4t7pNq
         HKiaqXQ9zrppGUZwNPatYrFfMNBmQOoYBAOLd2XmS3beJELnNmJQ+7yEMMyIilWCihVg
         LNDxqS63aGNPMKEyvkpX7Y1xK47JG7T03F5ejqwjHmBTIh223MRyv1FRn2dxD8+8mpX/
         /7HqNMogdgUaymMNFfVJl0mDHqoJPCqkpitze+tjSEKH8aXEADT3RUiIrE8EMpJEh7P6
         OtPw==
X-Forwarded-Encrypted: i=1; AJvYcCX63jHbLIybWMeFl/fwHDwF6ML9Rqpj5Bak5aSLhmPpn6YKxyDq9miPq+dMxBgrWm2gWqlUfKBm06/F@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyrlrLrINc+v13JOkjVz7HOe6m3BL5G7mCsKcBXAo3Kw9HxlO
	ckCWYR3nrTlPbLFaoEwNO9YRXvP9s0/+xMKRzZ+vSOd92jAf2JRO6IpfMhGzCDd58I2he5P6G4o
	Tapw4VA==
X-Received: from dyx25.prod.google.com ([2002:a05:693c:8219:b0:2c0:c743:7f67])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:220f:b0:119:e56b:98b9
 with SMTP id a92af1059eb24-12a726bb993mr3455319c88.32.1774158201439; Sat, 21
 Mar 2026 22:43:21 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:08 -0700
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-5-surenb@google.com>
Subject: [PATCH v4 4/4] mm: use vma_start_write_killable() in process_vma_walk_lock()
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

Replace vma_start_write() with vma_start_write_killable() when
process_vma_walk_lock() is used with PGWALK_WRLOCK option.
Adjust its direct and indirect users to check for a possible error
and handle it. Ensure users handle EINTR correctly and do not ignore
it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c |  5 ++++-
 mm/mempolicy.c     |  1 +
 mm/pagewalk.c      | 20 ++++++++++++++------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca1..2fe3d11aad03 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1797,6 +1797,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		struct clear_refs_private cp = {
 			.type = type,
 		};
+		int err;
 
 		if (mmap_write_lock_killable(mm)) {
 			count = -EINTR;
@@ -1824,7 +1825,9 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 						0, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		if (err)
+			count = err;
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 929e843543cf..bb5b0e83ce0f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -969,6 +969,7 @@ static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
  *      (a hugetlbfs page or a transparent huge page being counted as 1).
  * -EIO - a misplaced page found, when MPOL_MF_STRICT specified without MOVEs.
  * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK unspecified.
+ * -EINTR - walk got terminated due to pending fatal signal.
  */
 static long
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index eda74273c8ec..a42cd6a6d812 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -438,14 +438,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
 		mmap_assert_write_locked(mm);
 }
 
-static inline void process_vma_walk_lock(struct vm_area_struct *vma,
+static inline int process_vma_walk_lock(struct vm_area_struct *vma,
 					 enum page_walk_lock walk_lock)
 {
 #ifdef CONFIG_PER_VMA_LOCK
 	switch (walk_lock) {
 	case PGWALK_WRLOCK:
-		vma_start_write(vma);
-		break;
+		return vma_start_write_killable(vma);
 	case PGWALK_WRLOCK_VERIFY:
 		vma_assert_write_locked(vma);
 		break;
@@ -457,6 +456,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 		break;
 	}
 #endif
+	return 0;
 }
 
 /*
@@ -500,7 +500,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
-			process_vma_walk_lock(vma, ops->walk_lock);
+			err = process_vma_walk_lock(vma, ops->walk_lock);
+			if (err)
+				break;
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = find_vma(mm, vma->vm_end);
@@ -717,6 +719,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
@@ -724,7 +727,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -747,6 +752,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (!walk.mm)
 		return -EINVAL;
@@ -754,7 +760,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
-- 
2.53.0.1018.g2bb0e51243-goog

