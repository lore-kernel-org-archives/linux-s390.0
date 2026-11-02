Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624057;
	b=VYpJWcRXUB7zGOvqG792pOfYWkDwncTSyR9RDxfXxX9m5OsJavbwPVqUhmJZOCYkihrc
	 p5vvQR10zaBBLZMEal6PKTJiQ9meRUsXKWMxH649tieqzqlbtg2M9/WYuNoGOL2kr93fF
	 xu5Bzk/TtWTrQuemm2/eJ7/bQ0A/ZFE3zuTmy4TXqwvEo2ak/G4fIFxVv1EhrIkeM34TD
	 FpONckx2/NFcJXkwVvFXQ3zc62Q3/aH95qMJ3s5MfgkWdEXA/uSwQshI1lBAxSTdoRNrz
	 cDWpi66o9kZCGsa3NBlfuWeQD9ryzIhWuz2epqAVD6tFfYxGW16HL15T+mTxch82iZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624057;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MYKdbODKc1prEg/TSIAKCpPLWFj9bHZOX1ZDiVmUN/E=;
	b=cU+5HdMn4vk+M8njCEk1fzCiN2XDvebwJ57E9cRWDwYrTVHI4/ufb00+Ynln8VdUyneQ
	 7XUpXGuALUQ4USpBbO7NDWUV+w5NEpN1lMy1br6K0qOulvLqver709uBEl1X2zj4stZgQ
	 9T6nWkCMDj5mBNxHSzScje2a2zlGBz1CgITFqee82p2gcOQIRynLMkw0T9JIi8N/5otv9
	 Op7qvgAZGxNqLLz66MaN80fN/lda4nrzF7+I52gYWoA569OVPfEKMZg+gquZuEuznHv0y
	 GvUEUfa1XtsX2CXo+HiPYz25Bw0QOIrpYW6HwwwzAdX+Gs+wWTrKyrpkZHI5RdlMVIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csvcTsOU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB61A606A326;
	Mon,  2 Nov 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=csvcTsOU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B651F00A16;
	Mon,  2 Nov 2026 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624056;
	bh=MYKdbODKc1prEg/TSIAKCpPLWFj9bHZOX1ZDiVmUN/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=csvcTsOUYC23IF5THZRKLkyoa8+bR3vOPOvcfHV1GbL03Pc0uq4mCw9+53mIF4ErN
	 MtvQVl9QC1exMlpUh/LNqLsdxSLvFxPPkCNJuwA6bMm++7lghNlev2lLb67EfsqjSk
	 4WLj/TyIG906qxCp+7j1OM8uKsUVLiPYjJRwQMQbm5RlSiV9xdyUgX5kOTFs3SZ2VZ
	 8dUQakbFT6sWB0GBISiaRU2M6b9amfOtTvYlM9z1T28yTAz7Grux/KR7DRiMIoqhza
	 87k9tQ+6GTFFRzU4v2SQ4mtWHCViIeMReaJNBIG/DbWU10n/S+lfFR6SfaIY8HW469
	 ll4JZH22VNegg==
Message-ID: <47abd304-e269-42dd-9d9a-3b7300ce23e3@kernel.org>
Date: Mon, 2 Nov 2026 13:54:06 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] mm/hugetlb: compare against persistent count when
 freeing lowmem folios
To: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Dave Airlie <airlied@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, stable@kernel.org
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
 <68EFA1E5-4898-4278-8718-06B1A010DFFD@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <68EFA1E5-4898-4278-8718-06B1A010DFFD@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 04:39, Muchun Song wrote:
> 
> 
>> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> wrote:
>>
>> try_to_free_low() gets a target number of persistent folios, but
>> compares it with "nr_huge_pages", which includes surplus folios. As a
>> result, it can free lowmem folios below that target.
>>
>> For example, with two persistent folios and one surplus folio, a target
>> of two can still end up freeing one persistent folio.
>>
>> Compare against persistent_huge_pages() instead. Convert the macro to a
>> helper function and place it before try_to_free_low().
>>
>> Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for MAP_PRIVATE mappings")
>> Cc: stable@kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Acked-by: Muchun Song <muchun.song@linux.dev>
> 
> One nit bellow.
> 
>> ---
>> mm/hugetlb.c | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index da5d04edf7c1..3a94ea1c9457 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1335,6 +1335,11 @@ static unsigned long available_huge_pages(struct hstate *h)
>> 	return h->free_huge_pages - h->resv_huge_pages;
>> }
>>
>> +static unsigned long persistent_huge_pages(struct hstate *h)
> 
> Better to make *h const?

Agreed, thanks!

-- 
Cheers,

David
