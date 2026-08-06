Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC03EB81B;
	Thu,  6 Aug 2026 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047877; cv=none; b=S9NgNqfjysIVfprO7DLhiT8uO2IcgQQX38eh2n56qZCnniJgpA+mb3MdHUPGm3Hxe8QaSqNP7ny0fZAV9uBc9Uq9gGiRJB9toASAG9GPnSGnZo7oj0DyLSzxbGM13d5QoBcqeU9Db4L/dsMmCVhLnYlSIYZc5R8RwmSS+pfGoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047877; c=relaxed/simple;
	bh=PoziUiui+lcnTYeWIW/Jvhg/0j22lR+6q9emZ8jY5cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsCkQpMc27W3GVxuvgHcinNFU0tUHzp46BtxMB9VC4QzJyHL5+Ej4TbpeYbXuwdm/75wy3kZ4mUgs+dhZDDlYomCTZ1h0OwE2Zz5kr1UC8QVbS0QN/wmgSWNPyzE9nN2ptcknAqLca4Rfr0mMWYcdfLeqe1oZlyJqn3SZMYsEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp1FKM+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp1FKM+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891461F00A3A;
	Thu,  6 Aug 2026 20:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047876;
	bh=bUF1A3bcjWsndOSThJkFooCv37wa4dNhaU3NAGA1ezE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Fp1FKM+eLh5lvZtVWpPOiPsPqz5lQD/UnC4C7x8GrG+pqXLW/xDbNogoYOsEm4YZu
	 J/f+dynwiGc8gWGd5RQ3MrJ05O0wWbz3sXxb1KnEMnfYdqhj56aavycaVzEqQymBvT
	 +nBrYxwuCHQRPay/Be9u2UYokJcnPUUrnqTkaf9Eq7yB4yGD9u4MhGFAKa9nYMKsds
	 IjwbQYKfqX5Oy5/O/z5PV9eOEegPxQ9JmqxSx+1zAliK8CxVgGEiMmUib3mc3JPSdC
	 7XJtV8wRQBXn0QDAnVa54BcLBuDpq9ttQsttWkB+QC1JhAbhVJmn3Y3EQjqb6mMR3v
	 tpB3HXYshyITw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 06 Aug 2026 21:21:32 +0100
Subject: [PATCH v4 07/20] mm/vma: fix self-merge check in copy_vma()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-7-ab318a350404@kernel.org>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5496; i=ljs@kernel.org;
 h=from:subject:message-id; bh=PoziUiui+lcnTYeWIW/Jvhg/0j22lR+6q9emZ8jY5cI=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3lzoWL7y96q3d3Zdrt2x0uQKZ88B2drsOjEHpQOuv
 8XSnnKwd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiptkM/6xsazxa/k0wrKzc
 VMJzt/X0oYb0Xz6JW7Ovv9rouCO/lJ3hf/095+r1Fjr83dcapircTzyaImbTqLLy3IL1NzPZSlR
 v8gEA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The existing logic is very confusing so improve things. Firstly rename the
confusing faulted_in_anon_vma variable to can_self_merge and update this
when the page offset is updated.

What is being checked for is a 'self-merge' - that is between the VMA being
remapped and its prior VMA (remember that this is copy_vma() - if a
non-MREMAP_DONTUNMAP remap the original VMA is only removed afterwards).

This can happen if the VMA is moved immediately adjacent to
itself, either before or after it:

		|----------------|----------------|
		|		 |                |
		v		 |		  v
	|...............||---------------||...............|
	|      new      ||      old      ||      new      |
	|...............||---------------||---------------|

In these cases the old VMA is simply expanded to cover the new range.

It is also possible for the move to both self-merge and merge with a prior
VMA if it is placed between a preceding VMA and its old self:

				|---------------|
				|		|
				v		|
	|---------------||...............||---------------|
	|      prev     ||     new       ||     old       |
	|---------------||...............||---------------|

In this case, the old VMA is removed and 'prev' is expanded and replaces
it.

Since copy_vma_and_data() which calls copy_vma() intends to reference the
old VMA after the merge, it must have this pointer updated.

This kind of self-merge is not possible with a succeeding merge, as the
merge always prefers to expand the preceding VMA if possible.

copy_vma() accounts for this by explicitly checking to see if a self-merge
occurred and updating the vmap pointer if so. However it incorrect did so
even for a subsequent merge (this is simply a noop so it had no impact).

So change this to only check for the case which matters - a backwards
merge - and rearrange the parameters to make it clearer we're doing that -
i.e. check new_vma->vm_start < old_vma_start (having already renamed
vma_start to old_vma_start to make it clear this is the previous VMA).

Also update the existing wall-of-text comment to be a lot clearer.

While we're here, replace the VM_BUG_ON_VMA() with a VM_WARN_ON_ONCE_VMA()
and update the VMA userland tests accordingly.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c                         | 35 ++++++++++++++++-------------------
 tools/testing/vma/vma_internal.h |  1 +
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index b5bc3eec961c..18c8f2546765 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1911,10 +1911,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	bool *need_rmap_locks)
 {
 	struct vm_area_struct *vma = *vmap;
-	unsigned long vma_start = vma->vm_start;
+	unsigned long old_vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma;
-	bool faulted_in_anon_vma = true;
+	bool can_self_merge = false;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
 
@@ -1924,7 +1924,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	 */
 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
 		pgoff = addr >> PAGE_SHIFT;
-		faulted_in_anon_vma = false;
+		can_self_merge = true;
 	}
 
 	/*
@@ -1944,24 +1944,21 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	new_vma = vma_merge_copied_range(&vmg);
 
 	if (new_vma) {
-		/*
-		 * Source vma may have been merged into new_vma
-		 */
-		if (unlikely(vma_start >= new_vma->vm_start &&
-			     vma_start < new_vma->vm_end)) {
+		/* Self-merged and VMA replaced. */
+		if (unlikely(new_vma->vm_start < old_vma_start &&
+			     new_vma->vm_end > old_vma_start)) {
 			/*
-			 * The only way we can get a vma_merge with
-			 * self during an mremap is if the vma hasn't
-			 * been faulted in yet and we were allowed to
-			 * reset the dst vma->vm_pgoff to the
-			 * destination address of the mremap to allow
-			 * the merge to happen. mremap must change the
-			 * vm_pgoff linearity between src and dst vmas
-			 * (in turn preventing a vma_merge) to be
-			 * safe. It is only safe to keep the vm_pgoff
-			 * linear if there are no pages mapped yet.
+			 * The only way a VMA can both self-merge and be
+			 * replaced is if the remap places the new VMA
+			 * immediately prior to its old self ('next') and
+			 * immediately after another VMA ('prev') causing the
+			 * next to be removed and prev to be expanded to cover
+			 * the entire range.
+			 *
+			 * This should only be possible if the page offset was
+			 * updated, i.e. the VMA is unfaulted.
 			 */
-			VM_BUG_ON_VMA(faulted_in_anon_vma, new_vma);
+			VM_WARN_ON_ONCE_VMA(!can_self_merge, new_vma);
 			*vmap = vma = new_vma;
 		}
 		*need_rmap_locks =
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 4f6c5666ac07..8a48b231aa7a 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -53,6 +53,7 @@ typedef __bitwise unsigned int vm_fault_t;
 
 #define VM_WARN_ON(_expr) (WARN_ON(_expr))
 #define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
+#define VM_WARN_ON_ONCE_VMA(_expr, _vma) (WARN_ON_ONCE(_expr))
 #define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
 #define VM_BUG_ON(_expr) (BUG_ON(_expr))
 #define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))

-- 
2.55.0

