Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E24772BF
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006481; cv=none; b=e7m0IE5IPD4OUegjORXBhL+jFtaXvf973XruuYUEpYITMQWEFn89DEUcbG9JyjbJPbDe/Ag0CDlAB1Qhb32C6lgEZ4BpoN8mrglGRTlU0WvovNdMNxive02gJ/B31H7g1D4UD/xNnhzmRAyBkX1Zm23NzKfu09/yJKDNJ6QZBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006481; c=relaxed/simple;
	bh=t/nF8UynVpc5ttFWo89PHKTi0QPmQBXs4nQfLqY7yLQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NTH8Ivnvb4ja8tB/AOMoISyKc0PF608BUrIXJ5oMbDjeGVioxN9igceA5lUQlKgaXQAt+ihlDBruiNr7WTwHs3565krDIrMmSfU6nxpUhJKKTrsTUz33TaNlnS4rnuHLGvzeSO87F1CYk0hJRkBO9HBwkLRQx/ChzGrUpyCBLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIzwgdgK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIzwgdgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792006479; x=1823542479;
  h=date:from:to:cc:subject:message-id;
  bh=t/nF8UynVpc5ttFWo89PHKTi0QPmQBXs4nQfLqY7yLQ=;
  b=kIzwgdgKV6rKW/JzsDmKrXv4DYCc9vReJ4TceUCwwwUHj+27893eZiKJ
   CiQxXMz9MMppOXNi6NDKpXW9W9PY5INdNSrDgXeR6+jy+8xmTxCqhlz87
   TtJYhRmeQ/s4XGGejsf6jhLbtLSbyBCM/rUTiSXafzxSO6iEUi5uBcC81
   U2QqOoVRxOClSxnMwJiKXRcbkeACjlWGPf95wg+gP2oAxfgBURzw4X0Nx
   WIg7D3bPOGWOsoup8Kbxmn6MseUpaLRk7nvM7ec/NwIJ+0OsXzWn4MxV7
   EAu44ZCazej/mzpwT3YN6CCBgXoaescmv2vZYRUzVvwfd9Ownc7+KHbu+
   w==;
X-CSE-ConnectionGUID: Qreyj1GHQzatvN/PQLgE+g==
X-CSE-MsgGUID: bqxsH8/FQZKoZm2l9P1hSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="758105"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="758105"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 12:34:39 -0700
X-CSE-ConnectionGUID: WHIjyriSSY20F0rIAJgotQ==
X-CSE-MsgGUID: IPV6IyORTJizoM3bClfWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1842902"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 12:34:37 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xH4kE-00000000F71-3WjU;
	Wed, 14 Oct 2026 19:34:34 +0000
Date: Thu, 15 Oct 2026 03:34:10 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>
Subject: [kvms390:queue 20/21]
 arch/arm64/include/asm/sysreg.h:182:10: fatal error: asm/sysreg-defs.h: No
 such file or directory
Message-ID: <202610150332.4CegXzzq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git queue
head:   74153e116543bc017aff93720fcc603cb0e8598c
commit: 325380d8e78936b65d30e29d6be478bdd03c87d8 [20/21] KVM: s390: arm64: Integrate arm on s390
config: s390-debug_defconfig (https://download.01.org/0day-ci/archive/20261015/202610150332.4CegXzzq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150332.4CegXzzq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150332.4CegXzzq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/arm64/sysreg.h:11,
                    from arch/s390/include/arm64/ptrace.h:6,
                    from arch/arm64/include/uapi/asm/kvm.h:37,
                    from arch/s390/include/asm/kvm.h:3,
                    from include/uapi/linux/kvm.h:16,
                    from include/linux/kvm_host.h:40,
                    from arch/s390/kvm/arm64/handle_exit.c:3:
>> arch/arm64/include/asm/sysreg.h:182:10: fatal error: asm/sysreg-defs.h: No such file or directory
     182 | #include "asm/sysreg-defs.h"
         |          ^~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +182 arch/arm64/include/asm/sysreg.h

7c9cb893ae3e06c Marc Zyngier 2025-04-25  175  
c07d8017bceb82c Mark Brown   2022-05-03  176  /*
c07d8017bceb82c Mark Brown   2022-05-03  177   * Automatically generated definitions for system registers, the
c07d8017bceb82c Mark Brown   2022-05-03  178   * manual encodings below are in the process of being converted to
c07d8017bceb82c Mark Brown   2022-05-03  179   * come from here. The header relies on the definition of sys_reg()
c07d8017bceb82c Mark Brown   2022-05-03  180   * earlier in this file.
c07d8017bceb82c Mark Brown   2022-05-03  181   */
c07d8017bceb82c Mark Brown   2022-05-03 @182  #include "asm/sysreg-defs.h"
c07d8017bceb82c Mark Brown   2022-05-03  183  

:::::: The code at line 182 was first introduced by commit
:::::: c07d8017bceb82cbe5fedd129d072c59a53f5513 arm64/sysreg: Enable automatic generation of system register definitions

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
