Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880879;
	b=eYU1EFyaw6/bWymRcmQU79+KAGfn6jkqyGCP/8uU/dq1ELmHlC+kGr1HkH6eCVl/gDZL
	 yl+xdDlwUcrapcSNH+wwpGi49nmg/DqJcHi6QTrV8shgvgaxh7/JMOaSx6Kz9poOU7gDX
	 tNthoYPjGKPZwTcRNxUyfQMPL0ygv7snCBI4Ao1dyUI0f6zdf3w/aa4esJh89MsdC4OtE
	 Ub8MpZPiBRGYh2Hy6iYolcwbtt+zDpyQJN/neTLBlyrMPci+debMIHDgors16cRifVdp1
	 YVydCowJmfljMHIp62QToBtEm/1hd7zRmH1jft4hagrYawZHexfIEH8vJ2rqjXfUI1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880879;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cRwA5sbmlFTv4dr/TsrihpefpRsTJ7E+PJDAiAJhZlc=;
	b=uJ7Kv+r0nren0Cxc102iBT47VrzxBNN19TZ4okY3nF5mnAbYTJUueBMmjQI0drp5fXGX
	 +SNPpz1p0IVMHVm0KqHNJvJiAxaUP1A5DDqHfJc6VTop36WdHw9x5UQizWRuFlnqpUksR
	 wcaSpoXHbZVK9LryeOpI/Q4catypLv2nZLjnd+0C9D0aQRSRBFbqTkPbn24iLeqhTkuPz
	 N/ATRAOzE41yMqPCTX0mdiw8VWHHi4eMjz38Rd0e00U6N2Kco2YQcoSSo/dUQjpDitje8
	 jDZ82NNClVQzNyAusaK9glSQMWPFHBfIjZhzapIub/uDkaUDTvXzLyEmqKXdZH9NwOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KtCaKHyM;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32769606D81E;
	Thu,  5 Nov 2026 12:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32769606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KtCaKHyM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793880879; x=1825416879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hNZG3p/TmBT75mwn4JDU6B5IEwPzDkrT+siPwGcILcw=;
  b=KtCaKHyMHxxht9DcYBJOaBrxoQ2w4pqfTvJ0n4e1LIgsQONR8E2mTAad
   4x5LkcUHtl/MH0qClFiVu6l4alj7X7tArZlo7MZXhsnktxhk4CjPG7hjO
   39eb2laydF4uCPMd+ZGeHUCXYLVK3XWNZYgXBQJYj5FaZO3yRxbwujkte
   jfb3Zhw/wVvXrgbfwgGxhhIBla75nyrhWS16DL4csPsobeG7naU9nl63n
   J10c6g+VbSmXL4KJpruQI5+cztiLLVyN554tjVxxnSLgVdWiRdn8rku4Y
   MMBeIyCdaaTJhrp783ahqjsFu7BE1uFh8Ais1kn6roistt1Wr0sUi7xEA
   A==;
X-CSE-ConnectionGUID: p0LUOfGiTRKShOMkA1Oo/A==
X-CSE-MsgGUID: tC/iXHxZRNS6I1xlBcTGiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2659729"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2659729"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 04:14:38 -0800
X-CSE-ConnectionGUID: n1CgJxqsSv2cC6PyZtAf1Q==
X-CSE-MsgGUID: PaUjo+ZjS1y3BQJZcClOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7401165"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Nov 2026 04:14:33 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOwMP-00000000mAX-3Cl8;
	Thu, 05 Nov 2026 12:14:29 +0000
Date: Thu, 5 Nov 2026 20:13:50 +0800
From: kernel test robot <lkp@intel.com>
To: Muchun Song <songmuchun@bytedance.com>,
	David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Message-ID: <202611052055.TcIXFI7V-lkp@intel.com>
References: <20261105061217.13302-3-songmuchun@bytedance.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105061217.13302-3-songmuchun@bytedance.com>

Hi Muchun,

kernel test robot noticed the following build errors:

[auto build test ERROR on dba8aba0a9a00ff781c03d82ae534fc6f8c2e263]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/powerpc-mm-make-vmemmap_populate_compound_pages-static/20261105-141213
base:   dba8aba0a9a00ff781c03d82ae534fc6f8c2e263
patch link:    https://lore.kernel.org/r/20261105061217.13302-3-songmuchun%40bytedance.com
patch subject: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261105/202611052055.TcIXFI7V-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052055.TcIXFI7V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052055.TcIXFI7V-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:31:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/loongarch/include/asm/pgtable.h:75:
   include/linux/vmemmap-optimization.h:62:9: error: call to undeclared function 'vmemmap_optimizable_order'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      62 |         return vmemmap_optimizable_order(section_compound_order(section));
         |                ^
>> include/linux/vmemmap-optimization.h:68:22: error: use of undeclared identifier 'vmemmap'; did you mean 'mem_map'?
      68 |         unsigned long pfn = page_to_pfn((struct page *)start);
         |                             ^
   include/asm-generic/memory_model.h:73:21: note: expanded from macro 'page_to_pfn'
      73 | #define page_to_pfn __page_to_pfn
         |                     ^
   include/asm-generic/memory_model.h:47:54: note: expanded from macro '__page_to_pfn'
      47 | #define __page_to_pfn(page)     (unsigned long)((page) - vmemmap)
         |                                                          ^
   include/linux/mmzone.h:1452:21: note: 'mem_map' declared here
    1452 | extern struct page *mem_map;
         |                     ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:31:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/loongarch/include/asm/pgtable.h:75:
   include/linux/vmemmap-optimization.h:138:20: error: conflicting types for 'vmemmap_optimizable_order'
     138 | static inline bool vmemmap_optimizable_order(unsigned int order)
         |                    ^
   include/linux/vmemmap-optimization.h:62:9: note: previous implicit declaration is here
      62 |         return vmemmap_optimizable_order(section_compound_order(section));
         |                ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/loongarch/kernel/asm-offsets.c:11:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];


vim +68 include/linux/vmemmap-optimization.h

    64	
    65	static inline void section_vmemmap_optimization_disable(unsigned long start,
    66			unsigned long end)
    67	{
  > 68		unsigned long pfn = page_to_pfn((struct page *)start);
    69		unsigned long nr_pages = (end - start) / sizeof(struct page);
    70		struct mem_section *section = __pfn_to_section(pfn);
    71	
    72		if (nr_pages < PAGES_PER_SECTION) {
    73			VM_WARN_ON_ONCE(section_vmemmap_optimizable(section));
    74			return;
    75		}
    76	
    77		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
    78		section_set_compound_order(section, 0);
    79	}
    80	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
