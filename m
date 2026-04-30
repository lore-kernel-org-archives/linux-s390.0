Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6214279917;
	Thu, 30 Apr 2026 04:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521909; cv=none; b=FGZEA+iQw61H6X4XKDxfZzzWuAWPcDXEg34gBhfj0kerjKjQjwxX9LRWpskOiQalHS163+X/SER7JEjxN0OFgnO8EhMXaaFFJcKTiE+Rrrc2DWL8okXs9oR2wzM+qOvPxK80AXRhppA/XQQXIFn0j72edrNb9Yg+ymSsMDEmpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521909; c=relaxed/simple;
	bh=IOVfryRIB//G7TP35s/rdTIpoHZE33+XU/HgNFu89vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPQNHLyeM7HauSyMbr7nGMe0qW0GVDRmzk78WqDyzHmv574+yJV5//B5jCZA1qJ9MPsev5Z2uFSunHOdpH4cs0LwZQx5kqjx+ezKKKZKyfvzJ8+nYrd+oTY5TpVzQE5tV/lTaiQ8i5VU6P3D4g8NA3nSTZ4GCRxnQ6ug/ZagqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVHmp1Z+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVHmp1Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BA2C2BCB8;
	Thu, 30 Apr 2026 04:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521909;
	bh=IOVfryRIB//G7TP35s/rdTIpoHZE33+XU/HgNFu89vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVHmp1Z+siadLb4Q4UHbDBBFXRgvKznPzVZgfJaZuDYbe4T7jnjjPpsDtJInwZIeE
	 4+I5FPsV3n+vKdFvmZlaVSvEPy/79jVItKW9FKiSkpofZcGT8gtPXTdJbnuWCRBQ7C
	 IotyNjhp+vK1JXwZXT1524wwOq3YNWA8MbefdUygDl892tC+sKqCeBWIognUzoFWBz
	 1ZfPBOz5ggtDlvNtoxkZ97/ykVcs4f1SLEbGN/iXyxKX9lzWM6c+fEG+I0aotBh4/p
	 pL2UOnf780mijkJBKnrAw7yfy8qSdrHqgtuQ3Q+6qcVgHDWif223rrlC6SFHrfHNEh
	 uuxK+cvO1oYsg==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	willy@infradead.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jack@suse.cz,
	pfalcato@suse.de,
	wanglian@kylinos.cn,
	chentao@kylinos.cn,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	liyangouwen1@oppo.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	"Barry Song (Xiaomi)" <baohua@kernel.org>
Subject: [PATCH v2 3/5] mm: Move folio_lock_or_retry() and drop __folio_lock_or_retry()
Date: Thu, 30 Apr 2026 12:04:25 +0800
Message-Id: <20260430040427.4672-4-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260430040427.4672-1-baohua@kernel.org>
References: <20260430040427.4672-1-baohua@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

folio_lock_or_retry() is effectively only used in mm/memory.c,
not in the filemap code. Move it there and make it static.

The helper __folio_lock_or_retry() can be folded into
folio_lock_or_retry(), allowing it to be removed.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 include/linux/pagemap.h | 17 -------------
 mm/filemap.c            | 45 ----------------------------------
 mm/memory.c             | 53 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 62 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1f50991b43e3..500ab783bf70 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1101,7 +1101,6 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
@@ -1198,22 +1197,6 @@ static inline int folio_lock_killable(struct folio *folio)
 	return 0;
 }
 
-/*
- * folio_lock_or_retry - Lock the folio, unless this would block and the
- * caller indicated that it can handle a retry.
- *
- * Return value and mmap_lock implications depend on flags; see
- * __folio_lock_or_retry().
- */
-static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
-					     struct vm_fault *vmf)
-{
-	might_sleep();
-	if (!folio_trylock(folio))
-		return __folio_lock_or_retry(folio, vmf);
-	return 0;
-}
-
 /*
  * This is exported only for folio_wait_locked/folio_wait_writeback, etc.,
  * and should not be used directly.
diff --git a/mm/filemap.c b/mm/filemap.c
index a045b771e8de..b532d6cbafc8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1740,51 +1740,6 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 	return ret;
 }
 
-/*
- * Return values:
- * 0 - folio is locked.
- * non-zero - folio is not locked.
- *     mmap_lock or per-VMA lock has been released (mmap_read_unlock() or
- *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY and
- *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still held.
- *
- * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
- * with the folio locked and the mmap_lock/per-VMA lock is left unperturbed.
- */
-vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
-{
-	unsigned int flags = vmf->flags;
-
-	if (fault_flag_allow_retry_first(flags)) {
-		/*
-		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
-		 * released even though returning VM_FAULT_RETRY.
-		 */
-		if (flags & FAULT_FLAG_RETRY_NOWAIT)
-			return VM_FAULT_RETRY;
-
-		release_fault_lock(vmf);
-		if (flags & FAULT_FLAG_KILLABLE)
-			folio_wait_locked_killable(folio);
-		else
-			folio_wait_locked(folio);
-		return VM_FAULT_RETRY;
-	}
-	if (flags & FAULT_FLAG_KILLABLE) {
-		bool ret;
-
-		ret = __folio_lock_killable(folio);
-		if (ret) {
-			release_fault_lock(vmf);
-			return VM_FAULT_RETRY;
-		}
-	} else {
-		__folio_lock(folio);
-	}
-
-	return 0;
-}
-
 /**
  * page_cache_next_miss() - Find the next gap in the page cache.
  * @mapping: Mapping.
diff --git a/mm/memory.c b/mm/memory.c
index 00ee1599d637..0c740ca363cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4442,6 +4442,59 @@ void unmap_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
+/*
+ * folio_lock_or_retry - Lock the folio, unless this would block and the
+ * caller indicated that it can handle a retry.
+ *
+ * Return values:
+ * 0 - folio is locked.
+ * non-zero - folio is not locked.
+ *     mmap_lock or per-VMA lock has been released (mmap_read_unlock() or
+ *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY and
+ *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still held.
+ *
+ * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
+ * with the folio locked and the mmap_lock/per-VMA lock is left unperturbed.
+ */
+static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
+					     struct vm_fault *vmf)
+{
+	unsigned int flags = vmf->flags;
+
+	might_sleep();
+	if (folio_trylock(folio))
+		return 0;
+
+	if (fault_flag_allow_retry_first(flags)) {
+		/*
+		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
+		 * released even though returning VM_FAULT_RETRY.
+		 */
+		if (flags & FAULT_FLAG_RETRY_NOWAIT)
+			return VM_FAULT_RETRY;
+
+		release_fault_lock(vmf);
+		if (flags & FAULT_FLAG_KILLABLE)
+			folio_wait_locked_killable(folio);
+		else
+			folio_wait_locked(folio);
+		return VM_FAULT_RETRY;
+	}
+	if (flags & FAULT_FLAG_KILLABLE) {
+		bool ret;
+
+		ret = __folio_lock_killable(folio);
+		if (ret) {
+			release_fault_lock(vmf);
+			return VM_FAULT_RETRY;
+		}
+	} else {
+		__folio_lock(folio);
+	}
+
+	return 0;
+}
+
 /*
  * Restore a potential device exclusive pte to a working pte entry
  */
-- 
2.39.3 (Apple Git-146)

