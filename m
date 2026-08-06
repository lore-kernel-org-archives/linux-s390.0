Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650A363C77;
	Thu,  6 Aug 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047898; cv=none; b=O3GXfMrjkbw7wbuRqzsXPSIA33u1Jm1nt+MNTSC3dgC4sYaYLCC2nKdP83MtbuWZDqxPDOfAgm3c51TXIeOBO8Azgn9G1ClC+vHwctyDyQbN4CG8R1+TIg4WuZF/d4PvlATnQ85JqojGcEh6+bJRqCxVFbf0/COsvKdT2Uz7TZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047898; c=relaxed/simple;
	bh=zAtkjtetOPzY9ZCvVmUG7AAWKdJxJJDvCD2O0e7vMx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIO9RcOssN5Yrf9LLryJVsbHAm5pYuXQW42aeMm8jcKkskPNHYGM8oIxPKbgLw7/Kh02rLDJhR9HOKmsXRM8Q9y4bIxY4fZudXrqrUr9pEmIdIqB6f5zhad/abCcMeOkIAoXYNC3IDG+b4NrNL+lW5Vv4iMzLfhYgTMYIYv9b6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it9dz7Pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it9dz7Pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790AF1F000E9;
	Thu,  6 Aug 2026 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047896;
	bh=PZwB0kepe8H+9w+FQhSK8VcxxvTZJ+pddqATUquP6OA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=it9dz7PpsOSLESWT8uwHQovZ/mvj67amjGnQ8gZRPpDJKKbsnlU1uSsY/1dLyMCXm
	 ba2y3JIf6FNk78aRrHS3h90Kr6M/zps4OruCQfkUBqboYjLqG80QbIkNDmz6dh6n8W
	 mQQ7kUuDbG1OKAQDp8JZG8nSMi9RF7HeuYHqCmUPZ7KC4oQGZ4ajukmQ1MKQXFGu9T
	 da2t8ur2ROVD5M9cVUNxBMGHOP2O4TEhTXJ1wpkcPwiLqj38eL+I6wV+tXv9o1uUMe
	 DYXAowI7nzDQEDDFNPCE9gJ9ol8ld4fAe+ZaBEx3jqA02FiOHvjBi2vKern8w0XtHY
	 30sTdJBOieI1Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 06 Aug 2026 21:21:33 +0100
Subject: [PATCH v4 08/20] tools/testing/vma: add tests for copy_vma()
 self-merge
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-8-ab318a350404@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=ljs@kernel.org;
 h=from:subject:message-id; bh=zAtkjtetOPzY9ZCvVmUG7AAWKdJxJJDvCD2O0e7vMx0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3lyInr43/OZH39eLbKZLSetMY+o5wy2lUrZZ6kDq2
 iXWu51ZO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjARqXuMDFeKHKTsNJ7EiaUb
 PnS1qhWtVE7Z9SV+XdrEE9Ys0v9UVRgZHk67+SqfQVCz8MXRWQ25+bMnhjzuvfSe13jeba8t/kz
 ruAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Assert that a VMA can be moved backwards, forwards and between a preceding
VMA and its old self.

In the cases in which the VMA merges only with itself expect that to be
achieved by expanding its old self, so assert that these function
correctly.

However in the case of a merge between a preceding VMA and itself the
original VMA is removed, so assert that the preceding VMA replaces the one
passed in as vmap and the merge is as expected.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 754a2da06321..0d40d7ba2181 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -33,7 +33,51 @@ static bool test_copy_vma(void)
 	struct mm_struct mm = {};
 	bool need_locks = false;
 	VMA_ITERATOR(vmi, &mm, 0);
-	struct vm_area_struct *vma, *vma_new, *vma_next;
+	struct vm_area_struct *vma, *vma_prev, *vma_new, *vma_next, *vma_orig;
+
+	/* Move forwards, adjacent to old self - self-merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, vma_flags);
+	vma_set_anonymous(vma);
+	vma_orig = vma;
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 1, &need_locks);
+	ASSERT_EQ(vma_new, vma_orig);
+	ASSERT_EQ(vma, vma_orig);
+	ASSERT_EQ(vma_new->vm_start, 0x1000);
+	ASSERT_EQ(vma_new->vm_end, 0x3000);
+
+	cleanup_mm(&mm, &vmi);
+
+	/* Move backwards, adjacent to old self - self-merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, vma_flags);
+	vma_set_anonymous(vma);
+	vma_orig = vma;
+	vma_new = copy_vma(&vma, 0x1000, 0x1000, 2, &need_locks);
+	ASSERT_EQ(vma_new, vma_orig);
+	ASSERT_EQ(vma, vma_orig);
+	ASSERT_EQ(vma_new->vm_start, 0x1000);
+	ASSERT_EQ(vma_new->vm_end, 0x3000);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * Move backwards between prior VMA and old self - self-merge and vma
+	 * updated to a new VMA.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, vma_flags);
+	vma_set_anonymous(vma_prev);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vma_flags);
+	vma_set_anonymous(vma);
+	vma_orig = vma;
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 3, &need_locks);
+	ASSERT_NE(vma_new, vma_orig);
+	ASSERT_EQ(vma_new, vma);
+	ASSERT_EQ(vma_new->vm_start, 0x1000);
+	ASSERT_EQ(vma_new->vm_end, 0x4000);
+
+	cleanup_mm(&mm, &vmi);
 
 	/* Move backwards and do not merge. */
 

-- 
2.55.0

