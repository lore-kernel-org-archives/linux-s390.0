Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0473A4505;
	Mon, 10 Aug 2026 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351016; cv=none; b=cKsLIG302uAFmHa2DLz0E4YM5XqC5VWGCB6yFmWmWKguFsGQ847sHhS5mqMv1qxYtLiDFfQMAfPSLj7+gKoJ8Vbo0DBiCW+v+1KWJtBlQLfPjQ2rjaeZwPatPLF4QgvTe7q9ayt7A/QN2czPxMCEeBoJBuyNchkP/qk1ROfn0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351016; c=relaxed/simple;
	bh=0heE0aeUQp5JoHVaYB/JZs1HN8xkC2lK7gU6vSQV+9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1E8wyD4Uq1SkzNfffuqybEFJE5SC9+auyTJxhcpXBGB7UTOCYzMmVFnFFYmaTsJJkB9D4PGgJFUal1IvzSqjfNbeL+ybVQet60cLTxjHYmpXFNPkwzzWMLgKlIvtEfR7SSnaz+Xi2VohYWAlS9tmSeXNwlDmlLRVQa+kLxDI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG9vfruA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG9vfruA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7FC1F00A3D;
	Mon, 10 Aug 2026 08:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786351015;
	bh=JV5WNgHkpKWzZzTADt5HV8WfufvTRE1W/LdtA3ppIU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WG9vfruAdcqV26E8riIECGmFnBJZd5QFGEF/vLwr28j8gC4/i7xF0ppv5LbXGsZXX
	 JxNn+AK3ID5hxM+oY6+3ga/4g5kSAUZ3bpLvKsQ3jdW2iUMHhzYR8K+qeLV3wBd+SH
	 VfMjlXUAPInIsYgKwkG0faj9NQPkTn8mbqTh93b2RkQ6vc61GikkngdVPvCYS8u1v3
	 Bbmd+K6Qvi9MyaqQYp3ipshXdNTBrXxLxAhKWBNy+rqBS761NXJu8HVp2apMLGHoSi
	 TNqEO7IDleHDyLVMiyzHc0N4UA6L3SFYnW+RHipKKKGb19601kNwdtCQOjQmzQOcPt
	 EgpNCWtEiomWw==
Date: Mon, 10 Aug 2026 09:36:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
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
Subject: Re: [PATCH v4 01/20] mm/vma: introduce VMA anon page offset field
 and add helpers
Message-ID: <anmLnvWAyIJwjsXj@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
 <CAJuCfpFAA1H2pOi6EOarNtrdzLQDJyhm6QOGsfZ4SFTuM5eiLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFAA1H2pOi6EOarNtrdzLQDJyhm6QOGsfZ4SFTuM5eiLQ@mail.gmail.com>

On Sat, Aug 08, 2026 at 05:51:10PM -0700, Suren Baghdasaryan wrote:
> On Thu, Aug 6, 2026 at 1:22 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 87feaa5a2b78..df78847f5f07 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct vm_area_struct *vma)
> >         return vma_end_pgoff(vma) - 1;
> >  }
> >
> > +/**
> > + * vma_start_anon_pgoff() - Get the anonymous page offset of the start of @vma
> > + * @vma: The VMA whose anonymous page offset is required.
> > + *
> > + * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted then the
> > + * anonymous page offset at the time of first fault.
> > + *
> > + * If the VMA is anonymous, this returns the same value as vma_start_pgoff().
> > + *
> > + * This value is used for tracking MAP_PRIVATE file-backed mappings by their
> > + * anonymous page offset.
>
> I assume this function should not be used with shared file-backed
> mappings, right? If so, maybe add a comment like the one you have for
> linear_anon_page_index(): "It is not valid to call this function for
> shared file-backed mappings."?

No that's not the case, it is valid to access this for any VMA though it's only
meaningful for MAP_PRIVATE and anonymous VMAs (though in the latter case pgoff
== anon pgoff).

The code keeps the anon pgoff values consistent even for shared mappings because
- hey - we have the field anyway and it's easiest and safest to just keep it the
same.

One alternative would be to have code that checks the flags and zeroes the field
otherwise , but then you have problems like - early on initialisation now
there's an ordering requirement which can easily go wrong.

Another alternative is to just leave it stale, but then that seems objectively
worse and again requires branching code on update and set.

All-in-all it's easier to keep this working the same for any type of mapping,
it's just useless to do anything with the anon pgoff for a shared mapping :)

--
Cheers, Lorenzo
