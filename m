Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992648;
	b=qmWlQD6woUrzWEFutCRTMXrvPoeelRcL7sm5uM9wz0yC0zfUjRv5Yti0FwXsn79kruYY
	 06poPN/QVWcN2abxZUra2yGdO/9huGhMRZewkFSOnSBMO0LoShLJtSDsR8KWAhPB/V/ih
	 qn4q7K2RxD+UcDzHTKQXaZloKDl85Zf25zb8mZR9ZsfTB17YetyHWMV5Xm7pPKKvwoV3F
	 Bivzsn8KkeEJAndIajzuJkd0vGni2g8XcwSop2yGWo/nm/wipR/P/mriLh9m+VgwYP7Ez
	 2UdL2uunNeUcM7eYHOmRd/I/v/cHtEinDYmn3oxd1CavUfZaOtFCKzyhaFrwu6LiI5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992648;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/ILw4EFux7bTkf5RNu3Ik+2UTxpkbYziGgraDHdKyo4=;
	b=C6GXyioPCa1qq8jmosDq37gyRofZ/1TMDoYTzBBztStwUVrXzcX3CxV0Hzx4UZGlE8T9
	 e0XKuKBJ6cIKVAug7KdSmDOYUe2L/R1+2efKjCyfma7h8i2+3VG1d/ooPIK4H73oYLuN+
	 8518zDMqlt2FB1XlMZHNudoFUGNB3a3xcq6sChbbHVIV1hvSTs9Q7JVwmPbsl2iWvAWq+
	 gj53wHKoA1JB49ZAKEg5l4jUCLLrGJ06bC66ujWps0mu60JxR+aOpKFX5A/I0p5VdChq4
	 jwpXpwqYph8+cKqbtFB7EqZFv65R551A7bQgC8wtI6xPy8fjYBL3VkZJJ7wx+bIb//g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxLWD3N7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0F606A31C;
	Wed, 18 Nov 2026 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxLWD3N7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C9E1F000CE;
	Wed, 18 Nov 2026 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992647;
	bh=/ILw4EFux7bTkf5RNu3Ik+2UTxpkbYziGgraDHdKyo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GxLWD3N73udbUDoNblg7Ifu79ktDf2tMPQZBPZqOeRhnEGWEZm7cUXVyjJ1dnGv5i
	 l3BIwO3wcRqh/opIRo3nC8VYsRjIQHTV2Z4Wp8Fk3nsEgpEC9o77OtjcDP3eGFN7Fb
	 n0MZW/am2GOXPaqhqQa+rFDYtnX3TblWDpKMk25PbbLNOINBG12hHwFhiI9ihwCobM
	 VY5YhSvOPK+r9knEQz2YZCvaUHzkAa7KgIXsQ7UnIahtmy9PqzvnfJTtC767GGKR4j
	 o18rv44b5AyfSff3CIXYD7OvaDKnLyI1Tg9wwp9KU2+/ayRnE1vvZxgnUG/oEapTsr
	 jDapuh74AaHyA==
Date: Wed, 18 Nov 2026 10:03:52 +0100
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
	Josef Bacik <josef@toxicpanda.com>, stable@kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH v2 07/15] hugetlbfs: fix unmapping folios from private
 VMAs
Message-ID: <av1p-MN1hMfZDuBL@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-7-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-7-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:28PM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> hugetlb_unmap_file_folio() assumes vm_private_data points to a struct
> hugetlb_vma_lock when hugetlb_vma_trylock_write() fails. Since hugetlb VMA
> locking was extended to private VMAs, this can also happen when
> vm_private_data contains a resv_map pointer; treating it as a
> hugetlb_vma_lock corrupts memory and can cause crashes or hangs.
> 
> Only take the VMA lock when a shareable lock exists, as additional locking
> is only needed for PMD table sharing. The fault mutex and i_mmap_rwsem
> already provide the required protection for private VMAs.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
> Cc: stable@kernel.org
> Tested-by: Daehyeon Ko <4ncienth@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify description and comment ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
