Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568F2C026C;
	Wed,  7 Oct 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404662; cv=none; b=GQm3cDYTaEYpv8M5y+/ET4XsBn3ngnOv7mLzgRs7KlB9UILvmeqR+V3KvmMP4ktQ9UKpPc4LpP5sKesaoDQtatLkfcs/ghXWWiz+/lY5XSxX12WyWcEyekoqsy+FhG1NNAnufKUaqXgk+cOTu24cD8EYongefWFSsBVHk3BIxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404662; c=relaxed/simple;
	bh=N9l9ulXCPIg0gc7OkBVvGgXXOJRlDx+6Pbz/KdymAdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxypsSTGLtjqQ1bIaftRdWhMwWRgV4b6S7pp8LgTnPMvNKE8C8MjFSt6HXBvKFjYRkeu9Rr5Dtl24ijyZ1HYarG/P7ujVYDW4XTREJX+m1lEbnRKcoYC/MlIMGKYsA9Fy6YBIfd/20OdEUhnHxqflNB47DZ9cXnJb4dfm6WZTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHOoH7+4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHOoH7+4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791404661; x=1822940661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N9l9ulXCPIg0gc7OkBVvGgXXOJRlDx+6Pbz/KdymAdM=;
  b=SHOoH7+4VQydMN8Vyb6BxbUZ0Df462MwBNM14q3eo0WcXbsEi6XwkKNG
   PoezOQr4IhiigztkDhq1B0aGTLIORR9UHliYN4sjVkLRuka0bL/oCiKIP
   y0wLghqNBzZ3K1YOfOCw3OG3cgd9zpNJzisVTquctv5eUTXBjSeF3IYKB
   b99CzuS1X1A8BAQ4owjD5X6XW1Rq87HAt7JGksYQWBvQcRTQZ8kaCtTUt
   SXSHchELN86lXZWBNjV3G/8WUGQQDR+g4Wz74T31eO2/GqQkvM89qODoa
   ZLtYw4YflN9EKv500/SYJrHFkYf3jE0A+mFVYMH85X1dFpmNjxpc0a8Nw
   Q==;
X-CSE-ConnectionGUID: qs1REJaDQWy3ntXWxCfuxw==
X-CSE-MsgGUID: oGrJzRbSQMme3E42xO0jiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="63066"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="63066"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 13:24:21 -0700
X-CSE-ConnectionGUID: WcP3pJg/QSGJ+Mlx0LNeSA==
X-CSE-MsgGUID: bqLGbVI7S1mkD+FD7SJiBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="315569616"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Oct 2026 13:24:18 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEYBS-000000003VM-41fP;
	Wed, 07 Oct 2026 20:24:14 +0000
Date: Thu, 8 Oct 2026 04:24:14 +0800
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
Message-ID: <202610080445.ZlyXFoBC-lkp@intel.com>
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
config: mips-bmips_stb_defconfig (https://download.01.org/0day-ci/archive/20261008/202610080445.ZlyXFoBC-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610080445.ZlyXFoBC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610080445.ZlyXFoBC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:14:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:45:
   In file included from include/linux/slab.h:276:
   In file included from include/linux/kasan.h:9:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/mips/include/asm/pgtable.h:14:
   In file included from arch/mips/include/asm/pgtable-32.h:22:
   In file included from arch/mips/include/asm/highmem.h:24:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/mips/include/asm/hardirq.h:16:
   In file included from include/asm-generic/hardirq.h:17:
   include/linux/irq.h:1211:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1211 |         kfree(gc);
         |         ^
   In file included from arch/mips/kernel/asm-offsets.c:14:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:45:
>> include/linux/slab.h:595:6: error: conflicting types for 'kfree'
     595 | void kfree(const void *objp);
         |      ^
   include/linux/irq.h:1211:2: note: previous implicit declaration is here
    1211 |         kfree(gc);
         |         ^
   In file included from arch/mips/kernel/asm-offsets.c:26:
   In file included from include/linux/kvm_host.h:5:
   In file included from include/linux/entry-virt.h:7:
   In file included from include/linux/syscalls.h:95:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:6:
   include/linux/poll.h:134:27: warning: division by zero is undefined [-Wdivision-by-zero]
     134 |                 M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
         |                                         ^~~~~~~~~
   include/linux/poll.h:132:32: note: expanded from macro 'M'
     132 | #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:118:51: note: expanded from macro '__MAP'
     118 |         (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
         |                                                          ^ ~~~~~~~~~
   include/linux/poll.h:134:39: warning: division by zero is undefined [-Wdivision-by-zero]
     134 |                 M(RDNORM) | M(RDBAND) | M(WRNORM) | M(WRBAND) |
         |                                                     ^~~~~~~~~
   include/linux/poll.h:132:32: note: expanded from macro 'M'
     132 | #define M(X) (__force __poll_t)__MAP(val, POLL##X, (__force __u16)EPOLL##X)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/poll.h:118:51: note: expanded from macro '__MAP'
     118 |         (from < to ? (v & from) * (to/from) : (v & from) / (from/to))
         |                                                          ^ ~~~~~~~~~
   2 warnings and 2 errors generated.
   make[3]: *** [scripts/Makefile.build:185: arch/mips/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1425: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/kfree +595 include/linux/slab.h

7bd230a26648ac Suren Baghdasaryan 2024-03-21  594  
72d67229f522e3 Kees Cook          2021-11-05 @595  void kfree(const void *objp);
af92793e52c3a9 Alexei Starovoitov 2025-09-08  596  void kfree_nolock(const void *objp);
72d67229f522e3 Kees Cook          2021-11-05  597  void kfree_sensitive(const void *objp);
05a940656e1eb2 Kees Cook          2022-09-23  598  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
