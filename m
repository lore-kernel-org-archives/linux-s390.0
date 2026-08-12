Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C02477E4F;
	Wed, 12 Aug 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558145; cv=none; b=e7V80HsfUhUL+zIGaBEBQN0MpG/sLQOhE5YGRiq76yWFEPlZX4WhzzICcf6qBIb5Fd1uDFykZ5WP9A1Ai0SVfv4gP5jvQ2xPOyVba6iKJ2SLjKgkeLHtjk9gTZTDb3EQX4yaDajVwks9uE2vrkjN9EsYgV8Z7bHuDqm61uLsQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558145; c=relaxed/simple;
	bh=Yi5far2ZKXnrZTlfHu9Izikx3SvheQpzfjRHuGQy+xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhlEuUeHi6j6kJiRovbFy0NlqR6RSB1kRMmZRRtVRaBwXpW+AHcrW2tBfOw3gj4oUt1/gsitHWw54w8tP001wfo69huuM5+yFbuPIDMgvnJmF05NbZ+h+T2i1tXrRhIEaurB+xzYJ0zoLu5mENX6TJq8S1yscqhaL3+PWQixHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPZqAbLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPZqAbLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B41F000E9;
	Wed, 12 Aug 2026 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786558144;
	bh=/4wKYM9MxtqgdWEMOzwNt0V2ekWexcqa8GGAN8Nt6p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPZqAbLLWRIKnNz+QQXKAqF9IVzq9IiefDRz1565tIbl/YT7GDxa0hVfpHvtuPJOv
	 21Vj/7WrU8+huUaZKOGhGAzGzQWLjfUMZVZt2ff4LGvtC2SCdGUaGADsrWisnU+XWO
	 beIMV93LtMwcdcrt2YjPyUDHzLIhwRqnV3IEVkVEGVWMozBMT+LElOjqy90TkkKs+N
	 ZQx0XKNVpk1LWcEBgnepPPW8ZiW8sWwUJy3aW30MjDw6aprydwCd/wc7rmQd1wt6sB
	 wuQg/3oKhwJjGNZDGpj090xIWx/Y23Nxl83v8P3inLlBDasM7ar0kQeBrH3IL7iRZm
	 rzZ5tMbMJv3NQ==
Date: Wed, 12 Aug 2026 19:08:29 +0100
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
Subject: Re: [PATCH v4 19/20] tools/testing/vma: add test to assert
 MAP_PRIVATE-/dev/zero is anon
Message-ID: <any2O0nZdz7R3V-G@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-19-ab318a350404@kernel.org>
 <5d1a35d2-8541-44d5-8958-1efa9773d7bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d1a35d2-8541-44d5-8958-1efa9773d7bb@kernel.org>

On Wed, Aug 12, 2026 at 07:17:39PM +0200, David Hildenbrand (Arm) wrote:
> > +static bool test_pure_anon_dev_zero(void)
> > +{
> > +	const vma_flags_t vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
> > +			VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
> > +	const struct file_operations f_op = {
> > +		.mmap_prepare = dummy_mmap_prepare,
> > +	};
> > +	struct inode inode = {
> > +		.i_mode = S_IFCHR,
> > +		.i_rdev = MKDEV(MEM_MAJOR, DEVZERO_MINOR),
> > +	};
> > +	struct file file = {
> > +		.f_inode = &inode,
> > +		.f_op = &f_op,
> > +	};
> > +	struct mm_struct mm = {};
> > +	struct vm_area_struct *vma;
> > +	unsigned long addr;
> > +	VMA_ITERATOR(vmi, &mm, 0);
> > +
>
> When we go with a zero_vm_ops this gets a bit simpler (see schloppedi-schlop).

Obviously will have to replace this with something else that just sets anon in
an mmap_prepare callback once I drop 17/20.

>
> > +	current->mm = &mm;
> > +
> > +	/*
> > +	 * Map a MAP_PRIVATE-/dev/zero mapping at address 0x300000 with a page
> > +	 * offset of 0x10, which we expect to be reset to the anonymous page
> > +	 * offset.
> > +	 */
> > +	addr = __mmap_region(&file, 0x300000, 0x3000, vma_flags, 0x10, NULL);
> > +	ASSERT_EQ(addr, 0x300000);
> > +
> > +	/* Assert that it truly is an anonymous mapping. */
> > +	vma = vma_lookup(&mm, addr);
> > +	ASSERT_NE(vma, NULL);
> > +	ASSERT_TRUE(vma_is_anonymous(vma));
> > +	ASSERT_EQ(vma->vm_file, NULL);
> > +	ASSERT_EQ(vma->vm_private_data, NULL);
> > +	/* Expect anonymous page offsets. */
> > +	ASSERT_EQ(vma->vm_pgoff, 0x300);
> > +	ASSERT_EQ(vma_start_anon_pgoff(vma), 0x300);
>
> Yes, that looks good to me.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
