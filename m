Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7E18757E;
	Mon, 29 Jul 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284466; cv=none; b=nm6pGCZhlnMaN1gAjmXhSzuJSB+di+9MUJzcyl+qzZcdrRXOaroQmRoRCK9qaLRYinDBMRC7OHLT4GG+/cZfGOGgqiAF9e559DeHyYT6In3YltCBXK/17wZTb4fKR5UZrm9JiaVYDwFPQOYbekA4YCaefVveMgopZJ0sHHbmWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284466; c=relaxed/simple;
	bh=9MnFmbMMl4welPbAXfEJprTWfaQmhfFar1+EgR/YeEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEoCPdMdBNwAH4nn4Zhj9ougLMtL8CXWnl/ATIuJM+QyNgjalgqBQSGOjAUP0HMZy8rcVUQ8O1bR1Hqtk7WMGvFsUujhROorws5jz75gWtwInd/7w19RhguJDogOBGuPaaYIEPgyIYZbDp2KVqh2b4fMmwTSFHvikh1B9U2V/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hb9ok3mQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hb9ok3mQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722284465; x=1753820465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MnFmbMMl4welPbAXfEJprTWfaQmhfFar1+EgR/YeEY=;
  b=hb9ok3mQENQK+H/9ucltGEdkCYsyE6kKtgS8gkjv/sI4RXgjZsZUXlu3
   22CbZQ7hL/ZqI/E47wvt676cI5gzuMLh1gUgOjklgqrb79FB1Z4Jec76W
   iojp0F2wjBrso65J6a83FWyzfYuZhwbrs0fH+H/Y5BmBbNjyRE5oy/KOT
   bfAstKt0ryujA4FyhQ3+/XxwoCv/dbqhiGVJv84IIlc+zBiXwRkttAWYz
   mh2OLUGMU5/dIl2Q1JkZYh/IdmnkbIDSTXyl31YTWQPfWOgTGMJgPq3Ri
   JMOm29PL8bM5Z3TRPxxoYyXqhkNL+xbkdjLKcBnIjkVBBhwa2SCdIjCsu
   g==;
X-CSE-ConnectionGUID: 2gFqsyfFQYCiNjd7y5Fgpw==
X-CSE-MsgGUID: UnwuCR+JSEKaXgcae5YjMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20222980"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="20222980"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:21:04 -0700
X-CSE-ConnectionGUID: JMsHV9crROu7a5Rx0cgJEA==
X-CSE-MsgGUID: NRpEEVfCSs2EuHroYVXk+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="85050208"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jul 2024 13:21:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYWra-000s2F-2j;
	Mon, 29 Jul 2024 20:20:58 +0000
Date: Tue, 30 Jul 2024 04:20:51 +0800
From: kernel test robot <lkp@intel.com>
To: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-s390@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
	Ramon Fried <ramon@neureality.ai>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Elad Nachman <enachman@marvell.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dma-mapping: replace zone_dma_bits by
 zone_dma_limit
Message-ID: <202407300338.oaUo6jtB-lkp@intel.com>
References: <053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il>

Hi Baruch,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on powerpc/next powerpc/fixes s390/features linus/master v6.11-rc1 next-20240729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baruch-Siach/dma-mapping-improve-DMA-zone-selection/20240729-211018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch%40tkos.co.il
patch subject: [PATCH v3 2/3] dma-mapping: replace zone_dma_bits by zone_dma_limit
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240730/202407300338.oaUo6jtB-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300338.oaUo6jtB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300338.oaUo6jtB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/dma/direct.c:23:46: warning: implicit conversion from 'unsigned long long' to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
      23 | phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
         |             ~~~~~~~~~~~~~~                   ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:40: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                        ^~~~~
   2 warnings generated.


vim +23 kernel/dma/direct.c

   > 7	#include <linux/memblock.h>
     8	#include <linux/export.h>
     9	#include <linux/mm.h>
    10	#include <linux/dma-map-ops.h>
    11	#include <linux/scatterlist.h>
    12	#include <linux/pfn.h>
    13	#include <linux/vmalloc.h>
    14	#include <linux/set_memory.h>
    15	#include <linux/slab.h>
    16	#include "direct.h"
    17	
    18	/*
    19	 * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use
    20	 * it for entirely different regions. In that case the arch code needs to
    21	 * override the variable below for dma-direct to work properly.
    22	 */
  > 23	phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
