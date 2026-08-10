Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07C3314AE;
	Mon, 10 Aug 2026 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786399811; cv=none; b=hlSWU4gbsH9UY6A+r4gZEjgdVHnKwIupQPCa5Xz1RlDNTelu8fNA0OUlNJPLr4oSTci8wsdYTmKE3KipMuzzevgnjaaiVssYZz6NE8s607CQvuFMaBn3iUmDcYkJlDz8KO/RZSa9AfjKwjim2mQWi0KKzULYPhCWGOah0oXPKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786399811; c=relaxed/simple;
	bh=0RWpdfIzCKEiyFzszpDc1xkHvtl02bntYX24+KDlego=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qj8jAECR6HfvLNZWPvRCGW+dv4oD+gMp3zR10Rx3dJ56Ap7Z20lAySDZXQXBEkEQjGkCE9k227c/T7ZCccvVleVy0WgkdwYU7o2cuTY9BVr/IywsO6fOyngywA8nj+tfHR2qKesA8aw3EySDSU75BrPdlm45qHmGneyxG0GT3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UwX/Ilov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UwX/Ilov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB66F1F000E9;
	Mon, 10 Aug 2026 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786399810;
	bh=/hUK9nmdYQUfhG6ut1/QpR/T7D3LLI4jSc7+bBZ5Ofc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UwX/Ilov0bIFii9m3iwtL8q7dWNlzT+Wx3UroPo9PylX7if0NcfH9JAavRDAn86dw
	 JNwDAbfcVY3VRo/UBsUbAdQe6WqOiVdxquE1mb7LVSCrY0NRcx31i22SVoR5H3wZ9K
	 Nroa/JyRqqFqLrw3hFrR5C55A7jEiwD4QPiMGP18=
Date: Mon, 10 Aug 2026 15:10:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, Kees Cook
 <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, John
 Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, Oscar
 Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park
 <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/20] mm: provide vma_[flags_]is_cow_mapping() and
 remove is_cow_mapping()
Message-Id: <20260810151007.c1cfbcf46d498d2f8ce566f9@linux-foundation.org>
In-Reply-To: <ann-vS6MYT9kuXqu@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
	<20260806-b4-scalable-cow-virt-pgoff-v4-2-ab318a350404@kernel.org>
	<ann-vS6MYT9kuXqu@lucifer>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 18:59:34 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> Hi Andrew - would it be possible to insert the comments added below? Trying
> to avoid a respin if possible :)

np, like this?

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-provide-vma_is_cow_mapping-and-remove-is_cow_mapping-fix
Date: Mon Aug 10 03:07:02 PM PDT 2026

add comments, per Lorenzo

Link: https://lore.kernel.org/ann-vS6MYT9kuXqu@lucifer
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mm.h |   57 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

--- a/include/linux/mm.h~mm-provide-vma_is_cow_mapping-and-remove-is_cow_mapping-fix
+++ a/include/linux/mm.h
@@ -2271,17 +2271,74 @@ void unpin_user_pages(struct page **page
 void unpin_user_folio(struct folio *folio, unsigned long npages);
 void unpin_folios(struct folio **folios, unsigned long nfolios);
 
+/**
+ * vma_flags_is_cow_mapping() - Do these VMA flags imply a CoW mapping?
+ * @flags: The VMA flags to check.
+ *
+ * Mappings which could be CoW'd (subject to Copy-On-Write faults) are
+ * described as CoW mappings.
+ *
+ * All mappings backed by anonymous folios (all anonymous mappings and most
+ * MAP_PRIVATE-file backed ranges) are CoW mappings.
+ *
+ * All other mappings (including all writable MAP_SHARED mappings) are
+ * non-CoW.
+ *
+ * The criteria are !VMA_SHARED_BIT, VMA_MAYWRITE_BIT.
+ *
+ * VMA_MAYWRITE_BIT is checked instead of VMA_WRITE_BIT to account for both
+ * future mprotect() calls which can render a read-only mapping writable, and
+ * GUP with FOLL_FORCE (e.g. ptrace) which can CoW a read-only mapping.
+ *
+ * - No anonymous mapping can ever clear VMA_MAYWRITE_BIT.
+ *
+ * - Writes to anonymous mappings do not immediately result in CoW faults but
+ *   may do so after the process is forked or if a read is followed by a
+ *   write.
+ *
+ * - Writes to MAP_PRIVATE file-backed mappings result in CoW faults and may
+ *   do so again after fork.
+ *
+ * - MAP_SHARED mappings of a file opened read-only are transformed into
+ *   VMA_MAYSHARE_BIT, !VMA_SHARED_BIT, !VMA_MAYWRITE_BIT mappings, so remain
+ *   non-CoW.
+ *
+ * - Drivers may clear VMA_MAYWRITE_BIT but do so at mmap() time and cannot
+ *   mark themselves anonymous. Having cleared this flag it is not valid for
+ *   them to leave the VMA_WRITE_BIT flag set.
+ *
+ * As a consequence, the anonymous reverse mapping only tracks CoW mappings.
+ *
+ * Returns: true if the flags indicate a CoW mapping, otherwise false.
+ */
 static inline bool vma_flags_is_cow_mapping(const vma_flags_t *flags)
 {
 	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
 		!vma_flags_test(flags, VMA_SHARED_BIT);
 }
 
+/**
+ * vma_is_cow_mapping() - Is this VMA a CoW mapping?
+ * @desc: The VMA to check.
+ *
+ * See vma_flags_is_cow_mapping() for details.
+ *
+ * Returns: true if the VMA is a CoW mapping, otherwise false.
+ */
 static inline bool vma_is_cow_mapping(const struct vm_area_struct *vma)
 {
 	return vma_flags_is_cow_mapping(&vma->flags);
 }
 
+/**
+ * vma_desc_is_cow_mapping() - Is this VMA descriptor a CoW mapping?
+ * @desc: The VMA descriptor to check.
+ *
+ * See vma_flags_is_cow_mapping() for details.
+ *
+ * Returns: true if the VMA descriptor describes a CoW mapping, otherwise
+ * false.
+ */
 static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
 {
 	return vma_flags_is_cow_mapping(&desc->vma_flags);
_

