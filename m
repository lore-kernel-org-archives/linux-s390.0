Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245305;
	b=u/VHKGubLk3M/ctnuAvDbUIZ78GMwA+zJI3FY2LZIe+JFZNa4FnJcnsmI1ZWNGbEQxMh
	 DVzzIImVb1rSfrS2q4EvIJt1JIzVuxi6kzURwCAJHYWJMR4R8e1ztbmSu5layLhAqf29t
	 sfyVpMVSpPARNZ3jDmBhSvHuB22lyvy92fRJztQCmEslfOHCicOlg4UMGcPaVXvfioUeE
	 B9H7lg7F+w2tmVyUpxmBRvuzidH/83Ruco8irfyhZ7w+W7yPoR5tPCfrZAO+6UBhietnO
	 2VCcRzeQYlwv1l4lE/kSA85rZPrGD63NBx1PFlrD4Toy8aT69eUUAkWHJvyPXGiehbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245305;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=SfpksgeRXYSviYFeyWHR5mqkoXxAslF2D1vkefSL3uw=;
	b=uvGjuWbgmcGvME7aNuF83/D5LNh2PVcp+qXfdg3AJh2M/FAOV9zod3AAPGFeteEUfBzF
	 /3S0KPy18L7gc8s8TtNKsHBqRRt+0nrga6G79yybEYobP7MhB8oc/nufpOhljMXbCH/ZD
	 XYSpdVfycEcM8NrN4qCWNoZIhQQ+secfa+xP8+4rg7+3UNFKlEONqJWOAZXXQ79PO+diT
	 QF2ZcxTrYumGCjkvrEn+9RIRFLj6pS6LIU/kOJhHVpqfhxfphQD2wOtw2Pd/Eb2zfko4W
	 MIZGiz0gth2XNLHJn9fTUnqIfKe1CTYABvNHVtBzmxls3K5J/nu8EW7sRDJPOuA/ypw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NxV2zbRI;
	arc=none smtp.remote-ip=91.218.175.88
Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C3606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 03:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 611C3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NxV2zbRI
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SfpksgeRXYSviYFeyWHR5mqkoXxAslF2D1vkefSL3uw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793245302; v=1; x=1793850102;
 b=NxV2zbRImUBwLKbaCg/zWhoTSvWR2eSfQzp5or3rZukb97Uuetb23hfqkeJZqlF/85Uv7SQV
 14s70j8cLPyw9jp/T7OE1W8F9ax2XsvgOtzbsLJ+K8zxGU3m0hjhT/SGpjNMU8Qv+D01RB5EhgF
 NXXHqIlq3oU27FdrMaowEbaY=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id dc9967750c407019;
	Thu, 29 Oct 2026 03:41:42 +0000
X-Mizu-Trace-ID: dc9967750c407019
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
Subject: Re: [PATCH 03/15] mm/hugetlb: preserve reservations when shrinking on
 HIGHMEM
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-3-a0a033db180f@kernel.org>
Date: Thu, 29 Oct 2026 11:41:12 +0800
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
 linux-s390@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4D91A63-87BD-4BFA-A12B-22A8513A496F@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-3-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> try_to_free_low() drops the hugetlb_lock while freeing lowmem folios.
> set_max_huge_pages() then resumes freeing folios using the
> min_count computed before that unlock. Reservations created in between
> can consequently lose their backing.
>=20
> Collect lowmem folios on the caller's existing page_list instead. Keep
> the hugetlb_lock held through both selection passes, and free the =
combined
> list at the caller's existing unlock point.
>=20
> Likely not stable-worthy.
>=20
> Fixes: 1121828a0c21 ("hugetlb: call update_and_free_page without =
hugetlb_lock")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

