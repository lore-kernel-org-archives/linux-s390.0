Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079502;
	b=U2OzCsAgrsMhQ9R3oDqKmhd96aI0GfEZxe/H5aYEo4xRnEnAws4JaEhykXPLbY5GsZP2
	 RL/vO9K9+xNeAXcjXJq7M5+4xUsvTOPhWAMTSwhThvSWKbiH1v0HTJMaHdZojdQ+rORyM
	 w0dQCWGnqpNVtShhEdw1RiyoEkOV5aDiDKgh6MgzdmVz3iVTN7HJlijb/ZU/Co6lOyp74
	 VjZgf4tcvYddhkn6MukJATFPishDmWffplgSMqg2nOmP7OqkyKEEIaj8toww6lqoDk+O0
	 dE56mdeV/dupJFHMM5p14D8o8s1bt7NBtM3c4i8yU6Se3+PK1SToWLzC65BUApO5B6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079502;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+ob3yII6XgPfaGzBlNNgVC1u1nxxTdD3c2/x1BrWMGM=;
	b=SkeiGIVOrmzV/TYkj90NFsbdeiLeMz9cPTTlqpz4a6KYsKvkoVb7Xn1inbLxZ6U3oVOl
	 3N9SM/MousinL4SIYqe2sWsORrCHmwGILqv9BD6IBl6kllr3aBRF6MSkLwJqZFzSRGl2J
	 XYQyZFnD0CKafcyY3xZtwluZT4SHImSub3gdITIWlJeue8YfZ+npR+lqa1uFFcMm5OPHv
	 ufV0M2xfKrRbUTXkhMzj6bPMvK4Esd6e3RcuYiZZQeSGoM8CxVz7zZTPKsic+E9Tc/Jw+
	 zZItS81dwokoj53K8RzqqsOeJk8sxjRaR+DKoE9YmJoXZ++xoIFVCG/oPhDvUO+dFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCAqElg+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AE606A320;
	Thu, 19 Nov 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCAqElg+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28301F000C4;
	Thu, 19 Nov 2026 09:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079501;
	bh=+ob3yII6XgPfaGzBlNNgVC1u1nxxTdD3c2/x1BrWMGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oCAqElg+jHpUv5NZi3+X5pT71z2hb8IbZEPK5BleYGMiMxx+phX6OjUT/P/4JUK2Q
	 gHVX8e7WqtiDEHBKb5OeG3+JgdTndcnYo+GJ4u74ENd96k6WZheR7PExY00+0aU+fN
	 oTV78DY/bCF6fuGrMLPl96Z2obRF3NzoMJzPTDcBtla5/DdGBhEyFt4AGOfdP2jkyn
	 wgW8UBwgVdqvAGib+vgTEmLFnEg4B6mqeSe1TfYDkZ1XM1hOX+fI3Qjn0gkajd6TLh
	 U5sKOqVa8tgXrJoD6aa8iOCHtuoYt75M1hI6VQVHKNjM3LzrR800nK0vZnwiwLPZFb
	 Wfp9a+v0hoLhA==
Date: Thu, 19 Nov 2026 10:11:30 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>, Andy Whitcroft <apw@canonical.com>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
	Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 09/15] mm/memfd: recheck the page cache before
 allocating a hugetlb folio
Message-ID: <av69QsxDuugzEJPL@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:30PM +0100, David Hildenbrand (Arm) wrote:
> A concurrent fault or PIN request can populate the page cache
> after memfd_pin_folios() misses it in the page cache but before
> memfd_alloc_folio() takes the fault mutex. The latter still tries to
> allocate another folio and can return -ENOMEM even though the requested
> folio is already cached.
> 
> In particular, hugetlb_reserve_pages() finds the existing reservation-map
> entry and reserves nothing. If no global reservations remain,
> alloc_hugetlb_folio_reserve() fails even when the pool has free pages,
> effectively failing memfd_pin_folios().
> 
> Recheck the page cache before reserving or allocating. If the folio is
> present, drop the lookup reference and return -EEXIST so
> memfd_pin_folios() retries its lookup.
> 
> This is probably not worth backporting to stable.
> 
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
