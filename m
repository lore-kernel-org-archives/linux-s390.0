Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78E65BBD
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944751; cv=none; b=LlnVPq4eHNj+o/eIs0EO1M31CmdaIGv8YCbgscif6r1s/6hmoBoofXv6jU/SNkdL4Po9ZJvFJNEcjGGaTPUiwyQxUJmSImLIkdf4twO+7jpLplxaVz9fS+VlxEWI4b+boYcuHUyvYR7u9CtIam1ja1Ck9TA52kWRl/GZpeq2Zyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944751; c=relaxed/simple;
	bh=7XH50HmrbpR0YQJb9apkCvMnFKnkJVBPfa7TMJYYH0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pRRww1d0x8sVgvVI0NITdX0Tq+q1cO+EsOQkdpgbolWVrOFa3CryKcmP5N6Nm5ujgDKiLgtWObA/iUh5dkTz2uGRUUSUa4UQzMRmoxq8VQean2EatQFSGws3mESm4pGjsMepj1ILGayJN0K5npvy4IOsMXUcLWQPD27QGQB75ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 459E91FB;
	Mon, 22 Jan 2024 09:33:14 -0800 (PST)
Received: from [10.1.33.151] (XHFQ2J9959.cambridge.arm.com [10.1.33.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06B743F5A1;
	Mon, 22 Jan 2024 09:32:26 -0800 (PST)
Message-ID: <70d17161-94c2-4737-bf03-ff393e27bc49@arm.com>
Date: Mon, 22 Jan 2024 17:32:25 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] mm: Convert to should_zap_page() to
 should_zap_folio()
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 kernel test robot <lkp@intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>, david@redhat.com,
 linux-s390@vger.kernel.org
References: <20240111152429.3374566-9-willy@infradead.org>
 <202401121250.A221BL2D-lkp@intel.com>
 <962a7993-fce9-4de8-85cd-25e290f25736@huawei.com>
 <3069ea17-d470-4f02-a411-99638485c430@arm.com>
In-Reply-To: <3069ea17-d470-4f02-a411-99638485c430@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/01/2024 17:19, Ryan Roberts wrote:
> On 12/01/2024 10:14, Kefeng Wang wrote:
>>
>>
>> On 2024/1/12 13:03, kernel test robot wrote:
>>> Hi Matthew,
>>>
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on akpm-mm/mm-everything]
>>>
>>> url:   
>>> https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Add-pfn_swap_entry_folio/20240111-232757
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>>> patch link:   
>>> https://lore.kernel.org/r/20240111152429.3374566-9-willy%40infradead.org
>>> patch subject: [PATCH v3 08/10] mm: Convert to should_zap_page() to
>>> should_zap_folio()
>>> config: arm-milbeaut_m10v_defconfig
>>> (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/config)
>>> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git
>>> ae42196bc493ffe877a7e3dff8be32035dea4d07)
>>> reproduce (this is a W=1 build):
>>> (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes:
>>> https://lore.kernel.org/oe-kbuild-all/202401121250.A221BL2D-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> mm/memory.c:1451:8: warning: variable 'folio' is used uninitialized whenever
>>>>> 'if' condition is false [-Wsometimes-uninitialized]
>>>                             if (page)
>>>                                 ^~~~
>>>     mm/memory.c:1454:44: note: uninitialized use occurs here
>>>                             if (unlikely(!should_zap_folio(details, folio)))
>>>                                                                     ^~~~~
>>>     include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
>>>     # define unlikely(x)    __builtin_expect(!!(x), 0)
>>>                                                 ^
>>>     mm/memory.c:1451:4: note: remove the 'if' if its condition is always true
>>>                             if (page)
>>>                             ^~~~~~~~~
>>>     mm/memory.c:1438:22: note: initialize the variable 'folio' to silence this
>>> warning
>>>                     struct folio *folio;
>>>                                        ^
>>>                                         = NULL
>>
>> Hi Andrew, please help to squash following change, thanks.
> 
> I just independently found this issue during coincidental review of the code.
> It's still a problem in mm-unstable, so wondered if you missed the request, Andrew?

Sorry - please ignore this - I was confused. I see that it is infact applied to
mm-unstable.


> 
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 998237b5600f..5e88d5379127 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1435,7 +1435,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>         arch_enter_lazy_mmu_mode();
>>         do {
>>                 pte_t ptent = ptep_get(pte);
>> -               struct folio *folio;
>> +               struct folio *folio = NULL;
>>                 struct page *page;
>>
>>                 if (pte_none(ptent))
>>
>>
>>
> 

