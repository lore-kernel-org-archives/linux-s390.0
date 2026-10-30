Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351285;
	b=AQB38cA68Z07G5hcnDHZX5E/d74iAW0GtQmEbDAt4xIABUbv7ScbKGjGwxxmC7G4OVIs
	 3CIjXWSURlYlo02awLR4aPQlJM4NU5TIdOfSuWC65rnkB0SoiU35zwGjjNcyJ1ZJY+/ui
	 nerY3KzqNmKW+/yDvPQ1Ey/ybkC6lScjiaB8Sg1y37feJN62vwDBtLFZyU/tTWE56sSmT
	 I6Fj5njcE+eaDfz1Xwn5PJoIdeuRwtdphv48YCkWx0FEhF4YkY69Z8hUAFjqz0NuhsQkD
	 zydOVWRWSouy0H9h8h/X9r/hYuOCnbbgDuWEwHoxmPLEzbZwXbcW646+wShqQwgqnNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351285;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=HzETpkZCDXkShONkGAZlIV0dEoNYXp2bUggxSrX6SDs=;
	b=f2MkHKuTuzR16KMif86eEiOVDyWHcekf5Do0aZnzt3CUSU0DDZMZFd0vEGnjdzfYpU9V
	 IZwaqBFA+7cmYOJQnQ88vu5ZG+IOhJQw9rV3VPhEy+LJTSdnlfTAcqAf1WIC6XomWbPd4
	 yt7SxmjdFjiuevzZ+mCtMj65qnmAuPcaL2ZO/fZHFmI/EgcWDiolPCXI4tNIYNpIKKcAe
	 Yj3PmSf7vibFU1XYQsgWLf2Vnhkmuc58SKTuxb8EyWYmDbhqmKvEUVsSMB9Q8EBpQvTAs
	 yPGA+k9BqNAtclpVWxlC1p9rbm9oZ6MDD7M1VMm9lhFZOKWr2sfGK2KlOEuz/KUuPGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BPoXN38o;
	arc=none smtp.remote-ip=91.218.175.101
Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13851606A31E
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 09:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13851606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BPoXN38o
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8R0FqJTbDe7nC/J3cP65RdEuTA26QhIX/KSEeF9uB9k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793351282; v=1; x=1793956082;
 b=BPoXN38obfYHfZy9SZp+rS0+IWXOSOa1zhP7QLcL77ktdrxAL4d2atfbjcLNQ2sB+By5fMvw
 Zlet4ZoKfrs3FT0BQKqZwIzk8DiwAYYqFH+PcGr1NtPmH/8/ABPUdlZ3C3w+CEm7DfCQZAxx/Af
 cpbh71pLOtzXW9BCaMr0ni7M=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b2e1111847a6cf4a;
	Fri, 30 Oct 2026 09:08:01 +0000
X-Mizu-Trace-ID: b2e1111847a6cf4a
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
Subject: Re: [PATCH 04/15] mm/hugetlb: account temporary folios separately
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-4-a0a033db180f@kernel.org>
Date: Fri, 30 Oct 2026 17:07:39 +0800
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
 stable@kernel.org,
 Josef Bacik <josef@toxicpanda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCB80A53-031D-4479-8D2B-0291ACF92F70@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-4-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> Hugetlb migration might have to allocate a temporary folio through
> alloc_migrate_hugetlb_folio(). Such folios are currently accounted in
> "nr_huge_pages" but not in "surplus_huge_pages". =
persistent_huge_pages()
> can mistake them as persistent huge pages, as it merely calculates the
> difference.
>=20
> If set_max_huge_pages() shrinks the pool at the wrong time, it will =
turn
> hugetlb folios into surplus folios until persistent_huge_pages() =
returns
> the desired number.
>=20
> After the migration (successful or unsuccessful) either the new =
(temporary)
> folio or the old folio gets freed: this will reduce "nr_huge_pages" =
but
> not "surplus_huge_pages", to undo what was done when allocating a
> temporary folio.
>=20
> This can result in having more surplus folios than actually allocated
> folios:
>=20
>  HugePages_Total:       0
>  HugePages_Surp:        1
>=20
> =46rom then on persistent_huge_pages() returns garbage.
>=20
> To fix it, add internal temporary counters and subtract them when
> calculating persistent pool sizes. Update persistent_huge_pages() and =
add
> persistent_huge_pages_node() to make the code easier to read.
>=20
> Count migration targets and rejected surplus allocations as temporary.
> Transfer the per-node temporary count along with the temporary flag on
> migration, such that folio freeing will always do the right thing.
>=20
> Take care of calling account_new_hugetlb_folio() only after setting =
the
> folios to be temporary.
>=20
> For now, keep temporary folios in nr_huge_pages, so HugePages_Total =
and
> Hugetlb continue to include them and overcommit accounting remains
> unchanged. The new temporary counters are internal for now and are not
> exported to userspace.
>=20
> Fixes: ab5ac90aecf5 ("mm, hugetlb: do not rely on overcommit limit =
during migration")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

