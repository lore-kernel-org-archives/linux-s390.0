Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F93DA5A5
	for <linux-s390@vger.kernel.org>; Thu,  5 Mar 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729749; cv=none; b=POqghw+ArzBCKhrmya/lbTjx809yrycee6OSYIHQulyYlzOxY4UNUikPI99dgVdrr5pm4VHEIcmsK6kZaNXW+qjS04x+QJY5vsVpYv7MreAkaKsVrwmcP3rU44AUEDyIzwpS3TPTduqssry8dKdJ7+Apabb/BAzg14pN2DuW0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729749; c=relaxed/simple;
	bh=4N7rm8WS0rvw+XK1sgXCepFcTsjdSaPrZklb2cWmzaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9GjNJEKkA9btf9i2FIZm3P6G1PAjWh+wi6SGVkOinkcKpT4RHfB8zDA1wPaRotNuDjak1XQv2G7f+immgIeNq190622GBBOsQZtCCKDjTMMVKDfpppnPEHBWn6YHxuYp70ByDDvFrhzcEzJwYDrpqg2ZyUct9DT6Krnq73MQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sqNO9UcP; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sqNO9UcP"
Message-ID: <6982e9fc-cc17-4d4f-b26e-83997c4bf070@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772729735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hT4+PlNJ1Mkp07e5E9uoTzP3KOj0N54uHsOXux45Z6Q=;
	b=sqNO9UcP0hmtciXBUAu7Ynkl1qEUHh7iFRCJkxQmZwrS5u0cKwu7aFd9qHPcfEcKmuh9E1
	G3X1kE9KcKVzFx69GZouJPdBt6myNS3LdOTaKYGVTad3j9s1CgcwNUA1rBW+5hqn2Y+h4D
	SmDMIzXQmBmMW3/PLs2vrrEchW1oYoA=
Date: Thu, 5 Mar 2026 19:55:22 +0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 12/21] mm: thp: handle split failure in device migration
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <20260226113233.3987674-13-usama.arif@linux.dev>
 <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 02/03/2026 21:20, Nico Pache wrote:
> On Thu, Feb 26, 2026 at 4:34 AM Usama Arif <usama.arif@linux.dev> wrote:
>>
>> Device memory migration has two call sites that split huge PMDs:
>>
>> migrate_vma_split_unmapped_folio():
>>   Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
>>   destination that doesn't support compound pages.  It splits the PMD
>>   then splits the folio via folio_split_unmapped().
>>
>>   If the PMD split fails, folio_split_unmapped() would operate on an
>>   unsplit folio with inconsistent page table state.  Propagate -ENOMEM
>>   to skip this page's migration. This is safe as folio_split_unmapped
>>   failure would be propagated in a similar way.
>>
>> migrate_vma_insert_page():
>>   Called from migrate_vma_pages() when inserting a page into a VMA
>>   during migration back from device memory.  If a huge zero PMD exists
>>   at the target address, it must be split before PTE insertion.
>>
>>   If the split fails, the subsequent pte_alloc() and set_pte_at() would
>>   operate on a PMD slot still occupied by the huge zero entry.  Use
>>   goto abort, consistent with other allocation failures in this function.
>>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> ---
>>  mm/migrate_device.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 78c7acf024615..bc53e06fd9735 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -909,7 +909,13 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>>         int ret = 0;
>>
>>         folio_get(folio);
> 
> Should we be concerned about this folio_get? Are we incrementing a
> reference that was already held if we back out of the split?
> 
> -- Nico



Hi Nico,

Thanks for pointing this out. It spun out to an entire investigation for me [1].

Similar to [1], I inserted trace prints [2] and created a new __split_huge_pmd2
that always returns -ENOMEM. Without folio_put on error [3], we get a refcount of 2.

       hmm-tests-129     [000] .l...     1.485514: __migrate_device_finalize: FINALIZE[0]: src=ffb48827440e8000 dst=ffb48827440e8000 src==dst=1 refcount_src=2 mapcount_src=0 order_src=9 migrate=0 BEFORE remove_migration_ptes
       hmm-tests-129     [000] .l...     1.485517: __migrate_device_finalize: FINALIZE[0]: src=ffb48827440e8000 refcount=3 mapcount=1 AFTER remove_migration_ptes
       hmm-tests-129     [000] .l...     1.485518: __migrate_device_finalize: FINALIZE[0]: src=ffb48827440e8000 refcount=2 AFTER folio_put(src)


With folio_put on error [4], we get a refcount of 1.

       hmm-tests-129     [001] .....     1.492216: __migrate_device_finalize: FINALIZE[0]: src=fff7b8be840f0000 dst=fff7b8be840f0000 src==dst=1 refcount_src=1 mapcount_src=0 order_src=9 migrate=0 BEFORE remove_migration_ptes
       hmm-tests-129     [001] .....     1.492219: __migrate_device_finalize: FINALIZE[0]: src=fff7b8be840f0000 refcount=2 mapcount=1 AFTER remove_migration_ptes
       hmm-tests-129     [001] .....     1.492220: __migrate_device_finalize: FINALIZE[0]: src=fff7b8be840f0000 refcount=1 AFTER folio_put(src)


So we need folio_put for split_huge_pmd_address failure, but NOT for
folio_split_unmapped.


[1] https://lore.kernel.org/all/332c9e16-46c3-4e1c-898e-2cb0a87ba1fc@linux.dev/
[2] https://gist.github.com/uarif1/6abe4bedb85814e9be8d48a4fe742b41
[3] https://gist.github.com/uarif1/f718af2113bc1a33484674b61b9dafcc
[4] https://gist.github.com/uarif1/03c42f2549eaf2bc555e8b03e07a63c8
