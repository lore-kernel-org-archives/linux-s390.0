Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27F21B8F8;
	Fri, 24 Jan 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737722354; cv=none; b=bRwuqmVlsadwEqXCMRrIUTbgXZJjpKk6YDzfbGwGG+HvggkjB4XFskOVHzvj639yGCXiB/1u8FFSw9+Hl1Ndhxd0G0AjhYfm1RyGfZSASNdvugIiN532AVn0kvoHgkPR0N4SabPi/i+SpbpATKGupDim0QXhln2VFNVheX3g7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737722354; c=relaxed/simple;
	bh=Emw2bbPqUP5KdqT9sCesqNaJIL9o2s1kfr6fiDoVpyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI5rm9S5hk3IsgdNeQg9DyX6kt8wmRrFj6wh9Y0h0J1lIUh1ia+hzXSh6prJrg0NiZHTy5LUlrd1EHt7eL8VpyPwYdAE1UaNkMX8EZozZfPOUcFD7Jx/196xUmDwIRDyPnFwrwDIPGfxn3KOr4erFiKcT9vTamHCPB2Do56QY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A39497;
	Fri, 24 Jan 2025 04:39:39 -0800 (PST)
Received: from [10.57.95.170] (unknown [10.57.95.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F5E3F5A1;
	Fri, 24 Jan 2025 04:39:09 -0800 (PST)
Message-ID: <426c1487-2bc4-4aa4-8da7-7559c7109ab8@arm.com>
Date: Fri, 24 Jan 2025 13:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
 <f1ff18a2-1b5e-4e9a-869b-9785faabf24d@arm.com>
 <20250124092917.19507-A-hca@linux.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20250124092917.19507-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2025 10:29, Heiko Carstens wrote:
> On Fri, Jan 24, 2025 at 08:58:07AM +0100, Kevin Brodsky wrote:
>> On 23/01/2025 17:03, Alexander Gordeev wrote:
>>> Commit 78966b550289 ("s390: pgtable: add statistics for PUD and P4D
>>> level page table") misses the call to pagetable_p4d_ctor() against
>>> a newly allocated P4D table in crst_table_upgrade();
>>>
>>> Commit 68c601de75d8 ("mm: introduce ctor/dtor at PGD level") misses
>>> the call to pagetable_pgd_ctor() against a newly allocated PGD and
>>> the call to pagetable_dtor() against a newly allocated P4D that is
>>> about to be freed on crst_table_upgrade() PGD upgrade fail path.
>>>
>>> The missed constructors and destructor break (at least) the page
>>> table accounting when a process memory space is upgraded.
>>>
>>> Reported-by: Heiko Carstens <hca@linux.ibm.com>
>>> Closes: https://lore.kernel.org/all/20250122074954.8685-A-hca@linux.ibm.com/
>>> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
>>> Fixes: 78966b550289 ("s390: pgtable: add statistics for PUD and P4D level page table")
>>> Fixes: 68c601de75d8 ("mm: introduce ctor/dtor at PGD level")
>>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>>> ---
>>> The patch is against:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git	next-20250123
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm			mm-stable
>> Thank you for putting together this patch! I was completely unaware of
>> this "upgrade" path on s390.
> This whole thing is even worse than it looks after this patch. With page
> table upgrade taken into account we still have the oddity that e.g. a
> previous pgd becomes a pud or p4d, which means that ctor and dtor functions
> might be called for different levels for the same page table. As of now
> this is ok, since they do all the same.
>
> As a quick fix this patch is ok, and most likely it will be ok for a long
> time, but it doesn't give me good feeling :)

This could clearly cause trouble if the pud/p4d/pgd constructors start
to diverge. In principle this could be addressed when upgrading by
calling the dtor on the old pgd and then the ctor on the new pud/p4d.
That said since there is now only one dtor, and the ctor are all the
same, it's probably good enough.

I'll mention in passing that my own series (that introduced PGD-level
ctor/dtor) really aimed at supporting the kpkeys page table protection
RFC [1], where hooks are inserted into the ctor/dtor to modify the pkey
page tables are mapped with. No idea if that would work with this sort
of upgrade path, but since s390 does not support pkeys this is just a
theoretical issue :)

- Kevin

[1]
https://lore.kernel.org/linux-hardening/20250108103250.3188419-1-kevin.brodsky@arm.com/
