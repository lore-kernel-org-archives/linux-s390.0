Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353205;
	b=s9la0+HwGS/Rb7Kaxb4vAW9oQl8P79DGvoskmmjlWW9L+8kbiQOmh0f5n9chjWQmM6Zf
	 wmr7OV6CAau0qlcNajelyb0iXi9LVCpZaYLcnx4nBpFMOdhGqKlvaCUiNCSjnCOJFNg+t
	 3hzabOBN+nvjgFBx5i45z3IKBk4EPC9jt4AW25C8zFuQRTNPsR0HU6+ishuSodND/EqH8
	 LlrVMIZqew+bsU1K3ekI4uJyIX9AIxOSJHMK/0mIZ5m0T/cDoI4Y0rPT28PClK5q42fX1
	 fCwoitr5rHI6/9IBFN7GkRhxXxVunG6inIxGitehoWUOqDfhjN+K8T76Q5mDgFyO+Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353205;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=GjoByvQgZF8hrJ3bMrfVpCnfunVN4IpvJDxs7mkxVe4=;
	b=WTZDd23jm4S3A+of8azaP8j2+La7di3iQIfWQbkEPnzuPoibcRIE8ci9en/xxioCCNT+
	 sG1qTCbsJUoh7NSc8bnjiy9HPMt2VWA4YJFPoJqNrOXNbwWixfwnxGnqafmyg+YWnrSwW
	 ZUHMgeqHJvj0+GbdyBpkZi2x7sLnkf1lYL9zkdQHK6eYjlRR3A2Pmern3YntKrJ6n+kdb
	 JRtTpmQVvEWdOx0pO8RnqQD2xzttkkCL16JxzdccZH8F5Zv2tFCWbNIWdxataVFP4iCQ6
	 wPM8x355jJPvjJmBiGNE8+Lj5XYm+m88Z3pZi4mUSyd7S4ZqMhkQ0wMYcOiWPDvraxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qZexjLA3;
	arc=none smtp.remote-ip=95.215.58.118
Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A98606A31A
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 09:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qZexjLA3
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GjoByvQgZF8hrJ3bMrfVpCnfunVN4IpvJDxs7mkxVe4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793353201; v=1; x=1793958001;
 b=qZexjLA3z72ct6BDu7Dc0m9BncpgG3hK4j1b3DwD3NTBjBZ20OkGtqQCD+B6oCyJi38c8XHe
 9b2RX+szEZRshADVCh8gg+NONUQycTdJN52pAqQDMvLEgbE702NFZ3cLusXxVA4wy+dTS9SAuUR
 yzwDlzgYu4KRlYFifvWrzh7g=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 391089da5ea8dc07;
	Fri, 30 Oct 2026 09:40:00 +0000
X-Mizu-Trace-ID: 391089da5ea8dc07
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
Subject: Re: [PATCH 07/15] hugetlbfs: fix unmapping folios from private VMAs
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-7-a0a033db180f@kernel.org>
Date: Fri, 30 Oct 2026 17:39:38 +0800
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
 Josef Bacik <josef@toxicpanda.com>,
 stable@kernel.org,
 Daehyeon Ko <4ncienth@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE1BEB7B-295B-4F93-9876-C397C2FF473B@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-7-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Josef Bacik <josef@toxicpanda.com>
>=20
> hugetlb_unmap_file_folio() assumes vm_private_data points to a struct
> hugetlb_vma_lock when hugetlb_vma_trylock_write() fails. Since hugetlb =
VMA
> locking was extended to private VMAs, this can also happen when
> vm_private_data contains a resv_map pointer; treating it as a
> hugetlb_vma_lock corrupts memory and can cause crashes or hangs.
>=20
> Only take the VMA lock when a shareable lock exists, as additional =
locking
> is only needed for PMD table sharing. The fault mutex and i_mmap_rwsem
> already provide the required protection for private VMAs.
>=20
> Fix generated by an LLM and sent by Josef Bacik in private.
>=20
> Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private =
VMAs")
> Cc: stable@kernel.org
> Tested-by: Daehyeon Ko <4ncienth@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: simplify description and comment ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

