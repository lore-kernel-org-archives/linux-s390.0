Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D848F848;
	Thu,  8 Oct 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455583; cv=none; b=uY6mhmlRBSubbKlwZ+KoRcNYlsMbHg148HorRPW1xgHiUuNlX+o+f0jTs74mRTmd2yNPduaVpjm/NUSY6win8kOEJMEOkcdjpjP+LxPxOGlSKD+2eT+WGHwLhT/NpvUgfXTGnC65sR4yrEMo3WJ8UpMXN8AZtvEQTgPRWdYxR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455583; c=relaxed/simple;
	bh=AI3ZBMAQ3eLWhZFlrVjzDdUZpkJemDx62honLkjULds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PapshmBot6wfYKZKpF+OEa9F7V0qSpnXOhwpJnPWQ6sQZjquaqxT5kFKAkDAWZR+xSsIs8S17XrXv2Ssb9vL8Ei1nKLgIOrnVj45F+hLhZj3778FTRDO9+4yn9XUYwGemBK8tKStol2eHQQNkXnNElL0/5XhIVhVc6YN6azQdQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaOyYSqC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaOyYSqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791455581; x=1822991581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AI3ZBMAQ3eLWhZFlrVjzDdUZpkJemDx62honLkjULds=;
  b=EaOyYSqCiXP5aflKju6O/h1rKvj18IFZw2vKMN2JrDO+8mWu6lXl38NQ
   RILKfniYhS9g2+BovvaqM46MTle8ktrYavF2K3kAQJ/F2rkSj5GB0BEX3
   z8m1b32Ym9h6vGDUsBmgYY1QD3TCB7LOu3/lEanbrt9cgS2t1vkRnPVzP
   LoVX/24+pUH9m6AYHFEpd4uMSRcQ6l0eSMAMZ9m1cR9EcrLRUqj7y2v75
   ffDgAyH9N5HlHYBJu0JwNzle0O81QbTKaRP7x6icwBO3jStCUF9DwO+WB
   0PL3FAI4q+4mXwDrMX6u7qrWVI8D3gTKnmbQOc9R2kelr+VBISA5SnLMl
   Q==;
X-CSE-ConnectionGUID: eCqrmw84QsCQkPp5E++RIQ==
X-CSE-MsgGUID: L3qk0o19TOa96Lf1V9Nw7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="132379"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="132379"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 03:33:00 -0700
X-CSE-ConnectionGUID: 35EGeBEQTcuoO28zWBm4cg==
X-CSE-MsgGUID: yOdSKP5kTbGY5nEnkjYrcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1835115"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 08 Oct 2026 03:32:57 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xElQj-000000004Hu-3mTD;
	Thu, 08 Oct 2026 10:32:53 +0000
Date: Thu, 8 Oct 2026 18:32:15 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v8 11/15] s390: Distinguish hardware and software PTEs
Message-ID: <202610081806.wcWlNqQf-lkp@intel.com>
References: <c22ed0a2d9ff0f4fff69a17332a377c460d993dc.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c22ed0a2d9ff0f4fff69a17332a377c460d993dc.1791365932.git.agordeev@linux.ibm.com>

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.3-rc6]
[cannot apply to akpm-mm/mm-everything s390/features kvms390/next next-20261006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Gordeev/mm-introduce-hw_pte_t-for-PTE-table-storage/20261007-134144
base:   linus/master
patch link:    https://lore.kernel.org/r/c22ed0a2d9ff0f4fff69a17332a377c460d993dc.1791365932.git.agordeev%40linux.ibm.com
patch subject: [PATCH v8 11/15] s390: Distinguish hardware and software PTEs
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261008/202610081806.wcWlNqQf-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 80cd965b6323b208519f8ab1d5ee86e4ea9862f4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610081806.wcWlNqQf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610081806.wcWlNqQf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/damon/vaddr.c:303:45: error: incompatible pointer types passing 'pte_t *' to parameter of type 'hw_pte_t *' (aka 'struct __hw_pte_t *') [-Wincompatible-pointer-types]
     303 |         *entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
         |                                                    ^~~
   arch/s390/include/asm/hugetlb.h:34:40: note: passing argument to parameter 'ptep' here
      34 |                                             unsigned long addr, hw_pte_t *ptep,
         |                                                                           ^
   mm/damon/vaddr.c:305:28: error: incompatible pointer types passing 'pte_t *' to parameter of type 'hw_pte_t *' (aka 'struct __hw_pte_t *') [-Wincompatible-pointer-types]
     305 |         set_huge_pte_at(mm, addr, pte, *entry, psize);
         |                                   ^~~
   arch/s390/include/asm/hugetlb.h:22:18: note: passing argument to parameter 'ptep' here
      22 |                      hw_pte_t *ptep, pte_t pte, unsigned long sz);
         |                                ^
>> mm/damon/vaddr.c:318:40: error: incompatible pointer types passing 'hw_pte_t *' (aka 'struct __hw_pte_t *') to parameter of type 'pte_t *' [-Wincompatible-pointer-types]
     318 |         referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
         |                                               ^~~
   mm/damon/vaddr.c:296:45: note: passing argument to parameter 'pte' here
     296 | static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
         |                                             ^
   3 errors generated.


vim +303 mm/damon/vaddr.c

3f49584b262cf8 SeongJae Park        2021-09-07  294  
49f4203aae06ba Baolin Wang          2022-01-14  295  #ifdef CONFIG_HUGETLB_PAGE
39c0ceedd54557 SJ Park              2026-09-07  296  static bool damon_hugetlb_ptep_mkold(pte_t *pte, struct mm_struct *mm,
39c0ceedd54557 SJ Park              2026-09-07  297  		struct vm_area_struct *vma, unsigned long addr, pte_t *entry)
39c0ceedd54557 SJ Park              2026-09-07  298  {
39c0ceedd54557 SJ Park              2026-09-07  299  	unsigned long psize = huge_page_size(hstate_vma(vma));
39c0ceedd54557 SJ Park              2026-09-07  300  
39c0ceedd54557 SJ Park              2026-09-07  301  	if (!pte_young(*entry))
39c0ceedd54557 SJ Park              2026-09-07  302  		return false;
39c0ceedd54557 SJ Park              2026-09-07 @303  	*entry = huge_ptep_get_and_clear(mm, addr, pte, psize);
39c0ceedd54557 SJ Park              2026-09-07  304  	*entry = pte_mkold(*entry);
39c0ceedd54557 SJ Park              2026-09-07  305  	set_huge_pte_at(mm, addr, pte, *entry, psize);
39c0ceedd54557 SJ Park              2026-09-07  306  	return true;
39c0ceedd54557 SJ Park              2026-09-07  307  }
39c0ceedd54557 SJ Park              2026-09-07  308  
6ecdfd6e16f5f4 Muhammad Usama Anjum 2026-10-07  309  static void damon_hugetlb_mkold(hw_pte_t *pte, struct mm_struct *mm,
49f4203aae06ba Baolin Wang          2022-01-14  310  				struct vm_area_struct *vma, unsigned long addr)
49f4203aae06ba Baolin Wang          2022-01-14  311  {
49f4203aae06ba Baolin Wang          2022-01-14  312  	bool referenced = false;
e6c0c03245b14d Christophe Leroy     2024-07-02  313  	pte_t entry = huge_ptep_get(mm, addr, pte);
6b7cea90c82e10 Kefeng Wang          2022-12-30  314  	struct folio *folio = pfn_folio(pte_pfn(entry));
49f4203aae06ba Baolin Wang          2022-01-14  315  
6b7cea90c82e10 Kefeng Wang          2022-12-30  316  	folio_get(folio);
49f4203aae06ba Baolin Wang          2022-01-14  317  
39c0ceedd54557 SJ Park              2026-09-07 @318  	referenced = damon_hugetlb_ptep_mkold(pte, mm, vma, addr, &entry);
49f4203aae06ba Baolin Wang          2022-01-14  319  	if (mmu_notifier_clear_young(mm, addr,
49f4203aae06ba Baolin Wang          2022-01-14  320  				     addr + huge_page_size(hstate_vma(vma))))
49f4203aae06ba Baolin Wang          2022-01-14  321  		referenced = true;
49f4203aae06ba Baolin Wang          2022-01-14  322  
49f4203aae06ba Baolin Wang          2022-01-14  323  	if (referenced)
6b7cea90c82e10 Kefeng Wang          2022-12-30  324  		folio_set_young(folio);
49f4203aae06ba Baolin Wang          2022-01-14  325  
6b7cea90c82e10 Kefeng Wang          2022-12-30  326  	folio_set_idle(folio);
6b7cea90c82e10 Kefeng Wang          2022-12-30  327  	folio_put(folio);
49f4203aae06ba Baolin Wang          2022-01-14  328  }
49f4203aae06ba Baolin Wang          2022-01-14  329  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
