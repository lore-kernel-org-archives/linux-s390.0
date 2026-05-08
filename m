Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE737FF5C
	for <linux-s390@vger.kernel.org>; Fri,  8 May 2026 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246589; cv=none; b=ajv+hdThE2Iu7hItkW4hVtQznRy4HetcGu7lNvo0ghmlYkSOx+b2Wa4LjBg4syGjj6VAH0OHcT6w+cfp2qhD2KIjw0ZqVp/e4yn0/ax94PU7eHFa7+yuZ/Y9w0O/gz+LgN2k5yLDxudiCf4+Hp7ML5T6i/b/w74UIpm3iadlcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246589; c=relaxed/simple;
	bh=8zMjjTIh7afG5oiqfdU+MK/5b/VMbZNu+SysEbxRI8U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fL+mrS3Ywg8qLxJ0Q+2d+cmTomQlw3W7G2zAvEAiYHVT2Vg97+oQPmeiPcEbpVX9KjxM3yeptIgKsgPudKsPYsz1pltLfCltl1U5mnzN7S0aKm3r4mKBSYfLt7WmZl1yYgd3IXimu9I2/3qFiHJ7IqSV0NFWvcCDYDiblN1wmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQMAEbJY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQMAEbJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778246587; x=1809782587;
  h=date:from:to:cc:subject:message-id;
  bh=8zMjjTIh7afG5oiqfdU+MK/5b/VMbZNu+SysEbxRI8U=;
  b=HQMAEbJY9oNZfNLwIMsccQ6rUtUJfBd95Kc4BSMpJekDNhSIMR9Y8OGr
   hEYs8Nwjg135tyk7c2a4S2fe3UfXpVSPif6hcSWAt2Z5JZCaQ86wMa6Jv
   9qhT+tuzrWSW4tQIhhfy4uPfY3eB+nGC3EOBy2UPSGtkGcoDTU/J8Us95
   v5Ty8htZxNrEJQLi96EIbP6F6tDypAIXlLIuJ8QXWRTEv9G4wz4g8cq6A
   ImeoG/PS9bVKoNsi549rG0AqRupN+zfbjCevmxabzNLUE+UswAw5EbghT
   7tFsYotwDqgfXPSTP3oHTK1UkoG+sZypijDpucmB2SyV7Vw1yGIEBZ0kb
   A==;
X-CSE-ConnectionGUID: f4y84cfTSwWU6PfUmZMc1w==
X-CSE-MsgGUID: 0u0eOoSHQ9y8OvCNT12aHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90315813"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90315813"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 06:23:07 -0700
X-CSE-ConnectionGUID: boroxfoKTnyeTIQjTpmoBw==
X-CSE-MsgGUID: Ri/LZIw+SkWlwycZ3C3Mow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="236698169"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 May 2026 06:23:05 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLLAV-0000000009p-0n08;
	Fri, 08 May 2026 13:23:03 +0000
Date: Fri, 08 May 2026 21:22:44 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org
Subject: [kvms390:sae 53/55] arch/s390/kvm/arm64/arm.c:232:13:
 warning: variable 'ret' set but not used
Message-ID: <202605082137.4rqrVNVY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   23885833f845ad11c99c4f458692250fc75908c5
commit: f41388cd69dc147f0e8f0aeeebc40eb8d19b6745 [53/55] KVM; s390: arm64: Implement sysreg handling
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260508/202605082137.4rqrVNVY-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605082137.4rqrVNVY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605082137.4rqrVNVY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/s390/kvm/arm64/arm.c: In function 'kvm_arch_vcpu_run_pid_change':
>> arch/s390/kvm/arm64/arm.c:232:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     232 |         int ret;
         |             ^~~


vim +/ret +232 arch/s390/kvm/arm64/arm.c

   228	
   229	int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
   230	{
   231		struct kvm *kvm = vcpu->kvm;
 > 232		int ret;
   233	
   234		if (!kvm_vcpu_initialized(vcpu))
   235			return -ENOEXEC;
   236	
   237		if (!kvm_arm_vcpu_is_finalized(vcpu))
   238			return -EPERM;
   239	
   240		if (likely(READ_ONCE(vcpu->pid)))
   241			return 0;
   242	
   243		ret = kvm_finalize_sys_regs(vcpu);
   244	
   245		mutex_lock(&kvm->arch.config_lock);
   246		set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
   247		mutex_unlock(&kvm->arch.config_lock);
   248	
   249		return 0;
   250	}
   251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
