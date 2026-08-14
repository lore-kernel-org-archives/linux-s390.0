Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F841D63D;
	Fri, 14 Aug 2026 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699161; cv=none; b=LRRUAqhurHjb3i1Ioqbt/dG9832qbSjTny4Ic/Wrpikxb+WbZQ9N4KkUMxYba5BH0R/REzC1ZZulE1/KeieFIf2sxTUWGMA+m8GnoGFR+DPCecXiB9ESBgMX/S7DmKcZEN7UEJBQNW2kx7pEmR7V+6jQE1xi3NCNkcDuz3G3q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699161; c=relaxed/simple;
	bh=eGXTSrY/e72GXMQm/b4vvNVMNssSrHB7ePmPJ/evmCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjJiMeyoyTyoa+80UpWuE/Qv2u7qLi7LgPnCOh3JQrpcOr6ht5bytWYymxTTDwJu8kiajCAHWLEHZI+Q+8sF2DuVrNeKMhoQQsixSx+aM5nadK8MlzasuTxRdpqjCnHic6EYUze7TVQz8MRCxG1lP21XFMPo0+li1hZszEMClBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClROgThb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClROgThb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6EC1F00A3A;
	Fri, 14 Aug 2026 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699159;
	bh=wSiv8Ryxhci6n2uyQC5hk0pgjrUd4kNrjgv+MUJmkHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ClROgThbzrACv5QEUbj7DSocgDof09D5Vd7sQg8I+Lt+b+Uh/duTux7hEUsAhO9YD
	 p6Gmfpy6TVyxbruLfAoIzXNgsGfse45hci9xJr8uwCdRr/sWmwzYiwkAEOkJXbYnkO
	 o3zxJzbVlIYeX6G9egfopDM3RX9OY+l6wO8ezGZyiHZ+/duems2RJFG3g6lmNWXRLE
	 QmFm1GOD01DhXfb8oWjFXZm94WasQ2gfDu8rtioB8alon8esBGOD3oL6inBOR4cbrp
	 wsZcsWaxHygY5y1ete2swQwTHFnPb1dR3CX6Cng064seinHx/l/tBbrLrw+txP+S04
	 Sp73EkyK4Pr9A==
Date: Fri, 14 Aug 2026 12:18:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 00/16] mm/rmap: index MAP_PRIVATE file-backed folios
 by anonymous pgoff
Message-ID: <an7dekaY7IMMrzID@kernel.org>
References: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
 <20260813115346.2aaad419a351341a4f5f3ae0@linux-foundation.org>
 <an7SkamROquJ7If0@lucifer>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an7SkamROquJ7If0@lucifer>

On Fri, Aug 14, 2026 at 10:01:19AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Aug 13, 2026 at 11:53:46AM -0700, Andrew Morton wrote:
> > You'll be mortified to hear that Sashiko wasn't able to find anything
> > to which to apply this.
> 
> :))
> 
> Well, when it's right it's useful, when it's wrong or suggesting unrelated
> what-nots it's less useful :>)
> 
> I do locally put things through claude + Chris Mason's prompts a lot, I
> don't always invoke local sashiko as it's very slow and token-heavy or has
> been so far, but am planning to do that more also in future.
> 
> >
> > Sashiko can be guided with a base-commit: tag but I'm not sure how to
> > tell it what tree/branch to try, or even if that's necessary.  Perhaps
> > someone can figure this out sometime.
> 
> b4 gives a base commit, but I think because the trees are rebased it ends
> up being the incorrect one.

It's not only that the tree is rebased, but also that mm-unstable carries
the previous version of the patches.

> Not sure what the solution is!
> 
> --
> Cheers, Lorenzo

-- 
Sincerely yours,
Mike.
