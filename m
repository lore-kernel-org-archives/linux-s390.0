Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4554EB51
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943967; cv=none; b=Wlb6UW5XEwLSQpbXPR390lYkXSUF4exe037E4JHIv7zFwtZ+Q6lfZ/sWJE7ktK9fn3UIFh5toZsTGQJ95LYD1wrtKO2tmyMYakgFCt79ZR74LDPs2EQvzMxgQaAcOn3OdZM04AOgKNLjWjLgmIDp16esA+JtJbUWk6P7RxZKbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943967; c=relaxed/simple;
	bh=hzkaavx+ytSFVwWTePja2IBEsyWEPSnTMeQ9EJGh6aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPpwc5W/OsQPhMc0mAf+i7umbbz0U6EUcObFO9Cv42OerCQcQ6T8KVh0XQCRwoNGMymlwIy1853tOsVHtmLl93KeHNSw6d3r9J0Vm5py6tntULr5z19cw2cUk+81Pfsv0u1VmmWt+YtaWM0KsxBngLRzXXOd/KYOlxqrVL96sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290CD1FB;
	Mon, 22 Jan 2024 09:20:11 -0800 (PST)
Received: from [10.1.33.151] (XHFQ2J9959.cambridge.arm.com [10.1.33.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2F93F5A1;
	Mon, 22 Jan 2024 09:19:23 -0800 (PST)
Message-ID: <3069ea17-d470-4f02-a411-99638485c430@arm.com>
Date: Mon, 22 Jan 2024 17:19:22 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <962a7993-fce9-4de8-85cd-25e290f25736@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/01/2024 10:14, Kefeng Wang wrote:
> 
> 
> On 2024/1/12 13:03, kernel test robot wrote:
>> Hi Matthew,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on akpm-mm/mm-everything]
>>
>> url:   
>> https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Add-pfn_swap_entry_folio/20240111-232757
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> patch link:   
>> https://lore.kernel.org/r/20240111152429.3374566-9-willy%40infradead.org
>> patch subject: [PATCH v3 08/10] mm: Convert to should_zap_page() to
>> should_zap_folio()
>> config: arm-milbeaut_m10v_defconfig
>> (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/config)
>> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git
>> ae42196bc493ffe877a7e3dff8be32035dea4d07)
>> reproduce (this is a W=1 build):
>> (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes:
>> https://lore.kernel.org/oe-kbuild-all/202401121250.A221BL2D-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> mm/memory.c:1451:8: warning: variable 'folio' is used uninitialized whenever
>>>> 'if' condition is false [-Wsometimes-uninitialized]
>>                             if (page)
>>                                 ^~~~
>>     mm/memory.c:1454:44: note: uninitialized use occurs here
>>                             if (unlikely(!should_zap_folio(details, folio)))
>>                                                                     ^~~~~
>>     include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
>>     # define unlikely(x)    __builtin_expect(!!(x), 0)
>>                                                 ^
>>     mm/memory.c:1451:4: note: remove the 'if' if its condition is always true
>>                             if (page)
>>                             ^~~~~~~~~
>>     mm/memory.c:1438:22: note: initialize the variable 'folio' to silence this
>> warning
>>                     struct folio *folio;
>>                                        ^
>>                                         = NULL
> 
> Hi Andrew, please help to squash following change, thanks.

I just independently found this issue during coincidental review of the code.
It's still a problem in mm-unstable, so wondered if you missed the request, Andrew?

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 998237b5600f..5e88d5379127 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1435,7 +1435,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>         arch_enter_lazy_mmu_mode();
>         do {
>                 pte_t ptent = ptep_get(pte);
> -               struct folio *folio;
> +               struct folio *folio = NULL;
>                 struct page *page;
> 
>                 if (pte_none(ptent))
> 
> 
> 

