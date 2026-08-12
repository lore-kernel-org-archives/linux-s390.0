Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBE31F9A0;
	Wed, 12 Aug 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557959; cv=none; b=j32r43n3Jt5KuuAZoM+9U3RXa6epDJMtFgWmbV7t9ARXFH2xnjEiHghyhVcPHXe83cDCpUsCiJmrCaYZSWN+vE88DgkvcVccHZg5Dg67DS3UhbNFIu/RZ110xoxgMhF43QmNhVyn5/QaSnifM09yrBoJ7S0HdU/QDdYEtsnGqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557959; c=relaxed/simple;
	bh=fpWWl6otK0Jr8fEmKlJ/t9Di1A0mUb+q5hOQ7VG8RQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArtWjbwUu50G2s4oCzLpDkFTY2EaihguBC7ZT3NZ33FlAqkTGy9Y7XwDjzhqdCjsqvtf9pUOOkTbwEc9EATMnAGLtwEkI3dITftfq/AubrBPvircs5T5l3s1ppOXzozC88gNC6SLPneG+GyPbJiOPQWAZA6tcZbALG3JWlkTXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMlFlWiO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMlFlWiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6721F000E9;
	Wed, 12 Aug 2026 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786557957;
	bh=3/7RbMilH1SQLqxI0qjfmo29u73H3ZEX1a3tHj6F58Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iMlFlWiOG7V80XsD8e/VPQUn7ardDYHVj/V2qqphOmG39UXaBzt+ciuEjM4pCq13c
	 KkdlhOQZbPus0Qg5akVir+wkEmhoBp1Hd/oKIZxUK/WGgcsVsln0Js4gnpuKa0qJWt
	 6j56sic26KIoSFTWpI22QnWLIJNewo9nZzjBRmwRJ0/6N1WF5OweJ9xiHBijuYvlta
	 FCRXonsxANMAsLRKJtPHb/mgnvzXYTHBJmyC1CwkGwghANvBFNJonhU3iMY2juLEgY
	 XSseaGY0jujdVRI9hdZXlfIru2Ia50ODO2wMl9h3qKe8x8Kh4Jkz9AJpqD65tVKPkE
	 Bk/WOaiwH/quA==
Date: Wed, 12 Aug 2026 19:05:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/20] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Message-ID: <anyst_4LGm6bpWdq@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-17-ab318a350404@kernel.org>
 <c7930f14-5978-4709-bac2-54950c988883@kernel.org>
 <ant1xwiG3djtoXoe@lucifer>
 <14a06774-4157-4629-8327-b1a6bae24ab7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a06774-4157-4629-8327-b1a6bae24ab7@kernel.org>

TL;DR - either we need to find a way to uniquely identify it (keep my approach
or move it to core mm) or we should drop this patch.

Given we're late in the cycle + you stringly objective to my approach I think
maybe best to drop it and respin?

Can do a follow up to add unique identification later, somehow.

The key change of 'make anon-assigned file-backed MAP_PRIVATE mappings not
special snowflakes' will still be achieved in the other patches (but have to
rework them a little obviously).

On Wed, Aug 12, 2026 at 07:15:05PM +0200, David Hildenbrand (Arm) wrote:
> >>
> >> My brain is a bit slow after digging through this series.
> >>
> >> We identify shmem, for example, through shmem_vm_ops/shmem_anon_vm_ops.
> >>
> >> So naturally I am wondering: couldn't we do something similar to identify that?
> >> Like, checking for zero_fops?
> >
> > We don't assign vm_ops for a MAP_PRIVATE-/dev/zero mapping. So that won't work.
> >
> > We could expose zero->f_ops but then it's literally in drivers/char/ and that's
> > just weird to expose in mm.h or whatever.
>
> Thinking out loud: could we use a dummy (empty) vm_ops?
>
> We'd place it in mm.h (zero_vm_ops) and just use it in drivers/char/.

The entire purpose of this patch is to _uniquely identify_ MAP_PRIVATE-mapped
/dev/zero and only permit this to make a mapping anonymous.

As per the commit message: 'mm/vma: only permit MAP_PRIVATE /dev/zero to be
mapped anonymous'

MAP_PRIVATE-/dev/zero to anon is a historical abberation. This is why it is a
unique case where semantics don't make sense.

Doing things by semantics makes sense if the semantics are a _class_ of
thing. This is not a class of thing it is a one of one.

Yes the method used is ugly, but the alternatives (I can think of) are:

1. (your proposal) allow any in-tree non-module mmap_prepare() driver to map
   anonymous pages, creating an entirely new semantic for memory mapping.

   (this is currently something that is possible, unfortunately).

   To be safe we would have to implement then a series of checks to prevent true
   insanities, because doing that would permit broken madness like a PFN map
   being treated as anon.

   Once this stuff is out there as an API, even in-tree, even non-module, people
   will abuse it because it'll go through some random tree and we'll have to
   support it.

   I mean we may as well just not make a change in this case other than maybe
   preventing .mmap from being able to do this.

2. My solution - ugly but uniquely identifies the single permitted situation
   where this behaviour is desired.

3. Export something from drivers/char/mem.c to mm - horrific for multiple
   reasons, violates separation of concerns etc. etc.

4. Move the driver code just for /dev/zero to mm - I thought a pretty horrible
   idea, but maybe we could have some mm/ bit and some driver/char bit like
   hugetlbfs or uffd? But I'm not sure there is a not-ugly way of doing this.
   MAP_SHARED /dev/zero does shmem stuff so maybe could live there.

Drivers not being able to get anon pages is a baked-in assumption in the kernel
(excepting MAP_PRIVATE-/dev/zero).

Anyway I don't want this to hold up the series so maybe I'll just drop the
patch and we can retain the current broken mess.

>
> See below.
>
> >
> > I'm giving a really minimal possible thing to export, which is the DEVZERO_MINOR
> > number which avoids all kinds of weirdness like that. No driver stuff exported,
> > just a number :) MEM_MAJOR is already available.
> >
> > So I think it's the least bad choice in this one, very very specific scenario.
>
> I'd hope we find something cleaner than the DEVZERO_MINOR thingy.

I think your objection here again is mistaking this for a class of thing rather
than a one-of-one.

>
> Something slightly cleaned up chloppedi-schlop on top of mm-unstable.
>
> vma tests seems to still work, but I haven't boot-tested this.

Yeah I don't love it :)

I mean this change eliminates the purpose of this patch, and we already handle
the /dev/zero MAP_PRIVATE like this:

static int mmap_zero_prepare(struct vm_area_desc *desc)
{
#ifndef CONFIG_MMU
	return -ENOSYS;
#endif
	if (vma_desc_test(desc, VMA_SHARED_BIT))
		return shmem_zero_setup_desc(desc);

	/*
	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
	 * of /dev/zero anonymous, despite it not being.
	 */
	vma_desc_set_anonymous(desc);
	return 0;
}

I'm not sure what the difference is between having to do
vma_desc_set_anonymous() and this new vm_ops (which would then get cleared which
is really weird).

>
>
> From 3cdc1d205a8e10dedd99b21a5f4f3f570ba24469 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Wed, 12 Aug 2026 19:13:32 +0200
> Subject: [PATCH] tmp
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/char/mem.c              |  5 +++--
>  include/linux/mm.h              |  4 +---
>  mm/init-mm.c                    |  1 +
>  mm/vma.c                        | 10 +--------
>  mm/vma_internal.h               |  1 -
>  tools/testing/vma/include/dup.h | 38 +--------------------------------
>  tools/testing/vma/shared.c      |  1 +
>  tools/testing/vma/tests/mmap.c  | 10 +++------
>  8 files changed, 11 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index dcfd896b733d8..147568c65c1be 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -506,7 +506,8 @@ static int mmap_zero_prepare(struct vm_area_desc *desc)
>  	if (vma_desc_test(desc, VMA_SHARED_BIT))
>  		return shmem_zero_setup_desc(desc);
>
> -	/* MAP_PRIVATE semantics are taken care for us by core mm. */
> +	/* Indicate MAP_PRIVATE mappings, so core mm can do the right thing. */
> +	desc->vm_ops = &zero_vm_ops;
>  	return 0;
>  }
>
> @@ -694,7 +695,7 @@ static const struct memdev {
>  #ifdef CONFIG_DEVPORT
>  	[4] = { "port", &port_fops, 0, 0 },
>  #endif
> -	[DEVZERO_MINOR] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
> +	[5] = { "zero", &zero_fops, FMODE_NOWAIT, 0666 },
>  	[7] = { "full", &full_fops, 0, 0666 },
>  	[8] = { "random", &random_fops, FMODE_NOWAIT, 0666 },
>  	[9] = { "urandom", &urandom_fops, FMODE_NOWAIT, 0666 },
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f940d20551d53..29f13cc6b52a2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -740,9 +740,6 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
>  	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
>  	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
>
> -/* /dev/zero minor device number. Special due to MAP_PRIVATE semantics. */
> -#define DEVZERO_MINOR	5

All of this to avoid this single #define...!

> -
>  /*
>   * vm_fault is filled by the pagefault handler and passed to the vma's
>   * ->fault function. The vma's ->fault is responsible for returning a bitmask
> @@ -990,6 +987,7 @@ static inline void mm_flags_clear_all(struct mm_struct *mm)
>  }
>
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
> +extern const struct vm_operations_struct zero_vm_ops;

See below but this is really not a great place to put it. Now we invite people
to invent new mad CoW schemes with anon pages... 'set a vm_ops that we clear' is
not great semantically either.

vma_dummy_vma_ops is set and then kept or overwritten with explicit meaning 'is
non-anon but does no special vm_ops stuff'.

>
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 3e792aad76261..2030f8e47a98a 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -18,6 +18,7 @@
>  #endif
>
>  const struct vm_operations_struct vma_dummy_vm_ops;
> +const struct vm_operations_struct zero_vm_ops;

Already this creates a brand new class of vm_ops.

Other *_vm_ops have meaning in belonging to a specific mapping (hugetlb, etc.)
but they are _defined in the relevant files_ though maybe have extern vars I guess.

But this one is set once _then cleared_ by the core mm mmap code.

It's really weird and obscure and 'just so'.

So I don't think it's the right method.

>
>  /*
>   * For dynamically allocated mm_structs, there is a dynamically sized cpumask
> diff --git a/mm/vma.c b/mm/vma.c
> index e7c8b6cb8347e..4f9b78791daf9 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2623,15 +2623,7 @@ static int __mmap_new_file_vma(struct mmap_state *map,
>
>  static bool map_is_dev_zero(const struct mmap_state *map)
>  {
> -	const struct file *file = map->file;
> -	struct inode *inode;
> -
> -	if (!file)
> -		return false;
> -	inode = file_inode(file);
> -	if (!S_ISCHR(inode->i_mode))
> -		return false;
> -	return imajor(inode) == MEM_MAJOR && iminor(inode) == DEVZERO_MINOR;
> +	return map->vm_ops == &zero_vm_ops;

Err no, the function name is completely wrong now. This just tells you somebody
set a vm_ops you're about to remove (badly named too!)

>  }
>
>  static void map_set_anon(struct mmap_state *map)
> diff --git a/mm/vma_internal.h b/mm/vma_internal.h
> index 385c0ab137774..4d300e7bbaf4c 100644
> --- a/mm/vma_internal.h
> +++ b/mm/vma_internal.h
> @@ -23,7 +23,6 @@
>  #include <linux/ksm.h>
>  #include <linux/khugepaged.h>
>  #include <linux/list.h>
> -#include <linux/major.h>

Again all this to avoid simple include...

>  #include <linux/maple_tree.h>
>  #include <linux/mempolicy.h>
>  #include <linux/mm.h>
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> index 41203b1c2323d..8457fabf53452 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -7,6 +7,7 @@ struct vm_area_struct;
>  static inline void vma_start_write(struct vm_area_struct *vma);
>
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
> +extern const struct vm_operations_struct zero_vm_ops;
>  extern unsigned long stack_guard_gap;
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
>  extern unsigned long rlimit(unsigned int limit);
> @@ -15,21 +16,6 @@ struct task_struct *get_current(void);
>  #define MMF_HAS_MDWE	28
>  #define current get_current()
>
> -#define MINORBITS	20
> -#define MINORMASK	((1U << MINORBITS) - 1)
> -
> -#define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
> -#define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
> -#define MKDEV(ma, mi)	(((ma) << MINORBITS) | (mi))
> -
> -#define S_IFMT  00170000
> -#define S_IFCHR  0020000
> -
> -#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
> -
> -#define MEM_MAJOR		1
> -#define DEVZERO_MINOR	5
> -
>  /*
>   * Define the task command name length as enum, then it can be visible to
>   * BPF programs.
> @@ -38,8 +24,6 @@ enum {
>  	TASK_COMM_LEN = 16,
>  };
>
> -typedef unsigned short		umode_t;
> -
>  /* PARTIALLY implemented types. */
>  struct mm_struct {
>  	struct maple_tree mm_mt;
> @@ -62,10 +46,6 @@ struct address_space {
>  	unsigned long		flags;
>  	atomic_t		i_mmap_writable;
>  };
> -struct inode {
> -	umode_t			i_mode;
> -	dev_t			i_rdev;
> -};
>  struct file_operations {
>  	int (*mmap)(struct file *, struct vm_area_struct *);
>  	int (*mmap_prepare)(struct vm_area_desc *);
> @@ -73,7 +53,6 @@ struct file_operations {
>  struct file {
>  	struct address_space	*f_mapping;
>  	const struct file_operations	*f_op;
> -	struct inode			*f_inode;
>  };
>  struct anon_vma_chain {
>  	struct anon_vma *anon_vma;
> @@ -1665,18 +1644,3 @@ static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
>
>  	return pgoff;
>  }
> -
> -static inline struct inode *file_inode(const struct file *f)
> -{
> -	return f->f_inode;
> -}
> -
> -static inline unsigned iminor(const struct inode *inode)
> -{
> -	return MINOR(inode->i_rdev);
> -}
> -
> -static inline unsigned imajor(const struct inode *inode)
> -{
> -	return MAJOR(inode->i_rdev);
> -}
> diff --git a/tools/testing/vma/shared.c b/tools/testing/vma/shared.c
> index 4a39c9d504896..46d8d2e96bd71 100644
> --- a/tools/testing/vma/shared.c
> +++ b/tools/testing/vma/shared.c
> @@ -9,6 +9,7 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
>  unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
>
>  const struct vm_operations_struct vma_dummy_vm_ops;
> +const struct vm_operations_struct zero_vm_ops;
>  struct anon_vma dummy_anon_vma;
>  struct task_struct __current;
>
> diff --git a/tools/testing/vma/tests/mmap.c b/tools/testing/vma/tests/mmap.c
> index ebe01362e530c..a63069d34a5a8 100644
> --- a/tools/testing/vma/tests/mmap.c
> +++ b/tools/testing/vma/tests/mmap.c
> @@ -45,8 +45,9 @@ static bool test_mmap_region_basic(void)
>  	return true;
>  }
>
> -static int dummy_mmap_prepare(struct vm_area_desc *desc)
> +static int zero_mmap_prepare(struct vm_area_desc *desc)
>  {
> +	desc->vm_ops = &zero_vm_ops;
>  	return 0;
>  }
>
> @@ -55,14 +56,9 @@ static bool test_pure_anon_dev_zero(void)
>  	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
>  			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
>  	const struct file_operations f_op = {
> -		.mmap_prepare = dummy_mmap_prepare,
> -	};
> -	struct inode inode = {
> -		.i_mode = S_IFCHR,
> -		.i_rdev = MKDEV(MEM_MAJOR, DEVZERO_MINOR),
> +		.mmap_prepare = zero_mmap_prepare,
>  	};
>  	struct file file = {
> -		.f_inode = &inode,
>  		.f_op = &f_op,
>  	};
>  	struct mm_struct mm = {};
> --
> 2.43.0
>
>
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
