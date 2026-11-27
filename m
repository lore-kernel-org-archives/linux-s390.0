Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795821777;
	b=d/hHemwReCoXXLALOuHBMn/pQ5a+PUDARszbn5HUxfxybzWW+c+6/kaM/23whsmzBfsA
	 CcNww6sFlwGf6zrMkFyJmLlz2mJBRLrwh+KfGa0CpHvbf0Whto7hGDYT+ru7ZpkpClGVd
	 B/FEKfKmhsJYwDke6dmVgZkp0QE9j+Ne7gc/tKbuLZIMiK6aQTAr96U+Rn0xkDCqXYWJE
	 3pFdiA+W27G7Rtxz3HiZUjCh3o82Q0aRe5O6sCH1/wi98GMkvE757ygvQMnzJsUntMJBn
	 VZOIbvyVia34iXJfAjZ+SfmyzeMd/+NCNX0f1n4mka/2FNrNMUoTwFYEilICwZwdwVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821777;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=BE3yJw+778YBHvXAGS/IP2yJ+XOJuwIwhW9cpe8+688=;
	b=y6ZCs3I2rdZLL00i1ySTsb1VZ9Lnik4xKHmkJmdGdPvM7Ajsj3/isLFM7aFMnyUMJbYJ
	 JaXuFY+kf9xm8Pa5Tsfd4D6QeEH0ohbhF7atlN76p7joKa+c6bs9jsHHGnKwO0Vrr2XJ0
	 tZh6SNhe6QPuXZ7fJLZYqQ47JqEfb2R29sWn7FdHNyr9byfaJ0mdKJSCYmRB3L4q3Xzf7
	 H2Odkcbff5FAc4woXVTlZxs1+6jvkWQTIH1b3EpCIfPM5A9KAgTV4sZu0NT45ju5hWb73
	 0MgjzfIpreg525LzHSMjLRbCXngAelN8LimDNFFHEuahjNnd0w+OBuqqsV/bbwgdFwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hmeqjeqs;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B08606A31E
	for <linux-s390@vger.kernel.org>; Fri, 27 Nov 2026 23:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B08606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hmeqjeqs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795821776; x=1827357776;
  h=date:from:to:cc:subject:message-id;
  bh=l1jRkcq1OU2R/ToMYQuPSazWVWpE475pKZCyaX/kX+w=;
  b=HmeqjeqsdezZEGviWee5SNpmQXFFsGtyqnk0mhBnHl0k6t1dBhzDEO1Z
   Bei1EraQ987z2tf1PgIJpTv6k6rKKt+lNLWER3daPzCFxcFVNbIsNn8sr
   aMw7RFu3Sv6Haaz/VQ26obVRm/ksECWAx6VNSvezwC6X5mncWhLTxTUHt
   0TmLmiegLoBDW5QdmdhOrnIZlHZTM9iv6BWliA0wWfgco2hp6YotDLiwV
   HGC8J+M11BokfBE5Dom/WSxG3YKhenuks0KVD/RWdQPZgS5D63OGsglXx
   LR2fDTOGAECPBzG6gdexUUbSLUgcQia0Srj6sdNhDNnMmiwHdaVYRk29L
   A==;
X-CSE-ConnectionGUID: YIEszf9uRFWFYRifvHd7KA==
X-CSE-MsgGUID: +ac/5+Y8QhyaV9crflC59A==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4696972"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4696972"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 15:22:56 -0800
X-CSE-ConnectionGUID: OZeniJcxS7OAum6a0T9Grw==
X-CSE-MsgGUID: Y07QfVNFSxGQqQJ5nW74Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12802361"
Received: from igk-lkp-server01.igk.intel.com (HELO 146cf1e082f1) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 27 Nov 2026 15:22:54 -0800
Received: from kbuild by 146cf1e082f1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xX5HI-000000000Os-24lk;
	Fri, 27 Nov 2026 23:22:52 +0000
Date: Sat, 28 Nov 2026 00:22:13 +0100
From: kernel test robot <lkp@intel.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [s390:for-next 2/3] arch/s390/kernel/machine_kexec.c:162:3:
 warning: ignoring return value of function declared with 'warn_unused_result'
 attribute
Message-ID: <20261128002018.6111Rbgo-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-next
head:   e8f20a7b5952e0d5f12f11af4966092242ce7f81
commit: fd5d165900beb00e33763af707cb9be32367e217 [2/3] Merge branch 'features' into for-next
config: s390-randconfig-2200-20261127 (https://download.01.org/0day-ci/archive/20261128/20261128002018.6111Rbgo-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261128/20261128002018.6111Rbgo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261128002018.6111Rbgo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/s390/kernel/machine_kexec.c:162:3: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     162 |                 set_memory_ro(addr, size >> PAGE_SHIFT);
         |                 ^~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kernel/machine_kexec.c:164:3: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
     164 |                 set_memory_rw(addr, size >> PAGE_SHIFT);
         |                 ^~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/s390/kernel/machine_kexec.c:165:6: warning: variable 'rc' is uninitialized when used here [-Wuninitialized]
     165 |         if (rc)
         |             ^~
   arch/s390/kernel/machine_kexec.c:155:8: note: initialize the variable 'rc' to silence this warning
     155 |         int rc;
         |               ^
         |                = 0
   3 warnings generated.


vim +/warn_unused_result +162 arch/s390/kernel/machine_kexec.c

2d0af2247906cf Heiko Carstens            2016-05-31  151  
4e042af463f806 Heiko Carstens            2016-05-31  152  static void crash_protect_pages(int protect)
dab7a7b1538fec Michael Holzheu           2011-10-30  153  {
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17  154) 	unsigned long addr, size;
21f8d19ddeb3c0 Heiko Carstens            2026-11-18  155  	int rc;
dab7a7b1538fec Michael Holzheu           2011-10-30  156  
4e042af463f806 Heiko Carstens            2016-05-31  157  	if (!crashk_res.end)
4e042af463f806 Heiko Carstens            2016-05-31  158  		return;
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17  159) 	addr = (unsigned long)__va(crashk_res.start);
4e042af463f806 Heiko Carstens            2016-05-31  160  	size = resource_size(&crashk_res);
4e042af463f806 Heiko Carstens            2016-05-31  161  	if (protect)
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17 @162) 		set_memory_ro(addr, size >> PAGE_SHIFT);
a9fbf1a53836d4 Michael Holzheu           2012-05-18  163  	else
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17  164) 		set_memory_rw(addr, size >> PAGE_SHIFT);
21f8d19ddeb3c0 Heiko Carstens            2026-11-18 @165  	if (rc)
21f8d19ddeb3c0 Heiko Carstens            2026-11-18  166  		pr_warn("Failed to %sprotect crashkernel memory: %d\n",	protect ? "" : "un", rc);
dab7a7b1538fec Michael Holzheu           2011-10-30  167  }
dab7a7b1538fec Michael Holzheu           2011-10-30  168  

:::::: The code at line 162 was first introduced by commit
:::::: a07bc01bec2337151166442b15047b8861c4b23e s390/kdump: Write protect the crash kernel memory by its virtual address

:::::: TO: Mike Rapoport (Microsoft) <rppt@kernel.org>
:::::: CC: Alexander Gordeev <agordeev@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
