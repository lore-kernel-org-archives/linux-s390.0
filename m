Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A83594A;
	Sat,  2 May 2026 04:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777697730; cv=none; b=lSPQ5p9hzrbRmBt7KIRVlHHRRYeMGjb3dr/zK45s/GMyb5KoSD4R4bohS99FSJBdNrbX9nWcWy371KQZOlOgiotohbYkRApAez634D6O+MH8kuSRFK2KOOI7Ouupe6a333UF0wpIkuNnIkMgtr0agdynqTnuFNtp9Fvm3Okkijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777697730; c=relaxed/simple;
	bh=muz3Gn4korg+6J8rsu49cXA8q5KYIYesTuw3bKtX29A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2qTQ+nSE57zxzrECKFs+5T1bB1VEVowUyTq58pQa++7K27KW4dn/ctdZTLxFEz6Q1b+9SOzbpJI/0Bz4ponA0gx8JmwMGdq1C3CVClZilaQuZQxGMyW3vZ/DiaNR1IUWdZWfKCt2+rUO/zszE8Ig6PeZvig6LsaM/1v+Mli2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFoS3qFR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFoS3qFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777697727; x=1809233727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=muz3Gn4korg+6J8rsu49cXA8q5KYIYesTuw3bKtX29A=;
  b=TFoS3qFRJFvfgbld4o/SkLZoTRWcYGv2xxdQfgw4TsQMqQriO9xjR4Az
   5CD+00D6eFVLL7Zcc93EU2iGzT9XpPuSQSNU/eOX0p758Bf85Eupq0wd/
   K/u4R6i3KhwXHgq2Poythd/CN9i8uiP/uR8pLBg1c7Y9XLWIFpKTugpS/
   s6mpeQ5NkNrqzwG7Ctf/bmfjg8c1fIqqDpCPmqDqBvEkDfYShtBxMsR/P
   6bMNQa7z5QXqGPCsedJm/e3W284n8aLSh53gUMXK1uCcmNs+QnODiR22m
   r0vaWJP4lb14kd3gno/fXKFWn/LL8ltVK4K3pa0BOWIoxMgNy/aKl7Q3O
   w==;
X-CSE-ConnectionGUID: Lqkgc7PKSXy5gfRGlLQSHQ==
X-CSE-MsgGUID: sYv0o/DaT6azbY1IfGhAVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="77811816"
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; 
   d="scan'208";a="77811816"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2026 21:55:26 -0700
X-CSE-ConnectionGUID: llL2noBBTQS1hGL4KDHO9w==
X-CSE-MsgGUID: qCtvcYm+R+2TAH3W5hO1JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; 
   d="scan'208";a="235099619"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 May 2026 21:55:24 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJ2Nt-000000001A5-0AOd;
	Sat, 02 May 2026 04:55:21 +0000
Date: Sat, 2 May 2026 12:54:45 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
Message-ID: <202605021251.huVQW8Xg-lkp@intel.com>
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427052000.196402-1-agordeev@linux.ibm.com>

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Gordeev/mm-page_vma_mapped_walk-add-missing-pgtable-entry-accessors/20260429-030409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260427052000.196402-1-agordeev%40linux.ibm.com
patch subject: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry accessors
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260502/202605021251.huVQW8Xg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260502/202605021251.huVQW8Xg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605021251.huVQW8Xg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
>> arch/arm/include/asm/pgtable.h:144:44: error: 'pgdp' undeclared (first use in this function); did you mean 'pgd'?
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:33: note: in expansion of macro 'READ_ONCE'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                 ^~~~~~~~~
   mm/page_vma_mapped.c:222:34: note: in expansion of macro 'pgdp_get'
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~
   arch/arm/include/asm/pgtable.h:144:44: note: each undeclared identifier is reported only once for each function it appears in
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^~~~
   include/linux/compiler_types.h:679:23: note: in definition of macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:699:9: note: in expansion of macro '_compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:144:33: note: in expansion of macro 'READ_ONCE'
     144 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                 ^~~~~~~~~
   mm/page_vma_mapped.c:222:34: note: in expansion of macro 'pgdp_get'
     222 |                 if (!pgd_present(pgdp_get(pgd))) {
         |                                  ^~~~~~~~


vim +144 arch/arm/include/asm/pgtable.h

4eec4b1396ac6a6 Russell King    2010-11-26  143  
eba2591d99d1f14 Alexandre Ghiti 2023-12-13 @144  #define pgdp_get(pgpd)		READ_ONCE(*pgdp)
eba2591d99d1f14 Alexandre Ghiti 2023-12-13  145  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
