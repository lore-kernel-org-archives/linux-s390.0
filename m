Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095795;
	b=U9cbis4Y1MT1XTczdSgQkNC48cDh/F7vZPaDIEwfdSRMaMTlfQmtK4LxHf4jACH1q62e
	 B6Bbaky/h+4w9yesZfjP3mof8XuuCCjSCoIRsfEO06cNuCMHSwFmBSGlScTt0LBuaubDk
	 d4rsHXAblAyLxHdsrHxCbhVJO0qpa3FnppX+ebBCt7ZetjwNNYeArs2HvBi/Iu0n43Ds4
	 /VtKmmMOY9LKJHL4jTSKuLA5xHcYkDmCEyU/xFvIjKUdmSGKbotG2klpvpgB20qQoqsWz
	 hith5O0Ea/6BBuF3qVT/PZXkVtFQIWpwZWQ50WRaU9P4SZhuyD30N0ZhtVxfvdgoXxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095795;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=t4Wp2CERSkPQBs1N7oEfOmaN2478PDOfPQaW5G48NZQ=;
	b=tacEA1/1shnPS6A5mHS98xA9PQpKTvHETtMJojv44AqbrQmODDCGHS+wUEIj/DqkXiEV
	 bCsZqlpIwiAQhyvGGEDP7EGAiE39QybuXavzdNCSfGEd4PN/7kCDyn40kH3KPOlTj5njs
	 IVIKoL1EQhda44gE8tA5GQSh8v502jpR9kW+VgMAe5RtOduiieJzNRQqDqjAuYev8wUEs
	 iqlp56IJZAz5tcfKC+Q27cl/e1IEZs8UNG/PGw8fq6+oGLzAcfIJkJ/B67b1FQWnaZzld
	 NinYZUnlPtRzqCho8M3l27CwjTPHc5S7Udu2UqsdHJgKo5tWM038jMmryS2AXP9DcOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HsJnotKe;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016C606A324;
	Tue, 27 Oct 2026 10:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9016C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HsJnotKe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793095795; x=1824631795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UKqMYXXut2lTCf7jDkoq6hLEMqqdc/pViH8/r8Z+g3o=;
  b=HsJnotKeHEdVVspUT9kK1CoJ281g8nLuec5fXjo/lqlhL/t/b5Bm4Zf7
   MtAOCle1QKCnumjyyO78uxKJ+KJxEwkjpLny7sn98wCCg/znrfy0ZuDGq
   yJhL/IfiNrjz1yCtep0JHxSkKlJtXkZUFvcq8mNHJ2QZIsUMSlt+rXX73
   LwEoNnSgJkvJ5vnwNuSiheKRmN74yOeLzIJBIniELBPWtmE0GBhpWk0yg
   3KJR6ECotOACmp1mFGx53HKZbMC6SQp6sZZxnvO/XRDH2dLZE08QETwvc
   qp+hAPIsCmGsPDiOwoa1OKS7TxrdaK1NVBZFEC64ZEgGn9/HAXdYQG8yE
   w==;
X-CSE-ConnectionGUID: ooVzE7seRrWwc+zK1NKFsw==
X-CSE-MsgGUID: uBEsBs5nRWWxre68ferxtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1681721"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1681721"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:09:53 -0700
X-CSE-ConnectionGUID: w5fNWj53TOS5CF+PkzH8Zw==
X-CSE-MsgGUID: Q3Xepr0XT/CcYXWypqkakQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4898248"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Oct 2026 03:09:50 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xLe7n-00000000X6M-2UQP;
	Tue, 27 Oct 2026 10:09:47 +0000
Date: Tue, 27 Oct 2026 18:09:20 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] s390/maccess: Remove spinlock from
 __s390_kernel_write()
Message-ID: <202610271855.Il2BMBvq-lkp@intel.com>
References: <20261026120329.1792436-5-hca@linux.ibm.com>
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
In-Reply-To: <20261026120329.1792436-5-hca@linux.ibm.com>

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on trace/for-next bpf-next/master bpf/master linus/master v7.3 next-20261026]
[cannot apply to bpf-next/net]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Carstens/s390-jump_label-Serialize-text-patching-with-text_mutex/20261026-130326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20261026120329.1792436-5-hca%40linux.ibm.com
patch subject: [PATCH 4/4] s390/maccess: Remove spinlock from __s390_kernel_write()
config: s390-defconfig (https://download.01.org/0day-ci/archive/20261027/202610271855.Il2BMBvq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261027/202610271855.Il2BMBvq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610271855.Il2BMBvq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/mm/maccess.c:9:
>> include/linux/text-patching.h:10:9: error: call to undeclared library function 'memcpy' with type 'void *(void *, const void *, unsigned long)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      10 |         return memcpy(dst, src, len);
         |                ^
   include/linux/text-patching.h:10:9: note: include the header <string.h> or explicitly provide a declaration for 'memcpy'
   In file included from arch/s390/mm/maccess.c:15:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/mm/maccess.c:15:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/mm/maccess.c:15:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/mm/maccess.c:15:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/mm/maccess.c:15:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:20:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:36:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:7:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/mm/maccess.c:15:
   In file included from include/linux/cpu.h:17:


vim +10 include/linux/text-patching.h

0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23   6) 
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23   7) #ifndef text_poke_copy
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23   8) static inline void *text_poke_copy(void *dst, const void *src, size_t len)
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23   9) {
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23 @10) 	return memcpy(dst, src, len);
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23  11) }
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23  12) #define text_poke_copy text_poke_copy
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23  13) #endif
0c3beacf681ec89 Mike Rapoport (Microsoft  2024-10-23  14) 

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
