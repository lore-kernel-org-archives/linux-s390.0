Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7831F991
	for <linux-s390@vger.kernel.org>; Wed,  4 Mar 2026 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772625378; cv=none; b=WaDyzu3BwSKgTu4kcXqr04zLMCgnTULH52dE7M/Rsa4n/ZNG1XyS/lpOMPpAjX7ryTkJXpzzeIazu6w9Nzb8brJaidl5vJ55DKEfMitRIUaouEzL/+mI8yiTvPbDdU7aXwOaIfRSsrzdgqL+8cjh90oNRMuttvBXtTWOQuR9hDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772625378; c=relaxed/simple;
	bh=iciqkRU2vgWQGfMCJeAvcun3HMNJogGNCGEpDD0/UCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELBf2m7BeL34aQ3ZG+RgizSQYC3wXZXhJlSLi6m6hMWHo1t7ci3Sv8wY89WixIPUHTwbZIJp0yEPzGJpqkuknX5M7x+6/VhM/YBp4eOT/+zNVSSdtyvb21v2OqjJ88GobJUVPrNWvyvle2rlEAgZqf9RDt9M2XSaIdQxEZcc2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKcOQ1qd; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKcOQ1qd"
Message-ID: <498e94a6-08e7-42dc-81e9-113265bf3cff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772625364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GSFW9HWutiyPhp3WzVGPO7yi4M3/V6mlTS86vxN+yo=;
	b=cKcOQ1qdVvdnQejcmemBI4Pq3qOY5VnVc9kwe4KNTg0wcqUPZFubgLA+UZ+vtrX4xkvo9N
	0LseiTbrMFJEX6nLoxhpStCE8IXpZXBTvgwWs/UtvTWYbzeBgnEsX6Hj6op/UWLNSEvgpZ
	/TOscOWi9uf7M4MNwUTzadtAmjmzgqo=
Date: Wed, 4 Mar 2026 14:55:55 +0300
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

Good catch! I think this bug existed even before this patch, if
folio_split_unmapped fails, the reference is still there. Let me
send an independent fix for this.

> -- Nico
> 
>> -       split_huge_pmd_address(migrate->vma, addr, true);
>> +       /*
>> +        * If PMD split fails, folio_split_unmapped would operate on an
>> +        * unsplit folio with inconsistent page table state.
>> +        */
>> +       ret = split_huge_pmd_address(migrate->vma, addr, true);
>> +       if (ret)
>> +               return ret;
>>         ret = folio_split_unmapped(folio, 0);
>>         if (ret)
>>                 return ret;
