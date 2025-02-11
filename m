Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDF1F03D2;
	Tue, 11 Feb 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264867; cv=none; b=VwCcxqVOR5+zfaGB4Hsb18GPOYuYe4f+MxjPQHgo2XLUcDA2Wz+Kf/6kB7xGn3v8fp426g9ln6qoGHF7GvpgfULaCm09EOK2+acBbcBTNQLdB86uyk/cqnRGPouC5/I2Zdi20q+PFVA3askvBchf+/zj7stMSgUvFc/jsyrQC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264867; c=relaxed/simple;
	bh=hFx79QumT2efvDIu9SQG+KhJyUcuw+IZ0OY2d/uT+og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8KLf8G0DcSbkJ8kxhlabyRaRpX/43uIvTlnybzTN7xJeeC4dDRYdbZLRHjoVEeIyipdtoiz217oS1MomEcl11l1UKJum5XktG1SEOxuFXUVt9ycltXIzhjz6z49vtkJDDyt1HuaPHTzpi+LHolrh+MIQrR2MriWBqVoVeF2x3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5xgcR2j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5xgcR2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739264866; x=1770800866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hFx79QumT2efvDIu9SQG+KhJyUcuw+IZ0OY2d/uT+og=;
  b=X5xgcR2jSLNt89s/67ieR8yzJN1T+7/bPWJsXx7aT4thNw9Fkgs2nVaI
   f0hdP9qApM+UReHx07eahi+LNSLiBLG9h65aZyBciNU4I8McMXhTbZ1jC
   cSkq479Gp4tE+GDcnnI/qEgT5tQUZUCt1/9GVkE7nK0BIJzespdvRTcPq
   nmkoSv7glLVxBOz4dFhwCnblxXstMYSXdY+MF52dE69sueEVyF2N7J+ms
   IRooQLEpjnXK01Q9u5YXSEOU00vL41invI6ZNRUDgaSYPCMmBcArowMUg
   DVVq4MAcRikY+VTimfbaNUBjydXBTDujjobn/fQi3hnEKnahqEoEZeKBF
   g==;
X-CSE-ConnectionGUID: KQQKYG4EThSTzOgzXc34gg==
X-CSE-MsgGUID: 8qxQp64eReOzFlXWRcAkug==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39758893"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39758893"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:07:45 -0800
X-CSE-ConnectionGUID: Wlse3+4DSkGTXxDkvf01tQ==
X-CSE-MsgGUID: nbHe+6jIRwa8BdCdBKGWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135702696"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Feb 2025 01:07:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thmF2-0013wj-0a;
	Tue, 11 Feb 2025 09:07:40 +0000
Date: Tue, 11 Feb 2025 17:07:13 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] arm64: scripts/sorttable: Implement sorting mcount_loc
 at boot for arm64
Message-ID: <202502111626.K7CTghCR-lkp@intel.com>
References: <20250210142647.083ff456@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210142647.083ff456@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc2 next-20250210]
[cannot apply to arm64/for-next/core arm-perf/for-next/perf kvmarm/next soc/for-next arm/for-next arm/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/arm64-scripts-sorttable-Implement-sorting-mcount_loc-at-boot-for-arm64/20250211-032956
base:   linus/master
patch link:    https://lore.kernel.org/r/20250210142647.083ff456%40gandalf.local.home
patch subject: [PATCH] arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64
config: riscv-randconfig-001-20250211 (https://download.01.org/0day-ci/archive/20250211/202502111626.K7CTghCR-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250211/202502111626.K7CTghCR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502111626.K7CTghCR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/sorttable.c:306:13: warning: 'rela_write_addend' defined but not used [-Wunused-function]
     306 | static void rela_write_addend(Elf_Rela *rela, uint64_t val)
         |             ^~~~~~~~~~~~~~~~~
>> scripts/sorttable.c:287:17: warning: 'rela_addend' defined but not used [-Wunused-function]
     287 | static uint64_t rela_##fn_name(Elf_Rela *rela)          \
         |                 ^~~~~
   scripts/sorttable.c:294:1: note: in expansion of macro 'RELA_ADDR'
     294 | RELA_ADDR(addend)
         | ^~~~~~~~~
>> scripts/sorttable.c:287:17: warning: 'rela_info' defined but not used [-Wunused-function]
     287 | static uint64_t rela_##fn_name(Elf_Rela *rela)          \
         |                 ^~~~~
   scripts/sorttable.c:293:1: note: in expansion of macro 'RELA_ADDR'
     293 | RELA_ADDR(info)
         | ^~~~~~~~~
>> scripts/sorttable.c:287:17: warning: 'rela_offset' defined but not used [-Wunused-function]
     287 | static uint64_t rela_##fn_name(Elf_Rela *rela)          \
         |                 ^~~~~
   scripts/sorttable.c:292:1: note: in expansion of macro 'RELA_ADDR'
     292 | RELA_ADDR(offset)
         | ^~~~~~~~~
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   include/linux/ftrace.h: In function 'ftrace_get_regs':
   include/linux/ftrace.h:190:16: error: implicit declaration of function 'arch_ftrace_get_regs'; did you mean 'arch_ftrace_regs'? [-Wimplicit-function-declaration]
     190 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                arch_ftrace_regs
   include/linux/ftrace.h:190:16: error: returning 'int' from a function with return type 'struct pt_regs *' makes pointer from integer without a cast [-Wint-conversion]
     190 |         return arch_ftrace_get_regs(fregs);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/riscv/kernel/asm-offsets.s] Error 1 shuffle=1925395641
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=1925395641
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=1925395641
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=1925395641
   make: Target 'prepare' not remade because of errors.


vim +/rela_write_addend +306 scripts/sorttable.c

   275	
   276	#define RELA_ADDR(fn_name)				\
   277	static uint64_t rela64_##fn_name(Elf_Rela *rela)	\
   278	{							\
   279		return r8((uint64_t *)&rela->e64.r_##fn_name);	\
   280	}							\
   281								\
   282	static uint64_t rela32_##fn_name(Elf_Rela *rela)	\
   283	{							\
   284		return r((uint32_t *)&rela->e32.r_##fn_name);	\
   285	}							\
   286								\
 > 287	static uint64_t rela_##fn_name(Elf_Rela *rela)		\
   288	{							\
   289		return e.rela_##fn_name(rela);			\
   290	}
   291	
   292	RELA_ADDR(offset)
   293	RELA_ADDR(info)
   294	RELA_ADDR(addend)
   295	
   296	static void rela64_write_addend(Elf_Rela *rela, uint64_t val)
   297	{
   298		w8(val, (uint64_t *)&rela->e64.r_addend);
   299	}
   300	
   301	static void rela32_write_addend(Elf_Rela *rela, uint64_t val)
   302	{
   303		w(val, (uint32_t *)&rela->e32.r_addend);
   304	}
   305	
 > 306	static void rela_write_addend(Elf_Rela *rela, uint64_t val)
   307	{
   308		e.rela_write_addend(rela, val);
   309	}
   310	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
