Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4782EBBB9;
	Wed, 12 Aug 2026 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554928; cv=none; b=YMUqSeWWqP0WJQ+qzaRODFOwMtTaBP0q7sfwuL/pPJ7Gj070+gKFtovk+kPy0o8g+SnVBsc5igmhC819WYlxCpeKRQqtyhJgysCNhD2IvZmDvCibtwly6PJs00SvtbKG6C7HegB960gl5NeWQtO2hq4INuCcY3RaEP/+pb8vSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554928; c=relaxed/simple;
	bh=FvASNYHe9O80FwOK8hUqEI5z9gNkWtM36vvFNEANCS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xpki7eZ/3CLbUDLAVkj7Ivmnqw5DGPw93n4x5WiRGb2uXn7Ll9pXTn6fWclMAT2Cc8gMxXANIySPeb8H/vNM60Us7yUVOeXPx03LdOudkqhnmPrCfSZvTWHQRqDTq3WVnXr/XXxYR+PKkEYDY4gkDNfvduoBKn7UMy6IW5vyv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsDvuBHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsDvuBHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C991F000E9;
	Wed, 12 Aug 2026 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786554927;
	bh=DjHOoBfUQtkHUrdk1xrWpUaj2qd89wkcLgXch0WJ2bg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CsDvuBHJB9AzA2G5yecRrR3krVdOetjRAxE4eBzDwYYxzHVDVx0uzP1ccaW7N3gaT
	 o2KbbL3Ikw/1vxKExVZ1xQdCV20Bgdex8l/riLlVp7CtTBNgkeds61TFn2OOQVeCj7
	 MSpLraGB4VjHYhapAf/PDgEKZNg6qRNU7fxfMHCIIiEuSNzQoTHqAo/Y2W2+pN1K0Y
	 KsqHhuRz+kjOHoLBA9hAGNka4fV+XSO85kMgE9AP0iuifXBW2hdpAGLlGK7CIroTJw
	 NiqdoRZgNkijgI2eWcxOnTGstpIWrKFe+1dHj0FhfeFTzo2hLra/dcolOBehH/OR1R
	 XVEvV1QMH/dRA==
Message-ID: <14a06774-4157-4629-8327-b1a6bae24ab7@kernel.org>
Date: Wed, 12 Aug 2026 19:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/20] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>,
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
 Sven Schnelle <svens@linux.ibm.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-17-ab318a350404@kernel.org>
 <c7930f14-5978-4709-bac2-54950c988883@kernel.org> <ant1xwiG3djtoXoe@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ant1xwiG3djtoXoe@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>
>> My brain is a bit slow after digging through this series.
>>
>> We identify shmem, for example, through shmem_vm_ops/shmem_anon_vm_ops.
>>
>> So naturally I am wondering: couldn't we do something similar to identify that?
>> Like, checking for zero_fops?
> 
> We don't assign vm_ops for a MAP_PRIVATE-/dev/zero mapping. So that won't work.
> 
> We could expose zero->f_ops but then it's literally in drivers/char/ and that's
> just weird to expose in mm.h or whatever.

Thinking out loud: could we use a dummy (empty) vm_ops?

We'd place it in mm.h (zero_vm_ops) and just use it in drivers/char/.

See below.

> 
> I'm giving a really minimal possible thing to export, which is the DEVZERO_MINOR
> number which avoids all kinds of weirdness like that. No driver stuff exported,
> just a number :) MEM_MAJOR is already available.
> 
> So I think it's the least bad choice in this one, very very specific scenario.

I'd hope we find something cleaner than the DEVZERO_MINOR thingy.

Something slightly cleaned up chloppedi-schlop on top of mm-unstable.

vma tests seems to still work, but I haven't boot-tested this.


From 3cdc1d205a8e10dedd99b21a5f4f3f570ba24469 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 12 Aug 2026 19:13:32 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/char/mem.c              |  5 +++--
 include/linux/mm.h              |  4 +---
 mm/init-mm.c                    |  1 +
 mm/vma.c                        | 10 +--------
 mm/vma_internal.h               |  1 -
 tools/testing/vma/include/dup.h | 38 +--------------------------------
 tools/testing/vma/shared.c      |  1 +
 tools/testing/vma/tests/mmap.c  | 10 +++------
 8 files changed, 11 insertions(+), 59 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index dcfd896b733d8..147568c65c1be 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -506,7 +506,8 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
 	if (vma_desc_test(desc, VMA_SHARED_BIT))
 		return shmem_zero_setup_desc(desc);
 
-	/* MAP_PRIVATE semantics are taken care for us by core mm. */
+	/* Indicate MAP_PRIVATE mappings, so core mm can do the right thing. */
+	desc->vm_ops = &zero_vm_ops;
 	return 0;
 }
 
@@ -694,7 +695,7 @@ static const struct memdev {
 #ifdef CONFIG_DEVPORT
 	[4] = { "port", &port_fops, 0, 0 },
 #endif
-	[DEVZERO_MINOR] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
+	[5] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
 	[7] = { "full", &full_fops, 0, 0666 },
 	[8] = { "random", &random_fops, FMODE_NOWAIT, 0666 },
 	[9] = { "urandom", &urandom_fops, FMODE_NOWAIT, 0666 },
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f940d20551d53..29f13cc6b52a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -740,9 +740,6 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
 	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
-/* /dev/zero minor device number. Special due to MAP_PRIVATE semantics. */
-#define DEVZERO_MINOR	5
-
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
  * ->fault function. The vma's ->fault is responsible for returning a bitmask
@@ -990,6 +987,7 @@ static inline void mm_flags_clear_all(struct mm_struct *mm)
 }
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern const struct vm_operations_struct zero_vm_ops;
 
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3e792aad76261..2030f8e47a98a 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -18,6 +18,7 @@
 #endif
 
 const struct vm_operations_struct vma_dummy_vm_ops;
+const struct vm_operations_struct zero_vm_ops;
 
 /*
  * For dynamically allocated mm_structs, there is a dynamically sized cpumask
diff --git a/mm/vma.c b/mm/vma.c
index e7c8b6cb8347e..4f9b78791daf9 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2623,15 +2623,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 
 static bool map_is_dev_zero(const struct mmap_state *map)
 {
-	const struct file *file = map->file;
-	struct inode *inode;
-
-	if (!file)
-		return false;
-	inode = file_inode(file);
-	if (!S_ISCHR(inode->i_mode))
-		return false;
-	return imajor(inode) == MEM_MAJOR && iminor(inode) == DEVZERO_MINOR;
+	return map->vm_ops == &zero_vm_ops;
 }
 
 static void map_set_anon(struct mmap_state *map)
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index 385c0ab137774..4d300e7bbaf4c 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -23,7 +23,6 @@
 #include <linux/ksm.h>
 #include <linux/khugepaged.h>
 #include <linux/list.h>
-#include <linux/major.h>
 #include <linux/maple_tree.h>
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 41203b1c2323d..8457fabf53452 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -7,6 +7,7 @@ struct vm_area_struct;
 static inline void vma_start_write(struct vm_area_struct *vma);
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern const struct vm_operations_struct zero_vm_ops;
 extern unsigned long stack_guard_gap;
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 extern unsigned long rlimit(unsigned int limit);
@@ -15,21 +16,6 @@ struct task_struct *get_current(void);
 #define MMF_HAS_MDWE	28
 #define current get_current()
 
-#define MINORBITS	20
-#define MINORMASK	((1U << MINORBITS) - 1)
-
-#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
-#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
-#define MKDEV(ma, mi)	(((ma) << MINORBITS) | (mi))
-
-#define S_IFMT  00170000
-#define S_IFCHR  0020000
-
-#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
-
-#define MEM_MAJOR		1
-#define DEVZERO_MINOR	5
-
 /*
  * Define the task command name length as enum, then it can be visible to
  * BPF programs.
@@ -38,8 +24,6 @@ enum {
 	TASK_COMM_LEN = 16,
 };
 
-typedef unsigned short		umode_t;
-
 /* PARTIALLY implemented types. */
 struct mm_struct {
 	struct maple_tree mm_mt;
@@ -62,10 +46,6 @@ struct address_space {
 	unsigned long		flags;
 	atomic_t		i_mmap_writable;
 };
-struct inode {
-	umode_t			i_mode;
-	dev_t			i_rdev;
-};
 struct file_operations {
 	int (*mmap)(struct file *, struct vm_area_struct *);
 	int (*mmap_prepare)(struct vm_area_desc *);
@@ -73,7 +53,6 @@ struct file_operations {
 struct file {
 	struct address_space	*f_mapping;
 	const struct file_operations	*f_op;
-	struct inode			*f_inode;
 };
 struct anon_vma_chain {
 	struct anon_vma *anon_vma;
@@ -1665,18 +1644,3 @@ static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
 
 	return pgoff;
 }
-
-static inline struct inode *file_inode(const struct file *f)
-{
-	return f->f_inode;
-}
-
-static inline unsigned iminor(const struct inode *inode)
-{
-	return MINOR(inode->i_rdev);
-}
-
-static inline unsigned imajor(const struct inode *inode)
-{
-	return MAJOR(inode->i_rdev);
-}
diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
index 4a39c9d504896..46d8d2e96bd71 100644
--- a/tools/testing/vma/shared.c
+++ b/tools/testing/vma/shared.c
@@ -9,6 +9,7 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
 unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
 
 const struct vm_operations_struct vma_dummy_vm_ops;
+const struct vm_operations_struct zero_vm_ops;
 struct anon_vma dummy_anon_vma;
 struct task_struct __current;
 
diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
index ebe01362e530c..a63069d34a5a8 100644
--- a/tools/testing/vma/tests/mmap.c
+++ b/tools/testing/vma/tests/mmap.c
@@ -45,8 +45,9 @@ static bool test_mmap_region_basic(void)
 	return true;
 }
 
-static int dummy_mmap_prepare(struct vm_area_desc *desc)
+static int zero_mmap_prepare(struct vm_area_desc *desc)
 {
+	desc->vm_ops = &zero_vm_ops;
 	return 0;
 }
 
@@ -55,14 +56,9 @@ static bool test_pure_anon_dev_zero(void)
 	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
 			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
 	const struct file_operations f_op = {
-		.mmap_prepare = dummy_mmap_prepare,
-	};
-	struct inode inode = {
-		.i_mode = S_IFCHR,
-		.i_rdev = MKDEV(MEM_MAJOR, DEVZERO_MINOR),
+		.mmap_prepare = zero_mmap_prepare,
 	};
 	struct file file = {
-		.f_inode = &inode,
 		.f_op = &f_op,
 	};
 	struct mm_struct mm = {};
-- 
2.43.0



-- 
Cheers,

David
