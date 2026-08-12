Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE42335081;
	Wed, 12 Aug 2026 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555503; cv=none; b=UuptlWrl/V3vc6dVHRjBSGEv2ibc+BqOaGva8C4cpcMA8O6KZN9LlCelsQFy2z0SoHwdVtt7pjs/jitV3igMl5rIb/lt1rVqG5L3MP5S9BsmWpeto/2mq0u6+p3OLHix+ZYZ72p8O50eSr1dVgsG2UCcnJShDjsNZ9bNUKUHDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555503; c=relaxed/simple;
	bh=9krHO3kdawIY6l5ywOCNmhxFUNDM92ilYwDPpMvTJzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVw8uSQkI59SKQi/af/oOhuwrVODdAT6rew8sGv2vIWyIWuast4I/RWvQAnNxQmiKHheK7zXGCStym5bUxCI1cyf/ymgU3KgYgC4f468AxMnVr1bwNFwwJODeJjLwC+IdvvurQFpFBZwyZWY6sgg1ZNTVMPSwh60XlRoQ/TALb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okENkuhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okENkuhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078981F000E9;
	Wed, 12 Aug 2026 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555501;
	bh=4oSNzFjHuzTOgbEhKYNA4ws0ltCJrHAzS2GU8pXVakw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=okENkuhgzJjXS2UaQaKvB9ybQ+m9ds7pwF4/b8z12pNVDtXC7HNFGnfr3MAVGjum9
	 OvD/UR/LQA7302JY5sAzT40e1zQDjEK91x2GZsHTbymznhWHeWiZDz7hwLCqiSn6HJ
	 dVm/gtD6dBtUo5Ozo/Ni81ygCihwBpcTeoM/4Oqf/oGFAhL3/gVP1qSTk3tipcc1f9
	 u+sOr4XyXy7FN4TCvoZtjmKo0V0yvHBm/1K/pWlH7wTBTxGJ51f5FevBzvXtye5VVe
	 yrp075F1nLy9NekTz0yx4F7BHc6yPEj13/zVnbG0vx+U8pYkCM5NqOG4MzgR1FeG48
	 OfkGs+4EOKBuA==
Date: Wed, 12 Aug 2026 18:24:27 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
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
Message-ID: <anysQa1hC83cdX_7@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-16-ab318a350404@kernel.org>
 <cf70ce8f-cdde-43ec-a50e-796d4e390f3f@kernel.org>
 <antWw3a0iEv4l1Yd@gremlin>
 <20260811130832.3f18d4326a5ebe6eb18cfb5f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811130832.3f18d4326a5ebe6eb18cfb5f@linux-foundation.org>

On Tue, Aug 11, 2026 at 01:08:32PM -0700, Andrew Morton wrote:
> On Tue, 11 Aug 2026 18:07:36 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > > "Fault in" is imprecise, as a read-fault won't do. "Trigger a CoW fault." might
> > > be better.
> >
> > Andrew - could you fix up? Thanks :)
>
> np.
>
> --- a/tools/testing/selftests/mm/merge.c~tools-testing-selftests-mm-test-anonymous-page-offset-merge-behaviour-fix
> +++ a/tools/testing/selftests/mm/merge.c
> @@ -1324,7 +1324,7 @@ TEST_F(merge, anon_and_page_offset_misma
>  	ASSERT_NE(ptr, MAP_FAILED);
>
>  	/*
> -	 * Map another separately, and fault in, at page offset 5:
> +	 * Map another separately and trigger a CoW fault, at page offset 5:
>  	 *
>  	 * |-----------|           |---------|
>  	 * | unfaulted |           | faulted |
> _
>

LGTM thanks very much! :)

--
Cheers, Lorenzo
