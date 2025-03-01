Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634419993D;
	Sat,  1 Mar 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740855722; cv=none; b=sMZ4dPscbqvOMM4EY3jmMGOnNuC7BAozIZ7RhaRU4vXD6/yGqxnQ+uqn9PnYujh+5wfZKHawfxWJrX3Xi4ufbF2wu7jv8zOfWODSxd/kTIldbifKVzqib/ZSUJQHq+j46F6lpIqbmfqehCKPPxQB7rzMQkaZcKSik6yDqahqIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740855722; c=relaxed/simple;
	bh=lMXy4Mm5N4WPWxUEKOlhMHEGyxhNvffspeCsLxw9/Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZJmeEmAubjErrjywucxb+dcRwzTPNvKZrKtK4KQMdPFSzJk5pggAJ+auFcmvdV0sz2tZN3e+HMlyL6EcrUMnp9lDNTVceklILVnvHglgRHc0VwZPpYKbENyQHVc1N5lazGwcn5Ii2m5zGyy10IaUA7wQ6QJ28m3HPXrR4WXlOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJn5bWUI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJn5bWUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740855720; x=1772391720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lMXy4Mm5N4WPWxUEKOlhMHEGyxhNvffspeCsLxw9/Ns=;
  b=HJn5bWUIaY8A9BFxaX4bxP9u9rMVbTEWuauV9Esfw+vwsBJNYYlCfpwi
   LgRzZiJ6LHie6ZrtFnog73v6Bc+DbQda26cjtgREqa7AS6HnHLWd3+Puo
   f8Af7wSYYBKjDXsARD8ddmSHLMH10ZPtoct3l0ei98zRPno2GDSmsnQLu
   eqFmy9j5SYhXcSgBS/yB0AluseXde9EXOnpYsaoJhGz+OUv57pEYFf43p
   fSCRVodqEdPXiBdsJJ2R4HaH5cCmZwjRXGmK3D07L1sOt+dr3HVCrlQy1
   viXFHbcJ4SGAkhtSfJlktJrWDOvWTcGvvFbBKH3RhVlPldzuBZrNiyulH
   A==;
X-CSE-ConnectionGUID: AsaeRv/sTGm84E6xLHIquw==
X-CSE-MsgGUID: IM1OC9kVQDKZHyEE/iHhZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="53154313"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="53154313"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 11:01:59 -0800
X-CSE-ConnectionGUID: slerZluNR+aP4+ASjjT6qQ==
X-CSE-MsgGUID: apmxOb0fT/OkQwTYM9ch9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="117409863"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 01 Mar 2025 11:01:54 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toS5L-000Gak-2N;
	Sat, 01 Mar 2025 19:01:20 +0000
Date: Sun, 2 Mar 2025 03:00:19 +0800
From: kernel test robot <lkp@intel.com>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <202503020203.USVBw4Bn-lkp@intel.com>
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250302/202503020203.USVBw4Bn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020203.USVBw4Bn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020203.USVBw4Bn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/preempt.h:85,
                    from include/linux/alloc_tag.h:11,
                    from include/linux/percpu.h:5,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kernel/asm-offsets.c:11:
   arch/s390/include/asm/preempt.h: In function '__preempt_count_add_return':
>> arch/s390/include/asm/preempt.h:109:38: error: void value not ignored as it ought to be
     109 |                         return val + __atomic_add_const(val, &get_lowcore()->preempt_count);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/s390/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


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
