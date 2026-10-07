Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3273C1097;
	Wed,  7 Oct 2026 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405324; cv=none; b=f9Eh0uFHpvPwag37oUh1G/YlykTG7qt0v7mEJk0CriaFZZB7QnRqGRGviuQ4jkxEoBDIOgAZXqViBT9nyoZG5SyMzhkv1JbWgPLtF73jj7PNJmUxYYR2HJtdMsZlIFVpshVPCWhc/p23v4SRQkgUFlPtnh8Uk3VqwQ0F2Z1lhU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405324; c=relaxed/simple;
	bh=JbeNIEU4iUQ8SYi2b45GJTIYlcE248gtt7WfKvw82fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=famTFeYDo6P/08EHCDTMToJ6hkccuJG21f+7nm3e2Fz+RWwpbyqccu+Ewo3PHfUgkwFGBhBAFmsaCl6H+DO0JyggCgvptZBMd9UEDBO7TJyqx/OKPVzSSNzNEo4xNlJVTyV5v6yryzWfrumThq9WwOu6NxDKYA4Al6bhXFP1mT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC5Y2+OO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC5Y2+OO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791405324; x=1822941324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JbeNIEU4iUQ8SYi2b45GJTIYlcE248gtt7WfKvw82fI=;
  b=DC5Y2+OOkTncnidSfuDTpDg6t/YCuPG+begr281onJjqxHFHBTT0n5Xb
   zKivWLlyn7CGTl7P8CD+SMhtpu0dSIBqjJ8JEj6TdL5R1BtzaE1cdiC35
   v2fcwmutsTwXVGkXWWFrt6f9q+0lhtKE0tTn4h8DYDS38JAZ+3wEIHzWX
   i+N7eDifuIOHyd+PaaMaUyeOdqk/kVu8dmQzlW4moO0DcbgffVmkM2LLl
   fCODqkRvEPpFVnugQKVqfcU6Wi4443l3IGxwA/+Qlaz3aERXocuPA7Tz8
   PjaNspHgSNZQ8SsTr/6FqcN8uVsVA8QrZMm/rDdDZwlmVwmZpI0QbSHot
   A==;
X-CSE-ConnectionGUID: itIrn8gNRx6HCfpY3rjJVQ==
X-CSE-MsgGUID: f8FihUe7TwqNLoJUXnf2GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="197568"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="197568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 13:35:23 -0700
X-CSE-ConnectionGUID: 5+0X6H5+RjqXJ0za8As3dQ==
X-CSE-MsgGUID: mK0Qw6jLTKS+Hhk4m333jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="285468564"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2026 13:35:19 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEYM8-000000003Vo-1pez;
	Wed, 07 Oct 2026 20:35:16 +0000
Date: Thu, 8 Oct 2026 04:35:12 +0800
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
Subject: Re: [PATCH v8 14/15] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Message-ID: <202610080433.XoFeDwjr-lkp@intel.com>
References: <e42d9f02ec1f8478a50fce424b95d0e7ff6a359f.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42d9f02ec1f8478a50fce424b95d0e7ff6a359f.1791365932.git.agordeev@linux.ibm.com>

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
patch link:    https://lore.kernel.org/r/e42d9f02ec1f8478a50fce424b95d0e7ff6a359f.1791365932.git.agordeev%40linux.ibm.com
patch subject: [PATCH v8 14/15] mm/kasan: Introduce helpers for lazy MMU mode sanitizer
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20261008/202610080433.XoFeDwjr-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610080433.XoFeDwjr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610080433.XoFeDwjr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:31:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/arm/include/asm/pgtable.h:16:
   In file included from arch/arm/include/asm/pgtable-nommu.h:13:
   In file included from include/linux/slab.h:276:
>> include/linux/kasan.h:430:37: error: unknown type name 'hw_pte_t'
     430 | static inline void kasan_poison_pte(hw_pte_t *pte, int nr) {}
         |                                     ^
   include/linux/kasan.h:431:39: error: unknown type name 'hw_pte_t'
     431 | static inline void kasan_unpoison_pte(hw_pte_t *pte, int nr) {}
         |                                       ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
     138 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
         |                      ^      ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:24: note: expanded from macro '_SIG_SET_BINOP'
     138 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
         |                                      ^      ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:14:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:139:8: note: expanded from macro '_SIG_SET_BINOP'
     139 |                 b3 = b->sig[3]; b2 = b->sig[2];                         \


vim +/hw_pte_t +430 include/linux/kasan.h

   420	
   421	static inline void kasan_unpoison_range(const void *address, size_t size) {}
   422	static inline void kasan_poison_pages(struct page *page, unsigned int order,
   423					      bool init) {}
   424	static inline bool kasan_unpoison_pages(struct page *page, unsigned int order,
   425						bool init)
   426	{
   427		return false;
   428	}
   429	static inline void kasan_poison_slab(struct slab *slab) {}
 > 430	static inline void kasan_poison_pte(hw_pte_t *pte, int nr) {}
   431	static inline void kasan_unpoison_pte(hw_pte_t *pte, int nr) {}
   432	static inline void kasan_unpoison_new_object(struct kmem_cache *cache,
   433						void *object) {}
   434	static inline void kasan_poison_new_object(struct kmem_cache *cache,
   435						void *object) {}
   436	static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
   437					const void *object)
   438	{
   439		return (void *)object;
   440	}
   441	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
