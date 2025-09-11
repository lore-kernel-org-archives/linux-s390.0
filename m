Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707543112D9;
	Thu, 11 Sep 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597092; cv=none; b=lkgpMuH3HsqhCDoeEoeVHCSp0b1B/RV4E4PELoyibdahTilSJA5iznq1hC14kCVplu6Bdz5cmwoym5/K/2NTZWDgt0Wh5sL6GeBGm5WoX5Qihr7IzzwqS0r9nfP/TRBmJfZMmLzonHALQg0KffH6Jhh9OozP8dLmQmQlehjDP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597092; c=relaxed/simple;
	bh=z2IwYHrG2uP+yqAp6QrCN48pwVj9rmFUIykTv0Z7+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7UkaEkt2l8+jIa3EoWm9R6g8qW4N3BItCmHh6pA/DJnJ7dXF8qCIFo1dx3W+xG6aAXDsjtx+J76JRsiceonC5TFnOsdJ6DeK9waCaitU9+86DUEXZEDQpPlJ024p/UW+GazgIy1RViGeLyi5mKY64aCv4puvwg9KMazGZtqPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwnFtV+S; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwnFtV+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757597091; x=1789133091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2IwYHrG2uP+yqAp6QrCN48pwVj9rmFUIykTv0Z7+Ls=;
  b=fwnFtV+SJ2doPFvcMb2qCWovo2+Qkcx2kZXb/bjCOI5elV6qTrzSxd3h
   9w8+codXKaOhZXDdLbzSPMJB/TIebBgMwBxBn1q/nhl+rJCJshnB2jDUc
   Dj6KMqqxKucXI3TPZf7HI4HOPkOHCfQMTGlG4lZ0U8iQVmjnnUIH4N+ZL
   NM9xSGOgIHmFk6/ytBDhZ8mSBAIZSUS6dBEiZ6PDeUXfLiNpHrnDePnFP
   2kOHM5+Ad5KbB6fuzHVdLb5cNAE7lC6Wzxn6nCEjM/6MDTrFMxC+Deb/6
   sF7Qm360R85xLDInEQeKppRLm1+KQntEofwnBV6hFBB+/uqBF+ivQEHiK
   g==;
X-CSE-ConnectionGUID: LdS68ReyQDKrFDnda1xvAw==
X-CSE-MsgGUID: T2Ng6XTuT0WSMJ0dVJWwEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63753549"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63753549"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 06:24:51 -0700
X-CSE-ConnectionGUID: GfN48kH3QSKRAJhTRGd+Mg==
X-CSE-MsgGUID: apsUjBajRHerjVhZqwW44w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173763968"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 11 Sep 2025 06:24:46 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwhI3-0000Ls-0z;
	Thu, 11 Sep 2025 13:24:43 +0000
Date: Thu, 11 Sep 2025 21:24:22 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 2/3] s390/bitops: Limit return value range of __flogr()
Message-ID: <202509112018.eZI47cSy-lkp@intel.com>
References: <20250910151216.646600-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910151216.646600-3-hca@linux.ibm.com>

Hi Heiko,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on next-20250911]
[cannot apply to linus/master v6.17-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Carstens/Compiler-Attributes-Add-__assume-macro/20250910-231949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20250910151216.646600-3-hca%40linux.ibm.com
patch subject: [PATCH 2/3] s390/bitops: Limit return value range of __flogr()
config: s390-randconfig-002-20250911 (https://download.01.org/0day-ci/archive/20250911/202509112018.eZI47cSy-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509112018.eZI47cSy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509112018.eZI47cSy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:67:
>> arch/s390/include/asm/bitops.h:174:3: error: '__assume__' attribute cannot be applied to a statement
                   __assume(bit <= 64);
                   ^                  ~
   include/linux/compiler_attributes.h:68:56: note: expanded from macro '__assume'
   # define __assume(expr)                 __attribute__((__assume__(expr)))
                                                          ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: kernel/bounds.s] Error 1 shuffle=1723937077
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2 shuffle=1723937077
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=1723937077
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=1723937077
   make: Target 'prepare' not remade because of errors.


vim +/__assume__ +174 arch/s390/include/asm/bitops.h

   124	
   125	/**
   126	 * __flogr - find leftmost one
   127	 * @word - The word to search
   128	 *
   129	 * Returns the bit number of the most significant bit set,
   130	 * where the most significant bit has bit number 0.
   131	 * If no bit is set this function returns 64.
   132	 */
   133	static __always_inline __attribute_const__ unsigned long __flogr(unsigned long word)
   134	{
   135		unsigned long bit;
   136	
   137		if (__builtin_constant_p(word)) {
   138			bit = 0;
   139			if (!word)
   140				return 64;
   141			if (!(word & 0xffffffff00000000UL)) {
   142				word <<= 32;
   143				bit += 32;
   144			}
   145			if (!(word & 0xffff000000000000UL)) {
   146				word <<= 16;
   147				bit += 16;
   148			}
   149			if (!(word & 0xff00000000000000UL)) {
   150				word <<= 8;
   151				bit += 8;
   152			}
   153			if (!(word & 0xf000000000000000UL)) {
   154				word <<= 4;
   155				bit += 4;
   156			}
   157			if (!(word & 0xc000000000000000UL)) {
   158				word <<= 2;
   159				bit += 2;
   160			}
   161			if (!(word & 0x8000000000000000UL)) {
   162				word <<= 1;
   163				bit += 1;
   164			}
   165			return bit;
   166		} else {
   167			union register_pair rp __uninitialized;
   168	
   169			rp.even = word;
   170			asm volatile(
   171				"       flogr   %[rp],%[rp]\n"
   172				: [rp] "+d" (rp.pair) : : "cc");
   173			bit = rp.even;
 > 174			__assume(bit <= 64);
   175			return bit & 127;
   176		}
   177	}
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
