Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035C48F024;
	Mon, 21 Sep 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995084; cv=none; b=AjJN2xXHHm0wOINYHgNCJWkYufHHsmDsWjPTHlpsRpQFtUULs/5dHuH1SiWOpeYtNf2M42Xm8l32DNeBBYiZGziv4PycIgfOmDM3ypufGGbvdDNRliQw/46nZirzUKSQgwsdQTzGPikikkGl/2IisVY+MaD2+3ITBOq5sLxW1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995084; c=relaxed/simple;
	bh=HXAhdpQuILv12trenzrxa0DxHNLn7f/XIZHr5cv391k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL+J3WXdFSFpMLga/ispsyEW4cnfKCAHv13TUZNuzY7QDY+aC4EgS7DsH47BPQZ8fIPT9L8ZchzP0lLXbbKTVuWm6nOP0/cnOcz2LwKemYofdncBF19nh+QF0KaLm3udDkORq3EkQ9JoJOwiTH0GxTELIuYvdpB4pt3Qv9bVtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ShtSmcPD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ShtSmcPD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E855176C;
	Mon, 21 Sep 2026 05:51:18 -0700 (PDT)
Received: from [10.57.6.224] (unknown [10.57.6.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 369BE3F86C;
	Mon, 21 Sep 2026 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789995082; bh=HXAhdpQuILv12trenzrxa0DxHNLn7f/XIZHr5cv391k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ShtSmcPDUXgPFJquxoISwgyxA0JeEBWLYMWSo5Kp/sAkxe8UArxJYx54OQw5DhKo5
	 91/PuhmUkjC3DEWhdBC9lka/rh0pM3m0nVfSaqpUkfTDsBcvRFYZZSXMBptKHvfkEq
	 2RXCaLm+4k0zuOQBpH3bJ8i8jcHuTYYleBbqAy+A=
Message-ID: <c4a38552-abdd-42e4-8b7d-bb1716888f1f@arm.com>
Date: Mon, 21 Sep 2026 14:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
 Will Deacon <will@kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
 <20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org>
 <d299f7c5-6c71-499a-b8cd-aa69c4c81dd1@arm.com> <aqzjBA_101LcKRCD@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <aqzjBA_101LcKRCD@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2026 09:06, Mike Rapoport wrote:
> On Thu, Sep 17, 2026 at 08:11:22PM +0200, Kevin Brodsky wrote:
>> On 03/09/2026 11:28, Mike Rapoport (Microsoft) wrote:
>>> When set_direct_map APIs were introduced by the commit d253ca0c3865
>>> ("x86/mm/cpa: Add set_direct_map_*() functions") the single page
>>> parameter made sense because the initial callers (vmalloc and
>>> hibernation) had sets of unsorted struct pages that required changes of
>>> their mappings in the direct map.
>>>
>>> Since there is an increasing demand for direct map manipulation and it
>>> is also desirable to be able to update larger physically contiguous
>>> mappings, for example an entire large folio, extend set_direct_map APIs
>>> to receive number of pages parameter.
>>>
>>> As there is still only a handful of callers, change the existing
>>> functions directly and update all the call sites rather than adding
>>> wrappers for single page case.
>>>
>>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/set_memory.h     | 4 ++--
>>>  arch/arm64/mm/pageattr.c                | 8 ++++----
>>>  arch/loongarch/include/asm/set_memory.h | 4 ++--
>>>  arch/loongarch/mm/pageattr.c            | 8 ++++----
>>>  arch/riscv/include/asm/set_memory.h     | 4 ++--
>>>  arch/riscv/mm/pageattr.c                | 8 ++++----
>>>  arch/s390/include/asm/set_memory.h      | 4 ++--
>>>  arch/s390/mm/pageattr.c                 | 8 ++++----
>>>  arch/x86/include/asm/set_memory.h       | 4 ++--
>>>  arch/x86/mm/pat/set_memory.c            | 8 ++++----
>>>  include/linux/set_memory.h              | 6 ++++--
>>>  kernel/power/snapshot.c                 | 4 ++--
>>>  mm/secretmem.c                          | 6 +++---
>>>  mm/vmalloc.c                            | 5 +++--
>>>  14 files changed, 42 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
>>> index 90f61b17275e1..b07fd4e026eac 100644
>>> --- a/arch/arm64/include/asm/set_memory.h
>>> +++ b/arch/arm64/include/asm/set_memory.h
>>> @@ -11,8 +11,8 @@ bool can_set_direct_map(void);
>>>  
>>>  int set_memory_valid(unsigned long addr, int numpages, int enable);
>>>  
>>> -int set_direct_map_invalid_noflush(struct page *page);
>>> -int set_direct_map_default_noflush(struct page *page);
>>> +int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
>>> +int set_direct_map_default_noflush(struct page *page, unsigned int numpages);
>> I don't have a strong opinion on whether to call the argument nr or
>> numpages, but we might as well be consistent across archs :)
> Well, it's either consistent across archs or consistent within each arch :)
> Or add a churny patch that renames it everywhere to nr_pages :)

Eh fair enough... Clearly not the biggest inconsistency in the
set_direct_map API anyway!

- Kevin
