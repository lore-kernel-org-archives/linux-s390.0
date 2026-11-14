Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617053;
	b=HDWooxd4lR9xyGIP7TCds0xO6V9nRBm/mRj46quaOsf3gOwuRiaMZCvhBNrxNkgAYhbv
	 DypUOW7jXc5YJBF1VDCto2D5sGTvx+QZn+h6MIlnYxBf/YHmfv6Qah5+d1kys9S7BSbsv
	 IhaOLezcPZ0ofIBlWY4k5vSfpapmngqWbGcbny/2Ue+2tDhVEpmOWjSG7bNVlbGL8GMTK
	 JJfsyW8Pgx+PheM3M1YHatG15btmcNhUDYbanShnafHaqmB5XxLEGsizP3Chplmb5cMLs
	 P92MFXuRXyYX29vUHfqczLtJ0Hn+KSpUk5HW3vXq0wH0vxj4VX3HLFDHVVdKYw/cBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617053;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=0xtAECFW3pXMdSq0lQxsNOUtdAywWPfdRsyXX2fdCbI=;
	b=j2+rciklqhKl95GHirOl8+culM2pOkGqWHmnlVDeaqWQz8RAJhlWVPwLHTCpnpBeMK2h
	 YfT/776olsPt61m3xtLF2aGQSQgREUxlah6q0GZmR0UexAJHWQg6xqjl0M//puaoVzFBc
	 SA/jseBXXfXR08PeRunmeWKwCikc7RaG9YRrSYvlYyZpbMxOPTC7oyHqZs1PyhitTT6Jc
	 +CpCstVXmcKNuSH8N61Vu/IjDF8f0PCiPFMGu7MQjCH8g78sRxRUcYqnGu9xpSlVIeJS1
	 3A01J81LVCVBJD/p2PeEmdLTRd+yTutD3hbnSvTaD4gspudvOSqvk6ia5WunwS74AzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WjUSNxfM;
	arc=none smtp.remote-ip=95.215.58.13
Received: from mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9B606A335
	for <linux-s390@vger.kernel.org>; Sat, 14 Nov 2026 00:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80B9B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WjUSNxfM
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0xtAECFW3pXMdSq0lQxsNOUtdAywWPfdRsyXX2fdCbI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794617049; v=1; x=1795221849;
 b=WjUSNxfMy0hDfRyJzKb819Vr/dago8ZhjlqIKxCsU5Eh/iEOn0k+mzOYY5mGr8iMuoO0hh+Z
 K6oMia537VmqhKgK7nb3poZfl/2UCcThfNEtH191QPCFb2+U6W2hubc0GOWNCIPNBpfdwHU3AG3
 l3v7d6oflc98U/ClmRZcbGjo=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5500ac1b1da158ed;
	Sat, 14 Nov 2026 00:44:07 +0000
X-Mizu-Trace-ID: 5500ac1b1da158ed
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 00/15] mm/hugetlb: various fixes
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <835c18d0-bee3-41e8-aa46-05dc7c1ebc64@kernel.org>
Date: Sat, 14 Nov 2026 08:43:44 +0800
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
 luojiajun <luojiajun3@huawei.com>,
 Josef Bacik <josef@toxicpanda.com>,
 stable@kernel.org,
 Chris Mason <mason@kernel.org>,
 Daehyeon Ko <4ncienth@gmail.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EDE76EC-0CD2-4C34-BD06-234E21C7BDEF@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <835c18d0-bee3-41e8-aa46-05dc7c1ebc64@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 14, 2026, at 04:22, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 10/28/26 21:13, David Hildenbrand (Arm) wrote:
>> These fixes almost finished me.
>=20
> Muchun, Oscar, should I respin with an un-rfc of patch #14?

Sure, please.

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David

