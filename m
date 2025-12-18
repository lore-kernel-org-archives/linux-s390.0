Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E12BE7C6;
	Thu, 18 Dec 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052131; cv=none; b=PZgJ7VwrrJbgbebgQW24FpyyUCgprS/iCltll9Zc2osd9fF58mszOWq9e+IjPQu1gDaruvBpgQXgsKO0txZ20zVK/HNUVLmme5YAcBauUvKeCrfQWDrWtQZNLAV5VHBKVUl684Rta0hp3szzT6rGdUN957Qsow5ygvLa6VumsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052131; c=relaxed/simple;
	bh=Nw8/xPqRtJ3jr9PSKxoQ1BcdKB0FWuTnbRQXps9AJuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FPkf+ofgJ5onTMVaOPWAmA/afjIv4VYF66/iMcJStxSAFpG4tMKhuWabN+1+e1xsH1psOK9ZMazstNwF6lRQ53fGLct1OgBoZaxUchVtUpwaTEKkf/KE27h2aY0pPRTgjSYAM/ANWpwD4q0a573671E/+lkrf8cV32ilPA1cWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUxR5p9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUxR5p9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ADCC4CEFB;
	Thu, 18 Dec 2025 10:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766052130;
	bh=Nw8/xPqRtJ3jr9PSKxoQ1BcdKB0FWuTnbRQXps9AJuA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qUxR5p9nLaGIa2IPol7GwO939YNt4cI6BRodAmVjF0+8L62Ffd2H5W0CeL07eFj3X
	 5farBmoQooRnqvZDzrtSUiOU43l64FLfBe4wILCSDYkNOXbYuEgUsUT8X6CXQYq2cQ
	 Maxo/huPBXAcATB8n7EoL9p7yl22QHDPL1PZ4p/EnQPnyzHfHNGXaFyCdixFqMSukR
	 dBoQm42UODTkVcUfdc8SdQw/3dmKFNwPiEa9rLlZ/tgVTTPCYWK3JR+UMJpxPMp2mz
	 y0Ox1jt27Qr7NiXyK6nzHn5U7juAH31r1UuHLge7X4DKioWpwQCiZx0bJFhjs7FUNw
	 XxqgeEWeLeGTg==
Message-ID: <ee42b057-b2d1-4a61-a6b0-39f81f78a918@kernel.org>
Date: Thu, 18 Dec 2025 11:01:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mm/pgtable: use ptdesc for pmd_huge_pte
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Thomas Huth <thuth@redhat.com>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Magnus Lindholm <linmag7@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20251214065546.156209-1-alexs@kernel.org>
 <52e2c1eb-67cf-41ee-9088-760fb6258153@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <52e2c1eb-67cf-41ee-9088-760fb6258153@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/25 01:53, Alex Shi wrote:
> 
> 
> On 2025/12/14 14:55, alexs@kernel.org wrote:
>> From: Alex Shi<alexs@kernel.org>
>>
>> 'pmd_huge_pte' are pgtable variables, but used 'pgtable->lru'
>> instead of pgtable->pt_list in pgtable_trans_huge_deposit/withdraw
>> functions, That's a bit weird.
>>
>> So let's convert the pgtable_t to precise 'struct ptdesc *' for
>> ptdesc->pmd_huge_pte, and mm->pmd_huge_pte, then convert function
>> pgtable_trans_huge_deposit() to use correct ptdesc.
>>
>> This convertion works for most of arch, but failed on s390/sparc/powerpc
>> since they use 'pte_t *' as pgtable_t. Is there any suggestion for these
>> archs? If we could have a solution, we may remove the pgtable_t for other
>> archs.
> 
> If s390/sparc/powerpc can't align pgtable_t with others, we have to keep
> the pgtable_t to bridge different types. But we could take step to
> change pgtable_t as 'struct ptdesc *' in other archs. That could
> simplify and clarify related code too, isn't it?

Not sure. s390 and friends squeeze multiple actual page tables into a 
single page and that single page has a single ptdesc.

I was rather hoping that we can make the code more consistent by making 
everybody just point at the start of the page table? (that is, make it 
consistent for all, not use ptdesc for some and pte_t * for others)

-- 
Cheers

David
