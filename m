Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B459253F13
	for <linux-s390@vger.kernel.org>; Sat, 18 Apr 2026 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473610; cv=none; b=VpQ4mlRYbuXy5Y8oAHLDreZFHkh0XqWIUbAeibLpFX4xBsiijs0s+OeykpOGSZQGxVYNeyVX4OcvY9OYnkZPiT+KuXmopy8A6YT4vyxYIlmc7BKwFgBM6EA31QPSwT3Sq4p24o1qHw0mqbdJcWXPDN4szlioqrD81VpveU4I1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473610; c=relaxed/simple;
	bh=/r0TucoxN7PqcsMbrpm68WcjBoGIHP52HqsUr2j6ysY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WiH1CVCd2tLQoWv/tqXU1o5+LWBMYDVYAUOcUP8bmJ74pTZdVrhRUqCmowBO5OS0OEwrFnIVT2+NW4J3V6G74alVQmrpp3hbHK3AeomqDR9wnZv+wpXaKJMNsMtjY3zo1IJlfGu+BzD2Yt1vf/8//NKglK4tBpBZlbIizTINuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gvu9bEdn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gvu9bEdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776473608; x=1808009608;
  h=date:from:to:cc:subject:message-id;
  bh=/r0TucoxN7PqcsMbrpm68WcjBoGIHP52HqsUr2j6ysY=;
  b=Gvu9bEdnZjLm5v7H1q5ADNJjvfCoQxyOqpBTaKhA+bY3uss0rzo19Hvr
   CUIBXN1C0AmQOFO0vk11WxhEgV7PNdN7SBAzJrk6oJeXrWP2e86sv2zq7
   MDNJbE0LnPTy+ERWJoqBSEcgat7b47o+6hzipXgtFxENmTxaEmnxPSGrB
   RzIepBIAaNx9PczkyHdlPwg/ZeEW/Db4efBNjY3HGfilwtlKEV3jU4vs5
   Hn6SYovUY39WXkC1Rxrg+pA9uRM4jzwUDQ6bYUW2jB7a4QqpekdPhPEGn
   9dSQTT+ooJXl4ZNGez9+8yohr/O8xGfvoS3/XBbzkbpJ1PxYA6f1bq4Mj
   A==;
X-CSE-ConnectionGUID: 26IRCge+SM+NzNTSMKgBmw==
X-CSE-MsgGUID: Hu/2MpjwSsy9N0UjXWxLdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77564124"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="77564124"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 17:53:28 -0700
X-CSE-ConnectionGUID: Krs6EgQbRpWB2T6sqTtjqQ==
X-CSE-MsgGUID: hTYPqjezSYer6gCZIFy8Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="226498415"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2026 17:53:26 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDtw3-000000000to-1xPf;
	Sat, 18 Apr 2026 00:53:23 +0000
Date: Sat, 18 Apr 2026 08:53:19 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>
Subject: [kvms390:sae-part1 27/27] arch/s390/kvm/arm64/mmu.c:49:16:
 warning: variable 'esr' set but not used
Message-ID: <202604180812.3JWdnPro-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae-part1
head:   c8ef958593be02ec09131a1f5e2744a98b6c01a1
commit: c8ef958593be02ec09131a1f5e2744a98b6c01a1 [27/27] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
config: s390-randconfig-001-20260418 (https://download.01.org/0day-ci/archive/20260418/202604180812.3JWdnPro-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260418/202604180812.3JWdnPro-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604180812.3JWdnPro-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/s390/kvm/arm64/mmu.c:49:16: warning: variable 'esr' set but not used [-Wunused-but-set-variable]
      49 |         unsigned long esr;
         |                       ^
   1 warning generated.


vim +/esr +49 arch/s390/kvm/arm64/mmu.c

1afccc97efeb65f Steffen Eiden 2026-04-02  43  
1afccc97efeb65f Steffen Eiden 2026-04-02  44  int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
1afccc97efeb65f Steffen Eiden 2026-04-02  45  {
1afccc97efeb65f Steffen Eiden 2026-04-02  46  	struct kvm_memory_slot *memslot;
1afccc97efeb65f Steffen Eiden 2026-04-02  47  	bool translation = false;
1afccc97efeb65f Steffen Eiden 2026-04-02  48  	phys_addr_t fault_ipa;
1afccc97efeb65f Steffen Eiden 2026-04-02 @49  	unsigned long esr;

:::::: The code at line 49 was first introduced by commit
:::::: 1afccc97efeb65f95d4ed646a34bbd49616169e9 KVM: s390: arm64: Implement basic page fault handler

:::::: TO: Steffen Eiden <seiden@linux.ibm.com>
:::::: CC: Steffen Eiden <seiden@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
