Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF85DDA9;
	Thu,  1 May 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746060765; cv=none; b=VLarwB9w/vj3Pb1B9NoJlAQYfK4Q8wiDDH3ZZs1mgjj92bBtMcn5oIslREU6B5C3ae3Kk0wB27KyTF93hKzad5EM4sES4TLgMIA/19dGN+w7uKVFTIwmY9QOYbxfj/GGLyTw+XEZ+1WxxJ8BAFLPNpdkjwdrymuj3Mb2yKKVFKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746060765; c=relaxed/simple;
	bh=LDZGBQNcsIA064rbXGgXPhU7sqWZ/3CVEUVEmDe0AWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuAz5k+o1/vNgNYwYhfWfxQXWgxWKlGXI8YaLtbq8JxSp3blSHfND0rHLj+5EkgWjnosHMiaXMWGHNSEKhCMmNGwZhElliEdzxHQlv/PWJPaIknJs747/y8GO+Di3OJuQN6x2wGLABbQ3cxu6wVQ1k6JkGxU1sCC9Q2OXLA7jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWOzK+4+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWOzK+4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746060763; x=1777596763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LDZGBQNcsIA064rbXGgXPhU7sqWZ/3CVEUVEmDe0AWY=;
  b=NWOzK+4+0EV0TywmcqeK54rO4ZABA54AGBnQZiFiE5BxSywUkrczciYh
   K/J06zm0ei6oBFaKWny4J5Jd3nUTEKhKzq4kbWsZyeXVUhgUgNciU+D+L
   ouIgPym9uXsbk0MtBb35tOFJm/kmYDtW0Rnl6167CvmyYHWGCXB4VI80R
   3WNm4kGZAAweN0tm4x4P4atygPG7QG7fctQQHlg8t7haEjnwKpJKKhCV9
   ZDt0wfQzr5NxFpTj1m7jKQN85MYWtjyaGS6n7VbPZ3QpPpg9CjZwQyokG
   ygrqDvJYN4FqYL94Od6uQ4odoiunRO+fOA04eRpQxm6STscb41XDoxhAL
   g==;
X-CSE-ConnectionGUID: cvQlpOefRO2a492bEr3MCg==
X-CSE-MsgGUID: kRC+hE4oSw6yttcYWHxltg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="59102541"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="59102541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 17:52:42 -0700
X-CSE-ConnectionGUID: CZ7wJ0HsTry5iIOxqydNWQ==
X-CSE-MsgGUID: FivrNy4gQVOiBEzlJsy6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="165336468"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Apr 2025 17:52:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uAIAH-0003s5-0L;
	Thu, 01 May 2025 00:52:37 +0000
Date: Thu, 1 May 2025 08:51:46 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Daniel Axtens <dja@axtens.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-s390@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from
 atomic context
Message-ID: <202505010807.0tj4Krnz-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20250501 (https://download.01.org/0day-ci/archive/20250501/202505010807.0tj4Krnz-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250501/202505010807.0tj4Krnz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505010807.0tj4Krnz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/kasan/shadow.c:313:11: error: call to undeclared function 'pfn_to_virt'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     313 |         __memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
         |                  ^
   mm/kasan/shadow.c:313:11: note: did you mean 'fix_to_virt'?
   include/asm-generic/fixmap.h:30:38: note: 'fix_to_virt' declared here
      30 | static __always_inline unsigned long fix_to_virt(const unsigned int idx)
         |                                      ^
>> mm/kasan/shadow.c:313:11: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'void *' [-Wint-conversion]
     313 |         __memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
         |                  ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/string_64.h:23:22: note: passing argument to parameter 's' here
      23 | void *__memset(void *s, int c, size_t n);
         |                      ^
   2 errors generated.


vim +/pfn_to_virt +313 mm/kasan/shadow.c

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
