Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FDF3D3317;
	Thu,  6 Aug 2026 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047815; cv=none; b=rXLAVyV9SLB2JWMTd2x8+X/Ev4/6Dzy2MxpgUFQoVTMYG7QYGdjneyans1BT6HKoUvGiL6DPyxEq77HAobuj1s+d+1iMlhBUVTAQY/0zjxQX0/wDkmyzjD0B/vUBNlj9S74TR3UwMzWaBo43GH8h/CoUf065T/R0vz0Tyw+VBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047815; c=relaxed/simple;
	bh=TcLlQnmra6maBGHXmsGw4bE6RvgdQMZRWpLIfm3Ze4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WfDJnQl2+TlvppF30KPxPJ0hITOzrAq1ajrJNK++tZOcQFBd1uVIeFkmEFSUVvJL8gVaPaE6d5/cnKbNLsZJchEcv1XLhycAyQ7DUtS27oXtn0zRu7lvlcVmy3CZ7uafZ8OtGliqqjevWYn27l24mu6sQA++mDBr/LfG0TOw6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoEPZN1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoEPZN1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4251F000E9;
	Thu,  6 Aug 2026 20:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047813;
	bh=GlrT7r3tcep46r6Il05ij5JS2SxeagPngYBWHI1YDNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EoEPZN1zYAkHbM1/HZ59R4SYuJ0kgr3s6twz6mViFc4pPHD2eOj4FlMUGCLkQYtoA
	 fbOjc1ObmaiC5Fvp4F4F4sEGCxfMHu8CpqnY9UkX9t65/RJPvve1cIM6J14pWhWSIg
	 dovnGA7O72WCJCrxNzM4MhVdhoqmzD1ZkT9jGwy6thH9LcjGcxTmN85p3XRCthcIOz
	 9/2A5+aVmLxBspPX4KvQ4RKFyT5cINyhuSH1ETm2C2yi1ZC0x/YHEhBeXEyP3REWQW
	 hfGbQgp5itsouInFdRcnEDAVzu1N2FrH00x+jldbo49ZvuO6+SflbXjm8tKAng8oV7
	 E0+VQJF9G3bAw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 06 Aug 2026 21:21:29 +0100
Subject: [PATCH v4 04/20] mm: abstract vma_address() and introduce
 vma_anon_address()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-scalable-cow-virt-pgoff-v4-4-ab318a350404@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3692; i=ljs@kernel.org;
 h=from:subject:message-id; bh=TcLlQnmra6maBGHXmsGw4bE6RvgdQMZRWpLIfm3Ze4w=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJK3pxfv5nv281PeyXv5/f0Bj7wnvh4UtjbB0rCvzbP1
 4u0y/x5qaOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQAXKWJkeNCeNjl5q85n2UfH
 w6IXMD5/Y1J7Ty9/5SeO5O8344p2ZDMyvG3unb1bcxsXz4KLxduOLfIV5GNdXtIgO32tmumScyU
 x/AA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Introduce __vma_address() which abstracts the VMA start page offset field
as pgoff_start, then update vma_address() to use it.

Then introduce vma_anon_address() which does the equivalent of
vma_address(), only using the anonymous page offset of the VMA rather than
the file-backed one.

Also add an assert to ensure that the function is not called for mappings
which are file-backed but not MAP_PRIVATE to ensure it is only used in the
correct places.

This will be necessary for determining the address of a folio's index
within a VMA when the folio belongs to a MAP_PRIVATE file-backed VMA but
has been CoW'd, and thus is anonymous, once the anonymous VMA page offset
field is used for the reverse mapping.

No callers are updated, so no functional change intended.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/internal.h | 49 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a75a1344e9ba..10b6662be8ed 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1005,19 +1005,9 @@ void mlock_drain_remote(int cpu);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
-/**
- * vma_address - Find the virtual address a page range is mapped at
- * @vma: The vma which maps this object.
- * @pgoff: The page offset within its object.
- * @nr_pages: The number of pages to consider.
- *
- * If any page in this range is mapped by this VMA, return the first address
- * where any of these pages appear.  Otherwise, return -EFAULT.
- */
-static inline unsigned long vma_address(const struct vm_area_struct *vma,
-		pgoff_t pgoff, unsigned long nr_pages)
+static inline unsigned long __vma_address(const struct vm_area_struct *vma,
+		pgoff_t pgoff, pgoff_t pgoff_start, unsigned long nr_pages)
 {
-	const pgoff_t pgoff_start = vma_start_pgoff(vma);
 	unsigned long address;
 
 	if (pgoff >= pgoff_start) {
@@ -1035,6 +1025,41 @@ static inline unsigned long vma_address(const struct vm_area_struct *vma,
 	return address;
 }
 
+/**
+ * vma_address - Find the virtual address a page range is mapped at.
+ * @vma: The vma which maps this object.
+ * @pgoff: The page offset within its object.
+ * @nr_pages: The number of pages to consider.
+ *
+ * If any page in this range is mapped by this VMA, return the first address
+ * where any of these pages appear.  Otherwise, return -EFAULT.
+ */
+static inline unsigned long vma_address(const struct vm_area_struct *vma,
+		pgoff_t pgoff, unsigned long nr_pages)
+{
+	return __vma_address(vma, pgoff, vma_start_pgoff(vma), nr_pages);
+}
+
+/**
+ * vma_anon_address - Find the address an anonymous folio with index @pgoff_anon
+ * is mapped at.
+ * @vma: The vma which maps this object.
+ * @pgoff_anon: The anonymous page index belonging to the folio.
+ * @nr_pages: The number of pages to consider.
+ *
+ * This is only valid for anonymous or MAP_PRIVATE-mapped file-backed VMAs.
+ *
+ * Returns: If any page in this range is mapped by this VMA, return the first
+ * address where any of these pages appear. Otherwise, return -EFAULT.
+ */
+static inline unsigned long vma_anon_address(const struct vm_area_struct *vma,
+		pgoff_t pgoff_anon, unsigned long nr_pages)
+{
+	VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
+
+	return __vma_address(vma, pgoff_anon, vma_start_anon_pgoff(vma), nr_pages);
+}
+
 /*
  * Then at what user virtual address will none of the range be found in vma?
  * Assumes that vma_address() already returned a good starting address.

-- 
2.55.0

