Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245192;
	b=Ks+eS7Uiy1AsTYinHtsAeEUjTO5OpB3WIwCmDIb/x05pzBPFAourc/Tj0xheUlKQCnNu
	 h9yss0B61EtjwtlMrxE6yBr67xJD+b6rc2ZoP24wlLP4al0bgTkJj+IKV5A8lE9qACVKp
	 vYgz+/UoNQ1oNtGtH3jFMHc6kSDqODtulV1npWga38Adqwu11K/NHdc2Q7SX06czo3ibp
	 ZN3jYQYbSbr9a6FwPzDfAJ+upKd/IX/f9Xv8Em+jZGm6E0qA2Es+IR4EckaHFw+Gl7YTB
	 IleZEBufpyaEYrriOoaLlutJpEOFOxlLDP5gk8MG/8772zAQZ6gKwcEZTzYCoAq7Q8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245192;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=nHYJzejo29azPzDNOxZ+tmpvvDu3XTTv89JLTyFVqd4=;
	b=nmp88+/p2LdB0I0ZBTR2kdaAtiISo2yxmZpFYnKL5FRTKQNzkCX8HJExQSHp9wH6gJ/F
	 4W9Vgt+KYARFIxuh2vmO1dAS++5XuD2GGMLbiMN3TNyBUS7DTkHfsbDmGZs12Gmrphse+
	 fNyn/AE2UHeuAeavB2u+BSupbs1GVidmjT0C4o+NFTHQmC127m0FXwWmkTqdahT3oyDL4
	 c8vYg6v18wbtD1AauIDwM9bBXRMi10QsTHFDRsnNVHGVhSdfBUYesgzRNCIq4qD9mYTAA
	 Ev8caXYYVzTqA+gEGGMbM48fICS4/6HDZcWVkBTTA0fLUYVQdDTTpN1Ai2fbsDRjNcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JwHCiaU6;
	arc=none smtp.remote-ip=91.218.175.54
Received: from mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3303606A31C
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 03:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3303606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JwHCiaU6
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=R50k7qXAG33bbhagggBhqvchCPQ52saBCXt3awMCb6U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793245189; v=1; x=1793849989;
 b=JwHCiaU6wNlgkZwersY6AMgWtViVtjskMcecd/6+Od2qPv/mWGKr7rlSGPwoiVQjWtSEquTl
 jz8ubRhsB/Dyc/RqHacrPomgc4WK1uts7m7DL8ZDejrhXjpDsM5Zh945kHdyhP94x2zIdgWwum6
 47kzoRxtALGbiybFTOALoFVw=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5ac0218b5b613cc1;
	Thu, 29 Oct 2026 03:39:48 +0000
X-Mizu-Trace-ID: 5ac0218b5b613cc1
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 02/15] mm/hugetlb: compare against persistent count when
 freeing lowmem folios
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
Date: Thu, 29 Oct 2026 11:39:27 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@suse.de>,
 Andy Whitcroft <apw@canonical.com>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Peter Xu <peterx@redhat.com>,
 Breno Leitao <leitao@debian.org>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org,
 stable@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <68EFA1E5-4898-4278-8718-06B1A010DFFD@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> try_to_free_low() gets a target number of persistent folios, but
> compares it with "nr_huge_pages", which includes surplus folios. As a
> result, it can free lowmem folios below that target.
>=20
> For example, with two persistent folios and one surplus folio, a =
target
> of two can still end up freeing one persistent folio.
>=20
> Compare against persistent_huge_pages() instead. Convert the macro to =
a
> helper function and place it before try_to_free_low().
>=20
> Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for =
MAP_PRIVATE mappings")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

One nit bellow.

> ---
> mm/hugetlb.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index da5d04edf7c1..3a94ea1c9457 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1335,6 +1335,11 @@ static unsigned long =
available_huge_pages(struct hstate *h)
> 	return h->free_huge_pages - h->resv_huge_pages;
> }
>=20
> +static unsigned long persistent_huge_pages(struct hstate *h)

Better to make *h const?

Thanks.

> +{
> +	return h->nr_huge_pages - h->surplus_huge_pages;
> +}
> +
> static struct folio *dequeue_hugetlb_folio(struct hstate *h, gfp_t =
gfp_mask,
> 					   struct mempolicy_interpreted =
*mpoli)
> {
> @@ -3719,7 +3724,7 @@ static void try_to_free_low(struct hstate *h, =
unsigned long count,
> 		struct folio *folio, *next;
> 		struct list_head *freel =3D &h->hugepage_freelists[i];
> 		list_for_each_entry_safe(folio, next, freel, lru) {
> -			if (count >=3D h->nr_huge_pages)
> +			if (count >=3D persistent_huge_pages(h))
> 				goto out;
> 			if (folio_test_highmem(folio))
> 				continue;
> @@ -3773,7 +3778,6 @@ static int adjust_pool_surplus(struct hstate *h, =
nodemask_t *nodes_allowed,
> 	return 1;
> }
>=20
> -#define persistent_huge_pages(h) (h->nr_huge_pages - =
h->surplus_huge_pages)
> static int set_max_huge_pages(struct hstate *h, unsigned long count, =
int nid,
> 			      nodemask_t *nodes_allowed)
> {
>=20
> --=20
> 2.43.0
>=20

