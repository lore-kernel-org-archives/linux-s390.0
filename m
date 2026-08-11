Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E162D738F;
	Tue, 11 Aug 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467117; cv=none; b=owhPFg/OWBlQ7KTMVpm8BFan27Amwz5aIeaP1+KevMNbWTWDIHrSvWgCHz03vy4fju/vOmFiK+Hkex86lULXzef2gPJP2fV6H8EmLRJGOxvMfbQP8nOOYdXbdQUboBggi2FayUVmn2V/vplAptn4anZGMH9BnAq/YI3Dtirrfi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467117; c=relaxed/simple;
	bh=nUtXloIWo+60BaXIYhpidIQX8u9D+3kedoVN7C9D9/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjzzhQemS3oasF4Ya/Ie3ay5OZaJM6T9BiLFQYIO72Q/GeLlwyW/oT5i/NzJNemTJl7nI6mGd9e2o7kw0o+pEpi+b40ex31oKpafsNkJykRvtcjKZp3/JM4yU5vpggv5QzMG4pzhzu+E505VJXYrlofdg54aiB539yDZDQhAZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu6P4EWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu6P4EWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694BD1F000E9;
	Tue, 11 Aug 2026 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786467109;
	bh=nUtXloIWo+60BaXIYhpidIQX8u9D+3kedoVN7C9D9/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zu6P4EWld4gpzY1R8hq3ER5DyVSS8EQG3tj3hB0FUUqztpnB1xSYcKl3Q43tc8cmj
	 UUsHVaeqqzm48VuQVJJx2EmW7mni8RQ6I1+levHRzt5ChDbHMTxJyaxCh3f6iBS0/C
	 55H0zKXQaRRXxQd/+WCqvaxpLr5pPGlTLRkmGM/8141rUWlck+hHndDPdyOG2aaDBw
	 gO3sp1uV5pzP/Ne9Y0kFwRhkfkxbs6cWxO90fh/uBbI39rSVBYq65rSukH7lNfLsuz
	 C2uETEK6ptuNat6DVNihDE0Y6C1cj1icY2cXtTTklAMhkklLMENnIaGg5NMBUxP04U
	 D1oeyGwJyciyA==
Date: Tue, 11 Aug 2026 17:51:33 +0100
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
Subject: Re: [PATCH v4 07/20] mm/vma: fix self-merge check in copy_vma()
Message-ID: <antTCpT9gXN7pSRn@gremlin>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-7-ab318a350404@kernel.org>
 <3a0a9aaf-20f5-4f92-b848-00ab702e8fe2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0a9aaf-20f5-4f92-b848-00ab702e8fe2@kernel.org>

On Tue, Aug 11, 2026 at 06:44:01PM +0200, David Hildenbrand (Arm) wrote:
> >
> > Since copy_vma_and_data() which calls copy_vma() intends to reference the
> > old VMA after the merge, it must have this pointer updated.
> >
> > This kind of self-merge is not possible with a succeeding merge, as the
> > merge always prefers to expand the preceding VMA if possible.
> >
> > copy_vma() accounts for this by explicitly checking to see if a self-merge
> > occurred and updating the vmap pointer if so. However it incorrect did so
> > even for a subsequent merge (this is simply a noop so it had no impact).
>
> Took me longer than it should to find out that this is no real fix ;)
>
> >
> > So change this to only check for the case which matters - a backwards
> > merge - and rearrange the parameters to make it clearer we're doing that -
> > i.e. check new_vma->vm_start < old_vma_start (having already renamed
> > vma_start to old_vma_start to make it clear this is the previous VMA).
> >
> > Also update the existing wall-of-text comment to be a lot clearer.
> >
> > While we're here, replace the VM_BUG_ON_VMA() with a VM_WARN_ON_ONCE_VMA()
> > and update the VMA userland tests accordingly.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> I skimmed over it, looks correct, but the merging stuff is way over my head to
> confidentially give a RB tag her :)

Well that's what A-b is for ;)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
