Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050204FD79D
	for <linux-s390@vger.kernel.org>; Thu, 15 Oct 2026 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792104385; cv=none; b=Z6RYpPI/Bu6+q4mW2gZRJ7ZhdgVrQQOuXVHfSBMQRxEJMXugxSKTV44eBnZSt10xJQGM8Q+0/QPkaIUhIC9KKrnjalcBc/0PKUcI6J9Ja2xUXtKLx/5OF38NsnbyQGk6MaiV3KnkNKqOJADzLvAYj6WuQAXqkvB1KfWWoRhhVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792104385; c=relaxed/simple;
	bh=9ZWzv+KNnujCBWUA43O4k1in+THeLq2wLqhFJ3C8cD4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Uedn7xIicJFOJ94vIsj0QNGRBje4asUkPf5/XFLSdXzHyP8wsdwarvP8F+7UiEIfIoglwtrbO8wAP3+xr4Pn3ZGPmsiyo28vsR7lmselM7roPvNWAUzyLyv56bQpKQkeRKE5oO/s98h8V7CVrYXb+Efujo01L1LQqCxOH8SYqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fc+oAeZV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc+oAeZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792104382; x=1823640382;
  h=date:from:to:cc:subject:message-id;
  bh=9ZWzv+KNnujCBWUA43O4k1in+THeLq2wLqhFJ3C8cD4=;
  b=fc+oAeZV2YGnr+UWQg1jrydK3X/t9Nps4TYPypYl54BG+P3hP2hxv25a
   FORsyiUUabjvqSCCbDXOuFXZC2Gfk6h+ZIRXChAwGpTc32OgFqD2rwLOf
   caoYBD/AUAocQhi2Y85P3EyJkdhQsYfIjGqLY4Ym809P1P694vKVAJ2g4
   WgJvqmSk2Y49hoBc8iaZJRhz+sGk2IB90ECEJJSclP/YXIwnoshyY4G2c
   +Fj4dA5IZzfgcH+WRdcH8alcTTGq1s2Vx1CqXE3dcK70JR1l3AvhE9wmY
   SmEYDuom4cUYDkTeUY+uBiN93Hcb0mfOP6ZaFumMlkY1SOZAuBHS/atgZ
   w==;
X-CSE-ConnectionGUID: GyRe83FARMSOhLQElu8uwQ==
X-CSE-MsgGUID: 86myL1IuSpCPhSQnCH0OkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="990706"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="990706"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 15:46:21 -0700
X-CSE-ConnectionGUID: g9Rrwn+5TWa6fjkZkSUZxg==
X-CSE-MsgGUID: kG790rJxQiCq90mgQPNv7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1696268"
Received: from igk-lkp-server01.igk.intel.com (HELO d0de6c2a75a7) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 15 Oct 2026 15:46:19 -0700
Received: from kbuild by d0de6c2a75a7 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHUDJ-00000000Btf-2YBd;
	Thu, 15 Oct 2026 22:46:17 +0000
Date: Fri, 16 Oct 2026 00:45:32 +0200
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: [kvms390:queue 24/24] arch/s390/kvm/arm64/arm.c:247:15-23:
 Unneeded variable: "features". Return "KVM_S390_ARM64_IMPL_FEATURES" on line
 249
Message-ID: <202610160028.dMuOkORC-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Hi Steffen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git queue
head:   e93fb70b748982fda5e6d97721df35194cacfc4a
commit: e93fb70b748982fda5e6d97721df35194cacfc4a [24/24] arm64: Use proper include variant
config: s390-randconfig-r2105-20261015 (https://download.01.org/0day-ci/archive/20261016/202610160028.dMuOkORC-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610160028.dMuOkORC-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> arch/s390/kvm/arm64/arm.c:247:15-23: Unneeded variable: "features". Return "KVM_S390_ARM64_IMPL_FEATURES" on line 249

vim +247 arch/s390/kvm/arm64/arm.c

761404d7acfe8c Steffen Eiden 2026-04-02  244  
761404d7acfe8c Steffen Eiden 2026-04-02  245  static unsigned long system_supported_vcpu_features(struct kvm_vcpu *vcpu)
761404d7acfe8c Steffen Eiden 2026-04-02  246  {
761404d7acfe8c Steffen Eiden 2026-04-02 @247  	unsigned long features = KVM_S390_ARM64_IMPL_FEATURES;
761404d7acfe8c Steffen Eiden 2026-04-02  248  
761404d7acfe8c Steffen Eiden 2026-04-02 @249  	return features;
761404d7acfe8c Steffen Eiden 2026-04-02  250  }
761404d7acfe8c Steffen Eiden 2026-04-02  251  

:::::: The code at line 247 was first introduced by commit
:::::: 761404d7acfe8c58f9bd938332c6cc9beed6bafd KVM: s390: Add basic arm64 kvm module

:::::: TO: Steffen Eiden <seiden@linux.ibm.com>
:::::: CC: Christian Borntraeger <borntraeger@linux.ibm.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
