Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231638E5DF
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089581; cv=none; b=F3kf/g/JDsfTPYpUtSCffT+4wEMraMD3HSHVTxyjnuabm8aoDPDK2EL5zmdSB8FkNJ7sHJZBnM66d2FcLe4qxL6Wpwk22jTfutxNiy7yNhFRFfiHbae+984hbUUnUaFdutPXlJ1DoKlHwEbaCcrXUs7D6MqpwgY/SYBSNsOUidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089581; c=relaxed/simple;
	bh=d8fYsygIXZ64WgQWnqsTL8l3me4MDRp18/QFSjPvsTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aswaeQwwBRrcHGvonX/4WRfk0IEad19KyQD5Uj9o0yot7sv1uX6hoLIYjladAbF0Z+A8GD0FUiNzrMvTCt43qMG7XBFGHDtPFqcNAbbo4wUZeWzC9065anZ7rv2BDX8nNhsrq7tNeN8Y28fA9wfbzE7cIkLntbUu0ghh05stn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlYyYPU/; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlYyYPU/"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdbf9bb128so8009531eec.0
        for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 23:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772089580; x=1772694380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5I1QOj3Vyf2nTpPPlemTkxt7qh7oWHe4YCv7YkUsRic=;
        b=DlYyYPU/5ve63PQcxAhvOWJY3qhmtQ6HtMfAtBIpjSpjCmjGHAQSeoSBovLlpQtauT
         gKy2vKyV656EJbcoZoXVg6gjKvU43zD0wzk225gE4bRzvyIW7SmRZPDXuBKzXTj5u4N+
         3kpTFU3C+0y2rSLwe+5IYtA8BHKqL7VIl7tve70uJfpJEOgcbYYND1WPcia4JGgn4uOM
         UjCouV+Is4bfJK85gSWuSK15AeRnk8Yu/RFXLq78IhxrpEIVjTHN9bNDSMQLb9gHlByW
         jGuCDsyHbd8noSMxKXW0Hl++lKKRcht66R5JGjzSu8+pqwsXN4Wza88gqLNlv/j1Brmb
         x17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772089580; x=1772694380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5I1QOj3Vyf2nTpPPlemTkxt7qh7oWHe4YCv7YkUsRic=;
        b=iXSQQyxjnQVHip6nodUbyGrZ69m/51/kTfAEvBXE3Wd8liLRgNailvghxEhEN79JWS
         ZiAE76zwOK5QIiTamlN9iIWCfw9RVcFVTIjYRSH+sCdL3oPwMyMuY7e99qFv0QHMVjJC
         1HUf4Rsblym91pXvdnj6iMM2A6jo2WtfGcQu38k0LhxKidMASZsKSVbXk/25iCJ3oT65
         SAZb2h/4DCDWZ63AVo9hi9WvBV2Ap45vPZdHyHwgj1P7puG8+GRUf7krH8bo4QMMWg65
         zeI7RU863Vn60RkkncL/TLa9P3weqDXOqGA3v9/DPzKTFhrvRvi2fs1bhdUZKhDYDDNx
         6gMA==
X-Forwarded-Encrypted: i=1; AJvYcCX+dqXlVolTofjPx16vsmGDI8PfkN06Mafw/uZzKFh6xuAVLlkdXdoX83OP3M11kcM6/tskOLcZfo2O@vger.kernel.org
X-Gm-Message-State: AOJu0YzxXW/zykk3nB5MALH1S4wiuaeWWH3hkQRNwIeMKYhsovDBJVQ4
	zJVRk0une7ofRfXFBiVoqhXY6Hf05HeBh1O9JWBoQ6ZRLbaYfQgoTz8r3MdJ604OlBFjfT2HOME
	alDF5sw==
X-Received: from dybri2.prod.google.com ([2002:a05:7300:f082:b0:2bd:c0e6:3762])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:4348:b0:2b4:5b59:af52
 with SMTP id 5a478bee46e88-2bdd301cbc8mr527999eec.29.1772089579483; Wed, 25
 Feb 2026 23:06:19 -0800 (PST)
Date: Wed, 25 Feb 2026 23:06:09 -0800
In-Reply-To: <20260226070609.3072570-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226070609.3072570-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226070609.3072570-4-surenb@google.com>
Subject: [PATCH v3 3/3] mm: use vma_start_write_killable() in process_vma_walk_lock()
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
 arch/s390/kvm/kvm-s390.c |  2 +-
 fs/proc/task_mmu.c       |  5 ++++-
 mm/mempolicy.c           | 14 +++++++++++---
 mm/pagewalk.c            | 20 ++++++++++++++------
 mm/vma.c                 | 22 ++++++++++++++--------
 mm/vma.h                 |  6 ++++++
 6 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7a175d86cef0..337e4f7db63a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2948,7 +2948,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		}
 		/* must be called without kvm->lock */
 		r = kvm_s390_handle_pv(kvm, &args);
-		if (copy_to_user(argp, &args, sizeof(args))) {
+		if (r != -EINTR && copy_to_user(argp, &args, sizeof(args))) {
 			r = -EFAULT;
 			break;
 		}
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e091931d7ca1..1238a2988eb6 100644
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
+		if (err < 0)
+			count = err;
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 90939f5bde02..3c8b3dfc9c56 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -988,6 +988,8 @@ queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
 			&queue_pages_lock_vma_walk_ops : &queue_pages_walk_ops;
 
 	err = walk_page_range(mm, start, end, ops, &qp);
+	if (err == -EINTR)
+		return err;
 
 	if (!qp.first)
 		/* whole range in hole */
@@ -1309,9 +1311,14 @@ static long migrate_to_node(struct mm_struct *mm, int source, int dest,
 				      flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 	mmap_read_unlock(mm);
 
+	if (nr_failed == -EINTR)
+		err = nr_failed;
+
 	if (!list_empty(&pagelist)) {
-		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
+		if (!err)
+			err = migrate_pages(&pagelist, alloc_migration_target,
+					    NULL, (unsigned long)&mtc,
+					    MIGRATE_SYNC, MR_SYSCALL, NULL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
@@ -1611,7 +1618,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 				MR_MEMPOLICY_MBIND, NULL);
 	}
 
-	if (nr_failed && (flags & MPOL_MF_STRICT))
+	/* Do not mask EINTR */
+	if ((err != -EINTR) && (nr_failed && (flags & MPOL_MF_STRICT)))
 		err = -EIO;
 	if (!list_empty(&pagelist))
 		putback_movable_pages(&pagelist);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a94c401ab2cf..dc9f7a7709c6 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -425,14 +425,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
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
@@ -444,6 +443,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 		break;
 	}
 #endif
+	return 0;
 }
 
 /*
@@ -487,7 +487,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
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
@@ -704,6 +706,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
@@ -711,7 +714,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -734,6 +739,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (!walk.mm)
 		return -EINVAL;
@@ -741,7 +747,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
diff --git a/mm/vma.c b/mm/vma.c
index 9f2664f1d078..46bbad6e64a4 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -998,14 +998,18 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (anon_dup)
 		unlink_anon_vmas(anon_dup);
 
-	/*
-	 * This means we have failed to clone anon_vma's correctly, but no
-	 * actual changes to VMAs have occurred, so no harm no foul - if the
-	 * user doesn't want this reported and instead just wants to give up on
-	 * the merge, allow it.
-	 */
-	if (!vmg->give_up_on_oom)
-		vmg->state = VMA_MERGE_ERROR_NOMEM;
+	if (err == -EINTR) {
+		vmg->state = VMA_MERGE_ERROR_INTR;
+	} else {
+		/*
+		 * This means we have failed to clone anon_vma's correctly,
+		 * but no actual changes to VMAs have occurred, so no harm no
+		 * foul - if the user doesn't want this reported and instead
+		 * just wants to give up on the merge, allow it.
+		 */
+		if (!vmg->give_up_on_oom)
+			vmg->state = VMA_MERGE_ERROR_NOMEM;
+	}
 	return NULL;
 }
 
@@ -1681,6 +1685,8 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
+	if (vmg_intr(vmg))
+		return ERR_PTR(-EINTR);
 	if (vmg_nomem(vmg))
 		return ERR_PTR(-ENOMEM);
 
diff --git a/mm/vma.h b/mm/vma.h
index eba388c61ef4..fe4560f81f4f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -56,6 +56,7 @@ struct vma_munmap_struct {
 enum vma_merge_state {
 	VMA_MERGE_START,
 	VMA_MERGE_ERROR_NOMEM,
+	VMA_MERGE_ERROR_INTR,
 	VMA_MERGE_NOMERGE,
 	VMA_MERGE_SUCCESS,
 };
@@ -226,6 +227,11 @@ static inline bool vmg_nomem(struct vma_merge_struct *vmg)
 	return vmg->state == VMA_MERGE_ERROR_NOMEM;
 }
 
+static inline bool vmg_intr(struct vma_merge_struct *vmg)
+{
+	return vmg->state == VMA_MERGE_ERROR_INTR;
+}
+
 /* Assumes addr >= vma->vm_start. */
 static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 				       unsigned long addr)
-- 
2.53.0.414.gf7e9f6c205-goog

