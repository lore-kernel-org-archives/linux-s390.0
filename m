Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D81E3761;
	Sat,  1 Mar 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740854997; cv=none; b=krL81p9d5RrqmXiUCL5lpXle2Ijdm+bmVo1MhtBECtU/QU+bLEIy+ANFbvGBUTc4NbMpxQzAIf0GG1f2OvogLY3n/2rNKQu9485aW9NDiCuWtRE15MuBOUovMms03P8BRA4nXpSdBsHFxjDpUw2+WcMOPgVPeH9k36iVYGzqLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740854997; c=relaxed/simple;
	bh=D6LK3deQZfKTTW6uwky3ge1mwOLyc/TdhQi0WSPhGbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbsqGRvB9Pmm+YKiGlciW7zgh+EtK4xx0eVTH9PNw2UVLN2HFriV3FZc+NDYFFjQXQ07poix5rTr5xvxG3bKWOSq6oabJ/Qj8lmoD8EmU5S5DsRRJx6f/f0Pnm/GByKvtZi1STUFc1+3HeGkmGNRttk4Y30CBEOEr6Xfaflu0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQ4nOWu7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQ4nOWu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740854997; x=1772390997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6LK3deQZfKTTW6uwky3ge1mwOLyc/TdhQi0WSPhGbU=;
  b=nQ4nOWu7QUs1M8FeIfDaMwY4BvlWIYecyCQ+XNdQ0fM3Coh195b4XDSv
   OI51O/cXiQzAwfkFI+z+WWbn0yBUvpMNvwVIM6NYMLR07QOuchgquOpG5
   jo/Op18IGsFq/oADXQCRIGqsd3zVOZgoJ8KMFE81z1OXLFCqIXODKvmyf
   PN1FaxRuKXFlbYNoNDS+AzUiSc/Xd4dJ1OICVoZSwHZWIWaA96zZ47ORj
   OHc60E49kCPSAas1RR0ctWlL2nsny+ePVALDeOgQnL0+iHiW9BSnUpbmt
   oN5QCS8pM9d2KrnF5LMljfGsthFUnj3qM/wkH1Ba1LOCaZa7L1eymB4sX
   w==;
X-CSE-ConnectionGUID: 2GJ7H/ufRlG90zGbo5CS2w==
X-CSE-MsgGUID: +3aTqtm+QVy2GFK6x/Fw3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="45416201"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45416201"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 10:49:56 -0800
X-CSE-ConnectionGUID: 0kPiMjFwTXa5X7KYVNjm2A==
X-CSE-MsgGUID: 8TbL827kQYuxjwBtg5CFGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122762860"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2025 10:49:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toRuG-000GaI-1E;
	Sat, 01 Mar 2025 18:49:48 +0000
Date: Sun, 2 Mar 2025 02:49:37 +0800
From: kernel test robot <lkp@intel.com>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"(maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"(moderated list:ARM64 PORT (AARCH64 ARCHITECTURE))" <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v9 2/9] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <202503020258.CSGrY5E6-lkp@intel.com>
References: <20250227221924.265259-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227221924.265259-3-lyude@redhat.com>

Hi Lyude,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyude-Paul/preempt-Introduce-HARDIRQ_DISABLE_BITS/20250228-062508
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250227221924.265259-3-lyude%40redhat.com
patch subject: [PATCH v9 2/9] preempt: Introduce __preempt_count_{sub, add}_return()
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250302/202503020258.CSGrY5E6-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020258.CSGrY5E6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020258.CSGrY5E6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:85:
>> arch/s390/include/asm/preempt.h:109:15: error: invalid operands to binary expression ('int' and 'void')
     109 |                         return val + __atomic_add_const(val, &get_lowcore()->preempt_count);
         |                                ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:116:5: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     116 |                         (set1->sig[1] == set2->sig[1]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:116:21: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     116 |                         (set1->sig[1] == set2->sig[1]) &&
         |                                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:119:11: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     119 |                 return  (set1->sig[1] == set2->sig[1]) &&
         |                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:
   include/linux/signal.h:119:27: warning: array index 1 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     119 |                 return  (set1->sig[1] == set2->sig[1]) &&
         |                                          ^         ~
   arch/s390/include/asm/signal.h:22:9: note: array 'sig' declared here
      22 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:11:


vim +109 arch/s390/include/asm/preempt.h

   100	
   101	static __always_inline int __preempt_count_add_return(int val)
   102	{
   103		/*
   104		 * With some obscure config options and CONFIG_PROFILE_ALL_BRANCHES
   105		 * enabled, gcc 12 fails to handle __builtin_constant_p().
   106		 */
   107		if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES)) {
   108			if (__builtin_constant_p(val) && (val >= -128) && (val <= 127)) {
 > 109				return val + __atomic_add_const(val, &get_lowcore()->preempt_count);
   110			}
   111		}
   112		return val + __atomic_add(val, &get_lowcore()->preempt_count);
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
