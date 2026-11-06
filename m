Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001852;
	b=sS7JuAmphWaVMjFYJIoV24k6P2ZsIgnuiTjOu0SRe1ISgTICGn0ceHgfok5zLHMZXBj5
	 AdERDbDbkqgrGvF7l3pkFW1kQ4DPNO52E9wZi9ZxBxfLd9w3x5oamJkgp7Iiv9GQvKFfW
	 LPjtYBpnsqkl7RxcHjqa9xrWSjx39G0BBw4dIaYmL/YHyBOstq/QbR+hyMDwP6AaK88Zh
	 V1VbEv7Y783fCYZEJA1vfA3JE5UYEtOuwLWYDmj03Byh0WIdz1WnesXTir/a7NlFs/cre
	 h6VeBKYGhE6V2ALT7yhrE0+grSbGeY3S7I1hA82o8WUSVH3FBX/xR9Fn5L07Ymbnr5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001852;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=gRZ49BvYYfZ4AMhcglC24CYAsSNbyZJp0UDdK0JZjUY=;
	b=fZbP/6lMtdQzhg9k1k4AxqqQ0+ADKtozYTkHYI59Ao2vVgynNEnk6vIKKLPT0NFydBCx
	 NmNwpoNpQE3fmwz3eSWeXcKytGGFB5oCIVVSeQ6Sy6YXc/FHqWBmsNcafjhry+6Oe/3e/
	 bX2Tin61o9XwlQpLvdsUeGUykdCqXOJhCFZM56T/BBa7URt+kb6EtscM5E9B70tP3Zdkm
	 nMn5GZJaja5lQEFupdy0fKysuQ21EYNUzGPZKObvsYJSGp9PPy9M3sAmrPh+E0dZLJDMV
	 hVbYH8ucOArZ7aOfbhwirOnUYq23dOc9ZG0e5fPVwJZ1X03mN5w22vwq9xvyMp4qjLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FCJvuWku;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0B606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 21:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD0B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FCJvuWku
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794001852; x=1825537852;
  h=date:from:to:cc:subject:message-id;
  bh=qEEmQhmj+7KR3dNFE5CCMP0xfX7ojFy8CoZ0ONV5Xcw=;
  b=FCJvuWkuBdDmM8oivE1je94y7ENFBSPgOFLs66/qCk40SfNPxtwMy5il
   zMKqVDMz31Q9nD/3nATbkDcTDDhhjtbs9DsSObRFzZNWJArHIvGj4627z
   nMXgsIVRuz/XdFqJkOndaWHSD9aA+i7hnjJgNk8tgWN8pOv90cyrx/dCx
   QeMrK79IkwMGy7+ZVPZ0OsrY+TGnSwRZ22xd4t4FgCl7vmujRteMQXyT0
   fY7rd/WFWtTSNYzv3AdWfRf2zJCVAWTCqzbu00IuNDsMAETkUvt+LYTvq
   wPCGD1JE4L+lrGedImCLejrXntzB40yybILEEFxf2LXkRGI9C10DI/LTh
   A==;
X-CSE-ConnectionGUID: 0CECXn6JSOKpK5IW2f5yHQ==
X-CSE-MsgGUID: WQiJ9YruQzKH/T046jz2Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2690973"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2690973"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:50:51 -0800
X-CSE-ConnectionGUID: /1lPOmyNSIO2FEtUAj2rZA==
X-CSE-MsgGUID: 2EcAFScARLyGxUECLzw6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7532072"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2026 13:50:48 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPRpe-00000000AN0-1nf5;
	Fri, 06 Nov 2026 21:50:46 +0000
Date: Fri, 06 Nov 2026 22:50:02 +0100
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
Subject: [kvms390:sae 10/28] arch/arm64/include/asm/cache.h:11:5:
 warning: 'ARM64_S390_COMMON' is not defined, evaluates to 0
Message-ID: <202611062223.0W9zRex6-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   2abfa741008fd96c3684c316a2f5f37d3bb7bd8b
commit: e8b6c7dc6f90bdd331d7747f381082943815fe6a [10/28] arm64: Share system register related headers and functions with s390
config: arm64-randconfig-2000-20261106 (https://download.01.org/0day-ci/archive/20261106/202611062223.0W9zRex6-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611062223.0W9zRex6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611062223.0W9zRex6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:7:
   In file included from include/vdso/datapage.h:14:
   In file included from include/vdso/cache.h:5:
>> arch/arm64/include/asm/cache.h:11:5: warning: 'ARM64_S390_COMMON' is not defined, evaluates to 0 [-Wundef]
      11 | #if ARM64_S390_COMMON == 1
         |     ^
   1 warning generated.
--
   In file included from <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:7:
   In file included from include/vdso/datapage.h:14:
   In file included from include/vdso/cache.h:5:
>> arch/arm64/include/asm/cache.h:11:5: warning: 'ARM64_S390_COMMON' is not defined, evaluates to 0 [-Wundef]
      11 | #if ARM64_S390_COMMON == 1
         |     ^
   1 warning generated.


vim +/ARM64_S390_COMMON +11 arch/arm64/include/asm/cache.h

    10	
  > 11	#if ARM64_S390_COMMON == 1
    12	#define CLIDR_LOUU_SHIFT	27
    13	#define CLIDR_LOC_SHIFT		24
    14	#define CLIDR_LOUIS_SHIFT	21
    15	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
