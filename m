Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910314;
	b=ZkUN1LXdnbD4324BB2iHfZXOpJogQac0q+pDYA/3AT/JFsUxAB4sgZfnCJsPBM9waEKL
	 Kz8YfcWHOBm752QUsfKpnba9XIKnfKzjO0Z562TYC6NbVC1vHAQZ/6iT3ITsHWC9pVyiB
	 b3ivcIYZWIc+7bVYi6MnBBzGNhnoPEgseZgE03gJsAE/YzbP2S7BBKIWvlSwoQfvbxLhr
	 ZKvJhfEv/d9J0noQ2uVwGm9G2idxyJ+BuB79j/lgQnkcr1ZR8fERzPtU7mfEHSYaXhV6C
	 Rc9pW5TUJIvNsVZmRyMgrb1CD/TjMAFay2eF0oRly7lK7xIyzUnYMdsfvV/0Mz1sFuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910314;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v0S4+MTT91ej2d/hxyY2qFRb1L9CnA6yF9yap31hKRE=;
	b=iJYgSnKD0jJv1/XaKji+5pm6wE05ffED3MC5hbOTBuKJvfiP+T0fWoL/dFfX5oGW9HFZ
	 y5IgaVWASuaQzBdTzMowfL10kcDKOqJJ0ATX76pZLWEj3mBQxG/TIOoRGObF/CGovK8qP
	 NVsAH751QXv0hczMtOTPXqKmmQAOp8Mtz/7ffGK/4iNEsgIaxecTnRn9/Pv0DdzAaVvw5
	 KGGWd/AgodLexyH5Sy1GRKVM6TndIVCLCvKZHuj8t/qsD2Tj/iWEba003DkJMZ34TsCsk
	 TubzV973XcJJnnMznidErgl0L9RZE5PW7OPVmH10B7MIvrOnag97CBBK31lvx2pfq9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqpZFEQM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835F606A329;
	Tue, 17 Nov 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqpZFEQM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40901F000C4;
	Tue, 17 Nov 2026 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910313;
	bh=v0S4+MTT91ej2d/hxyY2qFRb1L9CnA6yF9yap31hKRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oqpZFEQM5ofSomkWqaxe0Onzz2y6PfdlUH3yQC7GBHXqpVKtb9MLH6jsD1/a9RvO0
	 Z++PWCG78r4lnETrSBGIuV/y1YgLKspMUzRzYYKa3eNg16VIoVJRnsQ6uGbpVdKLbi
	 PtBk7VeOn9LIaBlrbAqq0WbA7XITMkxVVroFXySEQGlh4KXcuyYr7DxqCgI7UkdOyT
	 wFw9fre03/o524fdNQF+0+EuQlP/GrIapST9Qy1uDleBme0qh1y8Ne5pYyotgc72D9
	 ANwgSmw7Q/llv0KBqRvyHZNyRznurk4/ibfnUVb9xtrhyPTLloc9RzulT/Hu4CwJE2
	 w58zgocjhEZVQ==
Date: Tue, 17 Nov 2026 11:11:41 +0100
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
	stable@kernel.org
Subject: Re: [PATCH v2 02/15] mm/hugetlb: compare against persistent count
 when freeing lowmem folios
Message-ID: <avwoXd4_gYi-qw1L@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-2-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-2-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:23PM +0100, David Hildenbrand (Arm) wrote:
> try_to_free_low() gets a target number of persistent folios, but
> compares it with "nr_huge_pages", which includes surplus folios. As a
> result, it can free lowmem folios below that target.
> 
> For example, with two persistent folios and one surplus folio, a target
> of two can still end up freeing one persistent folio.
> 
> Compare against persistent_huge_pages() instead. Convert the macro to a
> helper function and place it before try_to_free_low().
> 
> Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for MAP_PRIVATE mappings")
> Cc: stable@kernel.org
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
