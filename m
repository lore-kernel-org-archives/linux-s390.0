Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2439280C
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644915; cv=none; b=TimR3TZnvUUv+4N64XYg6VvT9RhzF3QLsGeMV30lgwIwkprnbrZZ5sjYOynnN9ls0+FLye725Ny/UVPNXQ0VMdTRI+HHSXScuWQygc+YdTbYh8wrrFXrH6gs2CD3Q5gibQkw2wr/iToEMjTkQpdLn1r7qLBwWauBCOI5rF4UcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644915; c=relaxed/simple;
	bh=ZiP2/jRFYzX7XcuvDC36XuCNtrYxPTdVBGe8uC3fy1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lvkr++EP+vLPRJFGGhUQIbknKE3FxPtPYW2xs5EPoY9dlgc3ECnrEzuwslGY9ad9eMipLWa52PkpJmTgsICYfNd5wM6afpNX2x5k1mHAFsimAfBViOfCCTW3zLVmie3tXPLy+sDmD9/2oFo0figIrNl3nB5YX+aB8DZsQX+XNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABFzHL6F; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABFzHL6F"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1273dfdaf5dso1689855c88.0
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644913; x=1775249713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEJVuDKnjdgqU8zwIL3/sLmobVk+HSWnDM5ddTiDQu8=;
        b=ABFzHL6FkSiY7VLGzodEmZWlqpkqlqGpkR2TAZFTDFdkayGESmfWgTU4cYB000Qf8Q
         c2D9UyYV+wsEamAGtcfQFQ2WgSRV5veeKuf8Q7YnWxi1LqCovVkGto1OBU+ius1tQlXI
         5dwwfC+Z1RC85B4GHivn1jqI9vDma1lh5C1F9tEQP7Mqqoy7Vq6W7dv11nvEJo8fiaRt
         w1zc9L6AXBlbPSB2d/I3DbWUzC0onjzDHgD1Tf/vz+CjtLb3Z+29CmvBkLg4P+QCux04
         zB39uxZktRCmS3tsmYxu6nFy9pDyWOPNgCS1gbtUKyTV/uO1lsU0l9hQJYNLTnNhBEVz
         KDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644913; x=1775249713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEJVuDKnjdgqU8zwIL3/sLmobVk+HSWnDM5ddTiDQu8=;
        b=RfiAP+kyJzpOEWSibBgJ42Zwt2S7kEYfnpLvCX5FTJdpVbjy7ACHAf0sraDjJcvYVb
         jvqOJXQAHRCF1N9fhvnysk5LqHgGD0XnFDCQZw/zG9GwGAyozkOoiUc4JvdGEVstYgIZ
         fqtlDaM01SW7WVWoXGV9qWyTwl59WG1Y3o7nd5ddtTqMv/w8QsCb5C/VqERbJYo2gpCU
         e04bqAuP7nm4LUMcwXDq4DfN1mI95b3IahQuQ5EAkoNrKDtXmG8NX6QprKeqgAKZyr1F
         kvihFRjb4GhinFEv3Rh7wHsNdcr4+knMR4Yo6zaa8aMIDeUj2ngURlVNUPAOdLIH80Hq
         o3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXQUd6d0Z2n0oxegEnOoOFMj/DRAZd1IydkY1rLu/8Jt7MLnuSGpe1VjYnXNyA+mo3YkklqYGJF7ufi@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCo3DTiVTYxVEQFS2/xJjbEXQ0BLmisN66AjeAxOpE9ijetWW
	mFEDD3VcoVHcFpY75CPE5TpHgYYKIjEYFb4Pxr3GXM/OY2W/iTgC04zt3TS8sLB3lRD0dtX8nST
	6eOgZtQ==
X-Received: from dly16-n1.prod.google.com ([2002:a05:701b:2050:10b0:12a:7f27:56f7])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6099:b0:119:e569:f874
 with SMTP id a92af1059eb24-12ab3045876mr1405563c88.17.1774644912438; Fri, 27
 Mar 2026 13:55:12 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:56 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-6-surenb@google.com>
Subject: [PATCH v6 5/6] mm: use vma_start_write_killable() in process_vma_walk_lock()
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable() when
process_vma_walk_lock() is used with PGWALK_WRLOCK option.
Adjust its direct and indirect users to check for a possible error
and handle it. Ensure users handle EINTR correctly and do not ignore
it. When queue_pages_range() fails, check whether it failed due to
a fatal signal or some other reason and return appropriate error.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/task_mmu.c | 12 ++++++------
 mm/mempolicy.c     | 10 +++++++++-
 mm/pagewalk.c      | 22 +++++++++++++++-------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca1..33e5094a7842 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1774,15 +1774,15 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	struct vm_area_struct *vma;
 	enum clear_refs_types type;
 	int itype;
-	int rv;
+	int err;
 
 	if (count > sizeof(buffer) - 1)
 		count = sizeof(buffer) - 1;
 	if (copy_from_user(buffer, buf, count))
 		return -EFAULT;
-	rv = kstrtoint(strstrip(buffer), 10, &itype);
-	if (rv < 0)
-		return rv;
+	err = kstrtoint(strstrip(buffer), 10, &itype);
+	if (err)
+		return err;
 	type = (enum clear_refs_types)itype;
 	if (type < CLEAR_REFS_ALL || type >= CLEAR_REFS_LAST)
 		return -EINVAL;
@@ -1824,7 +1824,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 						0, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
@@ -1837,7 +1837,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 	}
 	put_task_struct(task);
 
-	return count;
+	return err ? : count;
 }
 
 const struct file_operations proc_clear_refs_operations = {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c38a90487531..51f298cfc33b 100644
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
@@ -1545,7 +1546,14 @@ static long do_mbind(unsigned long start, unsigned long len,
 			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
 
 	if (nr_failed < 0) {
-		err = nr_failed;
+		/*
+		 * queue_pages_range() might override the original error with -EFAULT.
+		 * Confirm that fatal signals are still treated correctly.
+		 */
+		if (fatal_signal_pending(current))
+			err = -EINTR;
+		else
+			err = nr_failed;
 		nr_failed = 0;
 	} else {
 		vma_iter_init(&vmi, mm, start);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3ae2586ff45b..eca7bc711617 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -443,14 +443,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
 		mmap_assert_write_locked(mm);
 }
 
-static inline void process_vma_walk_lock(struct vm_area_struct *vma,
-					 enum page_walk_lock walk_lock)
+static int process_vma_walk_lock(struct vm_area_struct *vma,
+				 enum page_walk_lock walk_lock)
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
@@ -462,6 +461,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 		break;
 	}
 #endif
+	return 0;
 }
 
 /*
@@ -505,7 +505,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
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
@@ -722,6 +724,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
@@ -729,7 +732,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -752,6 +757,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (!walk.mm)
 		return -EINVAL;
@@ -759,7 +765,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
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

