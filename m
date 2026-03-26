Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556338D6A9
	for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512528; cv=none; b=Np9ZTMgPMBUHg6aqh+Nr0LeNBFYFHQ+EFde0XGbXUrHqsKoS2TFEHYhc64jQ88oMGzFHc0L6wLAFz1cGqZ1G3Ah1SDdzmakq2RaoutcW9T+gVt4xiOl/kAO1U4Pt5nbIRyRuIhN3Rh/CUgSS1KxzmyOIQi7kEXeHXXX2OMlbBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512528; c=relaxed/simple;
	bh=t74dnI+rxOISLYbAQ9wo5lkenKT6OQ51Z5+uKLX6Lxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bW8Jkz3MeNk3pz9GYIYQFinqRPrkWT0fz5GdAikrAd9lE0BqtO5IqTHM2WfwVMFsr0BVImlPNYuuTb2zXxyzHF1EXkWdcTmfvctPfo7S/j1w4hEiTDUyQnwWEe7SwqmLoa2t1jzXyUloKawcdyVYe3+OpdmPX3EewwfkPY1IoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLQSdwKL; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLQSdwKL"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12721cd1a2aso5019087c88.1
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2026 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512526; x=1775117326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yXmhx3uKy+6G9q4kJM+us9QDWjdFJDAOgDq56Y4dE=;
        b=tLQSdwKLC8kDAOHCsUi0vAe3124R4x7w9bZHzZR2Ql1ymRZVUdLhQ9/xDBLplca+c5
         RmkYV2q2HljCwsCZXYnWYep/Bh4rywBiYX5rC3RXHyWv/CFmY8Kf39SEPKpmiEnpDCf4
         PWuNfqQNfJoeLFAEqhtr2PyD6Fl2lMmrTXO+CwILorDYmGk9QzG47XCJ61ARvu/Fu0xw
         nAG7+hcUzV0r/nIfLBzzwDAMqzgbamw2mMJk2W3WGJGGnF20srT0XNG3DTq7k46XACQC
         /GJWaLfB2A8NPL9R9SmCnF1pZIV9Km7WDWkZ14GJn7lQVgyfVwAOmyLqjmW4TkczCN2z
         cQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512526; x=1775117326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yXmhx3uKy+6G9q4kJM+us9QDWjdFJDAOgDq56Y4dE=;
        b=Ly8/PWW1hhFK4WLStVUsIiyQXtvFcDxjwoev1ZURTS2KitPsv4+mPqZxDEWzu6iiEL
         3PYhbz6rSKqHCSJSsZVboc+5zujWXcRglDIp5kAlQd3OcGgGoKOkIdr07XEPqBhRnk8w
         fprt/27pBRRhzbNecgOHh8DIdOzXkP4bwEnYKWbNVhLMhWwOrxM9rpUJp5Bryj5Tf3FV
         X59376Qg03Gn6r1UGx7ROODzDqgrTerbKh3BDDVpidnBiOKSWY0WpUvjyGtPLQ8oWQUQ
         uiKlfjzGKv7WWd63z0nUq5D4Ldb/4WkGTIpOA3Cbas+YRyiPwvZ0/T/iyjSV2vQewHF6
         jGNg==
X-Forwarded-Encrypted: i=1; AJvYcCUTUs4su+4Oid7oGQ1zqWUDr479/4eiTKxVpuJ9fIPAs+XyM6ZVVP2KqvMP/JbMPOdSDlaeDaBGRZLm@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqUxCmfktGC1ZO/a7vPJeTu2Yl+y9r1JSW1TL+CQkKGMjsvkA
	XlN7tzGzlkGAeqwCTZm1vsN6x62JkKMh5fndtPuNQGvI1PoJlxLWjSMqZ0xbY1XWN0JN12EAvui
	KWbLTMg==
X-Received: from dlbvs2.prod.google.com ([2002:a05:7022:3f02:b0:128:d36e:eb6f])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:402:b0:11b:c1ab:bdd4
 with SMTP id a92af1059eb24-12a96f04f69mr3338876c88.38.1774512525642; Thu, 26
 Mar 2026 01:08:45 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:32 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-3-surenb@google.com>
Subject: [PATCH v5 2/6] mm: use vma_start_write_killable() in mm syscalls
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

Replace vma_start_write() with vma_start_write_killable() in syscalls,
improving reaction time to the kill signal.

In a number of places we now lock VMA earlier than before to avoid
doing work and undoing it later if a fatal signal is pending. This
is safe because the moves are happening within sections where we
already hold the mmap_write_lock, so the moves do not change the
locking order relative to other kernel locks.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/madvise.c   |  4 +++-
 mm/memory.c    |  2 ++
 mm/mempolicy.c | 11 +++++++++--
 mm/mlock.c     | 28 ++++++++++++++++++++++------
 mm/mprotect.c  |  5 ++++-
 mm/mremap.c    |  8 +++++---
 mm/mseal.c     |  5 ++++-
 7 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 69708e953cf5..feaa16b0e1dc 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -175,7 +175,9 @@ static int madvise_update_vma(vm_flags_t new_flags,
 	madv_behavior->vma = vma;
 
 	/* vm_flags is protected by the mmap_lock held in write mode. */
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma))
+		return -EINTR;
+
 	vma->flags = new_vma_flags;
 	if (set_new_anon_name)
 		return replace_anon_vma_name(vma, anon_name);
diff --git a/mm/memory.c b/mm/memory.c
index e44469f9cf65..9f99ec634831 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -366,6 +366,8 @@ void free_pgd_range(struct mmu_gather *tlb,
  * page tables that should be removed.  This can differ from the vma mappings on
  * some archs that may have mappings that need to be removed outside the vmas.
  * Note that the prev->vm_end and next->vm_start are often used.
+ * We don't use vma_start_write_killable() because page tables should be freed
+ * even if the task is being killed.
  *
  * The vma_end differs from the pg_end when a dup_mmap() failed and the tree has
  * unrelated data to the mm_struct being torn down.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fd08771e2057..c38a90487531 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1784,7 +1784,8 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		return -EINVAL;
 	if (end == start)
 		return 0;
-	mmap_write_lock(mm);
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
 	prev = vma_prev(&vmi);
 	for_each_vma_range(vmi, vma, end) {
 		/*
@@ -1801,13 +1802,19 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 			err = -EOPNOTSUPP;
 			break;
 		}
+		/*
+		 * Lock the VMA early to avoid extra work if fatal signal
+		 * is pending.
+		 */
+		err = vma_start_write_killable(vma);
+		if (err)
+			break;
 		new = mpol_dup(old);
 		if (IS_ERR(new)) {
 			err = PTR_ERR(new);
 			break;
 		}
 
-		vma_start_write(vma);
 		new->home_node = home_node;
 		err = mbind_range(&vmi, vma, &prev, start, end, new);
 		mpol_put(new);
diff --git a/mm/mlock.c b/mm/mlock.c
index 8c227fefa2df..3d9147f3d404 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -419,8 +419,10 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
  *
  * Called for mlock(), mlock2() and mlockall(), to set @vma VM_LOCKED;
  * called for munlock() and munlockall(), to clear VM_LOCKED from @vma.
+ *
+ * Return: 0 on success, -EINTR if fatal signal is pending.
  */
-static void mlock_vma_pages_range(struct vm_area_struct *vma,
+static int mlock_vma_pages_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end,
 	vma_flags_t *new_vma_flags)
 {
@@ -442,7 +444,9 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	 */
 	if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
 		vma_flags_set(new_vma_flags, VMA_IO_BIT);
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma))
+		return -EINTR;
+
 	vma_flags_reset_once(vma, new_vma_flags);
 
 	lru_add_drain();
@@ -453,6 +457,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 		vma_flags_clear(new_vma_flags, VMA_IO_BIT);
 		vma_flags_reset_once(vma, new_vma_flags);
 	}
+	return 0;
 }
 
 /*
@@ -506,11 +511,13 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 	if (vma_flags_test(&new_vma_flags, VMA_LOCKED_BIT) &&
 	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT)) {
+		ret = vma_start_write_killable(vma);
+		if (ret)
+			goto out; /* mm->locked_vm is fine as nr_pages == 0 */
 		/* No work to do, and mlocking twice would be wrong */
-		vma_start_write(vma);
 		vma->flags = new_vma_flags;
 	} else {
-		mlock_vma_pages_range(vma, start, end, &new_vma_flags);
+		ret = mlock_vma_pages_range(vma, start, end, &new_vma_flags);
 	}
 out:
 	*prev = vma;
@@ -739,9 +746,18 @@ static int apply_mlockall_flags(int flags)
 
 		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
 				    newflags);
-		/* Ignore errors, but prev needs fixing up. */
-		if (error)
+		if (error) {
+			/*
+			 * If we failed due to a pending fatal signal, return
+			 * now. If we locked the vma before signal arrived, it
+			 * will be unlocked when we drop mmap_write_lock.
+			 */
+			if (fatal_signal_pending(current))
+				return -EINTR;
+
+			/* Ignore errors, but prev needs fixing up. */
 			prev = vma;
+		}
 		cond_resched();
 	}
 out:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 110d47a36d4b..ae6ed882b600 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -768,7 +768,10 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
 	 */
-	vma_start_write(vma);
+	error = vma_start_write_killable(vma);
+	if (error)
+		goto fail;
+
 	vma_flags_reset_once(vma, &new_vma_flags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
diff --git a/mm/mremap.c b/mm/mremap.c
index e9c8b1d05832..0860102bddab 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1348,6 +1348,11 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
+	/* We don't want racing faults. */
+	err = vma_start_write_killable(vrm->vma);
+	if (err)
+		return err;
+
 	/*
 	 * If accounted, determine the number of bytes the operation will
 	 * charge.
@@ -1355,9 +1360,6 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
-	/* We don't want racing faults. */
-	vma_start_write(vrm->vma);
-
 	/* Perform copy step. */
 	err = copy_vma_and_data(vrm, &new_vma);
 	/*
diff --git a/mm/mseal.c b/mm/mseal.c
index 603df53ad267..3b7737ba7524 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -70,6 +70,7 @@ static int mseal_apply(struct mm_struct *mm,
 
 		if (!vma_test(vma, VMA_SEALED_BIT)) {
 			vma_flags_t vma_flags = vma->flags;
+			int err;
 
 			vma_flags_set(&vma_flags, VMA_SEALED_BIT);
 
@@ -77,7 +78,9 @@ static int mseal_apply(struct mm_struct *mm,
 					       curr_end, &vma_flags);
 			if (IS_ERR(vma))
 				return PTR_ERR(vma);
-			vma_start_write(vma);
+			err = vma_start_write_killable(vma);
+			if (err)
+				return err;
 			vma_set_flags(vma, VMA_SEALED_BIT);
 		}
 
-- 
2.53.0.1018.g2bb0e51243-goog

