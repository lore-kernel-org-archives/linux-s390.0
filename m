Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D9263C8F;
	Tue, 11 Aug 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468073; cv=none; b=oovXSpBGeV9iGwts+iOrrF/Vz/vI8MUN9DBVoHRPlx8+5pqlFIGgotPRJREiIUU0w2ZJ3rCsSA3QgHO//THssnJyDY/m1N85e9uOWdUKsT1kApmp7bR3+BlqQ8Yw4iDGiDJLgSpp9MGjW7QpOfqQ31qDa59TmlokLQ0hqw40HEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468073; c=relaxed/simple;
	bh=N+mXIOIWXA0/orzNzNwGG39tuU2ATGudf/Z8m3WST2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enfbRKignxBQMv6FDdxJRyH+MKYKfCcYtfjCC5C5MGZ0kyFmzzmzsPvIBtoFZS/wxJm5aGgrKAuedFd/LfKBYsEphhgnPigwVWqYgN9ysanbjWmohdr2vZBS8RAh2f6JZvkOOh0X65DsM8ZL1sPQ0Bv5Ksu6i8sALcVrt0t6MPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muZHQpJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muZHQpJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E4A1F00A3A;
	Tue, 11 Aug 2026 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468071;
	bh=iUKLaNVgnm6yVlIUuq3S+v3XbNNRA5IFdKQLUZEf4Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=muZHQpJO9uzZAk0kMRcdaEMI9jcfs4Uu8oC32MtScjPY0WQhPC9xcG9YtLeaqYkRQ
	 BghULgIcL5/Ouo5WcMWjVgCzG81bXQD6IdhgzJ6RLsQSkBK03Zm7Q/fe1OeV3TUm0h
	 46THJIkIrI54+SDkzKF9E0cwdr8sdNPbtzdgd4zMW4gmlKrbgcMHPDNsbQ5FIgOYzV
	 5i4BQIab45nRpWJ+5/jy2TB8m8BQIVBiwTgWhiKCPfXFIL663Lp+qsXIZ1AuT7UVS6
	 vdbOBvZg6oEOgAzKgxsuG5rlZ/X3CLkTg0FKOgfOxRCP92SoTKocLw6YIaqodz+n1H
	 r9H212Mfzjw/w==
Date: Tue, 11 Aug 2026 18:07:36 +0100
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
Subject: Re: [PATCH v4 16/20] tools/testing/selftests/mm: test anonymous page
 offset merge behaviour
Message-ID: <antWw3a0iEv4l1Yd@gremlin>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-16-ab318a350404@kernel.org>
 <cf70ce8f-cdde-43ec-a50e-796d4e390f3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf70ce8f-cdde-43ec-a50e-796d4e390f3f@kernel.org>

On Tue, Aug 11, 2026 at 06:56:18PM +0200, David Hildenbrand (Arm) wrote:
> On 8/6/26 22:21, Lorenzo Stoakes (ARM) wrote:
> > While maintaining anonymous page offsets for VMAs has no impact for most
> > merge cases, it does impact MAP_PRIVATE-mapped file-backed mappings which
> > happen to have matching page offset but not matching anonymous page offset.
> >
> > Assert this behaviour by attempting to map an unfaulted MAP_PRIVATE-memfd
> > region with a faulted one with compatible file page offsets but
> > incompatible anonymous page offsets.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  tools/testing/selftests/mm/merge.c | 57 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> > index 519e5ac02db7..cb7cdb6b7ada 100644
> > --- a/tools/testing/selftests/mm/merge.c
> > +++ b/tools/testing/selftests/mm/merge.c
> > @@ -1305,6 +1305,63 @@ TEST_F(merge, merge_vmas_with_mseal)
> >  	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> >  }
> >
> > +TEST_F(merge, anon_and_page_offset_mismatch_memfd)
> > +{
> > +	struct procmap_fd *procmap = &self->procmap;
> > +	unsigned int page_size = self->page_size;
> > +	char *carveout = self->carveout;
> > +	char *ptr, *ptr2;
> > +	int fd;
> > +
> > +	/* Create a 10 page memfd descriptor. */
> > +	fd = memfd_create("anon_page_offset_test", MFD_CLOEXEC);
> > +	ASSERT_NE(fd, -1);
> > +	ASSERT_EQ(ftruncate(fd, 10 * page_size), 0);
> > +
> > +	/* Map a region using the memfd at page offset 0. */
> > +	ptr = mmap(carveout, 5 * page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_FIXED | MAP_PRIVATE, fd, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +
> > +	/*
> > +	 * Map another separately, and fault in, at page offset 5:
> > +	 *
>
> "Fault in" is imprecise, as a read-fault won't do. "Trigger a CoW fault." might
> be better.

Andrew - could you fix up? Thanks :)

>
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
