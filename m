Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080112;
	b=zKZfx1a4jQ5J/G0OHu2AUTdeu+0lG+cIevKypVhjjNLfVfzqs6+mS0qrwTUpElLS2MLG
	 EptaSMDfLgHkK/9tqYvhplj2TrbsWajdNNSrM2r1KuK7bU1WWIULchkZ2/af+89AdMyqH
	 B0Bac7P9+PpMRSfDxtVapi9Wpq6i7YwiXquY+4hbGrjcXDyp4THzDHULG+ie0HjXnXEpC
	 O34acrsCgbe4uT+NPadBmMw11ELzBka1LV8Fyh2oHqjbxetl4Dc9gxgoPh1aH220ntriQ
	 iuvSJVTt97+0JVCF7sFhG0lb0TVzJMIePy6RBDQwKWDxMeQ6CPQnKl9iRv0EY6Vhluw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5Wr5mBmCRIZACCxxVm/06jDLVb0/ss7nm5ggZMozLNA=;
	b=22WEEWvPMycouyAI2i8tgxrm1nzj6Yfx6RD7r/9OlaKsweiAH709oNu1x1NNzcO7dDhF
	 jaSszUZN2htz3Y/sJ0Edb0NIo2FlVqQIv5Dg3UJdE4EH3i4iHitE1ksBu1nVFvF+Votxv
	 57xwpaMg61EuDqCFtMEn6RzGrWWGeaVlghpzW/eqnc63VMZf384j5USY+j6pTkvTeySDG
	 c0KvhCh+V/ZqdSjD/vHuCf7cHq7c/BmWHuSJNzW1lt4d7nhjdgSojMF8vmc/8RpKX2yqd
	 w5YK3hgdYo1GyAc4e0J1aitPnfjL2uicRhQNNM5C8DYqpU+TCv9PPqqvkWhvwAL1MWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsjvME0P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696F606A32A;
	Thu, 19 Nov 2026 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsjvME0P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CEF1F000C5;
	Thu, 19 Nov 2026 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080111;
	bh=5Wr5mBmCRIZACCxxVm/06jDLVb0/ss7nm5ggZMozLNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nsjvME0Pz0scMadhgpwHZPUo0otG94zFoSunBqCc/ZSA51ayJFG8XqUgDzzVs9Kfq
	 3P+ziEEQQJWx3OysvzemIRFFeoie9jwxaDw22jftfAxZgwFDyhMCvLx5A4P3f8620s
	 1eWHtIXTDL1mhK8xJXXRt4XlGQI/HnGU3ZC/PIv/tfgU6XMBYyWP+YwFXlhGUaJCg4
	 ZOdBHhg+WiQFjUzLs9J5RL8/A/ACyTs7vPnDwfbaENEsz0bqTu2Jtq8PFV1wXKxqIC
	 lEi+uM3OYdUCpyTUH1K3L12s49gJNUVKHPYKHuEktEtvpC35sURPiFFyWMN6vajWEG
	 E2Ax/gq4PoIng==
Date: Thu, 19 Nov 2026 10:21:39 +0100
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
	Chris Mason <mason@kernel.org>, stable@kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v2 12/15] mm/hugetlb: keep surplus folios that are
 reserved
Message-ID: <av6_o6kr6Thpc0ds@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-12-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-12-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:33PM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> free_huge_folio() may restore a reservation, but still returns the folio
> to the page allocator if its node has surplus huge pages.
> 
> For example, start with no hugetlb folios and allow one surplus 2 MiB
> folio:
> 
>   1. Mount hugetlbfs with pagesize=2M,min_size=2M. This allocates and
>      reserves one surplus folio: free=1, reserved=1.
>   2. Create a 2 MiB file and write to a shared mapping of it. The fault
>      consumes the folio and its reservation: free=0, reserved=0.
>   3. Unmap the file and truncate it to zero. The mount's reservation is
>      restored, but the surplus folio is freed: free=0, reserved=1.
> 
> Besides losing a hugetlb folio that is required for a reservation, this
> can also make available_huge_pages() underflow and cause other issues.
> 
> Keep the folio in the pool if it is needed to cover reservations,
> including any reservation we just restored.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 07443a85ad90 ("mm, hugetlb: return a reserved page to a reserved pool if failed")
> Cc: stable@kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
