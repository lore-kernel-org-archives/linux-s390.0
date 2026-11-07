Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055900;
	b=bPKC+dnRV+rSqnHKV/FpWkHw6IzSwmC3VVbj770eY37UXhIiljo9mIU5QqmWcq2EMnax
	 5RRcP6JPpVYaBWJ1np7a95EOSFb+sJr9mrrgafntfQY0WYzhN/huOApMAHBYMHBfLC5Kp
	 b94Jir4hxRpvjXvEp1rizBcGOLtyL00jnZ5u3pXKsjnLW+0ScIufjITpq7EHsI6VnxAWF
	 7mGSWw+ktbD1noilPzaK4WWtb1ygA9djYiezagTZVmtX6a0Qc8Es8UG8xRCyHxo4q+y1i
	 +skVJjRoVmzpFH6QjypvZo6GZDRXuDwQAJByIhUWpsSXUkx6qWZn3Z75Rs5YatB5S+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055900;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=pdTLQVDDfdcAV1doN1EW1UzMc8K7SBlmvPVJBugRTYY=;
	b=w3pASn5e8yUbGJaJtwxP6fwpgczL6pCUaB9gZI4oKLawHR/F0Ehbsfs3YQq5ATL8GqiY
	 o46jEZvXuEhKTH16uMj6vs/2AHwOboPtA7dMaK78RopDNgWOsFUtb50ZaQtjxLocmLlMe
	 hAXi5QetTcfIOfqvPgDoE9/Dvp4kkF2RZPMAPD4p/ExnbCyXQAls+wncuuCiKCVbgSdpX
	 igm4RdyC2W6nVUKX17ILm1LP8COzD1v+/mN5rEy7Evypm4CSN0pQVGJXU+PYbs5JUgQcA
	 m5fwu8ATFeDSfCjalaKYsSTLvWOox9TLqQfGpaeVAx3D9EwhjGY1CQX/hDtq09aB8EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OZff+0pr;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B0606A326
	for <linux-s390@vger.kernel.org>; Sat,  7 Nov 2026 12:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OZff+0pr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794055899; x=1825591899;
  h=date:from:to:cc:subject:message-id;
  bh=uLaSYIYeqdwXwFCpTwr6EmthCRBIVxXQHuSvmo9r1NQ=;
  b=OZff+0prpKQFgfqwRqxX6eAbWSSbsrBbtXQGnu6iw7oejpUDHLOSkqlh
   SdkYFcXL0VgxkjUNCRiVgDQzH+GvWkrXs9l9ffnVvwAbITEbJ+1Gf6w0p
   X0xTeuZ+f2HQmcERsXkD9jaoA9MNLtiNdJIUfpQ43r/zPoKgnBKEMZrd8
   rbJN6EtWKm5Pl+pkt/9n/01XrjTNIsysW55Bbx8sGbxpvD8nbCbTIKNDb
   AIHAjzX+OZhRXhqHl2rVtKJXz557l/fHZVGcL0C9TcvCNQsoP8l/Kv9ks
   d3TQ6WR8VMOzKX1iMgPmNzOhC2P2/9jFYmqGDLvc0cfc+ZPaBtAqFXCyk
   A==;
X-CSE-ConnectionGUID: Hf0coNH6SFyMcPr12beUnQ==
X-CSE-MsgGUID: tZoemC2wSE606eyAuKz2Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2953081"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2953081"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 04:51:38 -0800
X-CSE-ConnectionGUID: I6oo7LwRS/m+g2AdjqhU1Q==
X-CSE-MsgGUID: xrpYnBYtTmyZNNv+D1LN8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7317997"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Nov 2026 04:51:36 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPftO-00000000qrH-0bR2;
	Sat, 07 Nov 2026 12:51:34 +0000
Date: Sat, 07 Nov 2026 20:51:13 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
Subject: [kvms390:sae 7/25] arch/arm64/include/asm/cache.h:11:5:
 warning: 'ARM64_S390_COMMON' is not defined, evaluates to 0
Message-ID: <202611072031.AuSQH3Uq-lkp@intel.com>
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
commit: 72b4e17e1d9768b577d52cf9cc75858cde547e80 [7/25] arm64: Share system register related headers and functions with s390
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20261107/202611072031.AuSQH3Uq-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project fc9576e3b179738d99c5babe5cd9d6c1f883e0db)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261107/202611072031.AuSQH3Uq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611072031.AuSQH3Uq-lkp@intel.com/

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
