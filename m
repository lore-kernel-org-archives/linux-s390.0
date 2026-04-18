Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180227FD49
	for <linux-s390@vger.kernel.org>; Sat, 18 Apr 2026 01:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776477393; cv=none; b=S9S4/2s95C7anvvRIacz1MC4uD8p8oFKt749A3zNGfOjbuDeGcXHVMRrYfPLHZrBGLEa8OM3/1Y7yAWC4DtnAlVDHZ6dwFtM+ZIEdYQCGBG5nqTIdTvqDs2hk4J4ceRIYsbXhRx2lvTDfDp6ruMg827J5X/3h+q5VxvhI5Ie2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776477393; c=relaxed/simple;
	bh=AoAg9PJYpVuzyrPDo6//EMEsGna4T2m06uUhOUdrMTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=slAf5uhhseB+txPpG6EiZUFrqtIxtu1B58uREK6NNhT30f3txE34SA9z7pz2dKSYOCXPg4bGI/XIwDrjQ1XygEC4COEJwIhY3UGoqEbHKUu4on0K50XJAbT0f8kZ0Sosd3CW0ctU03qRL7JIIL805oWpaENMCxDMYDHuFgcJbOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRdda/hF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRdda/hF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776477392; x=1808013392;
  h=date:from:to:cc:subject:message-id;
  bh=AoAg9PJYpVuzyrPDo6//EMEsGna4T2m06uUhOUdrMTs=;
  b=IRdda/hFAhZ46DLFQ4reutNWS+TKh7liZnkwP756CRxqawa5RBPIrsb0
   vDE3AQuFH3eO4Daag1+kGDqQfX/Ya2iWKOZxiZaUWKdwR77Ujb0e17ayM
   GxRMgVBPlQ/pDgZ8E36YcRD3Izh4BEFnCbD1qwWpdFgab82AoNPAXtMoE
   yFjJy2oVuo+/m104k0FBBMxnXhhRFkTiPqE1DabBjJvaJVZtmFqkjXMf9
   J9JAEZnzfty64fu+dNS4YuGbFCbER/gEuHQ27Tae4oKHsHamMKFvpUIog
   DunSgAb3TQx6rxjQRQlNVuwYxGR5G3aspitUiyx3KE5LQ5HlR18Bj2Qg2
   A==;
X-CSE-ConnectionGUID: 6x+LKVg+RJagSl/ujBVwUQ==
X-CSE-MsgGUID: AHJxSLbwSNK1SW/coXBXjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77611088"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="77611088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 18:56:31 -0700
X-CSE-ConnectionGUID: ZlcjIp9fRbKnWd3P6PBpXA==
X-CSE-MsgGUID: jp9OyVnqSoqQbctAuouKdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="224672459"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2026 18:56:30 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDuv4-000000000vy-3vCV;
	Sat, 18 Apr 2026 01:56:26 +0000
Date: Sat, 18 Apr 2026 09:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>
Subject: [kvms390:sae-part1 27/27]
 arch/s390/kvm/arm64/../../../../virt/kvm/arm64/mmio.c:119:22: error: no
 member named 'mmio_needed' in 'struct kvm_vcpu'
Message-ID: <202604180914.L6FMypYF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae-part1
head:   c8ef958593be02ec09131a1f5e2744a98b6c01a1
commit: c8ef958593be02ec09131a1f5e2744a98b6c01a1 [27/27] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
config: s390-randconfig-001-20260418 (https://download.01.org/0day-ci/archive/20260418/202604180914.L6FMypYF-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260418/202604180914.L6FMypYF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604180914.L6FMypYF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/s390/kvm/arm64/../../../../virt/kvm/arm64/mmio.c:119:22: error: no member named 'mmio_needed' in 'struct kvm_vcpu'
     119 |         if (unlikely(!vcpu->mmio_needed || kvm_pending_external_abort(vcpu)))
         |                       ~~~~  ^
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/s390/kvm/arm64/../../../../virt/kvm/arm64/mmio.c:122:8: error: no member named 'mmio_needed' in 'struct kvm_vcpu'
     122 |         vcpu->mmio_needed = 0;
         |         ~~~~  ^
   arch/s390/kvm/arm64/../../../../virt/kvm/arm64/mmio.c:244:8: error: no member named 'mmio_needed' in 'struct kvm_vcpu'
     244 |         vcpu->mmio_needed       = 1;
         |         ~~~~  ^
   3 errors generated.


vim +119 arch/s390/kvm/arm64/../../../../virt/kvm/arm64/mmio.c

e735a5da64420a arch/arm64/kvm/mmio.c Oliver Upton     2024-10-25  102  
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  103  /**
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  104   * kvm_handle_mmio_return -- Handle MMIO loads after user space emulation
83091db981e105 arch/arm/kvm/mmio.c   Christoffer Dall 2016-03-29  105   *			     or in-kernel IO emulation
83091db981e105 arch/arm/kvm/mmio.c   Christoffer Dall 2016-03-29  106   *
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  107   * @vcpu: The VCPU pointer
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  108   */
74cc7e0c35c1e4 arch/arm64/kvm/mmio.c Tianjia Zhang    2020-06-23  109  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  110  {
6d89d2d9b5bac9 arch/arm/kvm/mmio.c   Marc Zyngier     2013-02-12  111  	unsigned long data;
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  112  	unsigned int len;
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  113  	int mask;
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  114  
e735a5da64420a arch/arm64/kvm/mmio.c Oliver Upton     2024-10-25  115  	/*
e735a5da64420a arch/arm64/kvm/mmio.c Oliver Upton     2024-10-25  116  	 * Detect if the MMIO return was already handled or if userspace aborted
e735a5da64420a arch/arm64/kvm/mmio.c Oliver Upton     2024-10-25  117  	 * the MMIO access.
e735a5da64420a arch/arm64/kvm/mmio.c Oliver Upton     2024-10-25  118  	 */
bfb7a30b19861e arch/arm64/kvm/mmio.c Oliver Upton     2025-07-08 @119  	if (unlikely(!vcpu->mmio_needed || kvm_pending_external_abort(vcpu)))
cc81b6dfc3bc82 arch/arm64/kvm/mmio.c Fuad Tabba       2024-04-23  120  		return 1;
2113c5f62b7423 virt/kvm/arm/mmio.c   Andrew Jones     2019-08-22  121  
2113c5f62b7423 virt/kvm/arm/mmio.c   Andrew Jones     2019-08-22  122  	vcpu->mmio_needed = 0;
2113c5f62b7423 virt/kvm/arm/mmio.c   Andrew Jones     2019-08-22  123  
0e20f5e25556c0 virt/kvm/arm/mmio.c   Marc Zyngier     2019-12-13  124  	if (!kvm_vcpu_dabt_iswrite(vcpu)) {
74cc7e0c35c1e4 arch/arm64/kvm/mmio.c Tianjia Zhang    2020-06-23  125  		struct kvm_run *run = vcpu->run;
74cc7e0c35c1e4 arch/arm64/kvm/mmio.c Tianjia Zhang    2020-06-23  126  
0e20f5e25556c0 virt/kvm/arm/mmio.c   Marc Zyngier     2019-12-13  127  		len = kvm_vcpu_dabt_get_as(vcpu);
d5a5a0eff368f0 arch/arm/kvm/mmio.c   Christoffer Dall 2016-04-24  128  		data = kvm_mmio_read_buf(run->mmio.data, len);
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  129  
0e20f5e25556c0 virt/kvm/arm/mmio.c   Marc Zyngier     2019-12-13  130  		if (kvm_vcpu_dabt_issext(vcpu) &&
f42798c6898bf1 arch/arm/kvm/mmio.c   Marc Zyngier     2013-03-05  131  		    len < sizeof(unsigned long)) {
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  132  			mask = 1U << ((len * 8) - 1);
6d89d2d9b5bac9 arch/arm/kvm/mmio.c   Marc Zyngier     2013-02-12  133  			data = (data ^ mask) - mask;
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  134  		}
6d89d2d9b5bac9 arch/arm/kvm/mmio.c   Marc Zyngier     2013-02-12  135  
0e20f5e25556c0 virt/kvm/arm/mmio.c   Marc Zyngier     2019-12-13  136  		if (!kvm_vcpu_dabt_issf(vcpu))
b6ae256afd32f9 virt/kvm/arm/mmio.c   Christoffer Dall 2019-12-12  137  			data = data & 0xffffffff;
b6ae256afd32f9 virt/kvm/arm/mmio.c   Christoffer Dall 2019-12-12  138  
6d89d2d9b5bac9 arch/arm/kvm/mmio.c   Marc Zyngier     2013-02-12  139  		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
e39d200fa5bf5b virt/kvm/arm/mmio.c   Wanpeng Li       2017-12-14  140  			       &data);
6d89d2d9b5bac9 arch/arm/kvm/mmio.c   Marc Zyngier     2013-02-12  141  		data = vcpu_data_host_to_guest(vcpu, data, len);
0e20f5e25556c0 virt/kvm/arm/mmio.c   Marc Zyngier     2019-12-13  142  		vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu), data);
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  143  	}
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  144  
0d640732dbebed virt/kvm/arm/mmio.c   Mark Rutland     2018-11-09  145  	/*
0d640732dbebed virt/kvm/arm/mmio.c   Mark Rutland     2018-11-09  146  	 * The MMIO instruction is emulated and should not be re-executed
0d640732dbebed virt/kvm/arm/mmio.c   Mark Rutland     2018-11-09  147  	 * in the guest.
0d640732dbebed virt/kvm/arm/mmio.c   Mark Rutland     2018-11-09  148  	 */
cdb5e02ed13373 arch/arm64/kvm/mmio.c Marc Zyngier     2020-10-14  149  	kvm_incr_pc(vcpu);
0d640732dbebed virt/kvm/arm/mmio.c   Mark Rutland     2018-11-09  150  
cc81b6dfc3bc82 arch/arm64/kvm/mmio.c Fuad Tabba       2024-04-23  151  	return 1;
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  152  }
45e96ea6b36953 arch/arm/kvm/mmio.c   Christoffer Dall 2013-01-20  153  

:::::: The code at line 119 was first introduced by commit
:::::: bfb7a30b19861e559d64b7f2c3202d948fbf93ea KVM: arm64: Don't retire MMIO instruction w/ pending (emulated) SError

:::::: TO: Oliver Upton <oliver.upton@linux.dev>
:::::: CC: Oliver Upton <oliver.upton@linux.dev>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
