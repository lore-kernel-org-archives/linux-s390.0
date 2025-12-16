Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519130FF3A;
	Tue, 16 Dec 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902733; cv=none; b=KN7/x3swUNbGI/Ylg9h3rWWnvxK544X9NqvK80OW+80p2t2j6/KQojpZ1EWVAjUyd+hZ/K2tDEr24R2J3HlRifYQDmsXqZtDBV5N6jFHlwo3flCtdCe4xpNyGEM09uxyyNwUow+Up0tEhmJ1rVKuu1Rm8eRqdo7RGq6z/TNiB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902733; c=relaxed/simple;
	bh=BYYyvPXCv/z3Zv/yIQlMx58UIuXYnnZWL+o4/ZYGJM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDLqoycV056I55f/H0P3WnmOROeXVqBWJrx1+RjmrEy09m4kq9NA7XZirmHiOPaC+/1Hvp/VmTuvZ/MsMo0TsuEJSbVm98iqwKvmhYE9um4q/kNoBswhJGGJaMysWRUkxFbPYnU36xl6ENJokQ80fkK7JOANdpAoW3M3szVzsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSYQJK1C; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSYQJK1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765902730; x=1797438730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BYYyvPXCv/z3Zv/yIQlMx58UIuXYnnZWL+o4/ZYGJM8=;
  b=TSYQJK1CzK13r7rV90cwDC0V70BYOOCk1VzxuCnFScHajQ/nWTlmY9ix
   0mdOjbQ+519XvKbZCqxuJ8lL5HWDzjbKxWhZNdfpRFLG2sLZxeyHz8CjY
   0FJeWrqXvtRU/U23XvmecnOrP0qHHceaQoYbBESrUOi69Ro6SZsikoLgY
   ML+uJWJBUfFYd2fd85Dzuz2jrSYctftjWQUt4UvTT0rTdTodEKDgSXWni
   4QvDVtEu0zL2Oi6iEJ3fMA4SJW847VJ5ml67lv9puOwoJJ/3kYJWiG18L
   xxLon1x2amc19Sl3eqVz+wiL3Lhpqu09MiX2WCCQDi8hbNj4g1s5ueKXe
   w==;
X-CSE-ConnectionGUID: cGDTdSJ3SBWn4qil73vDMg==
X-CSE-MsgGUID: x9NJ0GbIRn+AVenpLZQWqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="67868235"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="67868235"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 08:32:07 -0800
X-CSE-ConnectionGUID: hOe0vqPVR7CciV+fTWvORw==
X-CSE-MsgGUID: v02B96M3SIa8VhPps1uokQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="197808734"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 16 Dec 2025 08:32:00 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVXxu-000000003YO-0J5B;
	Tue, 16 Dec 2025 16:31:58 +0000
Date: Wed, 17 Dec 2025 00:31:27 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 3/3] randomize_kstack: Unify random source across
 arches
Message-ID: <202512170038.vJZdUhEN-lkp@intel.com>
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
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20251217/202512170038.vJZdUhEN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251217/202512170038.vJZdUhEN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512170038.vJZdUhEN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> arch/x86/boot/startup/sev-startup.o: warning: objtool: section .discard.addressable has absolute relocation at offset 0x0
--
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/blk_types.h:11,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:23,
                    from include/linux/resume_user_mode.h:8,
                    from include/linux/entry-virt.h:6,
                    from include/linux/kvm_host.h:5,
                    from arch/x86/kvm/svm/svm.c:3:
>> include/linux/module.h:132:49: error: redefinition of '__inittest'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   arch/x86/kvm/svm/svm.c:5509:1: note: in expansion of macro 'module_init'
    5509 | module_init(svm_init)
         | ^~~~~~~~~~~
   include/linux/module.h:132:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:125:41: note: in expansion of macro 'module_init'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   include/linux/randomize_kstack.h:86:1: note: in expansion of macro 'late_initcall'
      86 | late_initcall(random_kstack_init);
         | ^~~~~~~~~~~~~
>> include/linux/module.h:134:13: error: redefinition of 'init_module'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   arch/x86/kvm/svm/svm.c:5509:1: note: in expansion of macro 'module_init'
    5509 | module_init(svm_init)
         | ^~~~~~~~~~~
   include/linux/module.h:134:13: note: previous definition of 'init_module' with type 'int(void)'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/module.h:125:41: note: in expansion of macro 'module_init'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   include/linux/randomize_kstack.h:86:1: note: in expansion of macro 'late_initcall'
      86 | late_initcall(random_kstack_init);
         | ^~~~~~~~~~~~~
--
   ld: arch/x86/kvm/vmx/main.o: in function `vt_init':
>> arch/x86/kvm/vmx/main.c:1038: multiple definition of `init_module'; arch/x86/kvm/vmx/vmx.o:include/linux/randomize_kstack.h:81: first defined here
--
   In file included from drivers/misc/sgi-xp/xpc_main.c:47:
>> include/linux/module.h:132:49: error: redefinition of '__inittest'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   drivers/misc/sgi-xp/xpc_main.c:1285:1: note: in expansion of macro 'module_init'
    1285 | module_init(xpc_init);
         | ^~~~~~~~~~~
   include/linux/module.h:132:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     132 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:125:41: note: in expansion of macro 'module_init'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   include/linux/randomize_kstack.h:86:1: note: in expansion of macro 'late_initcall'
      86 | late_initcall(random_kstack_init);
         | ^~~~~~~~~~~~~
>> include/linux/module.h:134:13: error: redefinition of 'init_module'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   drivers/misc/sgi-xp/xpc_main.c:1285:1: note: in expansion of macro 'module_init'
    1285 | module_init(xpc_init);
         | ^~~~~~~~~~~
   include/linux/module.h:134:13: note: previous definition of 'init_module' with type 'int(void)'
     134 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/module.h:125:41: note: in expansion of macro 'module_init'
     125 | #define late_initcall(fn)               module_init(fn)
         |                                         ^~~~~~~~~~~
   include/linux/randomize_kstack.h:86:1: note: in expansion of macro 'late_initcall'
      86 | late_initcall(random_kstack_init);
         | ^~~~~~~~~~~~~


vim +1038 arch/x86/kvm/vmx/main.c

d6bee7813752b3 Kai Huang 2025-01-22  1036  
d6bee7813752b3 Kai Huang 2025-01-22  1037  static int __init vt_init(void)
d6bee7813752b3 Kai Huang 2025-01-22 @1038  {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
