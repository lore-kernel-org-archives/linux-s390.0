Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC962802
	for <linux-s390@vger.kernel.org>; Fri, 12 Jan 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TBHSl5GLGzGpxn;
	Fri, 12 Jan 2024 18:14:15 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D7D514011A;
	Fri, 12 Jan 2024 18:14:33 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 18:14:32 +0800
Message-ID: <962a7993-fce9-4de8-85cd-25e290f25736@huawei.com>
Date: Fri, 12 Jan 2024 18:14:32 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] mm: Convert to should_zap_page() to
 should_zap_folio()
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, Linux Memory
 Management List <linux-mm@kvack.org>, <david@redhat.com>,
	<linux-s390@vger.kernel.org>
References: <20240111152429.3374566-9-willy@infradead.org>
 <202401121250.A221BL2D-lkp@intel.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202401121250.A221BL2D-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/1/12 13:03, kernel test robot wrote:
> Hi Matthew,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Add-pfn_swap_entry_folio/20240111-232757
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240111152429.3374566-9-willy%40infradead.org
> patch subject: [PATCH v3 08/10] mm: Convert to should_zap_page() to should_zap_folio()
> config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121250.A221BL2D-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401121250.A221BL2D-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> mm/memory.c:1451:8: warning: variable 'folio' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>                             if (page)
>                                 ^~~~
>     mm/memory.c:1454:44: note: uninitialized use occurs here
>                             if (unlikely(!should_zap_folio(details, folio)))
>                                                                     ^~~~~
>     include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
>     # define unlikely(x)    __builtin_expect(!!(x), 0)
>                                                 ^
>     mm/memory.c:1451:4: note: remove the 'if' if its condition is always true
>                             if (page)
>                             ^~~~~~~~~
>     mm/memory.c:1438:22: note: initialize the variable 'folio' to silence this warning
>                     struct folio *folio;
>                                        ^
>                                         = NULL

Hi Andrew, please help to squash following change, thanks.

diff --git a/mm/memory.c b/mm/memory.c
index 998237b5600f..5e88d5379127 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1435,7 +1435,7 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
         arch_enter_lazy_mmu_mode();
         do {
                 pte_t ptent = ptep_get(pte);
-               struct folio *folio;
+               struct folio *folio = NULL;
                 struct page *page;

                 if (pte_none(ptent))


