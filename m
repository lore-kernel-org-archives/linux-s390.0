Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531F366DD3;
	Tue, 16 Dec 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898897; cv=none; b=PnyRyhDJKUqmpCitZAOjRcUu8S+nAyuZNJbegngFmY7aB1kHouuc2nMuvkkSCYwWofmd5P9564RbXYa6Lxxg82/wfv784xMBkD05MexJyPhUGMvK2N5nC6TkxnSmvz6/Q+dc/npSeqD4zwziRg00KP+2OJBTCM9Wj4hu1MMiCNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898897; c=relaxed/simple;
	bh=sD65R5UGhCtay10P/5W+7TM+UmAjlbjVbXwRe2em6yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAdCwvg5BI+HCAJW75v8PVq1ZIWs9EGYu2FQFwn4/EUBL1+5FhmMcN6AgTUuwCMrTJ0DdRFkFQa3b+KNSAUfxxgNUVsX1JqzP/BFWlNmwhTs9AyXiXpLjNnIe2/33hxy4AZANZzb76KDapqkwbCOEM3wWfgIew3sIu2vW9s3jZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mD9XwJ3L; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mD9XwJ3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765898896; x=1797434896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sD65R5UGhCtay10P/5W+7TM+UmAjlbjVbXwRe2em6yA=;
  b=mD9XwJ3Lj01xTNoXj9cQpEmoILV6uN5IVsDZ9H8/DuoaYVgrTIO8qVJt
   ngZUt5SxDHlXR6Rx3LtKPfDqQFZ0+bCLCfRgyZQlOLLyoBQZ0cJuFvpB2
   t4H9aspp7UnO7b7qTnOQerWA0BVpabnR8s/BhkNowD5AJEGx4LAbdTjY3
   Y+aaVsRNgc2dbeoj3QUlj9xa7EWzWgIpuMqoxLRUOohl8bfSuyy6cfRZS
   0cPKPg/pk0g+C2MyHa0Vcu00/zSAGilLdIsVMGpIOY1RWSXZ9HBF7le9O
   S/6wWbs/BPdJQfNwNPMhhbM9DTK+VTXfohGJSlawz8jMKSOhLVAX1hqnK
   w==;
X-CSE-ConnectionGUID: vYP8RkaiT6yEjFn657MCPg==
X-CSE-MsgGUID: Zqd02a0tT76qKnai4hT0hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="79187679"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="79187679"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 07:28:15 -0800
X-CSE-ConnectionGUID: 2xFsI/dBQXKE8DWUTEVNrg==
X-CSE-MsgGUID: HIgAl8RFQHWXgAdjx3aUnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="202458915"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 16 Dec 2025 07:28:08 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVWy6-000000003RG-37cv;
	Tue, 16 Dec 2025 15:28:06 +0000
Date: Tue, 16 Dec 2025 23:27:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <202512162320.WFgo042e-lkp@intel.com>
References: <20251215163520.1144179-4-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215163520.1144179-4-ryan.roberts@arm.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on akpm-mm/mm-everything linus/master v6.19-rc1 next-20251216]
[cannot apply to kees/for-next/hardening kees/for-next/execve]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/prandom-Convert-prandom_u32_state-to-__always_inline/20251216-013546
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20251215163520.1144179-4-ryan.roberts%40arm.com
patch subject: [PATCH v2 3/3] randomize_kstack: Unify random source across arches
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20251216/202512162320.WFgo042e-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251216/202512162320.WFgo042e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512162320.WFgo042e-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kvm/svm/svm.c:5509:1: error: redefinition of '__inittest'
    5509 | module_init(svm_init)
         | ^
   include/linux/module.h:132:42: note: expanded from macro 'module_init'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
   include/linux/randomize_kstack.h:86:1: note: previous definition is here
      86 | late_initcall(random_kstack_init);
         | ^
   include/linux/module.h:125:28: note: expanded from macro 'late_initcall'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^
   include/linux/module.h:132:42: note: expanded from macro 'module_init'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
>> arch/x86/kvm/svm/svm.c:5509:1: error: redefinition of 'init_module'
    5509 | module_init(svm_init)
         | ^
   include/linux/module.h:134:6: note: expanded from macro 'module_init'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^
   include/linux/randomize_kstack.h:86:1: note: previous definition is here
      86 | late_initcall(random_kstack_init);
         | ^
   include/linux/module.h:125:28: note: expanded from macro 'late_initcall'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^
   include/linux/module.h:134:6: note: expanded from macro 'module_init'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^
   2 errors generated.
--
>> drivers/misc/sgi-xp/xpc_main.c:1285:1: error: redefinition of '__inittest'
    1285 | module_init(xpc_init);
         | ^
   include/linux/module.h:132:42: note: expanded from macro 'module_init'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
   include/linux/randomize_kstack.h:86:1: note: previous definition is here
      86 | late_initcall(random_kstack_init);
         | ^
   include/linux/module.h:125:28: note: expanded from macro 'late_initcall'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^
   include/linux/module.h:132:42: note: expanded from macro 'module_init'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
>> drivers/misc/sgi-xp/xpc_main.c:1285:1: error: redefinition of 'init_module'
    1285 | module_init(xpc_init);
         | ^
   include/linux/module.h:134:6: note: expanded from macro 'module_init'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^
   include/linux/randomize_kstack.h:86:1: note: previous definition is here
      86 | late_initcall(random_kstack_init);
         | ^
   include/linux/module.h:125:28: note: expanded from macro 'late_initcall'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^
   include/linux/module.h:134:6: note: expanded from macro 'module_init'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^
   2 errors generated.


vim +/__inittest +5509 arch/x86/kvm/svm/svm.c

6aa8b732ca01c3d drivers/kvm/svm.c Avi Kivity 2006-12-10  5508  
6aa8b732ca01c3d drivers/kvm/svm.c Avi Kivity 2006-12-10 @5509  module_init(svm_init)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
