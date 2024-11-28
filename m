Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8224EB38
	for <linux-s390@vger.kernel.org>; Thu, 28 Nov 2024 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732760620; cv=none; b=u10Qbsk1mvPE3oJQFvucXm2uRVSFYfl2Pto/1x1K7pObBhVgbneO8YiV65BCOZ8+8QIUbrpXQkg+oDUK1/sIWJMuNThq2tbkwe72qr3m8+tVGZy29XwaJTK2+XeTE4scTcK5GiutIO1lq8RyZu3tMcp+9z4/wDELROzBVIGS0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732760620; c=relaxed/simple;
	bh=djkkK1vCI+M9g0iJlW7s5Qkr5buDUgq9GMFIMHN83Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ANzkdbahlLq56TzoaPP4daXOgxayB6KiVcvUkueI2eXgBRZgzbVmt2NN4yv8h/PC+RfDxMI59l8FG+xXceiM39Sna8xk5VRUMKFxt3+eCsEifUz82G4bzlZgEnEHLqOevfR++8Ja+ayC0FF6wG8F/gtaAvlciZWrRqMV+qSqMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tm4ds5OP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tm4ds5OP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732760618; x=1764296618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=djkkK1vCI+M9g0iJlW7s5Qkr5buDUgq9GMFIMHN83Tg=;
  b=Tm4ds5OP74L+DB6qrSpvyD5xEOkVzd09LdFb48pmTDyTZplGG5Ymrc5V
   VFK/cIT1KsHkMqgZFGlpn8uQkA19dJnZuktvXZQApXBiNEeKhzakBc0qX
   VZu4MUl0pUvTShgcKSKoYylDJ+/OIEEuavGekevQnd+xLG7dERhw/CtYO
   QYNoXvaeFNdP1OCSh27hQ4fT69qyudNwXDyoA/rz1vMUxjuuxCFvHLK25
   OAMIdrbi/e4O/iJudUOCv0cXNY/yzDdS6xYFjtYAiNhrgD6BE7w16Kl/s
   1wJFe6EYRF3TnEkGvyPw0nhb5d+T4HZ/+FcFLO//qNKCgYkACiX/rAffA
   g==;
X-CSE-ConnectionGUID: K2Q4oenxRce9LIYvWL3gzg==
X-CSE-MsgGUID: NKpkDFS5RSi1lZFIWDKXIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32351011"
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="32351011"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 18:23:37 -0800
X-CSE-ConnectionGUID: MM6u5W7tSnmWXLr39ZGKgQ==
X-CSE-MsgGUID: AzNFpqrGToKiuzBT+OTBjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="92040065"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Nov 2024 18:23:34 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGUBn-0008hD-17;
	Thu, 28 Nov 2024 02:23:31 +0000
Date: Thu, 28 Nov 2024 10:22:56 +0800
From: kernel test robot <lkp@intel.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [s390:for-next 17/17] arch/s390/include/asm/hugetlb.h:94:31: error:
 call to undeclared function 'is_pte_marker'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202411281002.IPkRpIcR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-next
head:   487ef5d4d912f6a32556d8a61cede17870925295
commit: 487ef5d4d912f6a32556d8a61cede17870925295 [17/17] s390/mm: Add PTE_MARKER support for hugetlbfs mappings
config: s390-randconfig-002-20241128 (https://download.01.org/0day-ci/archive/20241128/202411281002.IPkRpIcR-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411281002.IPkRpIcR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411281002.IPkRpIcR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/pagewalk.c:2:
   In file included from include/linux/pagewalk.h:5:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/pagewalk.c:5:
   In file included from include/linux/hugetlb.h:798:
>> arch/s390/include/asm/hugetlb.h:94:31: error: call to undeclared function 'is_pte_marker'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |         return huge_pte_none(pte) || is_pte_marker(pte);
         |                                      ^
   In file included from mm/pagewalk.c:6:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:454:22: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/pagewalk.c:6:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:454:10: warning: array index 7 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:42: warning: array index 6 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:53: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/pagewalk.c:6:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:22: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/pagewalk.c:6:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:10: warning: array index 5 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:42: warning: array index 4 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:53: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/pagewalk.c:6:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:22: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/pagewalk.c:6:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:10: warning: array index 3 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:42: warning: array index 2 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:53: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/pagewalk.c:7:
>> include/linux/swapops.h:448:20: error: static declaration of 'is_pte_marker' follows non-static declaration
     448 | static inline bool is_pte_marker(pte_t pte)
         |                    ^
   arch/s390/include/asm/hugetlb.h:94:31: note: previous implicit declaration is here
      94 |         return huge_pte_none(pte) || is_pte_marker(pte);
         |                                      ^
   13 warnings and 2 errors generated.
--
   In file included from mm/page_vma_mapped.c:2:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/page_vma_mapped.c:4:
   In file included from include/linux/hugetlb.h:798:
>> arch/s390/include/asm/hugetlb.h:94:31: error: call to undeclared function 'is_pte_marker'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |         return huge_pte_none(pte) || is_pte_marker(pte);
         |                                      ^
   In file included from mm/page_vma_mapped.c:6:
>> include/linux/swapops.h:448:20: error: static declaration of 'is_pte_marker' follows non-static declaration
     448 | static inline bool is_pte_marker(pte_t pte)
         |                    ^
   arch/s390/include/asm/hugetlb.h:94:31: note: previous implicit declaration is here
      94 |         return huge_pte_none(pte) || is_pte_marker(pte);
         |                                      ^
   In file included from mm/page_vma_mapped.c:8:
   In file included from mm/internal.h:13:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
   3 warnings and 2 errors generated.
--
   In file included from mm/hugetlb_vmemmap.c:15:
   In file included from include/linux/bootmem_info.h:5:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/hugetlb_vmemmap.c:20:
   In file included from mm/hugetlb_vmemmap.h:11:
   In file included from include/linux/hugetlb.h:798:
>> arch/s390/include/asm/hugetlb.h:94:31: error: call to undeclared function 'is_pte_marker'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |         return huge_pte_none(pte) || is_pte_marker(pte);
         |                                      ^
   1 warning and 1 error generated.
--
   In file included from mm/migrate.c:16:
   In file included from include/linux/migrate.h:5:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/migrate.c:16:
   In file included from include/linux/migrate.h:8:
   In file included from include/linux/hugetlb.h:798:
>> arch/s390/include/asm/hugetlb.h:94:31: error: call to undeclared function 'is_pte_marker'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |         return huge_pte_none(pte) || is_pte_marker(pte);
         |                                      ^
   In file included from mm/migrate.c:18:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:454:22: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/migrate.c:18:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:454:10: warning: array index 7 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:42: warning: array index 6 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:454:53: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     454 |         case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/migrate.c:18:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:22: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/migrate.c:18:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:456:10: warning: array index 5 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:42: warning: array index 4 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:456:53: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     456 |         case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/migrate.c:18:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:22: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                             ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/migrate.c:18:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:23:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:168:
   include/linux/compat.h:458:10: warning: array index 3 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:42: warning: array index 2 is past the end of the array (that has type 'compat_sigset_word[2]' (aka 'unsigned int[2]')) [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                 ^     ~
   include/linux/compat.h:130:2: note: array 'sig' declared here
     130 |         compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
         |         ^
   include/linux/compat.h:458:53: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     458 |         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
         |                                                            ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from mm/migrate.c:19:
>> include/linux/swapops.h:448:20: error: static declaration of 'is_pte_marker' follows non-static declaration
     448 | static inline bool is_pte_marker(pte_t pte)
         |                    ^
   arch/s390/include/asm/hugetlb.h:94:31: note: previous implicit declaration is here
      94 |         return huge_pte_none(pte) || is_pte_marker(pte);
         |                                      ^
   In file included from mm/migrate.c:22:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
   15 warnings and 2 errors generated.
..


vim +/is_pte_marker +94 arch/s390/include/asm/hugetlb.h

    91	
    92	static inline int huge_pte_none_mostly(pte_t pte)
    93	{
  > 94		return huge_pte_none(pte) || is_pte_marker(pte);
    95	}
    96	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
