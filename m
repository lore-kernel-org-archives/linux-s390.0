Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB64C8FF6
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590045; cv=none; b=IZXT5zbUKc+AvPuK5iqhXpCIfgjC1QEcj56Al+5N8uelo9YpeCkVZvcVzmFq5+NNFrNzLDHiHcBk1L+vT4+OSpe4Exh33I0l1abNvpqixPW41+YqdJRPW1nbCBSJOubtSHUD25Ynh13XG5Wmz60lsIFTKsi4Hs8GIQ38cpxDJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590045; c=relaxed/simple;
	bh=zu7vc4KZFa/fdm3pzcprXGx74mW7GSNgQmLzWwUnf+Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mH0RQNp5AXX0h8bAeiL4yyMCmFjIOUZW1qtMvenIsfvRmwORtr4uxyYAGOrVEWOVFh1jA4B/saHqdpv7JpQ9F64afFtunC+pPxOcyGqFLMSh4iRfQMVGAqQIXkJswg167uoPshlkXTDOzjpS0sT2A5Vj/qvAo5jr2Quxmb8hIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5uNAYly; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5uNAYly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778590042; x=1810126042;
  h=date:from:to:cc:subject:message-id;
  bh=zu7vc4KZFa/fdm3pzcprXGx74mW7GSNgQmLzWwUnf+Y=;
  b=l5uNAYlyqVQmDi01tEssQtqL4OL/pU32UyjrEBu63OmxmJhMolUf300m
   jDXPwMYERiAs7fYFPPiXS52/H281KQvpHV+CJEpB4tm8y9BFJx+bVYchH
   I2HkL3AT0R6UFe3QtLoBUM26MQhx3KubZFIjkcd0bCLCQjJ+hcHL9nBFY
   IiLNIi0IdsE3yut70XcPGfEHlXhf2y0iAN5YGTHxzN8nAeaw2kwTDOYSn
   6CQOXuWw7q4vOLLVBE8nmOk4e+KJ374PBcDUMTXOPEeFsSTS8DHaODAn5
   f3z5mNFV8bZah9hLE4arp1CIXjKUMcxiWOCIWXqa1CGyONj624F4CoSwb
   g==;
X-CSE-ConnectionGUID: fsoTf71jT8GoMG/grhZ4ZQ==
X-CSE-MsgGUID: HoH02zmZTkajxCZqYS9wtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90597836"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90597836"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:47:21 -0700
X-CSE-ConnectionGUID: tD5mz32mTsalGA9X/qA+sA==
X-CSE-MsgGUID: oF8sY5aHSm6TiHHAPkrIsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="239584450"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 May 2026 05:47:19 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMmW4-0000000029J-0gTM;
	Tue, 12 May 2026 12:47:16 +0000
Date: Tue, 12 May 2026 20:47:02 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Steffen Eiden <seiden@linux.ibm.com>
Subject: [kvms390:sae 2/54] arch/x86/kvm/svm/sev.c:117:32: error:
 'struct kvm' has no member named 'users_count'
Message-ID: <202605122020.wEdQHOry-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   e952fb65773b1e5cd2e5ca409e712db5ef252bb1
commit: 134336e0cba8dd18185738333bc26c1b0b020b6d [2/54] KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
config: x86_64-rhel-9.4-bpf (https://download.01.org/0day-ci/archive/20260512/202605122020.wEdQHOry-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605122020.wEdQHOry-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605122020.wEdQHOry-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kvm/svm/sev.c: In function 'kvm_lockdep_assert_sev_lock_held':
>> arch/x86/kvm/svm/sev.c:117:32: error: 'struct kvm' has no member named 'users_count'
     117 |         if (!refcount_read(&kvm->users_count))
         |                                ^~


vim +117 arch/x86/kvm/svm/sev.c

eaf78265a4ab33 Joerg Roedel        2020-03-24  109  
ba903f73824907 Sean Christopherson 2026-03-10  110  static __always_inline void kvm_lockdep_assert_sev_lock_held(struct kvm *kvm)
ba903f73824907 Sean Christopherson 2026-03-10  111  {
ba903f73824907 Sean Christopherson 2026-03-10  112  #ifdef CONFIG_PROVE_LOCKING
ba903f73824907 Sean Christopherson 2026-03-10  113  	/*
ba903f73824907 Sean Christopherson 2026-03-10  114  	 * Querying SEV+ support is safe if there are no other references, i.e.
ba903f73824907 Sean Christopherson 2026-03-10  115  	 * if concurrent initialization of SEV+ is impossible.
ba903f73824907 Sean Christopherson 2026-03-10  116  	 */
ba903f73824907 Sean Christopherson 2026-03-10 @117  	if (!refcount_read(&kvm->users_count))
ba903f73824907 Sean Christopherson 2026-03-10  118  		return;
ba903f73824907 Sean Christopherson 2026-03-10  119  
ba903f73824907 Sean Christopherson 2026-03-10  120  	/*
ba903f73824907 Sean Christopherson 2026-03-10  121  	 * Querying SEV+ support from vCPU context is always safe, as vCPUs can
ba903f73824907 Sean Christopherson 2026-03-10  122  	 * only be created after SEV+ is initialized (and KVM disallows all SEV
ba903f73824907 Sean Christopherson 2026-03-10  123  	 * sub-ioctls while vCPU creation is in-progress).
ba903f73824907 Sean Christopherson 2026-03-10  124  	 */
ba903f73824907 Sean Christopherson 2026-03-10  125  	if (kvm_get_running_vcpu())
ba903f73824907 Sean Christopherson 2026-03-10  126  		return;
ba903f73824907 Sean Christopherson 2026-03-10  127  
ba903f73824907 Sean Christopherson 2026-03-10  128  	lockdep_assert_held(&kvm->lock);
ba903f73824907 Sean Christopherson 2026-03-10  129  #endif
ba903f73824907 Sean Christopherson 2026-03-10  130  }
ba903f73824907 Sean Christopherson 2026-03-10  131  

:::::: The code at line 117 was first introduced by commit
:::::: ba903f7382490776d2df2fca6bf5c8ef2eb4663f KVM: SEV: Assert that kvm->lock is held when querying SEV+ support

:::::: TO: Sean Christopherson <seanjc@google.com>
:::::: CC: Sean Christopherson <seanjc@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
