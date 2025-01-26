Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626714830C
	for <linux-s390@vger.kernel.org>; Sun, 26 Jan 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737920845; cv=none; b=DbmkmH9E0k3+IxLtmI7iAFDrR4WtPaXeU6zJSg6jUgE6Um4lUP/nJRphUpBk9JCuUNVukKvqXaUw8K1PNWFQnZLktN7QdBa/XNbYK/sFHV1NFy4MDq6RRfOco+xi1Kg6APdclOtB3Wop4OsQ3mzFcQJbZ7cgzyC3N3U95bvygsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737920845; c=relaxed/simple;
	bh=pttzpsCdYMUGNdO1mJNcprLQTbvGVhtH39PZjtwhlDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=glwY0/g8ociGERynmGNCEZzYNwE9H10nfieYy828BjrXQjOqBpafFkShw8g7w9mZVwLeeTXktRCNMZ8oXNR4PFXi8zixk+gqoKb1lVJczGLaAwKjdlYYB1qu32Wli8Y3w6c9UyZ1HZW3fYWQJ5B5wthh2ok68ZDY7yj0CJAWEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwUTaNfP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwUTaNfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737920842; x=1769456842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pttzpsCdYMUGNdO1mJNcprLQTbvGVhtH39PZjtwhlDE=;
  b=JwUTaNfPkOzIsOtBwcmb0PWgyIXNjqpxGPOKrhnbDjqo/HKVrNpqCxwB
   pCiwA3HK5T+EMFu66HRKD05zHq8p7g/DvlFINmEovpn3rYK+F85W9XuzE
   5qvu7kQAi/bM/T+43GxlkO27nvQDHJB1KtWhwEr7Cfe/SlmEGzoc3aaMN
   8M5OGgVg/pvg4LOBuvCkwQKGIwAZkCxAwp4mfdagjUwi2jVEkAZx+IkUS
   qak1F2C9G32uh8+1dZ7xDr8u54dO8VUL76Lu/dl6pGsMLbNBtSM+stHej
   3haZ0VqbSIjGf7hCzFrz620GW2QUPEFxXX1C8qN/HKcNOG4Yrp0/RDWfV
   g==;
X-CSE-ConnectionGUID: gxOQRLQcQN+cs95ExhT+Tw==
X-CSE-MsgGUID: DVcrZyjsSxu/SrUCYg2J8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="55926592"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="55926592"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 11:47:22 -0800
X-CSE-ConnectionGUID: zL5uLHgvTEaKFqTVj4il3Q==
X-CSE-MsgGUID: FS6gnzOySwekXNWvtqrbGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113394077"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Jan 2025 11:47:20 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tc8bG-000fww-1G;
	Sun, 26 Jan 2025 19:47:18 +0000
Date: Mon, 27 Jan 2025 03:47:11 +0800
From: kernel test robot <lkp@intel.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [s390:for-next 68/91] arch/s390/mm/vmem.c:665:36: warning:
 performing pointer arithmetic on a null pointer has undefined behavior
Message-ID: <202501270309.HzsVNo3o-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-next
head:   6abcbcab29996eba5d4bc5df20ed0bb4800effa9
commit: d7bebcb4a898bd214bbd71107f975b7b9f0bde32 [68/91] s390: Optimize __pa/__va when RANDOMIZE_IDENTITY_BASE is off
config: s390-randconfig-001-20250127 (https://download.01.org/0day-ci/archive/20250127/202501270309.HzsVNo3o-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 19306351a2c45e266fa11b41eb1362b20b6ca56d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250127/202501270309.HzsVNo3o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501270309.HzsVNo3o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/s390/mm/vmem.c:7:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/s390/mm/vmem.c:665:36: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     665 |                 __set_memory_4k(__va(0), __va(0) + ident_map_size);
         |                                          ~~~~~~~ ^
   2 warnings generated.


vim +665 arch/s390/mm/vmem.c

4df29d2b9024d6 Alexander Gordeev 2022-07-20  651  
f4eb07c17df2e6 Heiko Carstens    2006-12-08  652  void __init vmem_map_init(void)
f4eb07c17df2e6 Heiko Carstens    2006-12-08  653  {
a7eb28801b692d Heiko Carstens    2023-08-25  654  	__set_memory_rox(_stext, _etext);
a7eb28801b692d Heiko Carstens    2023-08-25  655  	__set_memory_ro(_etext, __end_rodata);
a7eb28801b692d Heiko Carstens    2023-08-25  656  	__set_memory_rox(__stext_amode31, __etext_amode31);
a6e49f10f4411e Heiko Carstens    2023-08-25  657  	/*
a6e49f10f4411e Heiko Carstens    2023-08-25  658  	 * If the BEAR-enhancement facility is not installed the first
a6e49f10f4411e Heiko Carstens    2023-08-25  659  	 * prefix page is used to return to the previous context with
a6e49f10f4411e Heiko Carstens    2023-08-25  660  	 * an LPSWE instruction and therefore must be executable.
a6e49f10f4411e Heiko Carstens    2023-08-25  661  	 */
c0f1d478121131 Heiko Carstens    2023-08-25  662  	if (!static_key_enabled(&cpu_has_bear))
c0f1d478121131 Heiko Carstens    2023-08-25  663  		set_memory_x(0, 1);
1e72ba5566d90a Heiko Carstens    2024-07-29  664  	if (debug_pagealloc_enabled())
1e72ba5566d90a Heiko Carstens    2024-07-29 @665  		__set_memory_4k(__va(0), __va(0) + ident_map_size);

:::::: The code at line 665 was first introduced by commit
:::::: 1e72ba5566d90a668c1c0fbde319cec03454fd20 s390/mm: Get rid of RELOC_HIDE()

:::::: TO: Heiko Carstens <hca@linux.ibm.com>
:::::: CC: Vasily Gorbik <gor@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
