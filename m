Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21B2F8E91;
	Tue, 11 Aug 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478920; cv=none; b=SgwWJGmpkc8rfltaY68kXuowNaOh1GBB2Ifbcic5tzqQAy5CYrkPq42fgQaX0u5yXZTj6yXeWLyPFNENko9gAUSGWiuxnvr0reNcpC4Fu/hjRScwhYS9CImAAYuJ9m0Lj6e6nyDKNqKP8Rh0wkdAL5Ca09iejSZ0x1WVFmrENkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478920; c=relaxed/simple;
	bh=SInW6aPtiXmfT1CA7VtmXzt8BbA3T2FQBK1qPozb2GA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ahiB3T8bANXbgjzULdp9kocbXnec9QkM/R4rcFkSMUVF0ZibJRygV9cYmKrkYsiuIyz/XVBA/NqO/1DWFeZuaxCHpomhqRmh8LP0QrXU1LXjX++5H17Eq4FEj2KPog24nQ0sRhB93nH/6XnZ3GUfdL3PQH3xl3xVmIKfhLUKjPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MVsx4Y86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MVsx4Y86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384501F00A3A;
	Tue, 11 Aug 2026 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786478915;
	bh=ay4Sx1aFee/8WOMMoH+smEVqfxFPpuKMRZQpbR6u3yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MVsx4Y86Lda8QCjyAeakFZeNbk1U1nnbpjqsIPtBxUMubFHCaQYUz20Z8mA0RiRLA
	 VCd+fPtrTR+NcFIxYVzfhh214iv37GZnIs3sWMgVPEcj8F9bTxcMlXmXihxTs0oG+8
	 fLgI8mKfy36hIx1mSwWptiKfVBg1ORNZHfRMBLR4=
Date: Tue, 11 Aug 2026 13:08:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "Liam R. Howlett"
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
Subject: Re: [PATCH v4 16/20] tools/testing/selftests/mm: test anonymous
 page offset merge behaviour
Message-Id: <20260811130832.3f18d4326a5ebe6eb18cfb5f@linux-foundation.org>
In-Reply-To: <antWw3a0iEv4l1Yd@gremlin>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
	<20260806-b4-scalable-cow-virt-pgoff-v4-16-ab318a350404@kernel.org>
	<cf70ce8f-cdde-43ec-a50e-796d4e390f3f@kernel.org>
	<antWw3a0iEv4l1Yd@gremlin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 18:07:36 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> > "Fault in" is imprecise, as a read-fault won't do. "Trigger a CoW fault." might
> > be better.
> 
> Andrew - could you fix up? Thanks :)

np.

--- a/tools/testing/selftests/mm/merge.c~tools-testing-selftests-mm-test-anonymous-page-offset-merge-behaviour-fix
+++ a/tools/testing/selftests/mm/merge.c
@@ -1324,7 +1324,7 @@ TEST_F(merge, anon_and_page_offset_misma
 	ASSERT_NE(ptr, MAP_FAILED);
 
 	/*
-	 * Map another separately, and fault in, at page offset 5:
+	 * Map another separately and trigger a CoW fault, at page offset 5:
 	 *
 	 * |-----------|           |---------|
 	 * | unfaulted |           | faulted |
_

