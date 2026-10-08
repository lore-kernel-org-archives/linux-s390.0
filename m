Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4826ED4F;
	Thu,  8 Oct 2026 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421943; cv=none; b=R/QS0+FL99xw8OB0bLHBfCCCrOQBPs+rKFGRsiDGZotJj+JZYVHCFD78/YIjRnRu14HMhzOMtXU1bk2jpacxF+0+WxwjexwFabNGbz4O205ZuHfhXaGgb3pTVHbASgI+flS/zmIMQz3lEW95OVAa84BxJW1r51RzkHm33FAEwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421943; c=relaxed/simple;
	bh=Z5ybaKWBPOL6QX0nuxqg9f/Zcrh90lwNVkVMjmF3vBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZbVCMMvNxuiWzGEA8YQCOSkktbvqekvTvkaAJOr4kEpTnJkhqctUYrdGbBkCqe5RSa6vC5ZKpeVPZQGVfvXgPqEJRe1Bs4ous2/fFReu9Z/wQtQ/2Ae0kXfGYdb0IMhyoQfwAQRYS7ijI49iVkJK6RuFZmLgG2N1glc2ba0LHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6CJgjHm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6CJgjHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791421943; x=1822957943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5ybaKWBPOL6QX0nuxqg9f/Zcrh90lwNVkVMjmF3vBo=;
  b=m6CJgjHmQSvI4440r4BmKqarYma1GWQdLPnYTWrCQTNJdl3mz0qKDXEj
   HXNBrBJu6rNWS9PVQATwr7168MzsP3X5e8gz0JdKIpt6P54my5ghLm69P
   8hHvJ6vWteLVFhtWOk/QwB4mCYGfoZXVgPDc9iPbeF8chidxFmsK49uiM
   fsvO+IccufskqdWpNeWd5d/dDBkP2SaEsY8Nh6ZcnCMWEjA7S4HkeVjjg
   LWu6QX8fMh6C87IX6NgTfPIQghtfk0QLl1M+WFaY7+yLwK9hJK/FF0Q55
   fWcQhkPa9t1Sb5tzABKTk0HvEnxvA6ohOrM4epMj50urZiX2xifzYQNkl
   A==;
X-CSE-ConnectionGUID: b/w2Q7xvThekawBSLIV+XQ==
X-CSE-MsgGUID: ugJ4uB+CSHq1kb7wPkALtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="83121"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="83121"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 18:12:22 -0700
X-CSE-ConnectionGUID: ZGn9PKkVQWa98h1ZNrPAwg==
X-CSE-MsgGUID: cqNaiWUXTz6lTxb/IDpp+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="285685618"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Oct 2026 18:12:18 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEcg9-000000003oW-3MzK;
	Thu, 08 Oct 2026 01:12:13 +0000
Date: Thu, 8 Oct 2026 09:11:19 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v8 14/15] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Message-ID: <202610080827.zfszZlVj-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.3-rc6]
[cannot apply to akpm-mm/mm-everything s390/features kvms390/next next-20261006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Gordeev/mm-introduce-hw_pte_t-for-PTE-table-storage/20261007-134144
base:   linus/master
patch link:    https://lore.kernel.org/r/e42d9f02ec1f8478a50fce424b95d0e7ff6a359f.1791365932.git.agordeev%40linux.ibm.com
patch subject: [PATCH v8 14/15] mm/kasan: Introduce helpers for lazy MMU mode sanitizer
config: mips-maltaup_xpa_defconfig (https://download.01.org/0day-ci/archive/20261008/202610080827.zfszZlVj-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261008/202610080827.zfszZlVj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610080827.zfszZlVj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/hardirq.h:17,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from arch/mips/include/asm/highmem.h:24,
                    from arch/mips/include/asm/pgtable-32.h:22,
                    from arch/mips/include/asm/pgtable.h:14,
                    from include/linux/pgtable.h:6,
                    from include/linux/kasan.h:9,
                    from include/linux/slab.h:276,
                    from include/linux/fs.h:45,
                    from include/linux/compat.h:17,
                    from arch/mips/kernel/asm-offsets.c:14:
   include/linux/irq.h: In function 'irq_free_generic_chip':
   include/linux/irq.h:1211:9: error: implicit declaration of function 'kfree' [-Wimplicit-function-declaration]
    1211 |         kfree(gc);
         |         ^~~~~
   include/linux/slab.h: At top level:
>> include/linux/slab.h:595:6: warning: conflicting types for 'kfree'; have 'void(const void *)'
     595 | void kfree(const void *objp);
         |      ^~~~~
   include/linux/irq.h:1211:9: note: previous implicit declaration of 'kfree' with type 'void(const void *)'
    1211 |         kfree(gc);
         |         ^~~~~
   make[3]: *** [scripts/Makefile.build:185: arch/mips/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1425: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +595 include/linux/slab.h

7bd230a26648ac Suren Baghdasaryan 2024-03-21  594  
72d67229f522e3 Kees Cook          2021-11-05 @595  void kfree(const void *objp);
af92793e52c3a9 Alexei Starovoitov 2025-09-08  596  void kfree_nolock(const void *objp);
72d67229f522e3 Kees Cook          2021-11-05  597  void kfree_sensitive(const void *objp);
05a940656e1eb2 Kees Cook          2022-09-23  598  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
