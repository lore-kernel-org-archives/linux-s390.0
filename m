Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFB2EB1D;
	Thu,  1 May 2025 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746090316; cv=none; b=F8HYPHz8fmBeUDldxDX8m9Q+LMsOOT8Oznk/tK5rQLzlxxN0ceDJkYglHIDJ1RfsffLfUuUHLAc/20EqXzQJguc5zT2WZi9jGWeTwW76PlI0sWA7BX7K873AgdAIxLgCOs3D3qFfxdLbMI8Z9dNW5R6gx6l4peGLacpxZYDEjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746090316; c=relaxed/simple;
	bh=LjqUK+jqYawxWebdEPFZWRtE1SPOMFDCEpd1NdX3gDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjXA9jjnVlqbc3bIhVf5p2xZHIWzaFjHeBq545TWewIAj0WEkENU2kSYrBvb3Ma1C0moDXuITlyc9qZVanlpRSrySmV2ZnbxgsBsLFHqO+sEyBavKad5kIZhYC1gb9ZgjqXsgd/NTNpica6F08ysZpEW96wdyj1pJ3P9DpcFvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APt5907U; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APt5907U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746090314; x=1777626314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LjqUK+jqYawxWebdEPFZWRtE1SPOMFDCEpd1NdX3gDs=;
  b=APt5907U8Ov7TK0W6z9q1NmLJlfxii9VMqZZpK5v51oVS3ou2SrexZI2
   J0feAa7j8StIAa97ymVkfjV3VRjNWx1709b2MAHlgwO4/eF31VhBk8bR3
   gE5UJvf5FIugnmPCzOm/zQgRA67E/Wx/UrjdmtB2d4lb8DXXdOaoYhYd6
   bAnG3Ac70wD/bIWD+KRxZIVrQJbuzJVsBaMU+3c+2oh6Dfdf3c8lgX/rN
   M+l0s9eRzJEyJkh36xQj7z0ZaYXpgxweflQd4u5luJWEzxfNZyfp+ayRB
   swETySXZyjEqoDbkSqH/dQsLdJoE9fnbpbisYlsm4Kosv5609GvaYEyMP
   A==;
X-CSE-ConnectionGUID: yzETTaRTQE6UTO1gCyYFMw==
X-CSE-MsgGUID: GCHKUpT1QGKzZ+6Zg0e0mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58423467"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="58423467"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:05:13 -0700
X-CSE-ConnectionGUID: AQZpm5eZTuOAKYj8W4GChA==
X-CSE-MsgGUID: eCKoVHzCQjq4j/jvm5gZaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="139527385"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 May 2025 02:05:10 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uAPqt-00044N-1D;
	Thu, 01 May 2025 09:05:07 +0000
Date: Thu, 1 May 2025 17:04:54 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Daniel Axtens <dja@axtens.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <202505011646.eHmKdH9T-lkp@intel.com>
References: <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.15-rc4 next-20250430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Gordeev/kasan-Avoid-sleepable-page-allocation-from-atomic-context/20250430-001020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev%40linux.ibm.com
patch subject: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from atomic context
config: x86_64-buildonly-randconfig-002-20250501 (https://download.01.org/0day-ci/archive/20250501/202505011646.eHmKdH9T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250501/202505011646.eHmKdH9T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505011646.eHmKdH9T-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/kasan/shadow.c: In function 'kasan_populate_vmalloc_pte':
>> mm/kasan/shadow.c:313:18: error: implicit declaration of function 'pfn_to_virt'; did you mean 'fix_to_virt'? [-Werror=implicit-function-declaration]
     313 |         __memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
         |                  ^~~~~~~~~~~
         |                  fix_to_virt
   mm/kasan/shadow.c:313:18: warning: passing argument 1 of '__memset' makes pointer from integer without a cast [-Wint-conversion]
     313 |         __memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
         |                  ^~~~~~~~~~~~~~~~
         |                  |
         |                  int
   In file included from arch/x86/include/asm/string.h:5,
                    from arch/x86/include/asm/cpuid/api.h:10,
                    from arch/x86/include/asm/cpuid.h:6,
                    from arch/x86/include/asm/processor.h:19,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:59,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from arch/x86/include/asm/pgtable.h:19,
                    from include/linux/pgtable.h:6,
                    from include/linux/kasan.h:37,
                    from mm/kasan/shadow.c:14:
   arch/x86/include/asm/string_64.h:23:22: note: expected 'void *' but argument is of type 'int'
      23 | void *__memset(void *s, int c, size_t n);
         |                ~~~~~~^
   cc1: some warnings being treated as errors


vim +313 mm/kasan/shadow.c

   299	
   300	static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
   301					      void *_data)
   302	{
   303		struct vmalloc_populate_data *data = _data;
   304		struct page *page;
   305		unsigned long pfn;
   306		pte_t pte;
   307	
   308		if (likely(!pte_none(ptep_get(ptep))))
   309			return 0;
   310	
   311		page = data->pages[PFN_DOWN(addr - data->start)];
   312		pfn = page_to_pfn(page);
 > 313		__memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
   314		pte = pfn_pte(pfn, PAGE_KERNEL);
   315	
   316		spin_lock(&init_mm.page_table_lock);
   317		if (likely(pte_none(ptep_get(ptep))))
   318			set_pte_at(&init_mm, addr, ptep, pte);
   319		spin_unlock(&init_mm.page_table_lock);
   320	
   321		return 0;
   322	}
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
