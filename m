Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF74388E68;
	Thu, 13 Aug 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642405; cv=none; b=GlV42g7SbF17Kw18jfE5kFXK0+NeNPtX/XUxP68W9rOxMvFCtsgKtdhGp4SpBdO0KPcFRZfduup6hiEgAR5Pjxzpzrm1AFsiVJpUb8B+Z4mBCZNInC+7WJF5X0cDY/2+Tr9NUWZK7b2MD54lHKVswo6eePEXoG7ZDMM4prXNH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642405; c=relaxed/simple;
	bh=k4nsxhVksl7Id9wH8PF9j9dwGi3ny6iiiLSmQsKoHuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=si9NOZZ9gO9GVCCnxM7DkF+//If50hXTyYpeyHrS6zicyTd2GTfuN94LcHqmyRbIyg1f1Rtbw7ZXqUO+POyf9d50Po5RSJeVNQVXzp/D2jgT7TpQ2PDEIEivWpgJqMUSsSVe7Miw1W6SZIl9l5jprPdfmP+9Pg4YTvSx4Fvh/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edE8IdYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edE8IdYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39091F00A3A;
	Thu, 13 Aug 2026 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786642403;
	bh=DbE5DHkTNtU6STxh6PeRdePiOC2bhJBQkXlvls/SNVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=edE8IdYlIINlenX9lgeJHUProrbMovmH4UE9do8ZRCxNT+52JZtnG6J2Ec8WlhYzD
	 mnMRt30TRAMo9hbN95yoUl3r5ptkkjszHnUjIhsTqtojYCS8LU7H67SdBhjPmAA0sg
	 HkIWDikanTZsQ20dEo918r70Jk/xF4Lx4M42CXZ19ty99RoYBeFc+uGbUHuBd0kLzG
	 IS6dykK3gesLDRnSdFEtApvN9u+GwqGLjS3xDU/AdlqajrIYGCKAykmzpATw+EJfFk
	 2gZXLhLCdnt8tcpxccFRnqIHR4EO/wc8YrDZnnGVb+yayLMza76oRlmPvCMt7ZpWUH
	 fthlzsDNOCBAQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 13 Aug 2026 18:32:18 +0100
Subject: [PATCH v5 01/16] mm/vma: introduce VMA anon page offset field and
 add helpers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-b4-scalable-cow-virt-pgoff-v5-1-c21581c0c3c8@kernel.org>
References: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
In-Reply-To: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8006; i=ljs@kernel.org;
 h=from:subject:message-id; bh=k4nsxhVksl7Id9wH8PF9j9dwGi3ny6iiiLSmQsKoHuc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJq/6+e0XPxYsziC6zu6zNPXOK8/03SJX4jx3bW5mDtO
 wIrmm/FdZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAipfsYGT4rrbO/rfyIRUP2
 6b0ldx7fsr+9/fzrCsvZFtvCVnflHqpm+GfXf/Blx12VfXeLdUzf5fv+nOh323A7/4Xfv27aWeU
 +NuMAAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Establish fields in vm_area_struct to store the anonymous page offset of
VMAs.

Initially, the anonymous page offset of a VMA is vma->vm_start >>
PAGE_SHIFT.

When a VMA is remapped to new_address its anonymous page offset is either
updated to new_address >> PAGE_SHIFT if unfaulted or, if faulted, remains
equal to the anonymous page offset it had when first faulted.

Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
file-backed VMAs are tracked by their file offsets. By adding anonymous
offset as a property of VMAs, we can now track them by their anonymous page
offset instead.

By tracking this, we provide the means by which to eliminate this
inconsistency, and more importantly lay the foundations for future work for
the scalable CoW anonymous rmap rework.

This patch simply adds the fields and some simple helpers. Subsequent
patches will update mm code to make use of these fields correctly.

The fields chosen are packed in the VMA such that, for 64-bit kernel
builds, no additional space is taken up.

The first field is present on cacheline 0 containing key VMA fields, and
the second on cacheline 3, which contains file-backed reverse mapping
fields.

Given the relative time spent accessing reverse mapping fields as well as
updating them, there shouldn't be any performance impact here from false
sharing.

Update the VMA userland tests to account for this change.

No callsites are updated yet, so no functional change intended.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h        | 12 +++++++++
 mm/vma.h                        | 14 ++++++++++
 mm/vma_init.c                   |  1 +
 tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
 5 files changed, 112 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 87feaa5a2b78..df78847f5f07 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct vm_area_struct *vma)
 	return vma_end_pgoff(vma) - 1;
 }
 
+/**
+ * vma_start_anon_pgoff() - Get the anonymous page offset of the start of @vma
+ * @vma: The VMA whose anonymous page offset is required.
+ *
+ * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted then the
+ * anonymous page offset at the time of first fault.
+ *
+ * If the VMA is anonymous, this returns the same value as vma_start_pgoff().
+ *
+ * This value is used for tracking MAP_PRIVATE file-backed mappings by their
+ * anonymous page offset.
+ *
+ * Returns: The anonymous page offset of the start of @vma.
+ */
+static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = 0;
+
+#ifdef CONFIG_64BIT
+	pgoff += vma->__vm_anon_pgoff_hi;
+	pgoff <<= 32;
+#endif
+	pgoff += vma->__vm_anon_pgoff_lo;
+	return pgoff;
+}
+
+/**
+ * vma_end_anon_pgoff() - Get the anonymous page offset of the exclusive end of
+ * @vma.
+ * @vma: The VMA whose end anonymous page offset is required.
+ *
+ * This returns the anonymous exclusive end page offset of @vma, which is useful
+ * for expressing page offset ranges.
+ *
+ * See the description of vma_start_anon_pgoff() for a description of VMA
+ * anonymous page offsets.
+ *
+ * Returns: The exclusive end anonymous page offset of @vma.
+ */
+static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_start_anon_pgoff(vma) + vma_pages(vma);
+}
+
+/**
+ * vma_last_anon_pgoff() - Get the anonymous page offset of the last page in
+ * @vma.
+ * @vma: The VMA whose last anonymous page offset is required.
+ *
+ * See the description of vma_start_anon_pgoff() for a description of VMA
+ * anonymous page offsets.
+ *
+ * Returns: The last anonymous page offset of @vma.
+ */
+static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_end_anon_pgoff(vma) - 1;
+}
+
 static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
 {
 	return desc->end - desc->start;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 939b5ea8c9e0..ebf0d912be7d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -967,6 +967,11 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	/*
+	 * Low 32-bits of anonymous page offset.
+	 * See vma_start_anon_pgoff() comment for details.
+	 */
+	unsigned int __vm_anon_pgoff_lo;
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
 	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
@@ -1041,6 +1046,13 @@ struct vm_area_struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map vmlock_dep_map;
 #endif
+#endif
+#ifdef CONFIG_64BIT
+	/*
+	 * High 32-bits of anonymous page offset.
+	 * See vma_start_anon_pgoff() comment for details.
+	 */
+	unsigned int __vm_anon_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
diff --git a/mm/vma.h b/mm/vma.h
index 0bc7d521e976..54ed7c744e3b 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -283,6 +283,20 @@ static inline void vma_set_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
 	vma->vm_pgoff = pgoff;
 }
 
+static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+{
+#ifdef CONFIG_64BIT
+	vma->__vm_anon_pgoff_hi = pgoff >> 32;
+#endif
+	vma->__vm_anon_pgoff_lo = pgoff & GENMASK(31, 0);
+}
+
+static inline void vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
+{
+	vma_assert_can_modify(vma);
+	__vma_set_anon_pgoff(vma, pgoff);
+}
+
 static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t delta)
 {
 	vma_assert_can_modify(vma);
diff --git a/mm/vma_init.c b/mm/vma_init.c
index 715feee283f0..baa7e82f47e3 100644
--- a/mm/vma_init.c
+++ b/mm/vma_init.c
@@ -51,6 +51,7 @@ static void vm_area_init_from(const struct vm_area_struct *src,
 	dest->vm_end = src->vm_end;
 	dest->anon_vma = src->anon_vma;
 	dest->vm_pgoff = vma_start_pgoff(src);
+	__vma_set_anon_pgoff(dest, vma_start_anon_pgoff(src));
 	dest->vm_file = src->vm_file;
 	dest->vm_private_data = src->vm_private_data;
 	vm_flags_init(dest, src->vm_flags);
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c52b23773cd2..26d9210b1e8b 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -577,6 +577,7 @@ struct vm_area_struct {
 	 */
 	unsigned int vm_lock_seq;
 #endif
+	unsigned int __vm_anon_pgoff_lo;
 
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
@@ -612,6 +613,9 @@ struct vm_area_struct {
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
 	refcount_t vm_refcnt;
+#endif
+#ifdef CONFIG_64BIT
+	unsigned int __vm_anon_pgoff_hi;
 #endif
 	/*
 	 * For areas with an address space and backing store,
@@ -1320,6 +1324,28 @@ static inline pgoff_t vma_end_pgoff(const struct vm_area_struct *vma)
 	return vma_start_pgoff(vma) + vma_pages(vma);
 }
 
+static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = 0;
+
+#ifdef CONFIG_64BIT
+	pgoff += vma->__vm_anon_pgoff_hi;
+	pgoff <<= 32;
+#endif
+	pgoff += vma->__vm_anon_pgoff_lo;
+	return pgoff;
+}
+
+static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_start_anon_pgoff(vma) + vma_pages(vma);
+}
+
+static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *vma)
+{
+	return vma_end_anon_pgoff(vma) - 1;
+}
+
 static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
 {
 	return file->f_op->mmap_prepare(desc);

-- 
2.55.0

