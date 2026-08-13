Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35A39B947;
	Thu, 13 Aug 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613687; cv=none; b=C8wkTEvJiovebDViKGW4fLng75Butd72uweCg3pUO0cLk7YpB17bDeyxVH5h3VBHRryImBUNpnB0rqyadC4XLgBMdsSphKLCEyJNu2vk8ucOa7/juMdOPt3YQmU0eVHnV/Z91dgiVgmN3HXAIaYTXaNlw257X0097Rpahl+4hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613687; c=relaxed/simple;
	bh=8GGJeMXZjenStr/KzvJ5bvXYBWbaVtnV9BN6Q25mvnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRmARe2gcehSxd8nflLUy88EEikRIVwXkl5HOaaN2EKz8bfbKSqL71YBT0qmpTFvhDQQC7bfuUj5+VQAQq/nvYBPXPXzCBCDsGyMqtPq+xY9yvZiVw8HbsKEZf9RKSe+TreIGdPMFOrlUGxkkn+Lx5CmDRwV6sBQ6hinuv1Ch84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUE5dJPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUE5dJPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2C21F00A3A;
	Thu, 13 Aug 2026 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786613677;
	bh=8GGJeMXZjenStr/KzvJ5bvXYBWbaVtnV9BN6Q25mvnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bUE5dJPAlkV0e3vT0h7pYlLJU5zXJxR2LXxBNspnyo1VD4QhHtGs98mt311XJsBdW
	 NwB8Nq4PllboYzEJBi81NS4Znt7rwrq4KgMryMSE0C43kPgg4JZBe4YaD73IDj3Qhc
	 hkISD3HoCeXW5N5BR+POiDBs1yZqmn+EUOSooN1tXl82a26xMjeWiPMpVvfYRQfG/x
	 ZMtuu9DxIOMyxMhsNgoWAd1PzcOu+EcD2NUsikKPG7Mr3cJCZt6UfUjHm2RYLp+0Px
	 1/SSm+fTyu/vmq45+SrPqFDYNWi/Yibqy+QbWRYX2IwQzUF1p8qhv0/ihpFi9UoHkc
	 0QX0gdddlS7+w==
Date: Thu, 13 Aug 2026 10:34:00 +0100
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
Subject: Re: [PATCH v4 18/20] mm/vma: make MAP_PRIVATE-mapped /dev/zero
 mappings truly anonymous
Message-ID: <an2PQD_pT-ZpSCvP@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-18-ab318a350404@kernel.org>
 <517ea018-d6a9-4c78-b0a6-4f002b3b72ca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517ea018-d6a9-4c78-b0a6-4f002b3b72ca@kernel.org>

On Thu, Aug 13, 2026 at 11:29:43AM +0200, David Hildenbrand (Arm) wrote:
> On 8/6/26 22:21, Lorenzo Stoakes (ARM) wrote:
> > When mapping /dev/zero with MAP_PRIVATE, one ends up with strange VMAs
> > originating from Linux's distant past.
> >
> > These have vma->vm_file set but NULL vma->vm_ops, meaning they satisfy
> > vma_is_anonymous() but otherwise resemble a file-backed VMA.
> >
> > The introduction of anonymous page offsets and their subsequent use as
> > indexes for MAP_PRIVATE-file-backed mappings mean the rmap does the right
> > thing with these but we are left with inconsistencies.
> >
> > The vma_start_pgoff(vma) == vma_start_anon_pgoff(vma) invariant is true for
> > all other anonymous VMAs, but not these.
> >
> > These VMAs are also observable as files in /proc/<pid>/[maps, smaps,
> > map_files] but otherwise behave like anonymous mappings.
> >
> > Therefore let's make these VMAs actually anonymous at mapping time which
> > will activate the anonymous code path for mappings.
> >
> > This means we no longer have to account for this discrepancy anywhere and
> > no longer have to think about these at all.
> >
> > This is user-observable, as MAP_PRIVATE-/dev/zero will no longer appear in
> > procfs as a file-backed mapping, but the impact of this change should be
> > low as likely nobody is relying upon this.
>
> As discussed off-list, it's best to discuss the impact with the wider community.
> I'm afraid not many people made it to patch #18 in this series. :)
>
> I don't expect this to actually break something, but we should be clear that
> doing a mmap("/dev/zero") will no longer indicate that as a file mapping in /proc/.
>
> You could mention that e.g., criu checks for "/dev/zero" mappings explicitly,
> but will just keep doing the right thing once this is a proper anon mapping; we
> expect similar use cases to do exactly that, and rather check for "/dev/zero"
> only to conclude themselves "this is just an anon mapping".
>
> Doing some digging, AI raised that there is the potential of some workload
> explicitly using "/dev/zero" to get an entry in map_files. I think that's
> essentially what our selftests do that you have to modify. I cannot thing of a
> good reason why someone would do that in their workload, and at least AI wasn't
> able to easily identify any such users.

I already fixed the self tests and yeah it's not very likely.

But as discussed off-list, let's defer the /dev/zero stuff to the next cycle and
get the core of this series in first. It's clear there's more discussion to be
had there :)

Will respin with the /dev/zero stuff peeled off!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
