Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910399;
	b=e+TdFRfYkRyjPVYzbWnzNc9NGDlYh1Hc0IkuxOryXgMOj3I0B1GymmHGqeESM3NgJDLO
	 Gn+XsaV0MAi2mtuEbte51tpn813RjcTytNxQ7nHKFpPAvW7W1j3gOawzZYVChol3sp8QS
	 kwPo2t8KD8VHPurrBdtrv2WxGaUwWWdagq0B5bRGEBSO+oL0FuGkFLrOGGXAKbgY/NqDO
	 cVLif+LSLakxTAbP4fzqkalLh4RJYT+8RhVKIdY23T8aQSx+mp4125D0kXc9P0/rxCc4p
	 fGGfCl1sPK1VTWPCIlYwHN1l1Zyzr6rjP+kIjbltwvhF79cS03Yj6B9i2wTuxcnOasg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910399;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bjegpoisEbZi471m0jCHyTug5TPNI/ZEHYUEeklKtvE=;
	b=lo3wAZyf/uVUpz54SkzJyU2OEjek9nOyxr6AdP6vZTPzUrkHZshoM1p6f4PwX2xEsfOv
	 7K9uK9BaTAuWbi9+YH1hP5hstNAIBpkDfMT0J7Jjg1ESRwpR0e/pJgUjqCHBogG+koGNk
	 tER7cJwuKFUQrmvzHEQdATiJhEuCVS0Zf+U43Ca0oV8QyKdAAQAL7KVfKeZCtoDj3gzEE
	 HhDfTRtkYM6lE2+X4XeHiZzgssCncapz9ykgGLnC6Qvvg30gp2NWiY6NLvtSokS6ioEh/
	 SZv2hamVxkEZ2n5DOIozgTlczMwFC7ltAC3EhGIeefx2xuMPT8O9XzpURA9FH4WstjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCWhJkXx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7D606A323;
	Tue, 17 Nov 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCWhJkXx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4161F000C4;
	Tue, 17 Nov 2026 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910399;
	bh=bjegpoisEbZi471m0jCHyTug5TPNI/ZEHYUEeklKtvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCWhJkXxe0cd+l/aKM456yX2OjBqh13wZLpZEuhQM2jbS+ys2teSairW1BLSqz39H
	 P4f1JlzNK1bP5fmVazLr6E5YpPmsAcCQWyZ+aMjk3YRRoY9x2c1kd2Xy11NmZPQZZ/
	 nBLIKujMVtHAYFMKk4FRiUcSm4e9uJ2iths/rBov6xl3NUUlHEfIktYnFJkS1dsS63
	 HpxgCf6kyYS8Gexowd2VVgg8+fLYPehQU6LUGZLe8sajy32NEX0nTKUuHyLs93tyxk
	 991CZ2XvEZcZiNJbKxs96PsQHM3YRz2jd1+SL1g1rShIJFNzja9UdHZSDWpX+4v+Rj
	 U++7nPWw4FK5g==
Date: Tue, 17 Nov 2026 11:13:07 +0100
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
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 03/15] mm/hugetlb: preserve reservations when
 shrinking on HIGHMEM
Message-ID: <avwos-qF9ADmdHIT@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-3-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-3-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:24PM +0100, David Hildenbrand (Arm) wrote:
> try_to_free_low() drops the hugetlb_lock while freeing lowmem folios.
> set_max_huge_pages() then resumes freeing folios using the
> min_count computed before that unlock. Reservations created in between
> can consequently lose their backing.
> 
> Collect lowmem folios on the caller's existing page_list instead. Keep
> the hugetlb_lock held through both selection passes, and free the combined
> list at the caller's existing unlock point.
> 
> Likely not stable-worthy.
> 
> Fixes: 1121828a0c21 ("hugetlb: call update_and_free_page without hugetlb_lock")
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
